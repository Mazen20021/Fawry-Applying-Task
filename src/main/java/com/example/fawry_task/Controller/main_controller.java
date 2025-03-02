package com.example.fawry_task.Controller;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequiredArgsConstructor
public class main_controller {
    @RequestMapping("/user_admin")
    public String admin() {
        return "admin";
    }
    @RequestMapping("/user")
    public String user() {
        return "user";
    }
}
