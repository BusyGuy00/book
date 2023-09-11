<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<sec:authorize access="isAuthenticated()">
   <sec:authentication property="principal" var="principal"/>
</sec:authorize>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${path}/resources/css/bootstrap.css" rel="stylesheet"/> 	
<link href="${path}/resources/css/style.css" rel="stylesheet"/> 
</head>
<body>
<%@ include file="../include/header.jsp" %>
<h2 class="top_line"></h2>
	<div id="book_table">
		<div class="view_info">
			<ul>
				<li>${board.pname}</li>
			</ul>
			<ul>
				<li>${board.category}</li>
			</ul>
			<ul>
				<li>${board.writer}</li>
			</ul>
				
		</div>
		<div class="view_img">
			<ul>
				<li>${board.pname}</li>
				<li id="book_cover">
				<img src="/display?filename=${board.fullname}">
				</li>
				<li><input type="hidden" class="individual_bookId_input" value="${board.bookid}"></li>
			</ul>
		</div>
		<div class="view_buy">
			<ul>
				<li>${board.price} 원</li>
			</ul>
			<ul>
				<li>발매일</li>
				<li><fmt:formatDate value="${board.postdate}" pattern="yyyy년MM월dd일 HH시mm분"/></li>
			</ul>
			<div class="button_set">
					<ul>
						<li>
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							<sec:authorize access="isAuthenticated()">
							<a class="btn_cart"> 장바구니 담기</a>
							</sec:authorize>
						</li>
					</ul>
				<div>
					<ul>
						<li>
							<sec:authorize access="isAuthenticated()">
							<a href="/cart/cartlist/${principal.username}">장바구니 가기</a>
							</sec:authorize>
							<form method="post" action="/product/remove">
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
								<input type="hidden" value="1" name="count">
								<input type="hidden" value="${board.bookid}" name="bookid">
								<input type="hidden" value="${board.uploadpath}" name="uploadpath">
								<input type="hidden" value="${board.filename}" name="filename">
								<sec:authorize access="hasRole('ROLE_ADMIN')">
								<button class="btn btn-outline-info view_admin_btn2" type="submit">삭제</button>
								</sec:authorize>
							</form>
							<sec:authorize access="hasRole('ROLE_ADMIN')">
							<button class="btn btn-outline-info view_admin_btn" onclick="location.href='/product/modify?bookid=${board.bookid}'">수정하기</button>
							</sec:authorize>
						</li>
					</ul>	
				</div>
			</div>
		</div>
	</div>
	<!-- 소감 영역 -->
	<sec:authentication property="principal" var="pinfo"/>
	<sec:authorize access="isAuthenticated()">
			<div class="card-body review">
				<div class="reviw_area">
				<form action="/review/reviewInsert" method="post" class="mb-4">	
					<input type="hidden" name="bookid" value="${ board.bookid }" />
					<input type="hidden" name="userid" value="${ pinfo.username }" />
					
					  <select class="form-select" id="exampleSelect1" name="score">
					    <option value="">별점</option>
					    <option value="1">1</option>
					    <option value="2">2</option>
					    <option value="3">3</option>
					    <option value="4">4</option>
					    <option value="5">5</option>
					  </select>
						
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					<div class="text-flex review_box">
						<!--  <textarea class= "review_text" rows="3" name="content"></textarea> -->
						      <textarea class="form-control review_text" name="content" id="exampleTextarea" rows="3"></textarea>
						<input type="submit" class="btn btn-info" value="등록">
					</div>
				</form>
				</div>
				<div  class="review_conment">
					<div class="review_conment_box">
						<c:if test="${ empty reviewlist }">
							<div>
								등록된 소감이 없습니다.
							</div>
						</c:if>
						<c:forEach items="${ reviewlist }" var="review" varStatus="loop">
							<div>
								<div>${ review.userid }
									<c:choose>
											<c:when test="${review.score eq 1}">
												<td>★☆☆☆☆</td>
											</c:when>
											<c:when test="${review.score eq 2}">
												<td>★★☆☆☆</td>
											</c:when>
											<c:when test="${review.score eq 3}">
												<td>★★★☆☆</td>
											</c:when>
											<c:when test="${review.score eq 4}">
												<td>★★★★☆</td>
											</c:when>
											<c:otherwise>
												<td>★★★★★</td>
											</c:otherwise>
										</c:choose>
									</div>
								<div class="commentflex review_conment_box_div" >
									${ review.content }
									<c:if test="${pinfo.username eq review.userid || pinfo.username eq 'admin'}">
									<form action="/review/reviewRemove" method="post">
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
										<input type="hidden" name="bookid" value="${ review.bookid }"/>
										<input type="hidden" name="rno" value="${ review.rno}" />
										<button type="submit" data-bookid="${review.bookid}" class="commentflexBtn btn btn-info delete_btn">X</button>
									</form>
									</c:if>
							</div>
						</div>	
					</c:forEach>
					</div>
				</div>
			</div>
	</sec:authorize>
	<sec:authorize access="isAnonymous()">
	<div class="card-body review">
		<div class="reviw_area">
				<c:forEach items="${ reviewlist }" var="review" varStatus="loop">
							<div class="commentflex review_conment_box_div">
								<div >${ review.userid }</div>
								<div >
									${ review.content }
								</div>
							</div>
						</c:forEach>	
				<div class="text-flex review_box">
					<textarea class="form-control review_text" id="exampleTextarea" rows="3" name="content" placeholder="소감을 남기시려면 로그인을 해주세요!"></textarea>
					<input type="submit" class="btn btn-info"  value="등록" disabled="disabled">
				</div>
				<div class="review_conment">
					<div class="review_conment_box">
						<c:if test="${ empty reviewlist }">
							<div class="ms-3">
								등록된 소감이 없습니다.
							</div>
						</c:if>
					</div>
				</div>
		</div>
	</div>
	</sec:authorize>
	<!-- 리뷰 영역 끝 -->
	</div>
	
<script type="text/javascript">



//서버로 전송할 데이터
const form = {
		userid : '${principal.username}',
		bookid : '${board.bookid}',
		count : ''
}
//장바구니 추가 버튼
$(".btn_cart").on("click", function(e){
	form.count = $(".quantity_input").val();
	console.log("장바구니");
	let csrfHeaderName = "${_csrf.headerName}";
	let csrfTokenValue = "${_csrf.token}";
	$.ajax({
		url: '/cart/add',
		type: 'POST',
		data: form,
		beforeSend:function(xhr){
			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		},
		success: function(result){
			cartAlert(result);

		}
	})
});
function cartAlert(result){
	if(result == '0'){
		alert("장바구니에 추가를 하지 못하였습니다.");
	} else if(result == '1'){
		alert("장바구니에 추가되었습니다.");
	} else if(result == '2'){
		alert("장바구니에 이미 추가되어져 있습니다.");
	} else if(result == '5'){
		alert("로그인이 필요합니다.");	
	}
}
//삭제
	function deleteReview(rno){
	        var ans = confirm("삭제하시겠습니까?");
	        let csrfHeaderName = "${_csrf.headerName}";
	    	let csrfTokenValue = "${_csrf.token}";
	        if(ans){
	            var query = {"rno" : rno};
	            $.ajax({
	                url : "/review/reviewRemove",
	                type : "POST",
	                data : query,
	                beforeSend:function(xhr){
	        			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
	        		},
	                success: function(result) {
	                    alert(result);
	                    location.reload();
	                }
	            });
	        }
	    }
	    // 삭제 버튼에 클릭 이벤트
	    $(document).ready(function() {
	        $(".delete_btn").click(function() {
	            var rno = $(this).data("bookid");
	            deleteReview(rno);
	        });
	    });

</script>
	
</body>
</html>