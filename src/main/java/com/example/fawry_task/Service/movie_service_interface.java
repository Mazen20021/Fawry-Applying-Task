package com.example.fawry_task.Service;

import com.example.fawry_task.Model.DTO.movies_dto;

import java.util.List;
import java.util.concurrent.ExecutionException;

public interface movie_service_interface {
    public List<movies_dto> searchMovies (String query) throws ExecutionException, InterruptedException;
    public List<movies_dto> getAllMovies(String query) throws ExecutionException, InterruptedException;
    public boolean removeMovie(String name) throws ExecutionException, InterruptedException;
    public boolean addMovie(String title ,String movieName, String type ,String poster, String year , String imdbID ) throws ExecutionException, InterruptedException;
}
