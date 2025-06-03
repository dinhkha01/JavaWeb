<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý Sản phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
<div class="container-fluid mt-4">
    <div class="row">
        <div class="col-12">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2><i class="fas fa-box"></i> Quản lý Sản phẩm</h2>
                <a href="${pageContext.request.contextPath}/categories" class="btn btn-info">
                    <i class="fas fa-list"></i> Quản lý Danh mục
                </a>
            </div>

            <!-- Search Form -->
            <div class="card mb-4">
                <div class="card-body">
                    <form method="get" action="${pageContext.request.contextPath}/products">
                        <div class="row">
                            <div class="col-md-8">
                                <input type="text" name="search" class="form-control"
                                       placeholder="Tìm kiếm theo tên sản phẩm..."
                                       value="${search}">
                            </div>
                            <div class="col-md-4">
                                <button type="submit" class="btn btn-primary me-2">
                                    <i class="fas fa-search"></i> Tìm kiếm
                                </button>
                                <a href="${pageContext.request.contextPath}/products" class="btn btn-secondary">
                                    <i class="fas fa-refresh"></i> Làm mới
                                </a>
                            </div>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Add New Button -->
            <div class="mb-3 d-flex justify-content-between align-items-center">
                <a href="${pageContext.request.contextPath}/products/add" class="btn btn-success">
                    <i class="fas fa-plus"></i> Thêm mới sản phẩm
                </a>

                <!-- Total records info -->
                <c:if test="${totalRecords > 0}">
                    <span class="text-muted">
                        Tổng cộng: <strong>${totalRecords}</strong> sản phẩm
                        <c:if test="${not empty search}">
                            cho từ khóa "<strong>${search}</strong>"
                        </c:if>
                    </span>
                </c:if>
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

            <!-- Products Table -->
            <div class="card">
                <div class="card-header">
                    <h5 class="mb-0">Danh sách Sản phẩm</h5>
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
                                        <th width="5%">ID</th>
                                        <th width="10%">Hình ảnh</th>
                                        <th width="15%">Tên sản phẩm</th>
                                        <th width="20%">Mô tả</th>
                                        <th width="10%">Giá</th>
                                        <th width="10%">Danh mục</th>
                                        <th width="8%">Trạng thái</th>
                                        <th width="10%">Thao tác</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="product" items="${products}" varStatus="loop">
                                        <tr>
                                            <td>${loop.count}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty product.imageUrl}">
                                                        <img src="${pageContext.request.contextPath}${product.imageUrl}"
                                                             class="img-thumbnail"
                                                             style="max-width: 60px; max-height: 60px;"
                                                             alt="${product.imageUrl}" />
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="text-center text-muted">
                                                            <i class="fas fa-image fa-2x"></i>
                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td><strong>${product.productName}</strong></td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${product.description.length() > 50}">
                                                        ${product.description.substring(0, 50)}...
                                                    </c:when>
                                                    <c:otherwise>
                                                        ${product.description}
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <span class="fw-bold text-success">
                                                    <fmt:formatNumber value="${product.price}" type="number" pattern="#,##0.##" /> VND
                                                </span>
                                            </td>
                                            <td>
                                                <span class="badge bg-info">${product.categoryName}</span>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${product.status}">
                                                        <span class="badge bg-success">Hoạt động</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-danger">Không hoạt động</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>

                                            <td>
                                                <a href="${pageContext.request.contextPath}/products/edit/${product.productId}"
                                                   class="btn btn-sm btn-primary me-1" title="Chỉnh sửa">
                                                    <i class="fas fa-edit"></i>
                                                </a>
                                                <form method="post"
                                                      action="${pageContext.request.contextPath}/products/delete/${product.productId}"
                                                      style="display: inline-block;"
                                                      onsubmit="return confirm('Bạn có chắc chắn muốn xóa sản phẩm này?')">
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

                            <!-- Pagination -->
                            <c:if test="${totalPages > 1}">
                                <nav aria-label="Page navigation">
                                    <ul class="pagination justify-content-center mt-4">
                                        <!-- Previous Page -->
                                        <c:if test="${currentPage > 1}">
                                            <li class="page-item">
                                                <a class="page-link"
                                                   href="?page=${currentPage - 1}${not empty search ? '&search='.concat(search) : ''}">
                                                    <i class="fas fa-chevron-left"></i> Trước
                                                </a>
                                            </li>
                                        </c:if>

                                        <!-- Page Numbers -->
                                        <c:forEach begin="${startPage}" end="${endPage}" var="i">
                                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                                <a class="page-link"
                                                   href="?page=${i}${not empty search ? '&search='.concat(search) : ''}">${i}</a>
                                            </li>
                                        </c:forEach>

                                        <!-- Next Page -->
                                        <c:if test="${currentPage < totalPages}">
                                            <li class="page-item">
                                                <a class="page-link"
                                                   href="?page=${currentPage + 1}${not empty search ? '&search='.concat(search) : ''}">
                                                    Sau <i class="fas fa-chevron-right"></i>
                                                </a>
                                            </li>
                                        </c:if>
                                    </ul>

                                    <!-- Page Info -->
                                    <div class="text-center text-muted mt-2">
                                        Trang ${currentPage} / ${totalPages}
                                    </div>
                                </nav>
                            </c:if>
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