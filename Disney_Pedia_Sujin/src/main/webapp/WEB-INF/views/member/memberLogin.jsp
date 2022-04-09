<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script type="text/javascript">
	$(function() {
		//커서
		$('#myModal').on(
				'shown.bs.modal',
				function() {
					$('#id').trigger('focus')
					document.getElementById("path").value = location.pathname
							+ location.search;
				})

	});
</script>
<!-- Modal Header -->
<div>
	<img src="${pageContext.request.contextPath}/resources/images/logo.png"
		height="86px;" class="sign-logo">
	<h4 class="modal-title">로그인</h4>
	<div class="blank_10"></div>
</div>
<!-- Modal body -->
<div class="modal-body">
	<form action="${pageContext.request.contextPath}/member/login.do"
		method="post" class="form-horizontal" role="form" id="login_form">
		<input type="hidden" name="path" id="path" />
		<%-- required: 필수입력필드지정->별도 유효성체크 생략 --%>
		<div class="form-group">
			<input type="text" id="id" name="id" class="form-control blank"
				placeholder="아이디" autofocus required>
		</div>

		<div class="form-group">
			<input type="password" id="passwd" name="passwd" class="form-control"
				placeholder="비밀번호" required>
		</div>
		<p>
		<div class="form-group">
			<!-- <button class="btn btn-info form-control sign-btn" type="submit">  -->
			<button class="btn btn-3 form-control sign-btn" type="submit">
				로그인</button>

		</div>
		<p>
		<div class="alter">
			계정이 없으신가요? <a href="#" data-bs-toggle="modal"
				data-bs-target="#myModal2" class="alter_text"> 회원가입</a>
		</div>
		<p>
			<!-- <div class="form-group"> -->
	</form>
</div>