package com.example.fawry_task.Service;

import com.example.fawry_task.Model.DTO.admin_dto;

import java.util.concurrent.ExecutionException;

public interface admin_service_interface {
    boolean is_admin_found(String email , String password) throws ExecutionException, InterruptedException;
    admin_dto get_admin_data(String email) throws ExecutionException, InterruptedException;


}
