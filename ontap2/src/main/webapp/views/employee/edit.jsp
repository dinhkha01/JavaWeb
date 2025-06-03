<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Chỉnh sửa Nhân viên</title>
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
              <i class="fas fa-user-edit"></i> Chỉnh sửa Nhân viên
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

          <!-- Employee Info -->
          <div class="alert alert-info">
            <i class="fas fa-info-circle"></i>
            <strong>ID Nhân viên:</strong> ${employee.employeeId}
          </div>

          <!-- Form -->
          <form:form modelAttribute="employee" method="post"
                     action="${pageContext.request.contextPath}/employees/edit/${employee.employeeId}"
                     enctype="multipart/form-data"
                     class="needs-validation" novalidate="true">

            <!-- Hidden field for employee ID -->
            <form:hidden path="employeeId" />

            <!-- Avatar Upload -->
            <div class="mb-3">
              <label for="avatarFile" class="form-label">
                <c:choose>
                  <c:when test="${not empty employee.avatarUrl}">
                    Thay đổi ảnh đại diện
                  </c:when>
                  <c:otherwise>
                    Ảnh đại diện
                  </c:otherwise>
                </c:choose>
              </label>
              <c:if test="${not empty employee.avatarUrl}">
                <div class="mb-2">
                  <img src="${pageContext.request.contextPath}${employee.avatarUrl}"
                       class="img-thumbnail" style="width: 100px; height: 100px; object-fit: cover;"
                       alt="Current Avatar">
                  <div class="form-text">Ảnh hiện tại</div>
                </div>
              </c:if>
              <input type="file"
                     name="avatarFile"
                     id="avatarFile"
                     class="form-control"
                     accept="image/*">
              <div class="form-text">
                <c:choose>
                  <c:when test="${not empty employee.avatarUrl}">
                    Để trống nếu không muốn thay đổi ảnh hiện tại
                  </c:when>
                  <c:otherwise>
                    Chỉ chấp nhận file ảnh (JPG, PNG, GIF). Tối đa 5MB
                  </c:otherwise>
                </c:choose>
              </div>
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
              <c:if test="${not empty employee.departmentName}">
                <div class="form-text">
                  Phòng ban hiện tại: <strong>${employee.departmentName}</strong>
                </div>
              </c:if>
            </div>

            <!-- Status -->
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
              <div class="form-text">
                <c:choose>
                  <c:when test="${employee.status}">
                    <span class="text-success">
                      <i class="fas fa-check-circle"></i> Nhân viên đang hoạt động
                    </span>
                  </c:when>
                  <c:otherwise>
                    <span class="text-danger">
                      <i class="fas fa-times-circle"></i> Nhân viên không hoạt động
                    </span>
                  </c:otherwise>
                </c:choose>
              </div>
            </div>

            <div class="d-grid gap-2 d-md-flex justify-content-md-end">
              <a href="${pageContext.request.contextPath}/employees"
                 class="btn btn-secondary me-md-2">
                <i class="fas fa-times"></i> Hủy
              </a>
              <button type="submit" class="btn btn-primary">
                <i class="fas fa-save"></i> Cập nhật
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