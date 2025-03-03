package com.example.fawry_task.Service;

import com.example.fawry_task.Model.DTO.user_dto;

import java.util.concurrent.ExecutionException;

public interface user_service_interface {
    boolean is_user_found(String email , String password) throws ExecutionException, InterruptedException;
    user_dto get_user_data(String email) throws ExecutionException, InterruptedException;
    boolean add_new_user(String email , String password , String name);
}
