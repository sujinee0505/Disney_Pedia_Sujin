<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script type="text/javascript">
$(function() {
		//회원가입 커서 설정
		$('#myModal2').on('shown.bs.modal', function() {
			$('#name').trigger('focus');
			$('#message_id').hide();		
		});		

		//keyup으로 아이디 중복 체크
		$('#id2').keyup(function() {
			//default
			$('#id2').css('border', 'none');
			$('#id2').css('background-color', '');
			
			//체크문구영역 높이조절 show hide로 제어
			if($('#id2').val()==''){
				$('#message_id').hide();
				
				$('#id2').css('border', 'none'); //왜안먹지(미해결)
				$('#id2').css('background-color', '');//왜안먹지(미해결2)
				
			}else{
				$('#message_id').show();
			};						
			
			//ajax
			$.ajax({
				url : '../member/confirmId.do',
				type : 'post',
				data : {id : $('#id2').val()},
				dataType : 'json',
				cache : false,
				timeout : 30000,
				success : function(param) {					
					if (param.result == 'idNotFound') {
						$('#message_id').text('');
						$('#id2').css('border', 'none');
						$('#id2').css('background-color', '');
						$('#message_id').hide();
					} else if (param.result == 'idDuplicated') {
						$('#message_id').css('color', 'red').text('이미 가입된 아이디입니다.');
						$('#id2').css('border', '1px solid red');
						$('#id2').css('background-color', '#ffedee');
					} else if (param.result == 'notMatchPattern') {
						$('#message_id').css('color', 'red').text('4~12자의 영문 소문자, 숫자만 가능합니다.');
						$('#id2').css('border', '1px solid red');
						$('#id2').css('background-color', '#ffedee');
					} else {						
						alert('ID 중복체크 오류');
					}
				},
				error : function() {					
					alert('네트워크 오류 발생');
				}
			});//end of ajax
						
	});//end of keyup
	
});
</script>
<!-- Modal Header -->
<div>
	<img src="${pageContext.request.contextPath}/resources/images/logo.png" height="86px;" class="sign-logo">
	<h4 class="modal-title">회원가입</h4>
	<div class="blank_10"></div>
</div>
<!-- Modal body -->
<div class="modal-body">
	<form action="${pageContext.request.contextPath}/member/registerUser.do" method="post" class="form-horizontal"
		role="form" id="signUp_form">
		
			<div class="form-group">
			<input type="text" id="name" name="name" class="form-control blank" 
			placeholder="이름" autofocus required>
			</div>
			
			<div class="form-group">
			<input type="text" id="id2" name="id" class="form-control blank" 
			placeholder="아이디"  required>	
			</div>		
			<!-- 중복체크 메시지 부분 -->
			<span id="message_id"></span>
			
						
			<div class="form-group">
			<input type="password" id="passwd2" name="passwd" 
			class="form-control" placeholder="비밀번호" required>
			</div><p>	
		
			<div class="form-group">
			<button class="btn btn-3 form-control sign-btn" type="submit">
			회원가입
			</button>
			</div><p>
	
			<div class="alter">
			이미 가입하셨나요? 		
			<a href="#" data-bs-toggle="modal" data-bs-target="#myModal" class="alter_text" onMouseOver="this.style.color='#10c3eb'">
			로그인</a>
			</div>	<p>		
		</form>
</div>