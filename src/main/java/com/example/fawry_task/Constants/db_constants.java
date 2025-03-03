package com.example.fawry_task.Constants;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@AllArgsConstructor
public class db_constants {
    private String mainCollection = "auth";
    private String subAdminDocument = "admins";
    private String subUserDocument = "users";
    private String subSubDocument = "data";
    private String nameParam = "name";
    private String emailParam = "email";
    private String passwordParam = "password";
    private int id = 202420250;
    private String movieMainCollection = "collection";
    private String movieDocument = "movies";
    private String movieSubCollection = "data";
    private String movieRatesParam = "average_rates";
    public db_constants() {

    }
}
