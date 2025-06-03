<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${category.categoryId != null ? 'Chỉnh sửa' : 'Thêm mới'} Danh mục</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card">
                <div class="card-header">
                    <div class="d-flex justify-content-between align-items-center">
                        <h4 class="mb-0">
                            <i class="fas ${category.categoryId != null ? 'fa-edit' : 'fa-plus'}"></i>
                            ${category.categoryId != null ? 'Chỉnh sửa' : 'Thêm mới'} Danh mục
                        </h4>
                        <a href="${pageContext.request.contextPath}/categories" class="btn btn-secondary">
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
                    <form:form modelAttribute="category" method="post" class="needs-validation" novalidate="true">
                        <div class="mb-3">
                            <label for="categoryName" class="form-label">
                                Tên danh mục <span class="text-danger">*</span>
                            </label>
                            <form:input path="categoryName"
                                        id="categoryName"
                                        class="form-control ${not empty errors.categoryName ? 'is-invalid' : ''}"
                                        placeholder="Nhập tên danh mục" />
                            <form:errors path="categoryName" cssClass="error" />
                        </div>

                        <div class="mb-3">
                            <label for="description" class="form-label">Mô tả</label>
                            <form:textarea path="description"
                                           id="description"
                                           class="form-control ${not empty errors.description ? 'is-invalid' : ''}"
                                           rows="4"
                                           placeholder="Nhập mô tả danh mục" />
                            <form:errors path="description" cssClass="error" />
                        </div>

                        <!-- Status field only for edit mode -->
                        <c:if test="${category.categoryId != null}">
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

                        <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                            <a href="${pageContext.request.contextPath}/categories"
                               class="btn btn-secondary me-md-2">
                                <i class="fas fa-times"></i> Hủy
                            </a>
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save"></i>
                                    ${category.categoryId != null ? 'Cập nhật' : 'Thêm mới'}
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
</script>
</body>
</html>