<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<h2>상품수정</h2>
<div class="insert_info">
<form class="product" method="post" action="/product/modify">
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
<ul>
<li><input type="hidden" class="form-control insert_form" id="exampleInputEmail1" value="${board.bookid }" name="bookid" > </li>
<li><input type="text" class="form-control insert_form" id="exampleInputEmail1" value="${board.pname }" name="pname" placeholder="책이름" required> </li>
<li><input type="text" class="form-control insert_form" id="exampleInputEmail1" value="${board.writer }" name="writer" placeholder="저자" required></li>
<li>
	<select class="form-select insert_select" id="exampleDisabledSelect1" name="category">
		<option value="all">카테고리</option>
		<option value="소설">소설</option>
		<option value="에서이">에서이</option>
		<option value="인문">인문</option>
		<option value="취미">취미</option>
		<option value="요리">요리</option>
	</select>
</li>
<li>
<input class="form-control insert_form" value="${board.fullname }" type="file" id="formFile" type="file" name="uploadfile"/>
<div class="uploadResult" >
<ul>
</ul>
</div>
</li>
<li>
<input class="form-control insert_form" id="exampleInputEmail1" value="${board.price }" type="text" name="price" placeholder="가격" required> 
</li>
<li class="insert_btn">
	<button class="btn btn-outline-info" type="submit" >등록</button>
	<button class="btn btn-outline-info" type="reset" >취소</button>
</li>
</ul>
</form>
</div>
</div>
<script>
		//html문서를 다 로드하면 실행한다.
		$(document).ready(function() {
			//전송 버튼 누를때 파일 관련 데이터도 같이 전송 
			$("button[type='submit']").on("click",function(e){
				 
				//연결된 이벤트 제거 (submit전송 제거)
				e.preventDefault();
				//폼선택 formObj할당
				let formObj = $("form.product");
				console.log("submmit클릭");
				let str = "";
				let li = $(".uploadResult ul li");
					str += "<input type='hidden' name='filename' value='"+li.data("filename")+"'/>"
					str += "<input type='hidden' name='uploadpath' value='"+li.data("path")+"'/>"
					str += "<input type='hidden' name='fullname' value='"+li.data("fullname")+"'/>"
			
				//폼에 데이터 추가 append()메소드 submit()전송하기 
				
				formObj.append(str);
				console.dir(formObj);
				formObj.submit();
			})
			
			//요소의 변경이 있으면 콜백함수 실행
			$("input[type='file']").change(function() {
				let csrfHeaderName = "${_csrf.headerName}";
		    	let csrfTokenValue = "${_csrf.token}";
				//가상의 폼을 생성(폼태그)
				let formData = new FormData();
				let inputFile = $("input[name='uploadfile']")
				let files = inputFile[0].files;
				for(let i=0; i<files.length; i++){
					formData.append("uploadFile", files[i]);
				}
				$.ajax({
					url: '/uploadAjaxAction',
					processData: false,
					contentType: false,
					data: formData,
					type: 'POST',
					dataType: 'json',
					beforeSend:function(xhr){
	        			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
	        		},
					success : function (result) {
						console.log(result);
						showUploadResult(result);
					}
				})
			})
				//썸네일 이미지 뿌려주는 함수 
			function showUploadResult(uploadResultArr) {
				//결과 배열이 null이거나 길이가 0이면 함수 종료
				if(!uploadResultArr || uploadResultArr.length==0 ){return;}
				let uploadul = $(".uploadResult ul");
				let str = "";
				$(uploadResultArr).each(function(i, obj){
					console.log(obj);
					let fileCallpath = encodeURIComponent(obj.uploadpath+"/s_"+obj.uuid+"_"+obj.filename);
					let filePullpath = encodeURIComponent(obj.uploadpath+"\\"+obj.uuid+"_"+obj.filename);
					str += "<li data-path='"+obj.uploadpath+"' data-filename='"+obj.uuid+"_"+obj.filename+"'"
					+" data-fullname='"+filePullpath+"'>"
					+"<img src='/display?filename="+fileCallpath+"'/>"
					+"<button class='btn' data-file=\'"+fileCallpath+"\' data-type='image'>"
					+"삭제</button>"
					+"</li>"
				})
				uploadul.append(str);
			}
			//삭제 버튼 추가하기 //"click","button",function 으로 버튼에만 이벤트를 줄 수있다.
			//or $(".uploadResult button")이라고 직접 지정해도 가능하다.
			$(".uploadResult").on("click","button",function (e) {
				console.log("삭제 클릭")
				//이벤트를 발생시키면 이벤트를 발생시킨 객체를 this가 가르킴 
				//커스텀 속성 dataset ---> data("키이름")
				//이렇게 함으로써 fileCallpath를 받아 온다.
				let targetFile = $(this).data("file");
				let type = $(this).data("type");
				//console.log($(this)) 어디서 작동하는지 확인 할 수있다.
				//사용하고 있는 this의 가까운 li를 찾는다. 
				let targetLi = $(this).closest("li")
				
				$.ajax({
					url: '/deleteFile',
					data: {filename : targetFile, type: type},
					dataType : 'text',
					type: 'POST',
					success: function(result) {
						alert(result)
					}
				})
				//찾은 targetLi를 기능이 다 수행한 후에 삭제 한다.
				targetLi.remove();
			})
			
		})
		
	</script>

</body>
</html>