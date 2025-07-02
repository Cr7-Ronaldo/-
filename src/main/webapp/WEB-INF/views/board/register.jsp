<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="../includes/header.jsp" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>팔도마켓 | 중고폰 상품등록</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@700&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/dist/css/main.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/dist/css/product.css" />
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

<div class="product-register-container">
    <h2 class="form-title">😎 중고폰 상품등록</h2>

    <form action="${pageContext.request.contextPath}/board/register" 
          method="post" 
          enctype="multipart/form-data" 
          class="product-form">

        <div class="form-group">
            <label>대표 이미지 <span class="required">*</span></label>
            <input type="file" name="mainImage" accept="image/*" required />
        </div>

        <div class="form-group">
            <label>제목 <span class="required">*</span></label>
            <input type="text" name="title" required placeholder="예: 아이폰 13 미드나이트" />
        </div>

        <div class="form-group">
            <label>모델명 <span class="required">*</span></label>
            <input type="text" name="product.modelname" required placeholder="예: 아이폰 13" />
        </div>

        <div class="form-group">
            <label>가격 <span class="required">*</span></label>
            <input type="number" name="product.price" required placeholder="예: 650000" />
        </div>

        <select name="product.brand" required>
            <option value="">선택하세요</option>
            <option value="Apple">Apple</option>
            <option value="Samsung">Samsung</option>
            <option value="Sony">Sony</option>
            <option value="LG">LG</option>
            <option value="기타">기타</option>
        </select>

        <div class="form-group">
            <label>상품 상태 <span class="required">*</span></label>
            <div class="option-group">
                <input type="radio" id="cond1" name="product.condition" value="S" checked />
                <label for="cond1" class="btn-radio">S</label>
                <input type="radio" id="cond2" name="product.condition" value="A" />
                <label for="cond2" class="btn-radio">A</label>
                <input type="radio" id="cond3" name="product.condition" value="B" />
                <label for="cond3" class="btn-radio">B</label>
                <input type="radio" id="cond4" name="product.condition" value="C" />
                <label for="cond4" class="btn-radio">C</label>
            </div>
        </div>

        <div class="form-group">
            <label>판매 상태</label>
            <div class="option-group">
                <input type="radio" id="stat1" name="status" value="판매중" checked />
                <label for="stat1" class="btn-radio">판매중</label>
            </div>
        </div>

        <div class="form-group">
            <label>닉네임 <span class="required">*</span></label>
            <input type="text" name="user.nickname" value="${pageContext.request.userPrincipal.name}" readonly />
        </div>

        <input type="hidden" name="user.pwd" id="hiddenPwdInput" />
		
		
        <div class="form-group">
            <label>설명 <span class="required">*</span></label>
            <textarea name="product.description" rows="6" minlength="20" required placeholder="20자 이상 상세 설명을 작성해 주세요."></textarea>
        </div>

        <div class="form-actions">
           <button type="button" class="btn-blue" id="openPwdModalBtn">비밀번호 확인 후 등록</button>
        </div>
    </form>
</div>

<!-- ✅ Bootstrap 5 비밀번호 확인 모달 -->
<div class="modal fade" id="pwdModal" tabindex="-1" aria-labelledby="pwdModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content rounded-3 shadow">
      <div class="modal-header">
        <h5 class="modal-title" id="pwdModalLabel">🔐 비밀번호 확인</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
      </div>
      <div class="modal-body">
        <input type="password" id="modalPwd" class="form-control" placeholder="비밀번호 입력" />
        <div id="pwdError" class="alert alert-danger mt-2 d-none" role="alert"></div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
        <button type="button" class="btn btn-primary" id="confirmPwdBtn">확인</button>
      </div>
    </div>
  </div>
</div>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
  document.addEventListener('DOMContentLoaded', function () {
    const pwdModalElement = document.getElementById('pwdModal');
    const pwdModal = new bootstrap.Modal(pwdModalElement);
    const form = document.querySelector(".product-form");
    const modalPwdInput = document.getElementById("modalPwd");
    const errorBox = document.getElementById("pwdError");
    const confirmBtn = document.getElementById("confirmPwdBtn");

    // 모달 트리거 버튼
    document.getElementById("openPwdModalBtn").addEventListener("click", function () {
      pwdModal.show();
      setTimeout(() => modalPwdInput.focus(), 300);
    });

    // 확인 버튼 클릭 시
    confirmBtn.addEventListener('click', function () {
	  const inputPwd = modalPwdInput.value.trim();
	
	  fetch("${pageContext.request.contextPath}/checkPwd", {
	    method: 'POST',
	    headers: { 'Content-Type': 'application/json' },
	    body: JSON.stringify({ pwd: inputPwd })
	  })
	    .then(response => response.text())
	    .then(result => {
	      if (result === 'success') {
	        // 확인되면 hidden input에 비밀번호 설정
	        document.getElementById("hiddenPwdInput").value = inputPwd;
	        form.submit();
	      } else {
	        errorBox.textContent = "❌ 비밀번호가 일치하지 않습니다.";
	        errorBox.classList.remove("d-none");
	      }
	    });
	});

    // 엔터 키로도 확인 가능
    modalPwdInput.addEventListener('keydown', function (e) {
      if (e.key === 'Enter') confirmBtn.click();
    });

    // 모달 닫힐 때 초기화
    pwdModalElement.addEventListener('hidden.bs.modal', function () {
      modalPwdInput.value = '';
      errorBox.classList.add("d-none");
      errorBox.textContent = '';
    });
  });
</script>



</body>
</html>
