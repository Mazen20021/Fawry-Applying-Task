package com.example.fawry_task.Controller;

import com.example.fawry_task.Model.DTO.admin_dto;
import com.example.fawry_task.Model.DTO.movies_dto;
import com.example.fawry_task.Model.DTO.user_dto;
import com.example.fawry_task.Service.admin_service_interface;
import com.example.fawry_task.Service.movie_service_interface;
import com.example.fawry_task.Service.user_service_interface;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import java.util.concurrent.ExecutionException;

@RequiredArgsConstructor
@RestController

public class main_controller {
    private final admin_service_interface adminService;
    private final user_service_interface userService;
    private final movie_service_interface movieService;
    @GetMapping("/auth")
    public int authorise(@RequestParam("email") String email, @RequestParam("password") String password, Model model) throws ExecutionException, InterruptedException {
        if (adminService.is_admin_found(email, password)) {
            model.addAttribute("message", "200");
            return 1;
        } else if (userService.is_user_found(email, password)) {
            model.addAttribute("message", "200");
            return 0;
        }
        model.addAttribute("message", "101");
        return -1;
    }
    @GetMapping("/get/admin/data")
    public admin_dto getAdminData(@ModelAttribute("admin") admin_dto adminDTO , Model model) throws ExecutionException, InterruptedException {
        if(adminService.get_admin_data(adminDTO.getEmail())!= null)
        {
            model.addAttribute("message", "200");
            return adminService.get_admin_data(adminDTO.getEmail());
        }
            return  null;
    }
    @GetMapping("/get/user/data")
    public user_dto getUserData(@ModelAttribute("user") user_dto userDTO , Model model) throws ExecutionException, InterruptedException {
        if(userService.get_user_data(userDTO.getEmail())!= null)
        {
            model.addAttribute("message", "200");
            return userService.get_user_data(userDTO.getEmail());
        }
        return  null;
    }
    @GetMapping("/signup")
    public boolean signUp(@RequestParam("email") String email, @RequestParam("password") String password,@RequestParam("name")String name, Model model) {
        model.addAttribute("message", "200");
       return userService.add_new_user(email , password , name);
    }
    @GetMapping("/home/search")
    public List<movies_dto> search(@ModelAttribute("movie") movies_dto moviesDto , String movieName, Model model) throws ExecutionException, InterruptedException {
        model.addAttribute("message", "200");
        return movieService.searchMovies(movieName);
    }
    @GetMapping("/home/movies")
    public List<movies_dto> viewAllMovies(@ModelAttribute("movie") movies_dto moviesDto , String query, Model model) throws ExecutionException, InterruptedException {
        model.addAttribute("message", "200");
        return movieService.getAllMovies(query);
    }
    @DeleteMapping("/admin/remove")
    public boolean removeMovie(@ModelAttribute("movie") movies_dto moviesDto , String name, Model model) throws ExecutionException, InterruptedException {
        model.addAttribute("message", "200");
        return movieService.removeMovie(name);
    }
    @PutMapping("/admin/add")
    public boolean addMovie(@ModelAttribute("movie") movies_dto moviesDto , String title , String type ,String movieName, String poster,String year,String imdbID, Model model)throws ExecutionException, InterruptedException {
        model.addAttribute("message", "200");
        return movieService.addMovie(title,movieName,type,poster,year,imdbID);
    }
}
