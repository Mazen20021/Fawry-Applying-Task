package com.example.fawry_task.Service;

import com.example.fawry_task.Constants.db_constants;
import com.example.fawry_task.Constants.omdb_constants;
import com.example.fawry_task.Model.DTO.movies_dto;
import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.*;
import com.google.firebase.cloud.FirestoreClient;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutionException;

@Service
public class movie_service implements movie_service_interface{
    private final RestTemplate restTemplate;
    db_constants dbConstants = new db_constants();
    omdb_constants omdbConstants = new omdb_constants();
    public movie_service(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }
    @Override
    public List<movies_dto> searchMovies(String movieName) {
        String url = omdbConstants.getUrl() + "?apikey=" + omdbConstants.getApiKey() + "&s=" + movieName;
        Map<String, Object> response = restTemplate.getForObject(url, Map.class);

        List<movies_dto> allMovies = new ArrayList<>();

        if (response != null && response.containsKey("Search")) {
            List<Map<String, Object>> moviesList = (List<Map<String, Object>>) response.get("Search");
            for (Map<String, Object> movieData : moviesList) {
                movies_dto movie = new movies_dto();
                movie.setTitle((String) movieData.get("Title"));
                movie.setYear((String) movieData.get("Year"));
                movie.setType((String) movieData.get("Type"));
                movie.setImdbID((String) movieData.get("imdbID"));
                movie.setPoster((String) movieData.get("Poster"));
                allMovies.add(movie);
            }
        }
        return allMovies;
    }

    public List<movies_dto> getAllMovies() throws ExecutionException, InterruptedException {
        List<movies_dto> storedMovies = new ArrayList<>();
        Firestore db = FirestoreClient.getFirestore();
        CollectionReference moviesCollection = db.collection(dbConstants.getMovieMainCollection());

        // 🔹 Check if Firestore already has movies
        ApiFuture<QuerySnapshot> future = moviesCollection.get();
        List<QueryDocumentSnapshot> documents = future.get().getDocuments();

        if (!documents.isEmpty()) {
            // ✅ Return movies from Firestore if they already exist
            for (QueryDocumentSnapshot document : documents) {
                movies_dto movie = document.toObject(movies_dto.class);
                storedMovies.add(movie);
            }
            return storedMovies;
        }

        // 🔹 If Firestore is empty, fetch from OMDb API
        List<movies_dto> allMovies = new ArrayList<>();
        int page = 1;
        int maxPages = 10;
        boolean hasMore = true;
        String defaultQuery = "all";

        while (hasMore && page <= maxPages) {
            String url = String.format("%s/?s=%s&page=%d&apikey=%s",
                    omdbConstants.getUrl(), defaultQuery, page, omdbConstants.getApiKey());

            System.out.println("Fetching from OMDb API: " + url);

            Map<String, Object> response = restTemplate.getForObject(url, Map.class);

            if (response != null && response.containsKey("Search")) {
                List<Map<String, Object>> moviesList = (List<Map<String, Object>>) response.get("Search");

                for (Map<String, Object> movieData : moviesList) {
                    movies_dto movie = new movies_dto();
                    movie.setTitle((String) movieData.get("Title"));
                    movie.setYear((String) movieData.get("Year"));
                    movie.setType((String) movieData.get("Type"));
                    movie.setImdbID((String) movieData.get("imdbID"));
                    movie.setPoster((String) movieData.get("Poster"));

                    allMovies.add(movie);
                }
            }

            if (response == null || !response.containsKey("Search") || ((List<?>) response.get("Search")).size() < 10) {
                hasMore = false;
            } else {
                page++;
            }
        }

        // 🔹 Store in Firestore only if fetched from OMDb
        if (!allMovies.isEmpty()) {
            for (movies_dto movie : allMovies) {
                if (movie.getTitle() != null) {
                    moviesCollection.document(movie.getTitle()).set(movie);
                }
            }
        }

        // ✅ Return the newly stored movies
        return allMovies;
    }

    @Override
    public boolean removeMovie(String name ,String title) throws ExecutionException, InterruptedException {
        Firestore db = FirestoreClient.getFirestore();
        DocumentSnapshot moviesDoc = db.collection(dbConstants.getMovieMainCollection()).document(name).get().get();
        if (moviesDoc.exists()) {
            db.collection(dbConstants.getMovieMainCollection())
                    .document(name).delete();// Replace with the actual field name
            return true;
        }
        return false;
    }
    @Override
    public boolean addMovie(String title, String movieName, String type, String poster, String year, String imdbID) throws ExecutionException, InterruptedException {
        Firestore db = FirestoreClient.getFirestore();
        DocumentReference movieDoc = db.collection(dbConstants.getMovieMainCollection()).document(movieName);

        // Check if the movie already exists
        DocumentSnapshot document = movieDoc.get().get();
        if (!document.exists()) {
            // Create a movie object to store in Firestore
            Map<String, Object> movieData = new HashMap<>();
            movieData.put("title", movieName);
            movieData.put("poster", poster);
            movieData.put("year", year);
            movieData.put("type", type);
            movieData.put("imdbID", imdbID);

            // Store the movie as a document with fields
            movieDoc.set(movieData).get();
            return true;
        }
        return false; // Movie already exists
    }


}