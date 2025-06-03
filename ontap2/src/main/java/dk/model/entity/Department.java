package dk.model.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Department {
    private int departmentId;

    @NotBlank(message = "Tên phòng ban không được để trống")
    @Size(max = 50, message = "Tên phòng ban không được vượt quá 50 ký tự")
    private String departmentName;

    @Size(max = 500, message = "Mô tả không được vượt quá 500 ký tự")
    private String description;

    private boolean status = true;
}