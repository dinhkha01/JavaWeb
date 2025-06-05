package dk.model.entity.bt6;

import lombok.Data;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;
@Data
public class User {

    @NotBlank(message = "{user.username.required}")
    @Size(min = 3, max = 20, message = "{user.username.size}")
    private String username;

    @NotBlank(message = "{user.password.required}")
    @Size(min = 6, max = 100, message = "{user.password.size}")
    private String password;

    @NotBlank(message = "{user.confirmPassword.required}")
    private String confirmPassword;

    @NotBlank(message = "{user.email.required}")
    @Email(message = "{user.email.invalid}")
    private String email;
    // Custom validation method for password confirmation
    public boolean isPasswordMatching() {
        return password != null && password.equals(confirmPassword);
    }

}