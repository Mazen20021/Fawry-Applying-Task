package com.example.fawry_task.Model.DTO;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class user_dto {
    String name;
    String password;
    String email;

    public user_dto() {

    }
}
