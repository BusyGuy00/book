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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<body>
<%@ include file="../include/header.jsp" %>
<h2 class="top_line"></h2>
<h2 class="cartlist_h2">장바구니</h2>
	<!-- 데이터 받아오기  -->
	<form id="purchaseForm" method ="post" name="frm" action="/sale/saleinsert">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	<div class="cart_table" >
	
	<c:forEach items="${cartInfo}" var="board">
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
			</div>
			<input name="fullname" type="hidden" value="${board.fullname}" />
		</li>
		<li><input type="hidden" name="pname" value="${board.pname}" required /></li>
		<!--<input type="text"  value="${board.price}" required readonly/>-->
		<li id="parent">
		<!--<fmt:formatNumber  value="${board.price}"  />-->
		</li>
		<li class="table_info_btn">	
			    <input id="price" name="price" type="hidden" value="${board.price}" />
			    <input id="Mbtn" class="btn btn-info cart_btn" type="button" value="-" name="minus" onclick="MiunsBtn(this)"/>
			    <input id="count" class="count cart_count" type="text" name="count" value="0" maxlength="3" onkeyup="cal();"/>
			    <input id="Pbtn" class="btn btn-info cart_btn" type="button" value="+" name="plus" onclick="PlusBtn(this)"/>
			    <input type="hidden" name="pricesales" size="5"  value="0"/>
		</li>
			<li id="delet"><button class="delete_btn btn btn-info cart_delete" data-cartid="${board.cartid}">상품 삭제</button></li>
		</ul>
		<h2 class="cart_line"></h2>
	</c:forEach>
		<ul class="cart_sale">
			<li>상품 금액 : <input id="listTotal" type="text"  value="" required /></li>
			<li >배송비 : <a id="deliveryPriceOn">3,00</a>0원</li>
			<li>
				 총 : <input id="total" type="text" name="daysales" size="5"  value=""/>원
				<input type="submit" value="구매 하기" />
			</li>
		</ul>
		<ul>
			
		</ul>
		</div>
		</form>

		<script> 
		let totalSales = 0;
	//마니이너스 버튼
 	function MiunsBtn(Mbtn) {
		console.log(MiunsBtn)
        let countInput = Mbtn.parentElement.querySelector("#count");
        if (countInput.value > 1)
            countInput.value = parseInt(countInput.value) - 1;
        cal(countInput, 0);
    };
	//플러스 버튼
    function PlusBtn(Pbtn) {
		console.log("Pbtn")
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
	
    //카트 총 금액 
	function calTotalSales() {
	        let totalSalesInput = document.getElementById("total");
	        let priceSalesInputs = document.querySelectorAll("[name=pricesales]");
			
	        let listTotal = document.getElementById("listTotal");
	        let totalSales = 0;
	        priceSalesInputs.forEach(function (input, element) {
	            totalSales += parseInt(input.value.replace(/[^0-9]/g, ""));
	        	
	        });
			//상품 금액				
	        listTotal.value = totalSales;
	        
	        /* 배송비 결정 */
	    	if(totalSales >= 30000){
	    		deliveryPrice = 0;
	    		$("#deliveryPriceOn").hide();
	    	} else if(totalSales == 0){
	    		$("#deliveryPriceOn").hide();
	    		deliveryPrice = 0;
	    	} else {
	    		deliveryPrice = 3000;	
	    		$("#deliveryPriceOn").show();
	    		
	    	}
	    	 //배송비 포함 상품 금액
	    	 totalSalesInput.value = totalSales + deliveryPrice;
	    }
    //삭제
	function deleteCart(bookid){
	        var ans = confirm("삭제하시겠습니까?");
	        let csrfHeaderName = "${_csrf.headerName}";
	    	let csrfTokenValue = "${_csrf.token}";
	        if(ans){
	            var query = {"bookid" : bookid};
	            $.ajax({
	                url : "/cart/delete",
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
	            var bookid = $(this).data("cartid");
	            deleteCart(bookid);
	        });
	    });
	    // 구매하기 버튼 클릭 이벤트
	    document.getElementById("purchaseForm").addEventListener("submit", function (event) {
	        event.preventDefault(); // 폼 제출 방지

	        // 모든 장바구니 항목 삭제
	        deleteAllCartItems();
	    });

	    // 모든 장바구니 항목 삭제 함수
	    function deleteAllCartItems() {
	    	let csrfHeaderName = "${_csrf.headerName}";
	    	let csrfTokenValue = "${_csrf.token}";
	    	var userid = "${principal.username}";
	    	document.getElementById("purchaseForm").action = "/sale/saleinsert";
            document.forms["frm"].submit();
	        $.ajax({
	            url: "/cart/deleteAll",
	            type: "POST",
	            data: {userid: userid },
	            beforeSend:function(xhr){
        			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
        		},
        		
	            success: function (result) {
	                alert("구매가 완료 되었습니다.");
	                window.location.href = "/sale/pricelist/" + userid;
	            },
	            error: function (error) {
	                alert("구매를 실패 했습니다.: " + error);
	            }
	        });
	    }

	   
  </script> 
</body>

</html>