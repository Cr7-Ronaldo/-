<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ include file="../includes/header.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>팔도마켓 | 마이페이지</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/dist/css/main.css" />
  <style>
    .mypage-container {
      max-width: 800px;
      margin: 50px auto;
      padding: 30px;
      background: #ffffff;
      border-radius: 12px;
    }
    .mypage-header {
      font-size: 28px;
      margin-bottom: 30px;
      border-bottom: 2px solid #ccc;
      padding-bottom: 10px;
    }
    .mypage-section {
      margin-bottom: 30px;
    }
    .mypage-section h4 {
      font-size: 20px;
      margin-bottom: 15px;
    }
    .mypage-button {
      display: inline-block;
      margin-right: 10px;
      padding: 10px 20px;
      background-color: #444;
      color: white;
      border-radius: 8px;
      text-decoration: none;
    }
  </style>
</head>
<body>

<div class="mypage-container">
  <div class="mypage-header">👤 마이페이지</div>

  <div class="mypage-section">
    <h4>회원 정보</h4>
    <p><strong>닉네임:</strong> ${user.nickname}</p>
    <p><strong>이메일:</strong> ${user.email}</p>
  </div>

  <div class="mypage-section">
    <h4>내 게시글</h4>
    <c:forEach items="${myPosts}" var="post">
      <div class="card" style="width: 28%; height: 300px; border: 1px solid #ccc; border-radius: 12px; padding: 15px; cursor: pointer; display: flex; flex-direction: column; justify-content: space-between;" 
	             onclick="location.href='/board/get?boardid=${post.boardid}'">
	            <!-- 이미지 -->
	            <img src="${post.imgPath}" alt="${post.title}" style="width: 100%; height: 200px; object-fit: cover; border-radius: 10px;">
	            <div style="font-weight: bold; margin-top: 8px;">${post.title}</div>
	            <div style="color: gray; font-size: 14px;">₩ <fmt:formatNumber value="${post.price}" type="number" /></div>
	        </div>
    </c:forEach>
    </div>
 

  <div class="mypage-section">
    <h4>계정 관리</h4>
    <a class="mypage-button" href="${pageContext.request.contextPath}/user/changePwd">비밀번호 변경</a>
    <a class="mypage-button" href="${pageContext.request.contextPath}/customLogout">로그아웃</a>
  </div>
</div>

</body>
</html>
