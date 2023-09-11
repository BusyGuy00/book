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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link href="${path}/resources/css/bootstrap.css" rel="stylesheet"/> 	
<link href="${path}/resources/css/style.css" rel="stylesheet"/> 
</head>
<body>
<%@ include file="../include/header.jsp" %>
<h2 class="top_line"></h2>
<h2 class="cartlist_h2">구매 정보 페이지 </h2>
	<div class="cart_table" >
		<c:forEach items="${list}" var="board">
		<ul class="table_info" >
			<li class="table_info_box">
				<input name="userid" type="hidden" value="${board.userid}" />
				<input name="cartid" type="hidden" value="${board.cartid}" />
				<img class="list_img" src="/display?filename=${board.fullname}">
				<div class="table_info_li">
					<div>
						<c:out value="${board.pname}"></c:out>
					</div>
					<div>
						<fmt:formatNumber  value="${board.price}"  />
					</div>
					<div>
						<c:out value="${board.count}"></c:out>권
						<c:out value="${board.pricesales}"></c:out>원
					</div>
					<div>
						<fmt:formatDate value="${board.postdate}" pattern="yyyy년MM월dd일 HH시mm분"/>
					</div>
				</div>
				<input name="fullname" type="hidden" value="${board.fullname}" />
			</li>
			<li><input type="hidden" name="pname" value="${board.pname}" required /></li>
			<!--<input type="text"  value="${board.price}" required readonly/>-->
			<li id="parent">
			<!--<fmt:formatNumber  value="${board.price}"  />-->
			</li>
			</ul>
			<h2 class="cart_line"></h2>
		</c:forEach>
	</div>
<script>
</script>
</body>
</html>