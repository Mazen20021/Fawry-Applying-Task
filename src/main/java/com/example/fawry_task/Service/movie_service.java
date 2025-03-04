package com.example.fawry_task.Service;

import com.example.fawry_task.Constants.db_constants;
import com.example.fawry_task.Constants.omdb_constants;
import com.example.fawry_task.Model.DTO.movies_dto;
import com.google.cloud.firestore.CollectionReference;
import com.google.cloud.firestore.DocumentSnapshot;
import com.google.cloud.firestore.Firestore;
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
    movies_dto moviesDto = new movies_dto();
    public movie_service(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }
//    @Override
//    public List<movies_dto> getAllMovies(String name) throws ExecutionException, InterruptedException {
//
//        // Get the "admins" document from the "auth" collection
//
//
//        return null; // User not found
//    }
    @Override
    public List<movies_dto> searchMovies (String movieName) {
        String url = omdbConstants.getUrl() + "?apikey=" + omdbConstants.getApiKey() + "&s=" + movieName;
        Map<String, Object> response = restTemplate.getForObject(url, Map.class);
        if (response != null && response.containsKey("Search")) {
            return (List<movies_dto>) response.get("Search");
        }
        return List.of();
    }
    public List<movies_dto> getAllMovies(String query) throws ExecutionException, InterruptedException {
        List<movies_dto> allMovies = new ArrayList<>();
        int page = 1;
        boolean hasMore = true;
        Firestore db = FirestoreClient.getFirestore();
        DocumentSnapshot moviesDoc = db.collection(dbConstants.getMovieMainCollection()).document(dbConstants.getMovieDocument()).collection(dbConstants.getMovieSubCollection()).document(query).get().get();
        if (moviesDoc.exists()) {
            // 🔹 If movies exist in Firestore, return them
            Map<String, Object> moviesMap = moviesDoc.getData();
            if (moviesMap != null) {
                for (Map.Entry<String, Object> entry : moviesMap.entrySet()) {
                    Map<String, Object> movieData = (Map<String, Object>) entry.getValue();
                    movies_dto movie = new movies_dto();
                    movie.setTitle((String) movieData.get("Title"));
                    movie.setRates((String) movieData.get("rates"));
                    movie.setYear((String) movieData.get("year"));
                    movie.setType((String) movieData.get("type"));
                    movie.setImdbID((String) movieData.get("imdbID"));
                    movie.setPoster((String) movieData.get("Poster"));
                    allMovies.add(movie);
                }
            }
            return allMovies; // 🔹 No need to call OMDB API
        }

        while (hasMore) {
            String url = String.format("%s/?s=%s&page=%d&apikey=%s", omdbConstants.getUrl(), query, page, omdbConstants.getApiKey());
            Map<String, Object> response = restTemplate.getForObject(url, Map.class);

            if (response != null && response.containsKey("Search")) {
                List<Map<String, Object>> moviesList = (List<Map<String, Object>>) response.get("Search");

                for (Map<String, Object> movieData : moviesList) {
                    movies_dto movie = new movies_dto();
                    movie.setTitle((String) movieData.get("Title"));
                    movie.setRates((String) movieData.get("imdbID")); // Example: Using IMDB ID as rates
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

        // 🔹 Step 3: Save fetched movies to Firestore
        if (!allMovies.isEmpty()) {
            Map<String, Object> moviesMap = new HashMap<>();
            for (movies_dto movie : allMovies) {
                moviesMap.put(movie.getTitle(), Map.of(
                        "title", movie.getTitle(),
                        "rates", movie.getRates(),
                        "poster", movie.getPoster()
                ));
            }
            db.collection(dbConstants.getMovieMainCollection()).document(query).set(moviesMap);
        }

        return allMovies;
    }
}
