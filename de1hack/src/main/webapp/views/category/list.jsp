<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý Danh mục</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
    <div class="row">
        <div class="col-12">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2><i class="fas fa-list"></i> Quản lý Danh mục</h2>
                <a href="${pageContext.request.contextPath}/products" class="btn btn-info">
                    <i class="fas fa-box"></i> Quản lý Sản phẩm
                </a>
            </div>

            <!-- Search Form -->
            <div class="card mb-4">
                <div class="card-body">
                    <form method="get" action="${pageContext.request.contextPath}/categories">
                        <div class="row">
                            <div class="col-md-8">
                                <input type="text" name="search" class="form-control"
                                       placeholder="Tìm kiếm theo tên danh mục..."
                                       value="${search}">
                            </div>
                            <div class="col-md-4">
                                <button type="submit" class="btn btn-primary me-2">
                                    <i class="fas fa-search"></i> Tìm kiếm
                                </button>
                                <a href="${pageContext.request.contextPath}/categories" class="btn btn-secondary">
                                    <i class="fas fa-refresh"></i> Làm mới
                                </a>
                            </div>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Add New Button -->
            <div class="mb-3">
                <a href="${pageContext.request.contextPath}/categories/add" class="btn btn-success">
                    <i class="fas fa-plus"></i> Thêm mới danh mục
                </a>
            </div>

            <!-- Alert Messages -->
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

            <!-- Categories Table -->
            <div class="card">
                <div class="card-header">
                    <h5 class="mb-0">Danh sách Danh mục</h5>
                </div>
                <div class="card-body">
                    <c:choose>
                        <c:when test="${not empty message}">
                            <div class="text-center py-4">
                                <i class="fas fa-info-circle fa-3x text-muted mb-3"></i>
                                <h5 class="text-muted">${message}</h5>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="table-responsive">
                                <table class="table table-striped table-hover">
                                    <thead class="table-dark">
                                    <tr>
                                        <th width="10%">ID</th>
                                        <th width="25%">Tên danh mục</th>
                                        <th width="40%">Mô tả</th>
                                        <th width="10%">Trạng thái</th>
                                        <th width="15%">Thao tác</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="category" items="${categories}">
                                        <tr>
                                            <td>${category.categoryId}</td>
                                            <td><strong>${category.categoryName}</strong></td>
                                            <td>${category.description}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${category.status}">
                                                        <span class="badge bg-success">Hoạt động</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-danger">Không hoạt động</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <a href="${pageContext.request.contextPath}/categories/edit/${category.categoryId}"
                                                   class="btn btn-sm btn-primary me-1" title="Chỉnh sửa">
                                                    <i class="fas fa-edit"></i>
                                                </a>
                                                <form method="post"
                                                      action="${pageContext.request.contextPath}/categories/delete/${category.categoryId}"
                                                      style="display: inline-block;"
                                                      onsubmit="return confirm('Bạn có chắc chắn muốn xóa danh mục này?')">
                                                    <button type="submit" class="btn btn-sm btn-danger" title="Xóa">
                                                        <i class="fas fa-trash"></i>
                                                    </button>
                                                </form>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>