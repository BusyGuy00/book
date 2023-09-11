<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link href="${path}/resources/css/bootstrap.css" rel="stylesheet"/> 	
<link href="${path}/resources/css/style.css" rel="stylesheet"/> 
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<body>
<div class="banner">
	<div class="slideshow-container">
		<ul class="slides">
			<li>
				<img src="/resources/img/1.jpg">
			</li>
			<li>
				<img src="/resources/img/2.jpg">
			</li>
			<li>
				<img src="/resources/img/3.jpg">
			</li>
		</ul>
		<div>
		<a class="prev" onclick="plusSlides(-1)">&#10094;</a>
		<a class="next" onclick="plusSlides(1)">&#10095;</a>
		</div>
	</div>
</div>
<%@ include file="../include/header.jsp" %>

<div>
	<form class="list_form" method = "post" name="frm"  action="/sale/insert">
		<div class="flex-container">
			<c:forEach items="${list}" var="board">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				<div class="book_list" >
					<ul class="book_list_ul"><a href='/product/view?bookid=${board.bookid}'>
						<li ><img src="/display?filename=${board.fullname}" class="list_img"></li>
						</a>
						<li><c:out value="${board.category}"></c:out></li>
						<li><c:out value="${board.pname}"></c:out></li>
						<li><c:out value="${board.writer}"></c:out></li>
						<li><c:out value="${board.price}"></c:out></li>
						<li><c:out value="${board.count}"></c:out></li>
					</ul>
				</div>
			</c:forEach>
		</div>
	</form>

</div>
<%@ include file="../include/Footer.jsp" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
var slideIndex = 0;
var slides = document.querySelectorAll('.slides li');
var autoSlideInterval = 5000; // 3초마다 자동 전환

function showSlides() {
  for (var i = 0; i < slides.length; i++) {
    slides[i].style.display = 'none';
  }
  slideIndex++;
  if (slideIndex > slides.length) {
    slideIndex = 1;
  }
  slides[slideIndex - 1].style.display = 'block';
  setTimeout(showSlides, autoSlideInterval);
}

function plusSlides(n) {
  showSlides(slideIndex += n);
}

// 페이지 로드 시 슬라이드 쇼 시작
showSlides();
</script>

</body>
</html>