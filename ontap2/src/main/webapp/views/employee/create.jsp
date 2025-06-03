<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Thêm mới Nhân viên</title>
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
              <i class="fas fa-user-plus"></i> Thêm mới Nhân viên
            </h4>
            <a href="${pageContext.request.contextPath}/employees" class="btn btn-secondary">
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
          <form:form modelAttribute="employee" method="post"
                     action="${pageContext.request.contextPath}/employees/create"
                     enctype="multipart/form-data"
                     class="needs-validation" novalidate="true">

            <!-- Avatar Upload -->
            <div class="mb-3">
              <label for="avatarFile" class="form-label">Ảnh đại diện</label>
              <input type="file"
                     name="avatarFile"
                     id="avatarFile"
                     class="form-control"
                     accept="image/*">
              <div class="form-text">Chỉ chấp nhận file ảnh (JPG, PNG, GIF). Tối đa 5MB</div>
            </div>

            <!-- Full Name -->
            <div class="mb-3">
              <label for="fullName" class="form-label">
                Họ và tên <span class="text-danger">*</span>
              </label>
              <form:input path="fullName"
                          id="fullName"
                          class="form-control ${not empty errors.fullName ? 'is-invalid' : ''}"
                          placeholder="Nhập họ và tên đầy đủ"
                          maxlength="100"
                          required="true" />
              <form:errors path="fullName" cssClass="invalid-feedback d-block" />
            </div>

            <!-- Email -->
            <div class="mb-3">
              <label for="email" class="form-label">
                Email <span class="text-danger">*</span>
              </label>
              <form:input path="email"
                          type="email"
                          id="email"
                          class="form-control ${not empty errors.email ? 'is-invalid' : ''}"
                          placeholder="Nhập địa chỉ email"
                          maxlength="100"
                          required="true" />
              <form:errors path="email" cssClass="invalid-feedback d-block" />
            </div>

            <!-- Phone Number -->
            <div class="mb-3">
              <label for="phoneNumber" class="form-label">
                Số điện thoại <span class="text-danger">*</span>
              </label>
              <form:input path="phoneNumber"
                          id="phoneNumber"
                          class="form-control ${not empty errors.phoneNumber ? 'is-invalid' : ''}"
                          placeholder="Nhập số điện thoại (10-11 chữ số)"
                          pattern="[0-9]{10,11}"
                          maxlength="11"
                          required="true" />
              <form:errors path="phoneNumber" cssClass="invalid-feedback d-block" />
            </div>

            <!-- Department -->
            <div class="mb-3">
              <label for="departmentId" class="form-label">
                Phòng ban <span class="text-danger">*</span>
              </label>
              <form:select path="departmentId"
                           id="departmentId"
                           class="form-select ${not empty errors.departmentId ? 'is-invalid' : ''}"
                           required="true">
                <option value="">-- Chọn phòng ban --</option>
                <c:forEach var="dept" items="${departments}">
                  <form:option value="${dept.departmentId}">${dept.departmentName}</form:option>
                </c:forEach>
              </form:select>
              <form:errors path="departmentId" cssClass="invalid-feedback d-block" />
            </div>

            <!-- Status -->
            <div class="mb-3">
              <label class="form-label">Trạng thái</label>
              <div class="form-check form-switch">
                <form:checkbox path="status"
                               id="status"
                               class="form-check-input"
                               checked="true" />
                <label class="form-check-label" for="status">
                  Hoạt động
                </label>
              </div>
            </div>

            <div class="d-grid gap-2 d-md-flex justify-content-md-end">
              <a href="${pageContext.request.contextPath}/employees"
                 class="btn btn-secondary me-md-2">
                <i class="fas fa-times"></i> Hủy
              </a>
              <button type="submit" class="btn btn-primary">
                <i class="fas fa-save"></i> Thêm mới
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