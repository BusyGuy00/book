<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<body>
<h1> 상품 리스트 </h1>
	<!-- 데이터 받아오기  -->
	<form method ="post" name="frm" action="./saleinsert">
	<table>
	<tr>
		<td>상품명</td>
		<td>작성자</td>
		<td>카테고리</td>
		<td>가격</td>
		<td>갯수</td>
		<td>상품 일 매출</td>
	</tr>

	<c:forEach items="${list}" var="board">
	<tr>
		
		<td><input type="text" name="pname" value="${board.pname}" required /></td>
		
		<td><input type="text" name="writer" value="${board.writer}" required /></td>
		
		<td><input type="text" name="category" value="${board.category}" required /></td>
		
		<td><!--<input type="text"  value="${board.price}" required readonly/>--><c:out value="${board.price}"/></td>
		<td><c:out value="${board.count}"></c:out></td>
		 <td id="parent">상품 일 매출
			    <fmt:formatNumber value="${board.price}"  />
			    <input id="price" type="text" value="${board.price}" />
			    <input id="Mbtn" type="button" value="-" name="minus" onclick="MiunsBtn(this)"/>
			   	<input id="count" class="count" type="text" name="priceCount" value="1" maxlength="3" onkeyup="cal();"/>
			    <input id="Pbtn" type="button" value="+" name="plus" onclick="PlusBtn(this)"/>
			    <input type="text" name="pricesales" size="5"  value=""/>원
				
			
	</tr>
	</c:forEach>
		<tr>
		<td>
		<input id="total" type="text" name="daysales" size="5"  value=""/>원
		<input type="submit" value="매출 등록 하기" />
		</td>
		</tr>
		
		

	</table>
	
		</form>
 <script> 

	//마니이너스 버튼
 	function MiunsBtn(Mbtn) {

        let countInput = Mbtn.parentElement.querySelector("#count");
        if (countInput.value > 1)
            countInput.value = parseInt(countInput.value) - 1;
        cal(countInput, 0);
    };
	//플러스 버튼
    function PlusBtn(Pbtn) {

        let countInput = Pbtn.parentElement.querySelector("#count");
        countInput.value = parseInt(countInput.value) + 1;
        cal(countInput, 1);
    };
    //상품 매출
	function cal(btn,num){
		 	let priceInput = btn.parentElement.querySelector("#price");
	        let countInput = btn.parentElement.querySelector("#count");
	        let priceSalesInput = btn.parentElement.querySelector("[name=pricesales]");

	        let price = parseInt(priceInput.value);
	        let count = parseInt(countInput.value);
	        let totalPrice = price * count;

	        priceSalesInput.value = totalPrice;
	        calTotalSales();
	}
    //매장 일 매출
	function calTotalSales() {
	        let totalSalesInput = document.getElementById("total");
	        let priceSalesInputs = document.querySelectorAll("[name=pricesales]");

	        let totalSales = 0;
	        priceSalesInputs.forEach(function (input) {
	            totalSales += parseInt(input.value.replace(/[^0-9]/g, ""));
	        });

	        totalSalesInput.value = totalSales;
	    }
		
		
	
		   
  </script> 
</body>
</html>