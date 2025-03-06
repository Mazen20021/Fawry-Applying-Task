package com.example.fawry_task.Service;

import com.example.fawry_task.Constants.db_constants;
import com.example.fawry_task.Constants.omdb_constants;
import com.example.fawry_task.Model.DTO.movies_dto;
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
    public movie_service(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }
    @Override
    public List<movies_dto> searchMovies (String movieName) throws ExecutionException, InterruptedException {
        List<movies_dto> allMovies = new ArrayList<>();
        Firestore db = FirestoreClient.getFirestore();
        DocumentSnapshot moviesDoc = db.collection(dbConstants.getMovieMainCollection()).document(movieName).get().get();
        if (moviesDoc.exists()) {
            Map<String, Object> moviesMap = moviesDoc.getData();
            if (moviesMap != null) {
                for (Map.Entry<String, Object> entry : moviesMap.entrySet()) {
                    movies_dto movie = new movies_dto();
                    Map<String, Object> movieData = (Map<String, Object>) entry.getValue();
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
            Map<String, Object> moviesMap = moviesDoc.getData();
            if (moviesMap != null) {
                for (Map.Entry<String, Object> entry : moviesMap.entrySet()) {
                    movies_dto movie = new movies_dto();
                    Map<String, Object> movieData = (Map<String, Object>) entry.getValue();
                    movie.setTitle((String) movieData.get("title"));
                    movie.setYear((String) movieData.get("year"));
                    movie.setType((String) movieData.get("type"));
                    movie.setImdbID((String) movieData.get("imdbID"));
                    movie.setPoster((String) movieData.get("poster"));
                    allMovies.add(movie);
                }
            }
            return allMovies;
        }
            while (hasMore) {
                String url = String.format("%s/?s=%s&page=%d&apikey=%s", omdbConstants.getUrl(), query, page, omdbConstants.getApiKey());
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
                } else if (response != null && response.containsKey("Title")) {
                    movies_dto movie = new movies_dto();
                    movie.setTitle((String) response.get("Title"));
                    movie.setYear((String) response.get("Year"));
                    movie.setType((String) response.get("Type"));
                    movie.setImdbID((String) response.get("imdbID"));
                    movie.setPoster((String) response.get("Poster"));
                    allMovies.add(movie);
                }
                if (response == null || !response.containsKey("Search") || ((List<?>) response.get("Search")).size() < 10) {
                    hasMore = false;
                } else {
                    page++;
                }
            }
        if (!allMovies.isEmpty()) {
            Map<String, Object> moviesMap = new HashMap<>();
            for (movies_dto movie : allMovies) {
                if (movie.getTitle() != null) {
                    moviesMap.put(movie.getTitle(), Map.of(
                            "Title", movie.getTitle(),
                            "Poster", movie.getPoster(),
                            "Year", movie.getYear(),
                            "Type", movie.getType()
                    ));
                }
            }
            db.collection(dbConstants.getMovieMainCollection()).document(query).set(moviesMap);
        }
        return allMovies;
    }
    @Override
    public boolean removeMovie(String name) throws ExecutionException, InterruptedException {
        Firestore db = FirestoreClient.getFirestore();
        DocumentSnapshot moviesDoc = db.collection(dbConstants.getMovieMainCollection()).document(name).get().get();
        if (moviesDoc.exists()) {
            db.collection(dbConstants.getMovieMainCollection()).document(name).delete().get();
            return true;
        }
        return false;
    }
    @Override
    public boolean addMovie(String title , String movieName , String type ,String poster, String year , String imdbID ) throws ExecutionException, InterruptedException {
        Firestore db = FirestoreClient.getFirestore();
        DocumentSnapshot moviesDoc = db.collection(dbConstants.getMovieMainCollection()).document(title).get().get();
        if (!moviesDoc.exists()) {
            Map<String, Object> moviesMap = new HashMap<>();
            moviesMap.put(movieName, Map.of(
                    "Title", movieName,
                    "Poster", poster,
                    "Year", year,
                    "Type", type,
                    "imdbID", imdbID,
                    "users" , Map.of(
                            "name", "N/A",
                            "rate" , 0
                    )
            ));
            db.collection(dbConstants.getMovieMainCollection()).document(title).set(moviesMap);
            return true;
        } else {
            Map<String, Object> newField = moviesDoc.getData();
            if (newField == null) {
                newField = new HashMap<>();
            }
            newField.put(movieName, Map.of(
                    "Title", movieName,
                    "Poster", poster,
                    "Year", year,
                    "Type", type,
                    "imdbID", imdbID,
                    "users" , Map.of(
                        "name", "N/A",
                        "rate" , 0
                    )
            ));
            db.collection(dbConstants.getMovieMainCollection()).document(title).update(newField).get();
            return true;
        }
    }
}