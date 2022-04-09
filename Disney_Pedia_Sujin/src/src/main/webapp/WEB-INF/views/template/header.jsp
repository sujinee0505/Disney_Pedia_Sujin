<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<head>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<script type="text/javascript">
	$(function() {
		getPath = function() {
			document.getElementById("path").value = location.pathname
					+ location.search;
		}
		getPath();
	});
</script>
<!-- 상단 시작 -->
<header class="css-6k8tqb" id="header">
	<nav>
		<div class="css-1gkas1x-Grid e1689zdh0">
			<div class="css-1djzg97">
				<ul class="css-6v7b8v-VisualUl">
					<li class="css-t686xv"><a
						href="${pageContext.request.contextPath}/main/main.do"><img
							src="${pageContext.request.contextPath}/resources/images/logo.png"
							height="62px;"></a></li>
					<li class="categories css-bj71cw"><button
							onclick="location.href='${pageContext.request.contextPath}/main/main.do?type=movie'"
							class="<c:if test="${param.type eq 'movie' && empty param.id  }">css-x6oby2-StylelessButton</c:if>
							<c:if test="${param.type ne 'movie' || !empty param.id }">css-q65tx9-StylelessButton</c:if>">영화</button></li>
					<li class="categories css-bj71cw"><button
							onclick="location.href='${pageContext.request.contextPath}/main/main.do?type=tv'"
							class="<c:if test="${param.type eq 'tv' && empty param.id  }">css-x6oby2-StylelessButton</c:if><c:if test="${param.type ne 'tv' || !empty param.id }">css-q65tx9-StylelessButton</c:if>">TV</button></li>
					<li class="categories css-bj71cw"><button
							onclick="location.href='${pageContext.request.contextPath}/chatboard/list.do'"
							class="css-q65tx9-StylelessButton">채팅방</button></li>
					<li class="css-1c3wwgb"><div class="css-1xm32e0">
							<div class="css-1okeg7p">
								<form
									action="${pageContext.request.contextPath}/contents/search.do"
									method="get">
									<label class="css-kyr608" id="label"><input type="text"
										autocomplete="off" placeholder="콘텐츠, 인물, 유저를 검색해보세요." name="keyword_header"
										value="${param.keyword_header}" class="css-13i5xe6" id="keyword_header">
										<div value="false" class="css-ikj5sk">
											<span aria-label="clear" role="button" class="css-14vwb0g"></span>
										</div></label>
								</form>
							</div>
						</div></li>
					<c:if test="${empty user_num ||  user_num ==0 }">
						<!-- 로그인 -->
						<li class="css-bj71cw">
							<button id="login-btn" type="button"
								class="css-fn0ezc-StylelessButton" data-bs-toggle="modal"
								data-bs-target="#myModal">로그인</button>
						</li>
						<!-- 로그인 -->
						<li class="css-bj71cw">
							<button id="register-btn" type="button" class="css-139vxi-StylelessButton"
								data-bs-toggle="modal" data-bs-target="#myModal2">회원가입
							</button>
					</c:if>
					<c:if test="${!empty user_num && user_num !=0}">
						<li class="css-bj71cw"><form action="logout.do"
								method="post">
								<input type="hidden" name="path" id="path" />
								<button class="css-fn0ezc-StylelessButton" id="header_logout"
									type="submit">로그아웃</button>
							</form></li>

					</c:if>
					<c:if test="${!empty user_num &&user_num != 0 && empty user_photo}">
						<a
							href="${pageContext.request.contextPath}/member/myPage.do?user_num=0">
							<img
							src="${pageContext.request.contextPath}/resources/images/face.png"
							width="25" height="25" class="my-photo">
						</a>
					</c:if>
					<c:if test="${!empty user_num && user_num !=0 && !empty user_photo}">
						<a
							href="${pageContext.request.contextPath}/member/myPage.do?user_num=0">
							<img
							src="${pageContext.request.contextPath}/member/photoView.do?user_num=0"
							width="25" height="25" class="my-photo">
						</a>
					</c:if>

				</ul>
			</div>
		</div>
	</nav>
</header>
<!-- 상단 끝 -->
<!--로그인 모달 틀-->
<div id="myModal" class="modal fade" tabindex="-1" role="dialog">
	<div class="modal-dialog modal-login">
		<div class="modal-content">
			<jsp:include page="/WEB-INF/views/member/memberLogin.jsp" />
		</div>
	</div>
</div>

<!--회원가입 모달 틀-->
<div id="myModal2" class="modal fade" tabindex="-1" role="dialog">
	<div class="modal-dialog modal-login">
		<div class="modal-content">
			<jsp:include page="/WEB-INF/views/member/memberRegister.jsp" />
		</div>
	</div>
</div>