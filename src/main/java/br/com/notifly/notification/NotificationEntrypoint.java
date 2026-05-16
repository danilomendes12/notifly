package br.com.notifly.notification;

import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/v1/notifications")
public class NotificationEntrypoint {

    @PostMapping
    public ResponseEntity<Void> create(@Valid @RequestBody CreateNotificationRequest request) {
        return ResponseEntity.accepted().build();
    }

}