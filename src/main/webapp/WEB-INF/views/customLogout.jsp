<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="includes/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Logout Page</title>

  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

  <style>
    body {
      font-family: 'Helvetica Neue', sans-serif;
      background-color: #f8f9fa;
      margin: 0;
      padding: 0;
      color: #171a20;
    }

    .center-container {
      display: flex;
      justify-content: center;
      align-items: center;
      min-height: 100vh;
      padding: 20px;
    }

    .logout-panel {
      width: 100%;
      max-width: 400px;
      padding: 40px;
      background: #fff;
      border-radius: 12px;
      box-shadow: 0 0 20px rgba(0,0,0,0.08);
      text-align: center;
    }

    h3 {
      margin-bottom: 30px;
    }

    .btn {
      width: 100%;
      padding: 12px;
      background-color: #171a20;
      color: white;
      border: none;
      border-radius: 6px;
      font-size: 16px;
      cursor: pointer;
      transition: background-color 0.3s ease;
    }

    .btn:hover {
      background-color: #2e2e2e;
    }

    .message-box {
      padding: 15px;
      margin-bottom: 20px;
      border-radius: 8px;
      font-size: 15px;
    }

    .error-box {
      background-color: #fff5f5;
      border: 1px solid #ed4e3b;
      color: #c53030;
    }

    .success-box {
      background-color: #e6ffed;
      border: 1px solid #38a169;
      color: #2f855a;
    }

    .pepe-img-small {
      max-width: 300px;
      margin-bottom: 10px;
      border-radius: 5px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    }
  </style>
</head>
<body>

  <div class="center-container">
    <div class="logout-panel">
      <h3>Logout Page</h3>

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
        <button type="submit" class="btn">
          <i class="fas fa-sign-out-alt"></i> Logout
        </button>
      </form>
    </div>
  </div>

</body>
</html>
