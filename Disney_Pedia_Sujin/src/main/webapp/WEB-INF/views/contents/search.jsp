<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/scroll.js"></script>
<section class="css-18gwkcr">
	<section class="css-le8j8b">
		<div class="css-1jehmiq">
			<div class="css-10zg79x-pageMarginStyle">"${param.keyword_header }"의
				검색결과</div>
		</div>
		<div class="css-15qcwbn-StyledTabBarContainer e1szkzar1"
			style="height: 50px;">
			<ul class="css-1gwdxtz-VisualUl-StyledTabBarUl e1szkzar2"
				style="width: 100%; margin: 0px auto;">

				<li><a
					class="<c:if test="${param.category eq 'contents'}">css-s8lqsd-StyledTab e1szkzar0</c:if>
                        <c:if test="${param.category ne 'contents' }">css-4tchbd-StyledTab e1szkzar0</c:if>"
					href="${pageContext.request.contextPath}/contents/search.do?keyword_header=${param.keyword_header }&category=contents">콘텐츠
				</a></li>
				<li><a
					class="<c:if test="${param.category eq 'users'}">css-s8lqsd-StyledTab e1szkzar0</c:if>
                        <c:if test="${param.category ne 'users' }">css-4tchbd-StyledTab e1szkzar0</c:if>"
					href="${pageContext.request.contextPath}/contents/search.do?keyword_header=${param.keyword_header }&category=users">유저
				</a></li>
			</ul>
		</div>
		<div class="css-ipmqep-StyledTabContentContainer e1szkzar3">
			<div class="css-12hxjcc-StyledHideableBlock e1pww8ij0"
				style="min-height: 650px;">
				<c:if
					test="${param.category eq 'contents' || empty param.category }">
					<c:if test="${fn:length(search_result) lt 1}">
						<section class="css-1aogsz3">
							<div class="css-1wq3gbk-Self eblbipc0">
								<span
									src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSI0OCIgaGVpZ2h0PSI0OCIgdmlld0JveD0iMCAwIDQ4IDQ4Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPGcgZmlsbD0iI0Q0RDRENCI+CiAgICAgICAgICAgIDxwYXRoIGQ9Ik00MS44MzMgNDMuOTg0bC02Ljg2LTYuOTFhLjY2OC42NjggMCAwIDAtLjQ3My0uMTk3aC0yN2ExLjMzNSAxLjMzNSAwIDAgMS0xLjMzMy0xLjMzNHYtMjdjMC0uNzM2LjU5OC0xLjMzNCAxLjMzMy0xLjMzNGgzM2MuNzM1IDAgMS4zMzMuNTk4IDEuMzMzIDEuMzM0djM1LjQ0MXpNNDAuNSA1Ljg3NmgtMzNhMi42NyAyLjY3IDAgMCAwLTIuNjY3IDIuNjY3djI3QTIuNjcgMi42NyAwIDAgMCA3LjUgMzguMjFoMjYuNzIzbDcuODA0IDcuODYxYS42NjYuNjY2IDAgMCAwIDEuMTQtLjQ2OVY4LjU0MkEyLjY3IDIuNjcgMCAwIDAgNDAuNSA1Ljg3N3oiLz4KICAgICAgICAgICAgPHBhdGggZD0iTTE0LjIzNiAyOC4zMjZ2LTMuMzU0aDMuMzUydjMuMzU0aC0zLjM1MnptMS42NzYtMTIuODU0YTEuODE3IDEuODE3IDAgMSAxIDAgMy42MzQgMS44MTcgMS44MTcgMCAwIDEgMC0zLjYzNHptNC4zMzEgNy44MjR2LTIuMjM1aDUuNTg5djIuMjM1aC01LjU4OXptOC41MTctOC43MmMzLjc2IDAgNi44MSAyLjIyIDYuODEgNy42MDJzLTMuMDUgNy42MDItNi44MSA3LjYwMlYxNC41Nzd6Ii8+CiAgICAgICAgPC9nPgogICAgPC9nPgo8L3N2Zz4K"
									class="css-1qrj66x-ErrorImage eblbipc1"></span>
								<div class="css-1qytvfb-Message eblbipc2">검색 결과가 없어요. 다른
									검색어를 입력해보세요.</div>
							</div>
						</section>
					</c:if>
					<c:if test="${fn:length(search_result) gt 0}">
						<section class="css-9ebwyf-pageMarginStyle">
							<section class="css-1s4ow07">
								<div class="css-usdi1z">
									<div class="css-9dnzub scroll">
										<div class="css-174lxc3">
											<ul class="css-1bk3hui-VisualUl">

												<c:forEach var="search_result" items="${search_result }">
													<li class="css-8y23cj"><a
														title="${search_result.title }"
														href="${pageContext.request.contextPath}/contents/detail.do?contents_type=${search_result.contents_type }&contents_num=${search_result.contents_num}">
															<div class="css-1qmeemv">
																<div
																	class=" css-1rdb949-StyledLazyLoadingImage ezcopuc0">
																	<img
																		src="https://image.tmdb.org/t/p/original/${search_result.poster_path }"
																		class="css-qhzw1o-StyledImg ezcopuc1">
																</div>
															</div>
															<div class="css-ixy093">
																<div class="css-31iyzt">${search_result.title }</div>
																<div class="css-1thqxgo">
																	<fmt:formatDate value="${search_result.release_date }"
																		pattern="yyyy-MM-dd" />
																</div>
																<div class="css-jgn78h">
																	<c:if test="${search_result.contents_type eq 'movie' }">영화</c:if>
																	<c:if test="${search_result.contents_type eq 'tv' }">시리즈</c:if>
																</div>
															</div>
													</a></li>
												</c:forEach>

												<div class="css-ml096x"></div>
											</ul>
										</div>
									</div>
									<div class="arrow_button css-1b9dnd0 left"
										style="display: none;">
										<button type="button" class="css-vp7uyl"
											style="margin-bottom: 60px;">
											<img
												src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxMiIgaGVpZ2h0PSIxNiIgdmlld0JveD0iMCAwIDEyIDE2Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZD0iTTAgMEgxMlYxNkgweiIgdHJhbnNmb3JtPSJyb3RhdGUoMTgwIDYgOCkiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjMjkyQTMyIiBzdHJva2U9IiMyOTJBMzIiIHN0cm9rZS13aWR0aD0iLjM1IiBkPSJNMy40MjkgMTMuNDA5TDQuMzU0IDE0LjI1OCAxMC42OCA4LjQ2IDExLjE0MyA4LjAzNiA0LjM1NCAxLjgxMyAzLjQyOSAyLjY2MiA5LjI5MSA4LjAzNnoiIHRyYW5zZm9ybT0icm90YXRlKDE4MCA2IDgpIi8+CiAgICA8L2c+Cjwvc3ZnPgo="
												alt="forward">
										</button>
									</div>
									<div class="arrow_button css-pf83cl right">
										<button type="button" class="css-vp7uyl"
											style="margin-bottom: 60px;">
											<img
												src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxMiIgaGVpZ2h0PSIxNiIgdmlld0JveD0iMCAwIDEyIDE2Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZD0iTTAgMEgxMlYxNkgweiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiMyOTJBMzIiIHN0cm9rZT0iIzI5MkEzMiIgc3Ryb2tlLXdpZHRoPSIuMzUiIGQ9Ik0zLjQyOSAxMy40MDlMNC4zNTQgMTQuMjU4IDEwLjY4IDguNDYgMTEuMTQzIDguMDM2IDQuMzU0IDEuODEzIDMuNDI5IDIuNjYyIDkuMjkxIDguMDM2eiIvPgogICAgPC9nPgo8L3N2Zz4K"
												alt="forward">
										</button>
									</div>
								</div>
								<hr class="css-cf9e76">
							</section>
							<section class="css-11yyw1d">
								<div class="css-1gkas1x-Grid e1689zdh0">
									<div class="css-1y901al-Row emmoxnt0">
										<header class="css-1ue9xs6">
											<h2 class="css-1wtjsst">영화</h2>
										</header>
									</div>
								</div>
								<div class="css-usdi1z">
									<div class="css-9dnzub scroll">
										<div class="css-174lxc3">
											<ul class="css-1a4f9b-VisualUl">
												<c:forEach var="search_result" items="${search_result }">
													<c:if test="${search_result.contents_type eq 'movie' }">
														<li class="css-1iuimiv"><a
															title="${search_result.title }"
															class="css-1aaqvgs-InnerPartOfListWithImage"
															href="${pageContext.request.contextPath}/contents/detail.do?contents_type=${search_result.contents_type }&contents_num=${search_result.contents_num}">
																<div class="css-cssveg">
																	<div class=" css-14fymwm-StyledSelf e1q5rx9q0">
																		<span class="css-bhgne5-StyledBackground e1q5rx9q1"
																			style="background-image:url('https://image.tmdb.org/t/p/original/${search_result.poster_path }');"></span>
																	</div>
																</div>
																<div class="css-zoy7di">
																	<div class="css-qkf9j">
																		<div class="css-x62r3q">${search_result.title }</div>
																		<div class="css-h25two">
																			<fmt:formatDate
																				value="${search_result.release_date }"
																				pattern="yyyy-MM-dd" />
																		</div>
																	</div>
																	<div></div>
																</div>
														</a></li>
													</c:if>
												</c:forEach>
												<div class="css-6qnjre"></div>
											</ul>
										</div>
									</div>
									<div class="arrow_button css-1b9dnd0 left"
										style="display: none;">
										<button type="button" class="css-vp7uyl"
											style="margin-bottom: 60px;">
											<img
												src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxMiIgaGVpZ2h0PSIxNiIgdmlld0JveD0iMCAwIDEyIDE2Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZD0iTTAgMEgxMlYxNkgweiIgdHJhbnNmb3JtPSJyb3RhdGUoMTgwIDYgOCkiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjMjkyQTMyIiBzdHJva2U9IiMyOTJBMzIiIHN0cm9rZS13aWR0aD0iLjM1IiBkPSJNMy40MjkgMTMuNDA5TDQuMzU0IDE0LjI1OCAxMC42OCA4LjQ2IDExLjE0MyA4LjAzNiA0LjM1NCAxLjgxMyAzLjQyOSAyLjY2MiA5LjI5MSA4LjAzNnoiIHRyYW5zZm9ybT0icm90YXRlKDE4MCA2IDgpIi8+CiAgICA8L2c+Cjwvc3ZnPgo="
												alt="forward">
										</button>
									</div>
									<div class="arrow_button css-pf83cl right">
										<button type="button" class="css-vp7uyl"
											style="margin-bottom: 60px;">
											<img
												src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxMiIgaGVpZ2h0PSIxNiIgdmlld0JveD0iMCAwIDEyIDE2Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZD0iTTAgMEgxMlYxNkgweiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiMyOTJBMzIiIHN0cm9rZT0iIzI5MkEzMiIgc3Ryb2tlLXdpZHRoPSIuMzUiIGQ9Ik0zLjQyOSAxMy40MDlMNC4zNTQgMTQuMjU4IDEwLjY4IDguNDYgMTEuMTQzIDguMDM2IDQuMzU0IDEuODEzIDMuNDI5IDIuNjYyIDkuMjkxIDguMDM2eiIvPgogICAgPC9nPgo8L3N2Zz4K"
												alt="forward">
										</button>
									</div>
									<hr class="css-g67iqr">
							</section>
							<section class="css-11yyw1d">
								<div class="css-1gkas1x-Grid e1689zdh0">
									<div class="css-1y901al-Row emmoxnt0">
										<header class="css-1ue9xs6">
											<h2 class="css-1wtjsst">TV 시리즈</h2>
										</header>
									</div>
								</div>
								<div class="css-usdi1z">
									<div class="css-9dnzub scroll">
										<div class="css-174lxc3">
											<ul class="css-1a4f9b-VisualUl">
												<c:forEach var="search_result" items="${search_result }">
													<c:if
														test="${search_result.contents_type eq 'tv'  && !empty search_result.contents_type}">
														<li class="css-1iuimiv"><a
															title="${search_result.title }"
															class="css-1aaqvgs-InnerPartOfListWithImage"
															href="${pageContext.request.contextPath}/contents/detail.do?contents_type=${search_result.contents_type }&contents_num=${search_result.contents_num}">
																<div class="css-cssveg">
																	<div class=" css-14fymwm-StyledSelf e1q5rx9q0">
																		<span class="css-bhgne5-StyledBackground e1q5rx9q1"
																			style="background-image:url('https://image.tmdb.org/t/p/original/${search_result.poster_path }');"></span>
																	</div>
																</div>
																<div class="css-zoy7di">
																	<div class="css-qkf9j">
																		<div class="css-x62r3q">${search_result.title }</div>
																		<div class="css-h25two">
																			<fmt:formatDate
																				value="${search_result.release_date }"
																				pattern="yyyy-MM-dd" />
																		</div>
																	</div>
																	<div></div>
																</div>
														</a></li>
													</c:if>
												</c:forEach>
												<div class="css-6qnjre"></div>
											</ul>
										</div>
									</div>
								</div>
								<div class="arrow_button css-1b9dnd0 left"
									style="display: none;">
									<button type="button" class="css-vp7uyl"
										style="margin-bottom: 60px;">
										<img
											src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxMiIgaGVpZ2h0PSIxNiIgdmlld0JveD0iMCAwIDEyIDE2Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZD0iTTAgMEgxMlYxNkgweiIgdHJhbnNmb3JtPSJyb3RhdGUoMTgwIDYgOCkiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjMjkyQTMyIiBzdHJva2U9IiMyOTJBMzIiIHN0cm9rZS13aWR0aD0iLjM1IiBkPSJNMy40MjkgMTMuNDA5TDQuMzU0IDE0LjI1OCAxMC42OCA4LjQ2IDExLjE0MyA4LjAzNiA0LjM1NCAxLjgxMyAzLjQyOSAyLjY2MiA5LjI5MSA4LjAzNnoiIHRyYW5zZm9ybT0icm90YXRlKDE4MCA2IDgpIi8+CiAgICA8L2c+Cjwvc3ZnPgo="
											alt="forward">
									</button>
								</div>
								<div class="arrow_button css-pf83cl right">
									<button type="button" class="css-vp7uyl"
										style="margin-bottom: 60px;">
										<img
											src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxMiIgaGVpZ2h0PSIxNiIgdmlld0JveD0iMCAwIDEyIDE2Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZD0iTTAgMEgxMlYxNkgweiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiMyOTJBMzIiIHN0cm9rZT0iIzI5MkEzMiIgc3Ryb2tlLXdpZHRoPSIuMzUiIGQ9Ik0zLjQyOSAxMy40MDlMNC4zNTQgMTQuMjU4IDEwLjY4IDguNDYgMTEuMTQzIDguMDM2IDQuMzU0IDEuODEzIDMuNDI5IDIuNjYyIDkuMjkxIDguMDM2eiIvPgogICAgPC9nPgo8L3N2Zz4K"
											alt="forward">
									</button>
								</div>
								<hr class="css-g67iqr">
							</section>
						</section>
					</c:if>
				</c:if>
				<!-- 유저 -->
				<c:if test="${param.category eq 'users'}">
					<c:if test="${fn:length(user_list) lt 1}">
						<section class="css-1aogsz3">
							<div class="css-1wq3gbk-Self eblbipc0">
								<span
									src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSI0OCIgaGVpZ2h0PSI0OCIgdmlld0JveD0iMCAwIDQ4IDQ4Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPGcgZmlsbD0iI0Q0RDRENCI+CiAgICAgICAgICAgIDxwYXRoIGQ9Ik00MS44MzMgNDMuOTg0bC02Ljg2LTYuOTFhLjY2OC42NjggMCAwIDAtLjQ3My0uMTk3aC0yN2ExLjMzNSAxLjMzNSAwIDAgMS0xLjMzMy0xLjMzNHYtMjdjMC0uNzM2LjU5OC0xLjMzNCAxLjMzMy0xLjMzNGgzM2MuNzM1IDAgMS4zMzMuNTk4IDEuMzMzIDEuMzM0djM1LjQ0MXpNNDAuNSA1Ljg3NmgtMzNhMi42NyAyLjY3IDAgMCAwLTIuNjY3IDIuNjY3djI3QTIuNjcgMi42NyAwIDAgMCA3LjUgMzguMjFoMjYuNzIzbDcuODA0IDcuODYxYS42NjYuNjY2IDAgMCAwIDEuMTQtLjQ2OVY4LjU0MkEyLjY3IDIuNjcgMCAwIDAgNDAuNSA1Ljg3N3oiLz4KICAgICAgICAgICAgPHBhdGggZD0iTTE0LjIzNiAyOC4zMjZ2LTMuMzU0aDMuMzUydjMuMzU0aC0zLjM1MnptMS42NzYtMTIuODU0YTEuODE3IDEuODE3IDAgMSAxIDAgMy42MzQgMS44MTcgMS44MTcgMCAwIDEgMC0zLjYzNHptNC4zMzEgNy44MjR2LTIuMjM1aDUuNTg5djIuMjM1aC01LjU4OXptOC41MTctOC43MmMzLjc2IDAgNi44MSAyLjIyIDYuODEgNy42MDJzLTMuMDUgNy42MDItNi44MSA3LjYwMlYxNC41Nzd6Ii8+CiAgICAgICAgPC9nPgogICAgPC9nPgo8L3N2Zz4K"
									class="css-1qrj66x-ErrorImage eblbipc1"></span>
								<div class="css-1qytvfb-Message eblbipc2">검색 결과가 없어요. 다른
									검색어를 입력해보세요.</div>
							</div>
						</section>
					</c:if>
					<c:if test="${fn:length(user_list) gt 0}">
						<div class="css-1djzg97">
							<ul class="css-paz4zm-VisualUl">
								<c:forEach var="user_list" items="${user_list }">
									<li class="css-1tmgvat"><a
										title="${param.keyword_header }"
										class="css-1aaqvgs-InnerPartOfListWithImage"
										href="${pageContext.request.contextPath}/member/myPage.do?user_num=${user_list.mem_num}">
											<div class="css-cssveg">
												<div class="css-lmg4ew">

													<div class="css-h6h0rq-ProfilePhotoImage">
														<c:if test="${empty user_list.photo_name}">
															<img width="71" height="71" class="my-photo"
																src="${pageContext.request.contextPath}/resources/images/face.png">
														</c:if>
														<c:if test="${!empty user_list.photo_name}">
															<img width="71" height="71" class="my-photo"
																src="${pageContext.request.contextPath}/member/photoView.do?user_num=${user_list.mem_num}">
														</c:if>
													</div>
												</div>
											</div>

											<div class="css-zoy7di">
												<div class="css-qkf9j">
													<div class="css-17vuhtq">
														<div class="css-14hy3cw">${user_list.name }</div>
													</div>
													<div class="css-1evnpxk-StyledSubtitle">
														<div class="css-xpswhu">${user_list.introduction }</div>
													</div>
												</div>
											</div>
									</a></li>
								</c:forEach>
							</ul>
						</div>
					</c:if>
				</c:if>
			</div>
		</div>
	</section>
</section>