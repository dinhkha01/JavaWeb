package dk.model.entity.bt1;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class User {
    @NotBlank(message = "Username ko dc de trong")
    private String username;
    @Size(min = 6,message = "mat khau phai co it nhat 6 ky tu")
    private String password;
}
