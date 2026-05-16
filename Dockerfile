# syntax=docker/dockerfile:1

# ---- Build stage ----------------------------------------------------------
# Usa a imagem oficial do Maven em vez do wrapper ./mvnw — o wrapper deste
# repo está incompleto (falta .mvn/wrapper/maven-wrapper.properties).
FROM maven:3.9-eclipse-temurin-21 AS build
WORKDIR /build

# Resolve dependências primeiro: essa camada fica em cache enquanto só o
# código-fonte muda, acelerando rebuilds.
COPY pom.xml .
RUN --mount=type=cache,target=/root/.m2 mvn -B -ntp dependency:go-offline

# Compila o jar executável.
COPY src ./src
RUN --mount=type=cache,target=/root/.m2 mvn -B -ntp clean package -DskipTests

# ---- Runtime stage --------------------------------------------------------
FROM eclipse-temurin:21-jre-alpine AS runtime
WORKDIR /app

# Roda como usuário sem privilégios.
RUN addgroup -S notifly && adduser -S -G notifly notifly
USER notifly:notifly

COPY --from=build /build/target/*.jar app.jar

EXPOSE 8080

# Usa o actuator (já exposto em application.yml) como health check do container.
HEALTHCHECK --interval=15s --timeout=3s --start-period=45s --retries=5 \
  CMD wget -q -O - http://localhost:8080/actuator/health | grep -q '"status":"UP"' || exit 1

# MaxRAMPercentage deixa a JVM respeitar o limite de memória do container.
ENTRYPOINT ["java", "-XX:MaxRAMPercentage=75.0", "-jar", "app.jar"]