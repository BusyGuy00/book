<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link href="/resources/css/styles.css" rel="stylesheet" />
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<body>
<h1> 상품 리스트 </h1>
	<!-- 데이터 받아오기  -->
	<div id="listPage">
		<form id="listFrom" method="get">
		<div class="listSearch">
			<select name="searchField" >
				<option value="이름">제목</option>
				<option value="저자">작가</option>
				<option value="금액">가격</option>
				<option value="카테고리">카테고리</option>
				<option value="출판사">출판사</option>
			</select>
			<input id="searchWord" name="searchWord" type="text"/>
			<input id="searchWordSubmit" type="submit" value="검색"/>
		</div>

	</form>
	<form method = "post" name="frm"  action="/sale/insert">
	<c:forEach items="${list}" var="board">
	<ul><a href='/product/view?bookid=${board.bookid}'>
		<li><img src="/display?filename=${board.fullname}" ></li>
		</a>
		<li><c:out value="${board.pname}"></c:out></li>
		<li><c:out value="${board.writer}"></c:out></li>
		<li><c:out value="${board.category}"></c:out></li>
		<li><c:out value="${board.price}"></c:out></li>
		<li><c:out value="${board.count}"></c:out></li>
	
	</ul>
	</c:forEach>
	</form>
	<p><button onclick="location.href='/sale/saleinsert'"> 일 매출 등록 </button></p>
	</div>
	<div id="calendar"></div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
$(document).ready(function() {
    $("#datepicker").datepicker({
        dateFormat: "yy-mm-dd", // 선택한 날짜 포맷
        onSelect: function(date) {
            displaySales(date); // 선택한 날짜로 매출 데이터를 표시하는 함수 호출
        }
    });

    function displaySales(date) {
        // date를 서버로 전송하여 해당 날짜의 매출 데이터를 받아와서 표시
        $.ajax({
            type: "GET",
            url: "/getSalesForDate", // 서버에서 해당 날짜의 매출 데이터를 가져오는 URL
            data: { date: date },
            success: function(data) {
                // 받아온 데이터를 이용하여 달력 영역에 표시
                $("#calendar").html(data);
            }
        });
    }
});
</script>

</body>
</html>