<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<sec:authorize access="isAuthenticated()">
   <sec:authentication property="principal" var="principal"/>
</sec:authorize>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${path}/resources/css/bootstrap.css" rel="stylesheet"/> 	
<link href="${path}/resources/css/style.css" rel="stylesheet"/> 
</head>
<body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
<%@ include file="../include/header.jsp" %>
	<h2 class="top_line"></h2>
	<div class="pricelist_table">
	<ul>
		<li>구매 확인 페이지 </li>
	</ul>
		<h2 class="cart_line"></h2>
		<div class="pricelist_info">
			<c:forEach items="${list}" var="board">
				<ul>
					<li> 구매 일자 : <a href='/sale/salelist?postdate=${board.postdate}'><fmt:formatDate value="${board.postdate}" pattern="yyyy/MM/dd HH:mm"/></a></li> </br>
					<div class="pricelist_btn"><button class="btn btn-outline-info" onclick="location.href='/sale/salelist?postdate=${board.postdate}'">상세보기</button></div>
					<li> 구매 금액 : <c:out value="${board.daysales}"></c:out></li>
				</ul>
				
				<h2 class="cart_line"></h2>
			</c:forEach>

		</div>
	</div>


<script>
</script>
</body>
</html>