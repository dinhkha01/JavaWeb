<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${product.productId != null ? 'Chỉnh sửa' : 'Thêm mới'} Sản phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
    <div class="row justify-content-center">
        <div class="col-md-10">
            <div class="card">
                <div class="card-header">
                    <div class="d-flex justify-content-between align-items-center">
                        <h4 class="mb-0">
                            <i class="fas ${product.productId != null ? 'fa-edit' : 'fa-plus'}"></i>
                            ${product.productId != null ? 'Chỉnh sửa' : 'Thêm mới'} Sản phẩm
                        </h4>
                        <a href="${pageContext.request.contextPath}/products" class="btn btn-secondary">
                            <i class="fas fa-arrow-left"></i> Quay lại
                        </a>
                    </div>
                </div>
                <div class="card-body">
                    <!-- Error Message -->
                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger">
                            <i class="fas fa-exclamation-circle"></i> ${errorMessage}
                        </div>
                    </c:if>

                    <!-- Form -->
                    <form:form modelAttribute="product" method="post" enctype="multipart/form-data" class="needs-validation" novalidate="true">
                        <div class="row">
                            <div class="col-md-8">
                                <!-- Product Name -->
                                <div class="mb-3">
                                    <label for="productName" class="form-label">
                                        Tên sản phẩm <span class="text-danger">*</span>
                                    </label>
                                    <form:input path="productName"
                                                id="productName"
                                                class="form-control ${not empty errors.productName ? 'is-invalid' : ''}"
                                                placeholder="Nhập tên sản phẩm" />
                                    <form:errors path="productName" cssClass="error" />
                                </div>

                                <!-- Description -->
                                <div class="mb-3">
                                    <label for="description" class="form-label">Mô tả</label>
                                    <form:textarea path="description"
                                                   id="description"
                                                   class="form-control ${not empty errors.description ? 'is-invalid' : ''}"
                                                   rows="4"
                                                   placeholder="Nhập mô tả sản phẩm" />
                                    <form:errors path="description" cssClass="override-specify-label" />
                                </div>

                                <!-- Price -->
                                <div class="mb-3">
                                    <label for="price" class="form-label">
                                        Giá <span class="text-danger">*</span>
                                    </label>
                                    <div class="input-group">
                                        <form:input path="price"
                                                    id="price"
                                                    type="number"
                                                    step="0.01"
                                                    min="0"
                                                    class="form-control ${not empty errors.price ? 'is-invalid' : ''}"
                                                    placeholder="0.00" />
                                        <span class="input-group-text">VND</span>
                                        <form:errors path="price" cssClass="error" />
                                    </div>
                                </div>

                                <!-- Category -->
                                <div class="mb-3">
                                    <label for="categoryId" class="form-label">
                                        Danh mục <span class="text-danger">*</span>
                                    </label>
                                    <form:select path="categoryId"
                                                 id="categoryId"
                                                 class="form-select ${not empty errors.categoryId ? 'is-invalid' : ''}">
                                        <form:option value="" label="-- Chọn danh mục --" />
                                        <form:options items="${categories}" itemValue="categoryId" itemLabel="categoryName" />
                                    </form:select>
                                    <form:errors path="categoryId" cssClass="error" />
                                </div>

                                <!-- Status field only for edit mode -->
                                <c:if test="${product.productId != null}">
                                    <div class="mb-3">
                                        <label class="form-label">Trạng thái</label>
                                        <div class="form-check form-switch">
                                            <form:checkbox path="status"
                                                           id="status"
                                                           class="form-check-input" />
                                            <label class="form-check-label" for="status">
                                                Hoạt động
                                            </label>
                                        </div>
                                    </div>
                                </c:if>
                            </div>

                            <div class="col-md-4">
                                <!-- Image Upload -->
                                <div class="mb-3">
                                    <label for="imageFile" class="form-label">Hình ảnh sản phẩm</label>
                                    <input type="file"
                                           id="imageFile"
                                           name="imageFile"
                                           class="form-control"
                                           accept="image/*"
                                           onchange="previewImage(this)" />
                                    <div class="form-text">Chọn file ảnh (JPG, PNG, GIF)</div>
                                </div>

                                <!-- Image Preview -->
                                <div class="mb-3">
                                    <label class="form-label">Xem trước</label>
                                    <div class="text-center">
                                        <img id="imagePreview"
                                             src="${product.imageUrl != null ? pageContext.request.contextPath.concat('/uploads/').concat(product.imageUrl) : ''}"
                                             class="img-thumbnail ${product.imageUrl != null ? '' : 'd-none'}"
                                             style="max-width: 200px; max-height: 200px;"
                                             alt="Preview" />
                                        <div id="noImageText" class="${product.imageUrl != null ? 'd-none' : ''}">
                                            <i class="fas fa-image fa-3x text-muted"></i>
                                            <p class="text-muted mt-2">Chưa có hình ảnh</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <hr>
                        <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                            <a href="${pageContext.request.contextPath}/products"
                               class="btn btn-secondary me-md-2">
                                <i class="fas fa-times"></i> Hủy
                            </a>
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save"></i>
                                    ${product.productId != null ? 'Cập nhật' : 'Thêm mới'}
                            </button>
                        </div>
                    </form:form>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Bootstrap form validation
    (function() {
        'use strict';
        window.addEventListener('load', function() {
            var forms = document.getElementsByClassName('needs-validation');
            var validation = Array.prototype.filter.call(forms, function(form) {
                form.addEventListener('submit', function(event) {
                    if (form.checkValidity() === false) {
                        event.preventDefault();
                        event.stopPropagation();
                    }
                    form.classList.add('was-validated');
                }, false);
            });
        }, false);
    })();

    // Image preview function
    function previewImage(input) {
        const preview = document.getElementById('imagePreview');
        const noImageText = document.getElementById('noImageText');

        if (input.files && input.files[0]) {
            const reader = new FileReader();

            reader.onload = function(e) {
                preview.src = e.target.result;
                preview.classList.remove('d-none');
                noImageText.classList.add('d-none');
            }

            reader.readAsDataURL(input.files[0]);
        }
    }
</script>
</body>
</html>