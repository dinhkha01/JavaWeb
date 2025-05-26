<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh Sách Sản Phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .product-card {
            transition: transform 0.2s;
            height: 100%;
        }
        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        .product-image {
            height: 200px;
            object-fit: cover;
            background: #f8f9fa;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #6c757d;
        }
        .price {
            color: #dc3545;
            font-weight: bold;
            font-size: 1.2em;
        }
        .cart-icon {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 1000;
        }
        .btn-add-to-cart {
            background: linear-gradient(45deg, #007bff, #0056b3);
            border: none;
        }
        .btn-add-to-cart:hover {
            background: linear-gradient(45deg, #0056b3, #004085);
        }
    </style>
</head>
<body class="bg-light">
<!-- Cart Icon -->
<div class="cart-icon">
    <a href="cart" class="btn btn-primary position-relative">
        <i class="fas fa-shopping-cart"></i>
        <c:if test="${cartItemCount > 0}">
                <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
                        ${cartItemCount}
                </span>
        </c:if>
    </a>
</div>

<div class="container py-5">
    <div class="row">
        <div class="col-12">
            <h1 class="text-center mb-5">
                <i class="fas fa-store me-2"></i>
                Danh Sách Sản Phẩm
            </h1>

            <!-- Alert Messages -->
            <c:if test="${not empty success}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="fas fa-check-circle me-2"></i>
                        ${success}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="fas fa-exclamation-circle me-2"></i>
                        ${error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
        </div>
    </div>

    <!-- Products Grid -->
    <div class="row">
        <c:choose>
            <c:when test="${not empty products}">
                <c:forEach var="product" items="${products}">
                    <div class="col-lg-3 col-md-4 col-sm-6 mb-4">
                        <div class="card product-card h-100">
                            <div class="product-image card-img-top d-flex align-items-center justify-content-center">
                                <c:choose>
                                    <c:when test="${not empty product.imageUrl}">
                                        <img src="${product.imageUrl}" alt="${product.name}"
                                             class="img-fluid" style="max-height: 200px;"
                                             onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';">
                                        <div style="display: none;" class="d-flex align-items-center justify-content-center h-100">
                                            <i class="fas fa-image fa-3x"></i>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <i class="fas fa-image fa-3x"></i>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <div class="card-body d-flex flex-column">
                                <h5 class="card-title">${product.name}</h5>
                                <p class="price mb-3">
                                    <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="$"/>
                                </p>

                                <div class="mt-auto">
                                    <form method="post" action="products" class="add-to-cart-form">
                                        <input type="hidden" name="productId" value="${product.id}">
                                        <div class="row g-2">
                                            <div class="col-4">
                                                <input type="number" class="form-control" name="quantity"
                                                       value="1" min="1" max="99" required>
                                            </div>
                                            <div class="col-8">
                                                <button type="submit" class="btn btn-add-to-cart w-100">
                                                    <i class="fas fa-cart-plus me-1"></i>
                                                    Thêm vào giỏ
                                                </button>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="col-12">
                    <div class="text-center py-5">
                        <i class="fas fa-box-open fa-5x text-muted mb-3"></i>
                        <h3 class="text-muted">Không có sản phẩm nào</h3>
                        <p class="text-muted">Hiện tại chưa có sản phẩm nào trong cửa hàng.</p>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- Footer -->
    <div class="row mt-5">
        <div class="col-12 text-center">
            <a href="cart" class="btn btn-outline-primary btn-lg">
                <i class="fas fa-shopping-cart me-2"></i>
                Xem Giỏ Hàng
                <c:if test="${cartItemCount > 0}">
                    (${cartItemCount})
                </c:if>
            </a>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Auto dismiss alerts after 5 seconds
    setTimeout(function() {
        var alerts = document.querySelectorAll('.alert');
        alerts.forEach(function(alert) {
            var bsAlert = new bootstrap.Alert(alert);
            bsAlert.close();
        });
    }, 5000);

    // Add loading effect to add to cart buttons
    document.querySelectorAll('.add-to-cart-form').forEach(function(form) {
        form.addEventListener('submit', function(e) {
            var button = form.querySelector('button[type="submit"]');
            button.innerHTML = '<i class="fas fa-spinner fa-spin me-1"></i>Đang thêm...';
            button.disabled = true;
        });
    });
</script>
</body>
</html>