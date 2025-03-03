package com.example.fawry_task.Service;

import com.example.fawry_task.Constants.db_constants;
import com.example.fawry_task.Model.DTO.admin_dto;
import com.example.fawry_task.Model.DTO.movies_dto;
import com.google.cloud.firestore.DocumentSnapshot;
import com.google.cloud.firestore.Firestore;
import com.google.firebase.cloud.FirestoreClient;
import org.springframework.stereotype.Service;

import java.util.Map;
import java.util.concurrent.ExecutionException;

@Service
public class movie_service implements movie_service_interface{
    db_constants dbConstants = new db_constants();
    movies_dto moviesDto = new movies_dto();
    @Override
    public movies_dto searchByName(String name) throws ExecutionException, InterruptedException {
        Firestore db = FirestoreClient.getFirestore();
        // Get the "admins" document from the "auth" collection
        DocumentSnapshot moviesDoc = db.collection(dbConstants.getMovieMainCollection()).document(dbConstants.getMovieDocument()).collection(dbConstants.getMovieSubCollection()).document(name).get().get();
        if (moviesDoc.exists()) {
            // Retrieve all admin users stored as a map
            Map<String, Object> moviesMap = moviesDoc.getData();
            if (moviesMap != null && moviesMap.get(dbConstants.getNameParam()).equals(name)) {
                // Extract user details as a map
                // Convert Firestore data to AdminDTO
                moviesDto.setName(moviesMap.get(dbConstants.getNameParam()).toString());
                moviesDto.setRates(moviesMap.get(dbConstants.getMovieRatesParam()).toString());
                return moviesDto;
            }
        }
        return null; // User not found
    }
}
