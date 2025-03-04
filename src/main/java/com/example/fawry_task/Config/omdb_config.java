package com.example.fawry_task.Config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.client.RestTemplate;

@Configuration
public class omdb_config {
    @Bean
    public RestTemplate restTemplate() {
        return new RestTemplate();
    }
}
