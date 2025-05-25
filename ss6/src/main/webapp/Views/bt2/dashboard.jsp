<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Trang Chủ</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
        }
        .navbar {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .dashboard-container {
            margin-top: 2rem;
        }
        .welcome-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            border: none;
            overflow: hidden;
        }
        .welcome-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 2rem;
        }
        .info-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
            border: none;
            transition: transform 0.3s ease;
        }
        .info-card:hover {
            transform: translateY(-5px);
        }
        .info-card .card-header {
            border: none;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            font-weight: 600;
        }
        .btn-logout {
            background: linear-gradient(135deg, #ff6b6b 0%, #ee5a52 100%);
            border: none;
            border-radius: 25px;
            padding: 8px 20px;
            font-weight: 600;
        }
        .btn-logout:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 107, 107, 0.4);
        }
        .user-avatar {
            width: 80px;
            height: 80px;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2rem;
            margin-bottom: 1rem;
        }
    </style>
</head>
<body>
<!-- Navigation Bar -->
<nav class="navbar navbar-expand-lg navbar-dark">
    <div class="container">
        <a class="navbar-brand" href="#">
            <i class="fas fa-tachometer-alt me-2"></i>Dashboard
        </a>
        <div class="navbar-nav ms-auto">
                <span class="navbar-text me-3">
                    <i class="fas fa-user me-2"></i>Chào mừng, ${user.userName}!
                </span>
            <a href="${request.contextPath}/logout" class="btn btn-logout">
                <i class="fas fa-sign-out-alt me-2"></i>Đăng xuất
            </a>
        </div>
    </div>
</nav>

<div class="container dashboard-container">
    <!-- Welcome Card -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="card welcome-card">
                <div class="welcome-header text-center">
                    <div class="user-avatar mx-auto">
                        <i class="fas fa-user"></i>
                    </div>
                    <h2>Chào mừng bạn trở lại!</h2>
                    <p class="mb-0">Chúc bạn có một ngày làm việc hiệu quả</p>
                </div>
                <div class="card-body p-4">
                    <div class="row text-center">
                        <div class="col-md-3">
                            <div class="p-3">
                                <i class="fas fa-calendar-day fa-2x text-primary mb-2"></i>
                                <h5>Hôm nay</h5>
                                <p class="text-muted mb-0" id="currentDate"></p>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="p-3">
                                <i class="fas fa-clock fa-2x text-success mb-2"></i>
                                <h5>Thời gian</h5>
                                <p class="text-muted mb-0" id="currentTime"></p>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="p-3">
                                <i class="fas fa-user-check fa-2x text-info mb-2"></i>
                                <h5>Trạng thái</h5>
                                <p class="text-muted mb-0">Đang hoạt động</p>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="p-3">
                                <i class="fas fa-shield-alt fa-2x text-warning mb-2"></i>
                                <h5>Bảo mật</h5>
                                <p class="text-muted mb-0">An toàn</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- User Information -->
    <div class="row">
        <div class="col-md-6 mb-4">
            <div class="card info-card h-100">
                <div class="card-header">
                    <i class="fas fa-user-circle me-2"></i>Thông tin cá nhân
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-sm-4"><strong>Tên:</strong></div>
                        <div class="col-sm-8">${user.userName}</div>
                    </div>
                    <hr>
                    <div class="row">
                        <div class="col-sm-4"><strong>Email:</strong></div>
                        <div class="col-sm-8">${user.email}</div>
                    </div>
                    <hr>
                    <div class="row">
                        <div class="col-sm-4"><strong>Điện thoại:</strong></div>
                        <div class="col-sm-8">
                            <c:choose>
                                <c:when test="${not empty user.phone}">
                                    ${user.phone}
                                </c:when>
                                <c:otherwise>
                                    <span class="text-muted">Chưa cập nhật</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    <hr>
                    <div class="row">
                        <div class="col-sm-4"><strong>ID:</strong></div>
                        <div class="col-sm-8">#${user.id}</div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-6 mb-4">
            <div class="card info-card h-100">
                <div class="card-header">
                    <i class="fas fa-chart-line me-2"></i>Thống kê hệ thống
                </div>
                <div class="card-body">
                    <div class="row text-center">
                        <div class="col-6 mb-3">
                            <div class="p-3">
                                <i class="fas fa-users fa-2x text-primary mb-2"></i>
                                <h4>1,234</h4>
                                <small class="text-muted">Người dùng</small>
                            </div>
                        </div>
                        <div class="col-6 mb-3">
                            <div class="p-3">
                                <i class="fas fa-file-alt fa-2x text-success mb-2"></i>
                                <h4>5,678</h4>
                                <small class="text-muted">Tài liệu</small>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="p-3">
                                <i class="fas fa-download fa-2x text-info mb-2"></i>
                                <h4>9,012</h4>
                                <small class="text-muted">Tải xuống</small>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="p-3">
                                <i class="fas fa-star fa-2x text-warning mb-2"></i>
                                <h4>4.8</h4>
                                <small class="text-muted">Đánh giá</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Quick Actions -->
    <div class="row">
        <div class="col-12">
            <div class="card info-card">
                <div class="card-header">
                    <i class="fas fa-bolt me-2"></i>Thao tác nhanh
                </div>
                <div class="card-body">
                    <div class="row text-center">
                        <div class="col-md-3 mb-3">
                            <button class="btn btn-outline-primary btn-lg w-100">
                                <i class="fas fa-edit fa-2x mb-2 d-block"></i>
                                Chỉnh sửa hồ sơ
                            </button>
                        </div>
                        <div class="col-md-3 mb-3">
                            <button class="btn btn-outline-success btn-lg w-100">
                                <i class="fas fa-upload fa-2x mb-2 d-block"></i>
                                Tải lên tài liệu
                            </button>
                        </div>
                        <div class="col-md-3 mb-3">
                            <button class="btn btn-outline-info btn-lg w-100">
                                <i class="fas fa-chart-bar fa-2x mb-2 d-block"></i>
                                Xem báo cáo
                            </button>
                        </div>
                        <div class="col-md-3 mb-3">
                            <button class="btn btn-outline-warning btn-lg w-100">
                                <i class="fas fa-cog fa-2x mb-2 d-block"></i>
                                Cài đặt
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
    // Cập nhật thời gian thực
    function updateTime() {
        const now = new Date();
        const timeString = now.toLocaleTimeString('vi-VN');
        const dateString = now.toLocaleDateString('vi-VN', {
            weekday: 'long',
            year: 'numeric',
            month: 'long',
            day: 'numeric'
        });

        document.getElementById('currentTime').textContent = timeString;
        document.getElementById('currentDate').textContent = dateString;
    }

    // Cập nhật thời gian mỗi giây
    updateTime();
    setInterval(updateTime, 1000);

    // Hiệu ứng hover cho các nút
    document.querySelectorAll('.btn-outline-primary, .btn-outline-success, .btn-outline-info, .btn-outline-warning').forEach(btn => {
        btn.addEventListener('mouseenter', function() {
            this.style.transform = 'translateY(-3px)';
        });

        btn.addEventListener('mouseleave', function() {
            this.style.transform = 'translateY(0)';
        });
    });
</script>
</body>
</html>