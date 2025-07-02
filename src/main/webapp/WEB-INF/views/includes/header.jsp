<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>팔도마켓</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="/resources/dist/css/main.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

  <style>
    #playButton {
        position: absolute;
        bottom: 10px;
        left: 50%;
        transform: translateX(-50%);
        padding: 10px 20px;
        font-size: 16px;
        background-color: #111;
        color: white;
        border: none;
        border-radius: 8px;
        cursor: pointer;
        opacity: 0.85;
    }
    
  </style>
</head>
<body>
   <nav class="nav-bar">
        <div class="nav-logo">
  <a href="/" style="text-decoration: none; color: inherit;">
  <img src="/resources/images/KakaoTalk_20250518_163345571.png" alt="팔도마켓" class="logo-img" /> 팔도마켓
</a>
      </div>
        <div class="nav-menu">
            <a href="/">홈</a>
            <a href="/board/list">게시판</a>
            <a href="/board/register">글쓰기</a>
            <a href="/board/user/mypage">마이페이지</a>
           <sec:authorize access="isAuthenticated()">
       	   <a href="/customLogout"><i class="fas fa-sign-out-alt"></i> Logout</a>
           </sec:authorize>
           <sec:authorize access="isAnonymous()">
       	   <a href="/customLogin"><i class="fas fa-right-to-bracket fa-fw"></i> Login</a>
           </sec:authorize>
           
        </div>
    </nav>
