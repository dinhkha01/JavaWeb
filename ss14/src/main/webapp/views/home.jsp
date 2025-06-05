<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="${currentLang}">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${homeTitle}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
        }
        .container {
            max-width: 1000px;
        }
        .header {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            padding: 2rem;
            margin: 2rem 0;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
        }
        .language-selector {
            background: rgba(255, 255, 255, 0.9);
            border-radius: 10px;
            padding: 1rem;
            margin-bottom: 2rem;
        }
        .content-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            padding: 2rem;
            margin: 1rem 0;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;
        }
        .content-card:hover {
            transform: translateY(-5px);
        }
        .btn-language {
            margin: 0 0.5rem;
            padding: 0.5rem 1.5rem;
            border: none;
            border-radius: 25px;
            background: linear-gradient(45deg, #667eea, #764ba2);
            color: white;
            transition: all 0.3s ease;
        }
        .btn-language:hover {
            transform: scale(1.05);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
        }
        .btn-language.active {
            background: linear-gradient(45deg, #764ba2, #667eea);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.3);
        }
        .welcome-title {
            color: #333;
            font-weight: bold;
            margin-bottom: 1.5rem;
        }
        .section-title {
            color: #667eea;
            font-weight: bold;
            margin-bottom: 1rem;
            border-bottom: 2px solid #667eea;
            padding-bottom: 0.5rem;
        }
        .feature-item {
            background: rgba(102, 126, 234, 0.1);
            border-left: 4px solid #667eea;
            padding: 1rem;
            margin: 0.5rem 0;
            border-radius: 0 10px 10px 0;
        }
    </style>
</head>
<body>
<div class="container">
    <!-- Header với chào mừng -->
    <div class="header text-center">
        <h1 class="welcome-title">${welcomeMessage}</h1>

        <!-- Language Selector -->
        <div class="language-selector">
            <label class="form-label fw-bold">${languageLabel}</label>
            <div class="mt-2">
                <!-- Sử dụng GET với URL parameter để thay đổi ngôn ngữ -->
                <a href="/?lang=en" class="btn btn-language ${currentLang eq 'en' ? 'active' : ''}" role="button">
                    ${englishLabel}
                </a>
                <a href="/?lang=vi" class="btn btn-language ${currentLang eq 'vi' ? 'active' : ''}" role="button">
                    ${vietnameseLabel}
                </a>
            </div>

            <!-- Thông tin hướng dẫn -->
            <div class="mt-3">
                <small class="text-muted">
                    <c:choose>
                        <c:when test="${currentLang eq 'vi'}">
                            💡 Bạn cũng có thể thay đổi ngôn ngữ bằng URL:
                            <code>?lang=en</code> hoặc <code>?lang=vi</code>
                        </c:when>
                        <c:otherwise>
                            💡 You can also change language via URL:
                            <code>?lang=en</code> or <code>?lang=vi</code>
                        </c:otherwise>
                    </c:choose>
                </small>
            </div>
        </div>
    </div>

    <!-- About Section -->
    <div class="content-card">
        <h2 class="section-title">${aboutTitle}</h2>
        <p class="lead">${aboutContent}</p>
    </div>

    <!-- Features Section -->
    <div class="content-card">
        <h2 class="section-title">${featuresTitle}</h2>
        <div class="feature-item">
            <strong>✓</strong> ${feature1}
        </div>
        <div class="feature-item">
            <strong>✓</strong> ${feature2}
        </div>
        <div class="feature-item">
            <strong>✓</strong> ${feature3}
        </div>
    </div>

    <!-- Contact Section -->
    <div class="content-card">
        <h2 class="section-title">${contactTitle}</h2>
        <p>${contactContent}</p>
    </div>

    <!-- Footer -->
    <div class="text-center mt-4 mb-4">
        <small class="text-light">
            <c:choose>
                <c:when test="${currentLang eq 'vi'}">
                    Ngôn ngữ hiện tại: Tiếng Việt | Ứng dụng Spring MVC Đa Ngôn Ngữ
                </c:when>
                <c:otherwise>
                    Current Language: English | Spring MVC Multi-language Application
                </c:otherwise>
            </c:choose>
        </small>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Thêm hiệu ứng smooth cho các nút ngôn ngữ
    document.querySelectorAll('.btn-language').forEach(btn => {
        btn.addEventListener('click', function(e) {
            e.preventDefault();

            // Thêm hiệu ứng loading
            const originalText = this.innerHTML;
            this.innerHTML = '<span class="spinner-border spinner-border-sm" role="status"></span>';

            // Chuyển hướng sau hiệu ứng
            setTimeout(() => {
                window.location.href = this.href;
            }, 300);
        });
    });

    // Hiệu ứng fade in cho các card
    window.addEventListener('load', function() {
        const cards = document.querySelectorAll('.content-card, .header');
        cards.forEach((card, index) => {
            card.style.opacity = '0';
            card.style.transform = 'translateY(20px)';
            setTimeout(() => {
                card.style.transition = 'all 0.6s ease';
                card.style.opacity = '1';
                card.style.transform = 'translateY(0)';
            }, index * 200);
        });
    });

    // Hiển thị URL hiện tại với language parameter
    console.log('Current URL: ' + window.location.href);
    console.log('Current Language: ${currentLang}');
</script>
</body>
</html>