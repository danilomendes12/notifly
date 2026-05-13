package br.com.notifly;

import org.springframework.boot.SpringApplication;

public class TestNotiflyApplication {

	public static void main(String[] args) {
		SpringApplication.from(NotiflyApplication::main).with(TestcontainersConfiguration.class).run(args);
	}

}
