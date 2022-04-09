<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- 중앙 컨텐츠 시작 -->
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(function() {
		//비밀번호 변경 체크
		$('#new_passwd').keyup(function(){
			$('#cpasswd').val('');
			$('#message_cpasswd').text('');
		});

		$('#cpasswd').keyup(function(){
			if($('#new_passwd').val() !=$('#cpasswd').val()){
				$('#message_cpasswd').css('color', 'red').text('비밀번호 확인이 올바르지 않습니다.');
			}else{
				$('#message_cpasswd').text('');
			}
		});
		
		//유효성체크alert
		$('#change_form').submit(function(){
			if($('#now_passwd').val().trim() == ''){
				Swal.fire({
                    title: ' ',
                    text: '현재 비밀번호를 입력하세요!',
                    imageUrl: '${pageContext.request.contextPath}/resources/images/warning_icon.png',
                    imageWidth: 70,
                    imageHeight: 70,
                    imageAlt: 'Custom image',
                    confirmButtonColor: '#84d7fa',
                    confirmButtonText: '알겠어요',
                    width: 400,
                    padding: '2em'
                })
				$('#now_passwd').val('').focus();
				return false;
			}
			if($('#new_passwd').val().trim() == ''){
				Swal.fire({
                    title: ' ',
                    text: '변경할 비밀번호를 입력하세요!',
                    imageUrl: '${pageContext.request.contextPath}/resources/images/warning_icon.png',
                    imageWidth: 70,
                    imageHeight: 70,
                    imageAlt: 'Custom image',
                    confirmButtonColor: '#84d7fa',
                    confirmButtonText: '알겠어요',
                    width: 400,
                    padding: '2em'
                })
				//alert('변경할 비밀번호를 입력하세요!');
				$('#new_passwd').val('').focus();
				return false;
			}
			if($('#cpasswd').val().trim() == ''){
				Swal.fire({
                    title: ' ',
                    text: '변경할 비밀번호 확인을 입력하세요!',
                    imageUrl: '${pageContext.request.contextPath}/resources/images/warning_icon.png',
                    imageWidth: 70,
                    imageHeight: 70,
                    imageAlt: 'Custom image',
                    confirmButtonColor: '#84d7fa',
                    confirmButtonText: '알겠어요',
                    width: 400,
                    padding: '2em'
                })
				//alert('변경할 비밀번호 확인을 입력하세요!');
				$('#cpasswd').val('').focus(); 
				return false;
			}

		});
	});
</script>
<style>
body {
	background: #F1F3FA;
}

ul li {
	list-style: none;
	text-align: center !important;
}
</style>
<div id="root">
	<form:form modelAttribute="memberVO" acceptCharset="changePassword.do" id="change_form">
		<form:errors element="div" cssClass="error-color" />
		<div class="css-5jq76">
			<div class="css-1xm32e0">
				<section class="css-18gwkcr">
					<div class="css-egiga7-Self e19zkogf0">
						<div class="css-19rw4yc-Container e19zkogf1">
							<div class="css-1xqcv4t">
								<div class="css-19lj1vd-RoundedCornerBlock-RoundedCornerBlock">
									<section class="css-q4evg3-MyPage e19zkogf2">
										<div class="css-1gkas1x-Grid e1689zdh0">
											<div class="css-1y901al-Row emmoxnt0">
												<header class="css-1hjjbcz-ProfileHeader e19zkogf4">
													<div class="css-1gry5r7">
													<h3 class="passtitle">비밀 번호 변경</h3>
													<p class="passtitle2">변경할 비밀번호를 입력해주세요.</p>
													</div>
													<ul>
														<li>
															<form:password class="passwd" path="now_passwd" placeholder="현재 비밀번호를 입력해주세요."/> 
															<form:errors path="now_passwd" cssClass="error-color" />
															<span id="message_nowpasswd"></span>
														</li>
														<li>
															<form:password class="passwd" id="new_passwd" path="passwd" placeholder="새 비밀번호를 입력해주세요."/> 
															<form:errors path="passwd" cssClass="error-color" />
														</li>
														<li>
															<input type="password" id="cpasswd" class="passwd" placeholder="새 비밀번호를 한 번 더 입력해주세요."> 
															<span id="message_cpasswd"></span>
														</li>
														<div class="clear"/>
													</ul>
													<div class="profile-userbuttons">
														<form:button class="modibtn">수정</form:button>
														<input type="button" class="homebtn" value="이전으로" onclick="location.href='update.do'">
													</div>
											</div>
										</header>
										</div>
									</section>
								</div>
							</div>
						</div>
					</div>
				</section>
			</div>
		</div>
	</form:form>
</div>
<!-- 중앙 컨텐츠 끝 -->