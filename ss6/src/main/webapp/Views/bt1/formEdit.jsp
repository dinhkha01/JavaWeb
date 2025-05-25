
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Chỉnh sửa sách - Quản lý Thư viện</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title mb-0">
                        <i class="fas fa-edit"></i> Chỉnh sửa thông tin sách
                    </h3>
                </div>
                <div class="card-body">
                    <!-- Error Message -->
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger" role="alert">
                            <i class="fas fa-exclamation-circle"></i> <c:out value="${error}"/>
                        </div>
                    </c:if>

                    <c:if test="${not empty book}">
                        <form method="post" action="<c:url value='/books'/>" id="editBookForm">
                            <input type="hidden" name="action" value="update">

                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="bookCode" class="form-label">
                                            <i class="fas fa-barcode"></i> Mã sách
                                        </label>
                                        <input type="text" class="form-control" id="bookCode" name="bookCode"
                                               value="<c:out value='${book.bookCode}'/>" readonly>
                                        <div class="form-text">Mã sách không thể thay đổi</div>
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="quantity" class="form-label">
                                            <i class="fas fa-sort-numeric-up"></i> Số lượng <span class="text-danger">*</span>
                                        </label>
                                        <input type="number" class="form-control" id="quantity" name="quantity"
                                               value="<c:out value='${book.quantity}'/>"
                                               min="0" placeholder="Nhập số lượng" required>
                                    </div>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="title" class="form-label">
                                    <i class="fas fa-book"></i> Tiêu đề <span class="text-danger">*</span>
                                </label>
                                <input type="text" class="form-control" id="title" name="title"
                                       value="<c:out value='${book.title}'/>"
                                       placeholder="Nhập tiêu đề sách" required>
                            </div>

                            <div class="mb-3">
                                <label for="author" class="form-label">
                                    <i class="fas fa-user-edit"></i> Tác giả <span class="text-danger">*</span>
                                </label>
                                <input type="text" class="form-control" id="author" name="author"
                                       value="<c:out value='${book.author}'/>"
                                       placeholder="Nhập tên tác giả" required>
                            </div>

                            <div class="mb-3">
                                <label for="genre" class="form-label">
                                    <i class="fas fa-tags"></i> Thể loại <span class="text-danger">*</span>
                                </label>
                                <select class="form-select" id="genre" name="genre" required>
                                    <option value="">-- Chọn thể loại --</option>
                                    <option value="Văn học" <c:if test="${book.genre == 'Văn học'}">selected</c:if>>Văn học</option>
                                    <option value="Khoa học" <c:if test="${book.genre == 'Khoa học'}">selected</c:if>>Khoa học</option>
                                    <option value="Công nghệ" <c:if test="${book.genre == 'Công nghệ'}">selected</c:if>>Công nghệ</option>
                                    <option value="Lịch sử" <c:if test="${book.genre == 'Lịch sử'}">selected</c:if>>Lịch sử</option>
                                    <option value="Tâm lý" <c:if test="${book.genre == 'Tâm lý'}">selected</c:if>>Tâm lý</option>
                                    <option value="Kinh tế" <c:if test="${book.genre == 'Kinh tế'}">selected</c:if>>Kinh tế</option>
                                    <option value="Giáo dục" <c:if test="${book.genre == 'Giáo dục'}">selected</c:if>>Giáo dục</option>
                                    <option value="Thiếu nhi" <c:if test="${book.genre == 'Thiếu nhi'}">selected</c:if>>Thiếu nhi</option>
                                    <option value="Trinh thám" <c:if test="${book.genre == 'Trinh thám'}">selected</c:if>>Trinh thám</option>
                                    <option value="Tiểu thuyết" <c:if test="${book.genre == 'Tiểu thuyết'}">selected</c:if>>Tiểu thuyết</option>
                                    <option value="Khác" <c:if test="${book.genre == 'Khác'}">selected</c:if>>Khác</option>
                                </select>
                            </div>

                            <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                <a href="<c:url value='/books'/>" class="btn btn-secondary me-md-2">
                                    <i class="fas fa-arrow-left"></i> Quay lại
                                </a>
                                <button type="reset" class="btn btn-outline-secondary me-md-2" onclick="resetForm()">
                                    <i class="fas fa-undo"></i> Khôi phục
                                </button>
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save"></i> Cập nhật
                                </button>
                            </div>
                        </form>
                    </c:if>

                    <c:if test="${empty book}">
                        <div class="alert alert-warning" role="alert">
                            <i class="fas fa-exclamation-triangle"></i>
                            Không tìm thấy thông tin sách để chỉnh sửa.
                            <a href="<c:url value='/books'/>" class="alert-link">Quay lại danh sách</a>
                        </div>
                    </c:if>
                </div>
            </div>

            <!-- Book Information Display -->
            <c:if test="${not empty book}">
                <div class="card mt-4">
                    <div class="card-header">
                        <h5 class="card-title mb-0">
                            <i class="fas fa-info-circle"></i> Thông tin hiện tại
                        </h5>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6">
                                <p><strong>Mã sách:</strong> <c:out value="${book.bookCode}"/></p>
                                <p><strong>Tiêu đề:</strong> <c:out value="${book.title}"/></p>
                                <p><strong>Tác giả:</strong> <c:out value="${book.author}"/></p>
                            </div>
                            <div class="col-md-6">
                                <p><strong>Thể loại:</strong> <c:out value="${book.genre}"/></p>
                                <p><strong>Số lượng:</strong>
                                    <span class="badge ${book.quantity > 0 ? 'bg-success' : 'bg-danger'}">
                                            <c:out value="${book.quantity}"/>
                                        </span>
                                </p>
                                <p><strong>Trạng thái:</strong>
                                    <span class="badge ${book.quantity > 0 ? 'bg-success' : 'bg-warning'}">
                                            ${book.quantity > 0 ? 'Còn hàng' : 'Hết hàng'}
                                    </span>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Help Section -->
                <div class="card mt-4">
                    <div class="card-header">
                        <h5 class="card-title mb-0">
                            <i class="fas fa-lightbulb"></i> Lưu ý
                        </h5>
                    </div>
                    <div class="card-body">
                        <ul class="list-unstyled">
                            <li><i class="fas fa-check text-success"></i> Mã sách không thể thay đổi sau khi tạo</li>
                            <li><i class="fas fa-check text-success"></i> Tất cả các trường có dấu <span class="text-danger">*</span> là bắt buộc</li>
                            <li><i class="fas fa-check text-success"></i> Số lượng phải là số nguyên không âm</li>
                            <li><i class="fas fa-check text-success"></i> Thay đổi sẽ được lưu ngay lập tức</li>
                        </ul>
                    </div>
                </div>
            </c:if>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Store original values for reset functionality
    const originalValues = {
        title: '<c:out value="${book.title}" escapeXml="false"/>',
        author: '<c:out value="${book.author}" escapeXml="false"/>',
        genre: '<c:out value="${book.genre}" escapeXml="false"/>',
        quantity: '<c:out value="${book.quantity}"/>'
    };

    // Form validation
    document.getElementById('editBookForm').addEventListener('submit', function(e) {
        const title = document.getElementById('title').value.trim();
        const author = document.getElementById('author').value.trim();
        const genre = document.getElementById('genre').value;
        const quantity = document.getElementById('quantity').value;

        if (!title || !author || !genre || quantity === '') {
            e.preventDefault();
            alert('Vui lòng điền đầy đủ thông tin bắt buộc!');
            return false;
        }

        if (parseInt(quantity) < 0) {
            e.preventDefault();
            alert('Số lượng không được âm!');
            return false;
        }

        // Confirm update
        if (!confirm('Bạn có chắc chắn muốn cập nhật thông tin sách này?')) {
            e.preventDefault();
            return false;
        }
    });

    // Reset form to original values
    function resetForm() {
        document.getElementById('title').value = originalValues.title;
        document.getElementById('author').value = originalValues.author;
        document.getElementById('genre').value = originalValues.genre;
        document.getElementById('quantity').value = originalValues.quantity;
    }

    // Highlight changes
    function highlightChanges() {
        const fields = ['title', 'author', 'genre', 'quantity'];
        fields.forEach(field => {
            const element = document.getElementById(field);
            const originalValue = originalValues[field];
            if (element.value !== originalValue) {
                element.classList.add('border-warning');
            } else {
                element.classList.remove('border-warning');
            }
        });
    }

    // Add event listeners to highlight changes
    ['title', 'author', 'genre', 'quantity'].forEach(field => {
        document.getElementById(field).addEventListener('input', highlightChanges);
        document.getElementById(field).addEventListener('change', highlightChanges);
    });
</script>
</body>
</html>