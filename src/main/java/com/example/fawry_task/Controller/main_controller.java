package com.example.fawry_task.Controller;

import com.example.fawry_task.Model.DTO.admin_dto;
import com.example.fawry_task.Model.DTO.user_dto;
import com.example.fawry_task.Service.admin_service_interface;
import com.example.fawry_task.Service.user_service_interface;
import lombok.RequiredArgsConstructor;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.concurrent.ExecutionException;

@RequiredArgsConstructor
@RestController

public class main_controller {
    private final admin_service_interface adminService;
    private final user_service_interface userService;
    @RequestMapping("/auth")
    public String authorise(@ModelAttribute("admin") admin_dto adminDTO , @ModelAttribute("user") user_dto userDTO, Model model) throws ExecutionException, InterruptedException {
        if (adminService.is_admin_found(adminDTO.getEmail() , adminDTO.getPassword()))
        {
            model.addAttribute("message", "200");
            return  "Admin Found";
        }
        else if(userService.is_user_found(userDTO.getEmail() , userDTO.getPassword()))
        {
            model.addAttribute("message", "200");
            return  "User Found";
        }
        model.addAttribute("message", "101");
        return "User Not Found";
    }
    @RequestMapping("/get/admin/data")
    public admin_dto getAdminData(@ModelAttribute("admin") admin_dto adminDTO , Model model) throws ExecutionException, InterruptedException {
        if(adminService.get_admin_data(adminDTO.getEmail())!= null)
        {
            model.addAttribute("message", "200");
            return adminService.get_admin_data(adminDTO.getEmail());
        }
            return  null;
    }
    @RequestMapping("/get/user/data")
    public user_dto getUserData(@ModelAttribute("user") user_dto userDTO , Model model) throws ExecutionException, InterruptedException {
        if(userService.get_user_data(userDTO.getEmail())!= null)
        {
            model.addAttribute("message", "200");
            return userService.get_user_data(userDTO.getEmail());
        }
        return  null;
    }
    @RequestMapping("/signup")
    public boolean signUp(@ModelAttribute("user") user_dto userDTO , Model model) {
        model.addAttribute("message", "200");
       return userService.add_new_user(userDTO.getEmail() , userDTO.getPassword() , userDTO.getPassword());
    }
}
