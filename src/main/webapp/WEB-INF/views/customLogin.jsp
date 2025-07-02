<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="includes/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Login</title>
  <style>
    body {
      font-family: 'Helvetica Neue', sans-serif;
      background-color: #f8f9fa;
      margin: 0;
      padding: 0;
      color: #171a20;
    }

    .container {
      max-width: 400px;
      margin: 100px auto;
      padding: 40px;
      background: #fff;
      border-radius: 12px;
      box-shadow: 0 0 20px rgba(0,0,0,0.08);
    }

    h1 {
      text-align: center;
      margin-bottom: 30px;
    }

    .form-item {
      margin-bottom: 20px;
    }

    .form-item input {
      width: 100%;
      padding: 12px;
      border: 1px solid #ccc;
      border-radius: 6px;
      font-size: 16px;
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

    .error-box {
      background-color: #fff5f5;
      border: 1px solid #ed4e3b;
      padding: 15px;
      border-radius: 8px;
      margin-bottom: 20px;
      text-align: center;
    }

    .error-box img {
      max-width: 300px;
      margin-bottom: 10px;
    }
     img {
      max-width: 320px;
      margin-bottom: 10px;
    }

    .logout-msg {
      text-align: center;
      color: #28a745;
      font-weight: bold;
      margin-top: 10px;
    }
  </style>
</head>
<body>

  <div class="container">
    <h1>로그인</h1>

    <c:if test="${not empty error}">
      <div class="error-box">
        <img src="/resources/img/${error}" alt="에러 이미지" />
        <p>똑바로 입력해!!!!!!!</p>
      </div>
    </c:if>

    <c:if test="${not empty logout}">
      <div class="logout-msg">
        <c:out value="${logout}" />
      </div>
    </c:if>
    <c:if test="${empty error}">
	<img src="/resources/img/M16192601962560392.gif" alt="이미지" />
        
    </c:if>
    <form action="/login" method="post">
      <div class="form-item">
        <input type="text" name="userid" placeholder="아이디 입력" value="user149" required>
      </div>
      <div class="form-item">
        <input type="password" name="password" placeholder="비밀번호 입력" value="1234" required>
      </div>
      <div class="form-item">
        <button type="submit" class="btn">로그인</button>
      </div>

      <%-- CSRF 토큰 생략 시 주의: 보안 설정 시 필수 --%>
       <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
    </form>
  </div>

</body>
</html>
