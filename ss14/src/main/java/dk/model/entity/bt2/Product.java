package dk.model.entity.bt2;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.validation.constraints.DecimalMin;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.math.BigDecimal;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class Product {
    @NotBlank(message = "Mã sản phẩm không được để trống")
    private String productCode;

    @NotBlank(message = "Tên sản phẩm không được để trống")
    private String productName;

    @NotNull(message = "Giá không được để trống")
    @DecimalMin(value = "0.0", inclusive = false, message = "Giá phải lớn hơn 0")
    private BigDecimal price;

    // Constructor để tạo từ String (từ cookie)
    public Product(String productString) {
        String[] parts = productString.split("\\|");
        if (parts.length == 3) {
            this.productCode = parts[0];
            this.productName = parts[1];
            this.price = new BigDecimal(parts[2]);
        }
    }

    // Chuyển đổi thành String để lưu vào cookie
    @Override
    public String toString() {
        return productCode + "|" + productName + "|" + price;
    }
}