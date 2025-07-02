<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>    
<%@ include file="../includes/header.jsp" %>
<%@ page isELIgnored="false" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/dist/css/product-detail.css">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@700&display=swap" rel="stylesheet">
<!-- 브랜드 로고 -->
<head>
    <meta charset="UTF-8">
    <title>팔도마켓 | 메인</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="/resources/dist/css/main.css">
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

<pre>${sessionScope}</pre>
<pre>${sessionScope.loginUser}</pre>

<div class="container py-4">
  <div class="row mb-4 align-items-left">
    <div class="col-lg-12 d-flex align-items-center justify-content-center">
      <c:choose>
        <c:when test="${dto.product.brand eq 'Apple'}">
          <img src="/resources/images/apple_logo_icon_168588.webp" alt="Apple" style="height: 76px;">
        </c:when>
        <c:when test="${dto.product.brand eq 'Samsung'}">
          <img src="/resources/images/Samsung_Logo.svg.webp" alt="Samsung" style="height: 62px;">
        </c:when>
        <c:when test="${dto.product.brand eq 'Sony'}">
          <img src="/resources/images/sonylogo.png" alt="Sony" style="height: 90px;">
        </c:when>
        <c:when test="${dto.product.brand eq 'LG'}">
          <img src="/resources/images/LG_logo_(2014).svg" alt="LG" style="height: 62px;">
        </c:when>
        <c:otherwise>
          <span class="text-muted">브랜드 없음</span>
        </c:otherwise>
      </c:choose>
    </div>
  </div>

  <!-- 상세 페이지 본문 -->
  <div class="product-detail-container">
    <div class="product-images">
      <div class="main-image">
        <img src="<c:url value='${dto.imgPaths[0].imgPath}'/>" alt="대표 이미지" />
      </div>
      <div class="thumb-list">
        <c:forEach var="img" items="${board.imgPaths}">
          <div class="thumb"><img src="<c:url value='/resources/${img.imgPath}'/>" alt="썸네일" /></div>
        </c:forEach>
      </div>
    </div>

    <div class="product-info">
      <nav class="breadcrumb">
        <a href="<c:url value='/'/>">HOME</a> &gt;
        <a href="<c:url value='/board/list'/>">전체 리스트</a> &gt;
        <span><c:out value="${dto.board.title}"/></span>
      </nav>

      <div class="product-title">
        <c:out value="${dto.board.title}"/>
      </div>
      <div class="model">
        <c:out value="${dto.product.modelname}"/>
      </div>
      <div class="brand">
        브랜드: ${dto.product.brand}
      </div>
      
      <div>
        판매자: ${dto.user.nickname}
      </div>
        
      <span class="reg-date">
        등록일: <fmt:formatDate value="${dto.board.regDate}" pattern="yyyy-MM-dd"/>
      </span>

      <div class="mb-3">
        <span class="sale-price">
         ₩ <fmt:formatNumber value="${dto.product.price}" pattern="#,/###"/>원
        </span>
      </div>

      <div>
        <span class="option active">상태 : ${dto.product.condition}급</span>
      </div>

      <div class="status-message">
        판매상태: ${dto.board.status}
      </div>

      <form class="purchase-form" onsubmit="return false;">
        <div class="purchase-row">
          <label for="quantity">구매 수량</label>
          <input type="text" id="quantity" class="qty" value="1" readonly>
          <span class="sum-price">
            총 금액: <fmt:formatNumber value="${dto.product.price}" pattern="#,/###"/>원
          </span>
        </div>
        <button type="button" class="btn-blue btn-purchase" disabled>즉시 구매하기</button>
      </form>

      <div class="product-description">
        <p><c:out value="${dto.product.description}"/></p>
      </div>

      <div class="d-flex justify-content-end gap-2 mt-4">
        <button data-oper='modify' class="btn btn-warning">수정</button>
        <button data-oper='list' class="btn btn-outline-secondary">목록</button>
      </div>

      <form id="operForm" action="/board/modify" method="get">
        <input type="hidden" name="boardid" value='<c:out value="${dto.board.boardid}"/>'>
        <input type="hidden" name="pageNum" value='<c:out value="${cri.pageNum}"/>'>
        <input type="hidden" name="amount" value='<c:out value="${cri.amount}"/>'>
        <input type="hidden" name="type" value='<c:out value="${cri.type}"/>'>
        <input type="hidden" name="keyword" value='<c:out value="${cri.keyword}"/>'>
      </form>
    </div>
  </div>
</div>

<!-- 댓글 영역 -->
<div class="container mt-5">
  <div class="card">
    <div class="card-header bg-success text-white d-flex justify-content-between align-items-center">
      <span><i class="fa fa-comments"></i> 댓글</span>
      <button id="addReplyBtn" class="btn btn-light btn-sm">댓글 등록</button>
    </div>
    <div class="card-body">
      <ul class="list-group chat"></ul>
    </div>
    <div class="card-footer"></div>
    <div> <ul class="pagination"></ul>
  </div>
   </div>
</div>

<!-- 댓글 모달 -->
<div class="modal fade" id="myModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header bg-primary text-white">
        <h5 class="modal-title">댓글 등록/수정</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <div class="mb-3">
          <label>댓글 내용</label>
          <input class="form-control" name="reply" />
        </div>
        <div class="mb-3">
          <label>작성자</label>
         <input class="form-control" name="replyer" readonly />
        </div>
        <div class="mb-3">
          <label>작성일</label>
          <input class="form-control" name="replyDate" readonly />
        </div>
      </div>
      <div class="modal-footer">
        <button id="modalRegisterBtn" type="button" class="btn btn-success">등록</button>
        <button id="modalModBtn" type="button" class="btn btn-warning">수정</button>
        <button id="modalRemoveBtn" type="button" class="btn btn-danger">삭제</button>
        <button id="modalCloseBtn" type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>

<!-- JS -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="/resources/js/reply.js"></script>
<script>
$(document).ready(function() {
    let boardid = '<c:out value="${dto.board.boardid}" />';  // 게시글 번호
    let currentPage = 1; // 초기 페이지 설정
    let replyUL = $(".chat");

    // 댓글 목록을 불러오는 함수 호출 (페이지 1로 시작)
    showList(currentPage, boardid);

    // 댓글 목록 로드 함수
  function showList(page, boardid) {
    console.log("현재 페이지 (showList 함수):", page);
    replyService.getList({ boardid: boardid, page: page }, function(replyCnt, list) {
        if (page == -1) { // 마지막 페이지로 이동
            let pageNum = Math.ceil(replyCnt / 10.0); // 전체 댓글 수에서 마지막 페이지 계산
            showList(pageNum, boardid); // 마지막 페이지로 이동
            return;
        }

        let str = "";
        if (list == null || list.length == 0) {
            replyUL.html(""); // 댓글이 없으면 리스트 비우기
            return;
        }

        // 댓글 목록 생성
        for (let i = 0; i < list.length; i++) {
            console.log("댓글 ID (rno):", list[i].rno); // 여기서 rno 값을 확인
            if (!list[i].rno) {
                console.error("댓글 ID가 없습니다. rno 값 확인 필요.");
                continue; // rno 값이 없으면 해당 댓글을 건너뜁니다.
            }

            str += "<li class='list-group-item d-flex justify-content-between align-items-start' data-rno='" + list[i].rno + "'>";
            str += "<div>";
            str += "<div class='fw-bold'>" + list[i].replyer + "</div>";
            str += "<small class='text-muted'>" + replyService.displayTime(list[i].replyDate) + "</small>";
            str += "<p>" + list[i].reply + "</p>";
            str += "</div>";
            str += "<div>";
            str += "<button class='btn btn-sm btn-warning editReplyBtn' data-id='" + list[i].rno + "' data-text='" + list[i].reply + "'>수정</button>";
            str += "<button class='btn btn-sm btn-danger removeReplyBtn' data-id='" + list[i].rno + "'>삭제</button>";  // rno를 data-id로 설정
            str += "</div>";
            str += "</li>";
	        }
	        replyUL.html(str); // 댓글 목록 업데이트
	        showReplyPage(replyCnt); // 페이지네이션 업데이트
	    });
	}


    // 댓글 등록 요청
    $("#modalRegisterBtn").on("click", function() {
        const reply = {
            reply: $("input[name='reply']").val(),
            replyer: $("input[name='replyer']").val(),
            boardid: boardid // 서버에서 전달된 boardid 사용
        };

        $.ajax({
            type: "post",
            url: "/replies/new",
            data: JSON.stringify(reply),
            contentType: "application/json; charset=utf-8",
            success: function(result) {
                alert("댓글 등록 성공!");
                $("#myModal").modal("hide");
                addNewReply(result); // 새 댓글만 추가
            },
            error: function(xhr, status, err) {
                alert("댓글 등록 실패: " + err);
            }
        });
    });

    // 댓글 수정 및 삭제 버튼 클릭 시 이벤트 처리
    $(document).on("click", ".editReplyBtn", function() {
    	let rno = $(this).attr("data-id");
    	console.log("댓글 수정 ID (rno):", rno);
        let replyText = $(this).data("text");

        $("input[name='reply']").val(replyText);
        $("input[name='rno']").val(rno);  // 수정할 댓글의 ID를 input에 저장
        $("input[name='replyer']").val("${sessionScope.loginUser.nickname}"); // 로그인한 유저 정보
        $("input[name='replyDate']").val(new Date().toLocaleString());

        $("#modalModBtn").show();
        $("#modalRegisterBtn").hide();
        $("#myModal").modal("show");

        // 수정 버튼 클릭시 처리
        $("#modalModBtn").off("click").on("click", function() {
            // 수정 AJAX 요청 처리
            let updatedReply = $("input[name='reply']").val();  // 수정된 댓글 내용
            let rno = $("input[name='rno']").val();  // 수정할 댓글 ID

            $.ajax({
                type: "PUT",
                url: "/replies/" + rno,
                data: JSON.stringify({ rno: rno, reply: updatedReply }), // rno와 수정된 내용을 전달
                contentType: "application/json; charset=utf-8",
                success: function(result) {
                    alert("댓글 수정 성공!");
                    $("#myModal").modal("hide");
                    showList(currentPage, boardid); // 수정 후 목록 업데이트
                },
                error: function(xhr, status, err) {
                    alert("댓글 수정 실패: " + err);
                }
            });
        });
    });

    // 댓글 삭제 버튼 클릭 시 처리
    $(document).on("click", ".removeReplyBtn", function() {
    	  let rno = $(this).attr("data-id");  // 댓글 고유 ID (rno)
        console.log("댓글 ID (rno):", rno); 
        if (confirm("정말 삭제하시겠습니까?")) {
            $.ajax({
                type: "DELETE",
                url: "/replies/" + rno,  // 댓글 ID(rno)를 URL에 포함하여 삭제 요청
                success: function(result) {
                    alert("댓글 삭제 성공!");
                    showList(currentPage, boardid); // 삭제 후 목록 업데이트
                },
                error: function(xhr, status, err) {
                    alert("댓글 삭제 실패: " + err);
                }
            });
        }
    });

    // 페이지네이션 처리
    function showReplyPage(replyCnt) {
        let totalPages = Math.ceil(replyCnt / 10.0); // 댓글 수에 따른 총 페이지 수 계산
        updatePagination(totalPages, currentPage); // 페이지네이션 업데이트
    }

    // 페이지 변경 시 호출
    window.navigatePage = function(page) { // `navigatePage`를 전역 함수로 선언
        currentPage = page; // 현재 페이지 업데이트
        showList(currentPage, boardid); // 해당 페이지로 댓글 목록 로드
    };

    function updatePagination(totalPages, currentPage) {
        let pagination = $(".pagination");
        pagination.empty();  // 기존 페이지네이션 비우기

        // 이전 페이지 버튼 추가 (첫 페이지가 아니면)
        if (currentPage > 1) {
            pagination.append('<li class="page-item"><a class="page-link" href="#" onclick="navigatePage(' + (currentPage - 1) + ')">이전</a></li>');
        }

        // 페이지 번호 동적으로 추가
        for (let i = 1; i <= totalPages; i++) {
            if (i === currentPage) {
                pagination.append('<li class="page-item active"><span class="page-link">' + i + '</span></li>');
            } else {
                pagination.append('<li class="page-item"><a class="page-link" href="#" onclick="navigatePage(' + i + ')">' + i + '</a></li>');
            }
        }

        // 다음 페이지 버튼 추가 (마지막 페이지가 아니면)
        if (currentPage < totalPages) {
            pagination.append('<li class="page-item"><a class="page-link" href="#" onclick="navigatePage(' + (currentPage + 1) + ')">다음</a></li>');
        }
    }
});
</script>

<%@ include file="../includes/footer.jsp" %>
