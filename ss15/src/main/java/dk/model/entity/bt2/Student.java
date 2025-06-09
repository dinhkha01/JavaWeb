package dk.model.entity.bt2;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class Student {
    String name;
    int age;
    String email;
    String address;
    String phoneNumber;
}
