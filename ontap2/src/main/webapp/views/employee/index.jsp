<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý nhân viên</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .avatar-img {
            width: 50px;
            height: 50px;
            object-fit: cover;
            border-radius: 50%;
        }
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
                <h2><i class="fas fa-users"></i> Quản lý nhân viên</h2>
                <a href="${pageContext.request.contextPath}/employees/create" class="btn btn-primary">
                    <i class="fas fa-plus"></i> Thêm nhân viên
                </a>
            </div>

            <!-- Search Form -->
            <div class="card mb-4">
                <div class="card-body">
                    <form method="get" action="${pageContext.request.contextPath}/employees">
                        <div class="row">
                            <div class="col-md-10">
                                <input type="text" name="search" class="form-control"
                                       placeholder="Tìm kiếm theo tên nhân viên..."
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

            <!-- Employee List -->
            <div class="card">
                <div class="card-header">
                    <h5 class="card-title mb-0">
                        <i class="fas fa-list"></i> Danh sách nhân viên
                        <c:if test="${not empty search}">
                            - Kết quả tìm kiếm cho: "<strong>${search}</strong>"
                        </c:if>
                    </h5>
                </div>
                <div class="card-body p-0">
                    <c:choose>
                        <c:when test="${not empty employees}">
                            <div class="table-responsive">
                                <table class="table table-hover mb-0">
                                    <thead class="table-light">
                                    <tr>
                                        <th>ID</th>
                                        <th>Ảnh đại diện</th>
                                        <th>Họ tên</th>
                                        <th>Email</th>
                                        <th>Điện thoại</th>
                                        <th>Phòng ban</th>
                                        <th>Trạng thái</th>
                                        <th width="150">Thao tác</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="employee" items="${employees}">
                                        <tr>
                                            <td>${employee.employeeId}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty employee.avatarUrl}">
                                                        <img src="${pageContext.request.contextPath}${employee.avatarUrl}"
                                                             alt="Avatar" class="avatar-img">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="avatar-img bg-secondary d-flex align-items-center justify-content-center text-white">
                                                            <i class="fas fa-user"></i>
                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>${employee.fullName}</td>
                                            <td>${employee.email}</td>
                                            <td>${employee.phoneNumber}</td>
                                            <td>${employee.departmentName}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${employee.status}">
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
                                                <a href="${pageContext.request.contextPath}/employees/edit/${employee.employeeId}"
                                                   class="btn btn-sm btn-outline-primary" title="Chỉnh sửa">
                                                    <i class="fas fa-edit"></i>
                                                </a>
                                                <form method="post"
                                                      action="${pageContext.request.contextPath}/employees/delete/${employee.employeeId}"
                                                      style="display: inline;"
                                                      onsubmit="return confirm('Bạn có chắc chắn muốn xóa nhân viên ${employee.fullName}?')">
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

                            <!-- Pagination -->
                            <c:if test="${totalPages > 1}">
                                <div class="card-footer">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <div>
                                            Hiển thị ${(currentPage - 1) * 5 + 1} - ${currentPage * 5 > totalRecords ? totalRecords : currentPage * 5}
                                            trong tổng số ${totalRecords} nhân viên
                                        </div>
                                        <nav>
                                            <ul class="pagination pagination-sm mb-0">
                                                <!-- Previous -->
                                                <c:if test="${currentPage > 1}">
                                                    <li class="page-item">
                                                        <a class="page-link" href="?page=${currentPage - 1}<c:if test='${not empty search}'>&search=${search}</c:if>">
                                                            <i class="fas fa-chevron-left"></i>
                                                        </a>
                                                    </li>
                                                </c:if>

                                                <!-- Page numbers -->
                                                <c:forEach begin="${startPage}" end="${endPage}" var="i">
                                                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                                                        <a class="page-link" href="?page=${i}<c:if test='${not empty search}'>&search=${search}</c:if>">
                                                                ${i}
                                                        </a>
                                                    </li>
                                                </c:forEach>

                                                <!-- Next -->
                                                <c:if test="${currentPage < totalPages}">
                                                    <li class="page-item">
                                                        <a class="page-link" href="?page=${currentPage + 1}<c:if test='${not empty search}'>&search=${search}</c:if>">
                                                            <i class="fas fa-chevron-right"></i>
                                                        </a>
                                                    </li>
                                                </c:if>
                                            </ul>
                                        </nav>
                                    </div>
                                </div>
                            </c:if>
                        </c:when>
                        <c:otherwise>
                            <div class="text-center py-5">
                                <i class="fas fa-users fa-3x text-muted mb-3"></i>
                                <p class="text-muted">${not empty message ? message : 'Chưa có nhân viên nào'}</p>
                                <a href="${pageContext.request.contextPath}/employees/create" class="btn btn-primary">
                                    <i class="fas fa-plus"></i> Thêm nhân viên đầu tiên
                                </a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <!-- Navigation Links -->
            <div class="mt-4">
                <a href="${pageContext.request.contextPath}/departments" class="btn btn-outline-secondary">
                    <i class="fas fa-building"></i> Quản lý phòng ban
                </a>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
