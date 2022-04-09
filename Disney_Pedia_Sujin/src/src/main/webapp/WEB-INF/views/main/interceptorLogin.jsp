<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript">
$(function() {
	//커서
	$('#myModal').on('shown.bs.modal', function() {
		$('#id').trigger('focus')
	})
});
</script>
<style type="text/css">
#login-border{
	width: 764px;
	border: solid 2px #8bcee3;
	border-radius: 10px;
	margin: 180px auto 100px;
    padding: 100px;
}
div#interceptor_logo{
    margin: 0 auto;
    width: 283px;
}
img#interceptor_logo{
	height:145px;
}
div#interceptor_body {
    width: 405px;
    margin: 0 auto;
}
</style>
</head>
<body>
<div id="login-border">
<!-- Modal Header -->
<div id="interceptor_logo">
	<img src="${pageContext.request.contextPath}/resources/images/logo.png" class="sign-logo" id="interceptor_logo">
	<!-- <h4 class="modal-title">로그인</h4> -->
	<div class="blank_10"></div>
</div>
<!-- Modal body -->
<div class="modal-body" id="interceptor_body">
	<form action="${pageContext.request.contextPath}/member/login.do" method="post" class="form-horizontal"
		role="form" id="login_form">

		<%-- required: 필수입력필드지정->별도 유효성체크 생략 --%>
		<div class="form-group">
			<input type="text" id="id" name="id"
				class="form-control blank" placeholder="아이디" autofocus required>
		</div>
		
		<div class="form-group">
			<input type="password" id="passwd" name="passwd" 
			class="form-control" placeholder="비밀번호" required>
		</div><p>	
		
		<div class="form-group">
			<!-- <button class="btn btn-info form-control sign-btn" type="submit">  -->
			<button class="btn btn-3 form-control sign-btn" type="submit">
			로그인
			</button>
			
		</div><p>
		
		<div class="alter">
			계정이 없으신가요?			
			<a href="#" data-bs-toggle="modal" data-bs-target="#myModal2" class="alter_text">
			회원가입</a>
		</div>	<p>
		<!-- <div class="form-group"> -->		
	</form>
</div>
</div>
</body>
</html>