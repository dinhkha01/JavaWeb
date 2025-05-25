<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quản lý Thư viện Sách</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
    <div class="row">
        <div class="col-12">
            <h1 class="text-center mb-4">
                <i class="fas fa-book"></i> Quản lý Thư viện Sách
            </h1>

            <!-- Success/Error Messages -->
            <c:if test="${param.success == 'add'}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="fas fa-check-circle"></i> Thêm sách thành công!
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
            <c:if test="${param.success == 'update'}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="fas fa-check-circle"></i> Cập nhật sách thành công!
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
            <c:if test="${param.success == 'delete'}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="fas fa-check-circle"></i> Xóa sách thành công!
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="fas fa-exclamation-circle"></i> <c:out value="${error}"/>
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <!-- Search Form -->
            <div class="card mb-4">
                <div class="card-body">
                    <form method="get" action="<c:url value='/books'/>">
                        <input type="hidden" name="action" value="search">
                        <div class="row g-3">
                            <div class="col-md-3">
                                <label for="searchType" class="form-label">Tìm kiếm theo:</label>
                                <select class="form-select" id="searchType" name="searchType">
                                    <option value="title" <c:if test="${searchType == 'title'}">selected</c:if>>Tiêu đề</option>
                                    <option value="code" <c:if test="${searchType == 'code'}">selected</c:if>>Mã sách</option>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label for="searchValue" class="form-label">Từ khóa:</label>
                                <input type="text" class="form-control" id="searchValue" name="searchValue"
                                       value="<c:out value='${searchValue}'/>" placeholder="Nhập từ khóa tìm kiếm...">
                            </div>
                            <div class="col-md-3">
                                <label class="form-label">&nbsp;</label>
                                <div class="d-grid gap-2">
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fas fa-search"></i> Tìm kiếm
                                    </button>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Add New Book Button -->
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h3>Danh sách sách</h3>
                <a href="<c:url value='/books?action=add'/>" class="btn btn-success">
                    <i class="fas fa-plus"></i> Thêm sách mới
                </a>
            </div>

            <!-- Books Table -->
            <div class="table-responsive">
                <table class="table table-striped table-hover">
                    <thead class="table-dark">
                    <tr>
                        <th>Mã sách</th>
                        <th>Tiêu đề</th>
                        <th>Tác giả</th>
                        <th>Thể loại</th>
                        <th>Số lượng</th>
                        <th>Thao tác</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:choose>
                        <c:when test="${empty books}">
                            <tr>
                                <td colspan="6" class="text-center text-muted">
                                    <i class="fas fa-book-open"></i> Không có sách nào trong thư viện
                                </td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="book" items="${books}">
                                <tr>
                                    <td><c:out value="${book.bookCode}"/></td>
                                    <td><c:out value="${book.title}"/></td>
                                    <td><c:out value="${book.author}"/></td>
                                    <td><c:out value="${book.genre}"/></td>
                                    <td>
                                                <span class="badge ${book.quantity > 0 ? 'bg-success' : 'bg-danger'}">
                                                    <c:out value="${book.quantity}"/>
                                                </span>
                                    </td>
                                    <td>
                                        <div class="btn-group" role="group">
                                            <a href="<c:url value='/books?action=edit&bookCode=${book.bookCode}'/>"
                                               class="btn btn-outline-primary btn-sm" title="Chỉnh sửa">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                            <button type="button" class="btn btn-outline-danger btn-sm"
                                                    title="Xóa" onclick="confirmDelete('<c:out value="${book.bookCode}"/>', '<c:out value="${book.title}"/>')">
                                                <i class="fas fa-trash"></i>
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                    </tbody>
                </table>
            </div>

            <!-- Statistics -->
            <c:if test="${not empty books}">
                <div class="mt-4">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Thống kê</h5>
                            <div class="row text-center">
                                <div class="col-md-4">
                                    <h3 class="text-primary">${books.size()}</h3>
                                    <p class="text-muted">Tổng số đầu sách</p>
                                </div>
                                <div class="col-md-4">
                                    <h3 class="text-success">
                                        <c:set var="totalQuantity" value="0"/>
                                        <c:forEach var="book" items="${books}">
                                            <c:set var="totalQuantity" value="${totalQuantity + book.quantity}"/>
                                        </c:forEach>
                                            ${totalQuantity}
                                    </h3>
                                    <p class="text-muted">Tổng số lượng sách</p>
                                </div>
                                <div class="col-md-4">
                                    <h3 class="text-warning">
                                        <c:set var="outOfStock" value="0"/>
                                        <c:forEach var="book" items="${books}">
                                            <c:if test="${book.quantity == 0}">
                                                <c:set var="outOfStock" value="${outOfStock + 1}"/>
                                            </c:if>
                                        </c:forEach>
                                            ${outOfStock}
                                    </h3>
                                    <p class="text-muted">Sách hết hàng</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:if>
        </div>
    </div>
</div>

<!-- Delete Confirmation Modal -->
<div class="modal fade" id="deleteModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Xác nhận xóa</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <p>Bạn có chắc chắn muốn xóa sách này không?</p>
                <p><strong>Mã sách:</strong> <span id="deleteBookCode"></span></p>
                <p><strong>Tiêu đề:</strong> <span id="deleteBookTitle"></span></p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                <form id="deleteForm" method="post" style="display: inline;">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="bookCode" id="deleteBookCodeInput">
                    <button type="submit" class="btn btn-danger">Xóa</button>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function confirmDelete(bookCode, bookTitle) {
        document.getElementById('deleteBookCode').textContent = bookCode;
        document.getElementById('deleteBookTitle').textContent = bookTitle;
        document.getElementById('deleteBookCodeInput').value = bookCode;
        document.getElementById('deleteForm').action = '<c:url value="/books"/>';
        new bootstrap.Modal(document.getElementById('deleteModal')).show();
    }
</script>
</body>
</html>