<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Quản lý phòng ban</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
  <style>
    .status-badge {
      font-size: 0.8em;
    }
  </style>
</head>
<body>
<div class="container mt-4">
  <div class="row">
    <div class="col-12">
      <div class="d-flex justify-content-between align-items-center mb-4">
        <h2><i class="fas fa-building"></i> Quản lý phòng ban</h2>
        <a href="${pageContext.request.contextPath}/departments/create" class="btn btn-primary">
          <i class="fas fa-plus"></i> Thêm phòng ban
        </a>
      </div>

      <!-- Search Form -->
      <div class="card mb-4">
        <div class="card-body">
          <form method="get" action="${pageContext.request.contextPath}/departments">
            <div class="row">
              <div class="col-md-10">
                <input type="text" name="search" class="form-control"
                       placeholder="Tìm kiếm theo tên phòng ban..."
                       value="${search}">
              </div>
              <div class="col-md-2">
                <button type="submit" class="btn btn-outline-primary w-100">
                  <i class="fas fa-search"></i> Tìm kiếm
                </button>
              </div>
            </div>
          </form>
        </div>
      </div>

      <!-- Messages -->
      <c:if test="${not empty successMessage}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
          <i class="fas fa-check-circle"></i> ${successMessage}
          <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
      </c:if>

      <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
          <i class="fas fa-exclamation-circle"></i> ${errorMessage}
          <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
      </c:if>

      <c:if test="${not empty message}">
        <div class="alert alert-info" role="alert">
          <i class="fas fa-info-circle"></i> ${message}
        </div>
      </c:if>

      <!-- Department List -->
      <div class="card">
        <div class="card-header">
          <h5 class="card-title mb-0">
            <i class="fas fa-list"></i> Danh sách phòng ban
            <c:if test="${not empty search}">
              - Kết quả tìm kiếm cho: "<strong>${search}</strong>"
            </c:if>
          </h5>
        </div>
        <div class="card-body p-0">
          <c:choose>
            <c:when test="${not empty departments}">
              <div class="table-responsive">
                <table class="table table-hover mb-0">
                  <thead class="table-light">
                  <tr>
                    <th>ID</th>
                    <th>Tên phòng ban</th>
                    <th>Mô tả</th>
                    <th>Trạng thái</th>
                    <th width="150">Thao tác</th>
                  </tr>
                  </thead>
                  <tbody>
                  <c:forEach var="department" items="${departments}">
                    <tr>
                      <td>${department.departmentId}</td>
                      <td><strong>${department.departmentName}</strong></td>
                      <td>
                        <c:choose>
                          <c:when test="${not empty department.description}">
                            <c:choose>
                              <c:when test="${department.description.length() > 50}">
                                ${department.description.substring(0, 50)}...
                              </c:when>
                              <c:otherwise>
                                ${department.description}
                              </c:otherwise>
                            </c:choose>
                          </c:when>
                          <c:otherwise>
                            <span class="text-muted">Chưa có mô tả</span>
                          </c:otherwise>
                        </c:choose>
                      </td>
                      <td>
                        <c:choose>
                          <c:when test="${department.status}">
                                                        <span class="badge bg-success status-badge">
                                                            <i class="fas fa-check"></i> Hoạt động
                                                        </span>
                          </c:when>
                          <c:otherwise>
                                                        <span class="badge bg-danger status-badge">
                                                            <i class="fas fa-times"></i> Không hoạt động
                                                        </span>
                          </c:otherwise>
                        </c:choose>
                      </td>
                      <td>
                        <a href="${pageContext.request.contextPath}/departments/edit/${department.departmentId}"
                           class="btn btn-sm btn-outline-primary" title="Chỉnh sửa">
                          <i class="fas fa-edit"></i>
                        </a>
                        <form method="post"
                              action="${pageContext.request.contextPath}/departments/delete/${department.departmentId}"
                              style="display: inline;"
                              onsubmit="return confirm('Bạn có chắc chắn muốn xóa phòng ban ${department.departmentName}?')">
                          <button type="submit" class="btn btn-sm btn-outline-danger" title="Xóa">
                            <i class="fas fa-trash"></i>
                          </button>
                        </form>
                      </td>
                    </tr>
                  </c:forEach>
                  </tbody>
                </table>
              </div>
            </c:when>
            <c:otherwise>
              <div class="text-center py-5">
                <i class="fas fa-building fa-3x text-muted mb-3"></i>
                <p class="text-muted">${not empty message ? message : 'Chưa có phòng ban nào'}</p>
                <a href="${pageContext.request.contextPath}/departments/create" class="btn btn-primary">
                  <i class="fas fa-plus"></i> Thêm phòng ban đầu tiên
                </a>
              </div>
            </c:otherwise>
          </c:choose>
        </div>
      </div>

      <!-- Navigation Links -->
      <div class="mt-4">
        <a href="${pageContext.request.contextPath}/employees" class="btn btn-outline-secondary">
          <i class="fas fa-users"></i> Quản lý nhân viên
        </a>
      </div>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>