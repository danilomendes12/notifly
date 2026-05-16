package br.com.notifly.notification;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController("v1/notifications")
public class NotificationEntrypoint {

    @GetMapping
    public String notification() {
        return "Hello World!";
    }

}
