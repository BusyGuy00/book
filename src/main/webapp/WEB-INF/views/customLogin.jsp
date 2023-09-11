<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${path}/resources/css/bootstrap.css" rel="stylesheet"/> 	
<link href="${path}/resources/css/style.css" rel="stylesheet"/> 
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<body>

<%@ include file="./include/header.jsp" %>
<div class="login_page">
	<div class="login" >
		<h2>로그인 페이지</h2>
		<p><c:out value="${error}"></c:out> </p>
		<p><c:out value="${logout}"></c:out> </p>
		<form action="/login" method="post">
			<p> <input class="form-control insert_form" id="exampleInputEmail1"  type="text" name="username"/></p>
			<p> <input class="form-control insert_form" id="exampleInputEmail1"  type="password" name="password"/></p>
			<!-- 자동 로그인 설정 -->
			<p><input type="checkbox" name="remember-me" />Remember Me </p>
			<p> <input class="btn btn-outline-info" type="submit" value="로그인"/></p>
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		</form>
	</div>
</div>
</body>
</html>