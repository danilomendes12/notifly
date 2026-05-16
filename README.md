# Notifly

Sistema de notificações multi-canal (email, push, SMS), event-driven,
construído para demonstrar padrões de sistemas distribuídos: outbox,
idempotência, DLQ, particionamento, replicação leader-follower.

## Pré-requisitos

- **JDK 21** — o projeto compila com `--release 21` (Spring Boot 4.1).
  Versões anteriores (ex.: JDK 17) falham na compilação.
- **Docker** rodando — os testes de integração usam Testcontainers
  (Redpanda, Postgres, Redis).

Verifique a versão de Java usada pelo wrapper:

```bash
./mvnw --version   # a linha "Java version" deve indicar 21
```

Se apontar para outra versão, ajuste o `JAVA_HOME`:

```bash
export JAVA_HOME=$(/usr/libexec/java_home -v 21)   # macOS
```

## Rodando os testes

```bash
./mvnw test      # apenas testes unitários (Surefire)
./mvnw verify    # unitários + integração com Testcontainers — igual ao CI
```

Rodar uma classe ou método específico:

```bash
./mvnw test -Dtest=NomeDoTeste
./mvnw test -Dtest=NomeDoTeste#nomeDoMetodo
```

## CI

Todo push e pull request para `main` roda `./mvnw --batch-mode verify`
no GitHub Actions (`.github/workflows/ci.yml`).