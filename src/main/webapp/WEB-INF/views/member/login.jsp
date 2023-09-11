<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<h2>로그인 페이지</h2>

	<form action="/member/login" method="post">
		<p> <input type="text" name="username"/></p>
		<p> <input type="password" name="password"/></p>
		<!-- 자동 로그인 설정 -->
		<p><input type="checkbox" name="remember-me" />Remember Me </p>
		<p> <input type="submit" value="로그인"/></p>
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	</form>
	<p><button onclick="location.href='/customLogout'">로그아웃</button></p>
 
<script type="text/javascript">
   // function do_write(obj) {
        
       // if($("#userid").val() == ''){
        //    $("#userid").focus();
       //     return false;
     //   }
      //  if($("#userpw").val() == ''){
      //      $("#userpw").focus();
      //      return false;
      //  }
      //  return true;
  //  }
</script>
</body>
</html>