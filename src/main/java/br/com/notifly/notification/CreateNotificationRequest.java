package br.com.notifly.notification;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import java.util.UUID;

public record CreateNotificationRequest(
        @NotNull UUID userId,
        @NotBlank String message,
        @NotBlank String channel
) {
}