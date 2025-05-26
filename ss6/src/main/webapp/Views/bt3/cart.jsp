<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giỏ Hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .cart-item {
            transition: all 0.3s ease;
        }
        .cart-item:hover {
            background-color: #f8f9fa;
        }
        .product-image {
            width: 80px;
            height: 80px;
            object-fit: cover;
            background: #f8f9fa;
        }
        .quantity-input {
            width: 80px;
        }
        .total-section {
            background: linear-gradient(135deg, #007bff, #0056b3);
            color: white;
        }
        .btn-remove {
            background: #dc3545;
            border: none;
            color: white;
        }
        .btn-remove:hover {
            background: #c82333;
            color: white;
        }
        .empty-cart {
            min-height: 400px;
        }
    </style>
</head>
<body class="bg-light">
<div class="container py-5">
    <div class="row">
        <div class="col-12">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h1>
                    <i class="fas fa-shopping-cart me-2"></i>
                    Giỏ Hàng
                </h1>
                <a href="products" class="btn btn-outline-primary">
                    <i class="fas fa-arrow-left me-2"></i>
                    Tiếp tục mua sắm
                </a>
            </div>

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

    <div class="row">
        <c:choose>
            <c:when test="${isEmpty or empty cartItems}">
                <!-- Empty Cart -->
                <div class="col-12">
                    <div class="card">
                        <div class="card-body empty-cart d-flex flex-column justify-content-center align-items-center">
                            <i class="fas fa-shopping-cart fa-5x text-muted mb-4"></i>
                            <h3 class="text-muted mb-3">Giỏ hàng trống</h3>
                            <p class="text-muted mb-4">Bạn chưa có sản phẩm nào trong giỏ hàng.</p>
                            <a href="products" class="btn btn-primary btn-lg">
                                <i class="fas fa-shopping-bag me-2"></i>
                                Bắt đầu mua sắm
                            </a>
                        </div>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <!-- Cart Items -->
                <div class="col-lg-8">
                    <div class="card">
                        <div class="card-header d-flex justify-content-between align-items-center">
                            <h5 class="mb-0">Sản phẩm trong giỏ hàng</h5>
                            <form method="post" action="cart" style="display: inline;">
                                <input type="hidden" name="action" value="clear">
                                <button type="submit" class="btn btn-outline-danger btn-sm"
                                        onclick="return confirm('Bạn có chắc muốn xóa tất cả sản phẩm?')">
                                    <i class="fas fa-trash me-1"></i>
                                    Xóa tất cả
                                </button>
                            </form>
                        </div>
                        <div class="card-body p-0">
                            <c:forEach var="item" items="${cartItems}" varStatus="status">
                                <div class="cart-item p-3 ${not status.last ? 'border-bottom' : ''}">
                                    <div class="row align-items-center">
                                        <div class="col-md-2 col-3">
                                            <c:choose>
                                                <c:when test="${not empty item.imageUrl}">
                                                    <img src="${item.imageUrl}" alt="${item.name}"
                                                         class="product-image rounded"
                                                         onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';">
                                                    <div style="display: none;" class="product-image rounded d-flex align-items-center justify-content-center">
                                                        <i class="fas fa-image text-muted"></i>
                                                    </div>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="product-image rounded d-flex align-items-center justify-content-center">
                                                        <i class="fas fa-image text-muted"></i>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div class="col-md-4 col-9">
                                            <h6 class="mb-1">${item.name}</h6>
                                            <p class="text-muted small mb-0">
                                                Giá: <fmt:formatNumber value="${item.price}" type="currency" currencySymbol="$"/>
                                            </p>
                                        </div>
                                        <div class="col-md-2 col-4 mt-2 mt-md-0">
                                            <form method="post" action="cart" class="quantity-form">
                                                <input type="hidden" name="action" value="update">
                                                <input type="hidden" name="cartId" value="${item.id}">
                                                <input type="number" class="form-control quantity-input"
                                                       name="quantity" value="${item.quantity}"
                                                       min="0" max="99" onchange="this.form.submit()">
                                            </form>
                                        </div>
                                        <div class="col-md-2 col-4 mt-2 mt-md-0 text-end">
                                            <strong class="text-primary">
                                                <fmt:formatNumber value="${item.totalPrice}" type="currency" currencySymbol="$"/>
                                            </strong>
                                        </div>
                                        <div class="col-md-2 col-4 mt-2 mt-md-0 text-end">
                                            <form method="post" action="cart" style="display: inline;">
                                                <input type="hidden" name="action" value="remove">
                                                <input type="hidden" name="cartId" value="${item.id}">
                                                <button type="submit" class="btn btn-remove btn-sm"
                                                        onclick="return confirm('Bạn có chắc muốn xóa sản phẩm này?')">
                                                    <i class="fas fa-trash"></i>
                                                </button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>

                <!-- Cart Summary -->
                <div class="col-lg-4">
                    <div class="card">
                        <div class="card-header total-section">
                            <h5 class="mb-0 text-white">
                                <i class="fas fa-calculator me-2"></i>
                                Tổng cộng
                            </h5>
                        </div>
                        <div class="card-body">
                            <div class="d-flex justify-content-between mb-3">
                                <span>Số lượng sản phẩm:</span>
                                <strong>${cartTotal.totalItems}</strong>
                            </div>
                            <div class="d-flex justify-content-between mb-3">
                                <span>Tạm tính:</span>
                                <strong>
                                    <fmt:formatNumber value="${cartTotal.totalAmount}" type="currency" currencySymbol="$"/>
                                </strong>
                            </div>
                            <div class="d-flex justify-content-between mb-3">
                                <span>Phí vận chuyển:</span>
                                <span class="text-success">Miễn phí</span>
                            </div>
                            <hr>
                            <div class="d-flex justify-content-between mb-4">
                                <h5>Tổng cộng:</h5>
                                <h5 class="text-primary">
                                    <fmt:formatNumber value="${cartTotal.totalAmount}" type="currency" currencySymbol="$"/>
                                </h5>
                            </div>

                            <div class="d-grid gap-2">
                                <button class="btn btn-primary btn-lg">
                                    <i class="fas fa-credit-card me-2"></i>
                                    Thanh toán
                                </button>
                                <a href="products" class="btn btn-outline-secondary">
                                    <i class="fas fa-arrow-left me-2"></i>
                                    Tiếp tục mua sắm
                                </a>
                            </div>
                        </div>
                    </div>

                    <!-- Coupon Section -->
                    <div class="card mt-3">
                        <div class="card-body">
                            <h6 class="card-title">
                                <i class="fas fa-tag me-2"></i>
                                Mã khuyến mãi
                            </h6>
                            <div class="input-group">
                                <input type="text" class="form-control" placeholder="Nhập mã khuyến mãi">
                                <button class="btn btn-outline-primary" type="button">
                                    Áp dụng
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>