package com.example.fawry_task.Service;

import com.example.fawry_task.Model.DTO.movies_dto;

import java.util.concurrent.ExecutionException;

public interface movie_service_interface {
    movies_dto searchByName(String name) throws ExecutionException, InterruptedException;
}
