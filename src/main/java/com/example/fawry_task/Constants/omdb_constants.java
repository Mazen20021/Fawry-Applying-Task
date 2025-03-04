package com.example.fawry_task.Constants;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@AllArgsConstructor
@Setter
@Getter
public class omdb_constants {
    private String apiKey = "be34ad9d";
    private String url = "http://www.omdbapi.com/";

    public omdb_constants() {

    }
}
