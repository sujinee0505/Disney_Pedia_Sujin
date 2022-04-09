<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script
	src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(function() {
		//프로필 사진 업로드
		$('#photo_btn').click(function() {
			$('#photo_choice').show();
			$(this).hide();
		});
		//처음 화면에 보여지는 이미지 읽기
		let photo_path = $('.my-photo').attr('src');
		let my_photo;
		$('#upload').change(
				function() {
					my_photo = this.files[0];
					if (!my_photo) {
						$('.my-photo').attr('src', photo_path);
						return;
					}
					if (my_photo.size > 1024 * 1024) {
						alert(Math.round(my_photo.size / 1024)
								+ 'kbytes(1024kbytes까지만 업로드 가능)');
						$('.my-photo').attr('src', photo_path);
						$(this).val('');
						return;
					}
					//이미지 미리보기
					var reader = new FileReader();
					reader.readAsDataURL(my_photo);

					reader.onload = function() {
						$('.my-photo').attr('src', reader.result);
					};
				});//end of change

		//이미지를 서버에 전송
		$('#photo_submit').click(function() {
			if ($('#upload').val() == '') {
				alert('파일을 선택하세요!');
				$('#upload').focus();
				return;
			}
			//파일 전송
			var form_data = new FormData();
			form_data.append('upload', my_photo);

			$.ajax({
				url : 'updateMyPhoto.do',
				type : 'post',
				data : form_data,
				dataType : 'json',
				contentType : false,
				enctype : 'multipart/form-data',
				processData : false,
				success : function(param) {
					if (param.result == 'logout') {
						alert('로그인 후 사용하세요'); 
					} else if (param.result == 'success') {
						
						Swal.fire({
				            title: ' ',
				            text: '프로필 사진 변경 완료.',
				            imageUrl: '${pageContext.request.contextPath}/resources/images/ok_icon.png',
				            imageWidth: 70,
				            imageHeight: 70,
				            imageAlt: 'Custom image',
				            confirmButtonColor: '#84d7fa',
				            confirmButtonText: '확인',
				            width: 400,
				            padding: '2em'
				        }).then((result) => {
				        	if (result.isConfirmed) {
                                location.reload(true);
                            }
				        }) //swal end
				        
						photo_path = $('.my-photo').attr('src');
						$('#upload').val('');
						$('#photo_choice').hide();
						$('#photo_btn').show();
					} else {
						alert('파일 전송 오류 발생');
					}
				},
				error : function() {
					alert('네트워크 오류 발생');
				}
			});
		});//end of click

		$('#photo_reset').click(function() {
			$('.my-photo').attr('src', photo_path);
			$('#upload').val('');
			$('#photo_choice').hide();
			$('#photo_btn').show();
		});

	});
</script>
<style>
*{
	font-family: 'SUIT-Medium';
}
body {
	background: #F1F3FA;
}

ul li {
	list-style: none;
	text-align: center !important;
}
</style>
<div class="container">
	<form:form modelAttribute="memberVO" action="update.do"
		id="modify_form">
		<form:errors element="div" cssClass="error-color" />
		<div id="root">
			<div class="css-5jq76">
				<div class="css-1xm32e0">
					<section class="css-18gwkcr">
						<div class="css-egiga7-Self e19zkogf0">
							<div class="css-19rw4yc-Container e19zkogf1">
								<div class="css-1xqcv4t">
									<div class="css-19lj1vd-RoundedCornerBlock-RoundedCornerBlock">
										<section class="css-q4evg3-MyPage e19zkogf2">
											<!-- SIDEBAR USERPIC -->
											<div class="profile-userpic">
												<ul>
													<li><c:if test="${empty user_photo}">
															<img
																src="${pageContext.request.contextPath}/resources/images/face.png"
																width="200" height="200" class="my-photo">
														</c:if> <c:if test="${!empty user_photo}">
															<img
																src="${pageContext.request.contextPath}/member/photoView.do?user_num=0"
																width="200" height="200" class="my-photo">
														</c:if></li>
													<li>
														<div class="align-center">
															<input type="button" class="yWX7d" value="사진변경"
																id="photo_btn">
														</div>
														<div id="photo_choice" class="filebtn"
															style="display: none;">
															<input type="file" id="upload"
																accept="image/gif,image/png,image/jpeg"> <input
																type="button" class="filebtn" value="변경"
																id="photo_submit"> <input type="button"
																class="filebtn" value="취소" id="photo_reset">
														</div>
													</li>
												</ul>
											</div>
											<!-- END SIDEBAR USERPIC -->
											<!-- SIDEBAR USER TITLE -->
											<div class="profile-usertitle">
												<div class="profile-usertitle-name">
													<ul>
														<li><form:label path="name">이름</form:label> <form:input
																class="form1" path="name" /> <form:errors path="name"
																cssClass="error-color" /></li>
														<li><form:label path="introduction">소개</form:label> 
														<form:textarea style="resize:none;"
																class="form2" path="introduction" /> <form:errors
																path="introduction" cssClass="error-color" /></li>
														<li><form:label path="passwd">비밀번호</form:label> <input
															type="button" class="passbtn" value="비밀번호변경하기 >"
															data-bs-toggle="modal" data-bs-target="#myModal3"
															onclick="location.href='changePassword.do'"></li>
													</ul>
												</div>
											</div>
											<!-- END SIDEBAR USER TITLE -->
											<!-- SIDEBAR BUTTONS -->
											<div class="profile-userbuttons">
												<form:button class="modibtn">수정</form:button>
												<input type="button" class="homebtn" value="이전으로"
													onclick="history.back(-1);">
												<div class="profile-userbuttons">
													<input type="button" class="yWX7s" value="회원탈퇴 >"
														onclick="location.href='delete.do'">
												</div>
											</div>
											<!-- END SIDEBAR BUTTONS -->
										</section>
									</div>
								</div>
							</div>
						</div>
					</section>
				</div>
			</div>
		</div>
	</form:form>
</div>
