package dk.model.entity.bt3;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class User {
    @NotBlank(message = "name khong duoc de trong")
    String name;
    @Email(message = "email khong hop le")
    String email;
    @Size(min =6, message = "pass phai hon 6 ki tu")
    String password;
}
