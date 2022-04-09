<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- 중앙 컨텐츠 시작 -->
<style>
body {
	background: #F1F3FA;
}

ul li {
	list-style: none;
	text-align: center !important;
}
*{
	font-family: 'SUIT-Medium';
}
</style>
<div id="root">
	<form:form modelAttribute="memberVO" acceptCharset="delete.do" id="delete_form">
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
														<h3 class="deletetitle">회원탈퇴</h3>
													</div>
													<ul>
														<li>
															<form:password path="id" class="passwd" placeholder="아이디를 입력해주세요."/> 
															<form:errors path="id" cssClass="error-color" />
														</li>	
														<li>
															<form:password path="passwd" class="passwd" placeholder="비밀번호를 입력해주세요." /> 
															<form:errors path="passwd" cssClass="error-color" />
														</li>
													</ul>
													<div class="profile-userbuttons">
														<form:button class="modibtn">탈퇴</form:button>
														<input type="button" class="homebtn" value="이전으로"
															onclick="location.href='update.do'">
													</div></div>
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
