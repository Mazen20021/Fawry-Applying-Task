package com.example.fawry_task.Model.DTO;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@AllArgsConstructor
public class movies_dto {
    private String title;
    private String year;
    private String imdbID;
    private String type;
    private String poster;

    public movies_dto(){}
}
