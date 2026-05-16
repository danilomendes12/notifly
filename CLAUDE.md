# CLAUDE.md — Notifly

## Sobre o projeto
Sistema de notificações multi-canal (email, push, SMS), event-driven,
construído pra demonstrar padrões de sistemas distribuídos: outbox,
idempotência, DLQ, particionamento, replicação leader-follower.

É um projeto de portfólio para entrevistas de engenharia sênior/staff.
Código defensável em code review é mais importante que velocidade de entrega.

## Stack
- Java 21 (sem Lombok — use records onde fizer sentido)
- Spring Boot 4.0.x
- Maven
- Postgres 16 + Flyway (schema versionado, ddl-auto=validate)
- Redpanda (Kafka-compatível) com producer idempotente, acks=all
- Redis para cache, rate limiting (token bucket implementado à mão), idempotency keys
- Testcontainers para testes de integração
- Prometheus + Grafana para observabilidade

## Convenções de código
- Package-by-feature, NÃO package-by-layer
  (br.com.notifly.notification, .outbox, .delivery, .ratelimit, etc)
- Entities JPA: construtor vazio protected, construtor de domínio público
  que valida invariantes, sem setters públicos, mutação via métodos com
  nome de domínio (markAsDelivered, não setStatus)
- DTOs, eventos, value objects: sempre records
- Testes de integração com Testcontainers, não @MockBean para infra
- Toda decisão arquitetural relevante vira ADR em docs/adr/

## O que NÃO fazer
- Não adicionar Lombok como dependência
- Não usar @MockBean para Postgres/Kafka/Redis (sempre Testcontainers)
- Não criar pacotes controller/service/repository como top-level
- Não adicionar Spring Security ainda (Fase 0-5 sem auth, decisão consciente)
- Não otimizar prematuramente — primeiro funciona, depois ADR explica trade-off