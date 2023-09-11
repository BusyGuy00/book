<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${path}/resources/css/bootstrap.css" rel="stylesheet"/> 	
<link href="${path}/resources/css/style.css" rel="stylesheet"/> 
</head>
<body>
<nav class="navbar navbar-expand-lg bg-light" data-bs-theme="light">
  <div class="container-fluid">
    
    <div class="top_menu">
    <a class="navbar-brand" href='/product/list'>퓨즈북스</a>
    <div class="top_menu_search" >
		<form class="d-flex" action="/product/list" method="get">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				<select class="selected form-control me-sm-2" id="" name="type">
					<option class="optionList" value="">----</option>
					<option class="optionList" value="T"  <c:out value="${pageMaker.cri.type == 'T' ? 'selected' : ''}"/>>제목</option>
					<option class="optionList" value="C" <c:out value="${pageMaker.cri.type == 'C' ? 'selected' : ''}"/>>저자</option>
					<option class="optionList" value="W" <c:out value="${pageMaker.cri.type == 'W' ? 'selected' : ''}"/>>내용</option>
					<option class="optionList" value="TC" <c:out value="${pageMaker.cri.type == 'TC' ? 'selected' : ''}"/>>제목,저자</option>
					<option class="optionList" value="TW" <c:out value="${pageMaker.cri.type == 'TW' ? 'selected' : ''}"/>>제목,내용</option>
					<option class="optionList" value="TCW" <c:out value="${pageMaker.cri.type == 'TCW' ? 'selected' : ''}"/>>제목,저자,내용</option>
				</select>
			<input  class="form-control me-sm-2" type="text" name="keyword" value="${pageMaker.cri.keyword}"/>
			<input class="btn btn-secondary my-2 my-sm-0" type="submit">
		</form>
	</div>
	<sec:authorize access="isAnonymous()">
	<div class="login_button">
		<a href="../customLogin" ><button type="button" class="btn btn-outline-info">로그인</button></a>
	</div>
	</sec:authorize>
	<div  class="log_info">
		<sec:authentication property="principal" var="pinfo"/>
		<sec:authorize access="isAuthenticated()">
		<div class="card-body login_button">
		    <h4 class="card-title">${pinfo.username}님 환영 합니다.</h4>
		   <div class="login_info">
				<button  onclick="location.href='/sale/pricelist/${pinfo.username}'" type="submit" class="btn btn-primary btn-sm">구매리스트</button>
			    <form action="/customLogout" method="post">
					<input type="hidden"  name="${_csrf.parameterName}" value="${_csrf.token}"/>
					<button  type="submit" class="btn btn-primary btn-sm">로그아웃</button>
				</form>  
				<sec:authorize access="hasRole('ROLE_ADMIN')">
				<a href="../product/insert"><button  type="submit" class="btn btn-primary btn-sm">상품 추가</button></a>
				</sec:authorize>
			</div>
		 </div>
		</sec:authorize>
	</div>
	</div>
    <button class="navbar-toggler" type="button" 
    	data-bs-toggle="collapse" data-bs-target="#navbarColor03" 
    		aria-controls="navbarColor03" aria-expanded="false" 
    			aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarColor03">
      <ul class="navbar-nav me-auto">
       <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">소설</a>
          <div class="dropdown-menu">
          	<a class="dropdown-item" href="/product/list?category=소설" > 소설</a>
            <a class="dropdown-item" href="/product/list?category=영미소설">영미 소설</a>
          </div>
        </li>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">시/에세이</a>
          <div class="dropdown-menu">
          	<a class="dropdown-item" href="/product/list?category=시">시 전체</a>
            <a class="dropdown-item" href="/product/list?category=시">시/에세이</a>
           </div>
        </li>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">인문</a>
          <div class="dropdown-menu">
            <a class="dropdown-item" href="/product/list?category=인문">인문학 전체</a>
            <a class="dropdown-item" href="/product/list?category=인문">심리학</a>
            <a class="dropdown-item" href="/product/list?category=인문">교육학</a>
          </div>
        </li>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">취미</a>
          <div class="dropdown-menu">
          	<a class="dropdown-item" href="/product/list?category=쥐미">취미 전체</a>
            <a class="dropdown-item" href="/product/list?category=쥐미">가정원예</a>
            <a class="dropdown-item" href="/product/list?category=쥐미">홈인테리어</a>
            <a class="dropdown-item" href="/product/list?category=쥐미">생활공예</a>
          </div>
        </li>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">요리</a>
          <div class="dropdown-menu">
            <a class="dropdown-item" href="/product/list?category=요리">요리 전체</a>
            <a class="dropdown-item" href="/product/list?category=요리">요리 에세이</a>
            <a class="dropdown-item" href="/product/list?category=요리">테마별 요리</a>
          </div>
        </li>
      </ul>
  
    </div>
  </div>
</nav>
<script>
document.addEventListener("DOMContentLoaded", function() {
  // 드롭다운 토글 버튼
  var dropdownToggleList = document.querySelectorAll(".dropdown-toggle");
  dropdownToggleList.forEach(function(dropdownToggle) {
    dropdownToggle.addEventListener("click", function(event) {
      // 드롭다운 토글 버튼이 클릭될 때 드롭다운 메뉴를 토글
      event.preventDefault();
      event.stopPropagation();
      var dropdownMenu = this.nextElementSibling;
      if (dropdownMenu) {
        dropdownMenu.classList.toggle("show");
        this.setAttribute("aria-expanded", dropdownMenu.classList.contains("show"));
      }
    });
  });
  
  // 클릭하면 모든 드롭다운 메뉴를 닫음
  document.addEventListener("click", function(event) {
    var dropdownMenus = document.querySelectorAll(".dropdown-menu");
    dropdownMenus.forEach(function(dropdownMenu) {
      dropdownMenu.classList.remove("show");
    });
    var dropdownToggleList = document.querySelectorAll(".dropdown-toggle");
    dropdownToggleList.forEach(function(dropdownToggle) {
      dropdownToggle.setAttribute("aria-expanded", "false");
    });
  });
});

//로그아웃 버튼 

$(".logout").on("click", function(e){
	let csrfHeaderName = "${_csrf.headerName}";
	let csrfTokenValue = "${_csrf.token}";
	$.ajax({
		url: '../customLogout',
		type: 'POST',
		data: "text",
		beforeSend:function(xhr){
			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		},
		
	})
});

</script>
</body>
</html>