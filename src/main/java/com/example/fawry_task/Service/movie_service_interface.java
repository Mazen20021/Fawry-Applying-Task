package com.example.fawry_task.Service;

import com.example.fawry_task.Model.DTO.movies_dto;

import java.util.List;
import java.util.concurrent.ExecutionException;

public interface movie_service_interface {
    public List<movies_dto> searchMovies (String query);
    public List<movies_dto> getAllMovies(String query) throws ExecutionException, InterruptedException;
}
