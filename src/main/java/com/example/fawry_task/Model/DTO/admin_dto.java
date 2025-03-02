package com.example.fawry_task.Model.DTO;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor

public class admin_dto {
    private String name;
    private String password;
    private String email;

    public admin_dto() {}
}
