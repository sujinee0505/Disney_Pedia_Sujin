<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 중앙 컨텐츠 시작 -->
<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<style>
*{
	font-family: 'SUIT-Medium';
}
div {
	display: block;
}

body {
	font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
	font-size: 14px;
	line-height: 1.42857143;
	color: #333;
	background-color: #fff;
}

body {
	margin: 0;
	font-family: var(- -bs-body-font-family);
	font-size: var(- -bs-body-font-size);
	font-weight: var(- -bs-body-font-weight);
	line-height: var(- -bs-body-line-height);
	color: var(- -bs-body-color);
	text-align: var(- -bs-body-text-align);
	background-color: var(- -bs-body-bg);
	-webkit-text-size-adjust: 100%;
	-webkit-tap-highlight-color: transparent;
}

section {
	display: block;
}

li {
	list-style: none
}

ul {
	display: block;
	list-style-type: disc;
	margin-block-start: 1em;
	margin-block-end: 1em;
	margin-inline-start: 85px;
	margin-inline-end: 0px;
}

input[type=button] {
	display: inline-block;
	width: 350px;
	outline: none;
	cursor: pointer;
	font-weight: 500;
	border: 1px solid transparent;
	border-radius: 2px;
	height: 36px;
	line-height: 34px;
	font-size: 14px;
	color: #241c15;
	background-color: #efeeea;
	padding: 0 18px;
	margin-right: 15px;
}
</style>
<div id="root">
	<div class="css-5jq76">
		<div class="css-1xm32e0">
			<section class="css-18gwkcr">
				<div class="css-egiga7-Self e19zkogf0">
					<div class="css-19rw4yc-Container e19zkogf1">
						<div class="css-1xqcv4t">
							<div class="css-19lj1vd-RoundedCornerBlock-RoundedCornerBlock">
								<section class="css-q4evg3-MyPage e19zkogf2">
									<div class="css-ewkqyn-WallPaper e19zkogf3">
										<ul>
											<li><c:choose>
													<c:when test="${empty usr_num}">
														<c:if test="${empty member.photo_name}">
															<img
																src="${pageContext.request.contextPath}/resources/images/face.png"
																width="150" height="150" class="my-photo">
														</c:if>
														<c:if test="${!empty member.photo_name}">
															<img
																src="${pageContext.request.contextPath}/member/photoView.do?user_num=${member.mem_num}"
																width="150" height="150" class="my-photo">
														</c:if>
													</c:when>
													<c:when test="${!empty usr_num}">
														<c:if test="${ empty user_photo}">
															<img
																src="${pageContext.request.contextPath}/resources/images/face.png"
																width="150" height="150" class="my-photo">
														</c:if>
														<c:if test="${!empty user_photo}">
															<img
																src="${pageContext.request.contextPath}/member/photoView.do?user_num=${member.mem_num}"
																width="150" height="150" class="my-photo">
														</c:if>
													</c:when>
												</c:choose></li>
										</ul>
									</div>
									<div class="css-1gkas1x-Grid e1689zdh0">
										<div class="css-1y901al-Row emmoxnt0">
											<header class="css-1hjjbcz-ProfileHeader e19zkogf4">
												<div class="css-1gry5r7"></div>
												<div class="css-5inudd-NameBlock e19zkogf5">
													<h1 class="css-aizam7-Name e19zkogf6">${member.name}</h1>
												</div>
												<div class="css-7w44b1-AboutMe e19zkogf9">
													<div class=" css-sloxdm-StyledSelf eb5y16b0">
														<div class="css-1fucs4t-StyledText eb5y16b1">${member.introduction}</div>
													</div>
												</div>
												<c:if
													test="${param.user_num ==0 || user_num == member.mem_num}">
													<div class="profile-userbutton">
														<input type="button" value="프로필수정"
															onclick="location.href='update.do'"> <a
															href="myCalendar.do?mem_num=${member.mem_num}"> <img
															src="${pageContext.request.contextPath}/resources/images/cal.png"
															width="30" height="30" id="myCal">
														</a>
													</div>
												</c:if>
										</div>
										</header>
										<div class="css-usdi112">
											<div class="css-9dnzub">
												<div class="css-174lxc3">
													<div class="css-1gkas1x-Grid e1689zdh0">
														<div class="css-1y901al-Row emmoxnt0">
															<ul
																class="e19zkogf12 css-i1bo8u-VisualUl-CategoryArchivesUl">
																<li
																	class="css-1u4jvye-CategoryArchivesListItem e19zkogf13">
																	<a class="css-h3f67w-CategoryArchivesLink e19zkogf14"
																	href="<c:if test="${param.user_num == 0 }">myContents.do?contents_type=movie&mem_num=${user_num }</c:if>
																<c:if test="${param.user_num != 0 }">myContents.do?contents_type=movie&mem_num=${param.user_num }</c:if>">
																		<ul
																			class="css-reeb92-VisualUl-CategoryArchives e19zkogf15">
																			<li
																				class="css-r3hbc5-CategoryArchivesName e19zkogf16">
																				영화</li>
																			<li
																				class="css-7xoi89-CategoryArchivesRatedCount e19zkogf17">
																				★<c:forEach var="star" items="${star}">
																					<c:if
																						test="${star.contents_type eq 'movie' && star.contents_type ne 'tv' }">${star.count }</c:if>
																				</c:forEach>
																			</li>
																			<li
																				class="css-kcevqh-CategoryArchivesWishedCount e19zkogf18">
																				보고싶어요 <strong> <c:forEach var="like"
																						items="${like}">
																						<c:if
																							test="${like.contents_type eq 'movie' && like.contents_type ne 'tv' }">${like.count }</c:if>
																					</c:forEach>
																			</strong>
																			</li>
																		</ul>
																</a>
																</li>
																<li
																	class="css-1u4jvye-CategoryArchivesListItem e19zkogf13">
																	<a background="[object Object]"
																	class="css-1gw6y00-CategoryArchivesLink e19zkogf14"
																	href="<c:if test="${param.user_num == 0 }">myContents.do?contents_type=tv&mem_num=${user_num }</c:if>
																<c:if test="${param.user_num != 0 }">myContents.do?contents_type=tv&mem_num=${param.user_num }</c:if>">
																		<ul
																			class="css-1x0nmo-VisualUl-CategoryArchives e19zkogf15">
																			<li
																				class="css-r3hbc5-CategoryArchivesName e19zkogf16">
																				TV프로그램</li>
																			<li
																				class="css-7xoi89-CategoryArchivesRatedCount e19zkogf17">
																				★<c:forEach var="star" items="${star}">
																					<c:if
																						test="${star.contents_type eq 'tv'&& star.contents_type ne 'movie'}">${star.count }</c:if>
																				</c:forEach>
																			</li>
																			<li
																				class="css-kcevqh-CategoryArchivesWishedCount e19zkogf18">
																				보고싶어요 <strong> <c:forEach var="like"
																						items="${like}">
																						<c:if
																							test="${like.contents_type eq 'tv'&& like.contents_type ne 'movie'}">${like.count }</c:if>
																					</c:forEach>
																			</strong>
																			</li>
																		</ul>
																</a>
																</li>
															</ul>
														</div>
													</div>
												</div>
											</div>
										</div>

										<div class="mylike" >
											<ul>
												<h2 style="font-size: 22px;">코멘트</h2>
												<li class="css-1u4jvye-CategoryArchivesListItem e19zkogf13">
													<a
													href="<c:if test="${!empty user_num && param.user_num == 0 }">myComment.do?mem_num=${user_num }</c:if>
																<c:if test="${param.user_num != 0 }">myComment.do?mem_num=${param.user_num }</c:if>">
														<h4 style="font-size: 15px;">작성한 코멘트 ></h4>
												</a>
												</li>
												<li class="css-1u4jvye-CategoryArchivesListItem e19zkogf13">
													<a
													href="<c:if
																test="${!empty user_num && param.user_num == 0 }">likeComment.do?mem_num=${user_num }</c:if>
															<c:if test="${param.user_num != 0}">likeComment.do?mem_num=${param.user_num }</c:if>">

														<h4 style="font-size: 15px;">좋아한 코멘트 ></h4>
												</a>
												</li>
											</ul>
										</div>

									</div>
								</section>
							</div>
						</div>
					</div>
				</div>
			</section>
		</div>
	</div>
</div>