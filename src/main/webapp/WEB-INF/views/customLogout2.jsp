<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="includes/header.jsp" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>Logout Page</title>

    <!-- ✅ Bootstrap & jQuery -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <script src="/resources/vendor/jquery/jquery.min.js"></script>
    <script src="/resources/vendor/bootstrap/js/bootstrap.min.js"></script>

    <!-- ✅ FontAwesome (optional) -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

    <style>
        .center-container {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background-color: #f9f9f9;
        }

        .login-panel {
            max-width: 400px;
            width: 100%;
            padding: 30px;
            background: white;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }

        .message-box {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 4px;
            text-align: center;
            font-size: 15px;
        }

        .error-box {
            background-color: #f2dede;
            border: 1px solid #ebccd1;
            color: #a94442;
        }

        .success-box {
            background-color: #dff0d8;
            border: 1px solid #d6e9c6;
            color: #3c763d;
        }

        .pepe-img-small {
            max-width: 80px;
            height: auto;
            margin-bottom: 10px;
            border-radius: 5px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
    </style>
</head>

<body>
    <div class="center-container">
        <div class="login-panel">
            <div class="text-center mb-4">
                <h3>Logout Page</h3>
            </div>

            <!-- 에러 메시지 -->
            <c:if test="${not empty error}">
                <div class="message-box error-box">
                    <img src="/resources/img/${error}" alt="페페는 슬프다..." class="pepe-img-small" />
                    <p>페페는 화가 났어요...<br>아이디나 비밀번호가 잘못된 것 같아요.</p>
                </div>
            </c:if>

            <!-- 로그아웃 메시지 -->
            <c:if test="${not empty logout}">
                <div class="message-box success-box">
                    <img src="/resources/img/sYSJY7DwDYvqCrRvxzAgqpbm7EQzxE6jKPBhRBJGLwRzWvA-uj3YEQjgAVfR1snu3tian_0NYAtv2b06664WkA.webp" alt="페페는 간다..." class="pepe-img-small" />
                    <p><c:out value="${logout}" /></p>
                </div>
            </c:if>

            <!-- 로그아웃 버튼 -->
            <form method="post" action="/customLogout">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                <button type="submit" class="btn btn-success w-100">
                    <i class="fas fa-sign-out-alt"></i> Logout
                </button>
            </form>
        </div>
    </div>
</body>

</html>
