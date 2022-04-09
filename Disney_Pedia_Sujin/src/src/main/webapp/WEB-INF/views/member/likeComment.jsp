<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/scroll.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/cmtLike.js"></script>
<section class="css-18gwkcr">
	<section class="css-le8j8b">
		<div class="css-1jehmiq"
			style="background: transparent; border-bottom: 1px solid #e3e3e3;">
			<div class="css-10zg79x-pageMarginStyle"
				style="font-weight: 700; font-size: 22px; color: black;">좋아한
				코멘트</div>
		</div>
	</section>
</section>
<div class="css-1gkas1x-Grid e1689zdh0">
	<div class="css-1y901al-Row emmoxnt0">
		<div class="css-tbg13q-CommentLists emaj6q20">
			<ul class="css-10n5vg9-VisualUl ep5cwgq0">
				<c:forEach var="cmtLikeList" items="${ cmtLikeList }"
					varStatus="status">
					<div class="css-bawlbm">
						<div class="css-4obf011">
							<div class="css-1cvf9dk">
								<a title="${memberList[status.index].name}"
									class="css-1f9m1s4-StylelessLocalLink eovgsd01"
									href="${pageContext.request.contextPath}/member/myPage.do?user_num=${memberList[status.index].mem_num}">
									<div class="css-107z6xc">
										<div class="css-10h5a7j-ProfilePhotoImage">
											<c:if test="${empty memberList[status.index].photo_name}">
												<img
													src="${pageContext.request.contextPath}/resources/images/face.png"
													width="32" height="32" class="my-photo">
											</c:if>
											<c:if test="${!empty memberList[status.index].photo_name}">
												<img width="32" height="32" class="my-photo"
													src="${pageContext.request.contextPath}/member/photoView.do?user_num=${memberList[status.index].mem_num}">
											</c:if>
										</div>
									</div>
									<div class="css-1agoci2">
										${memberList[status.index].name} <span
											src="data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTIiIGhlaWdodD0iMTIiIHZpZXdCb3g9IjAgMCAxMiAxMiIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KICA8cGF0aCBmaWxsLXJ1bGU9ImV2ZW5vZGQiIGNsaXAtcnVsZT0iZXZlbm9kZCIgZD0iTTQuNzcwNDYgMC41NjI0NTlDNS4yNDMyOCAtMC4xNTY0MzIgNi4zMTE0NyAtMC4xOTMwNyA2LjgzNTM1IDAuNDkyMTU1QzcuMTczMzcgMC45MzM3ODggNy43NzM4NSAxLjEwMTEzIDguMzAxODEgMC45MDAxMjFDOS4xMTk4IDAuNTg4MjA1IDEwLjAwNjIgMS4xNjc0OCAxMC4wMTQ0IDIuMDIxMDRDMTAuMDE5NSAyLjU2OTYxIDEwLjQwNTUgMy4wNDc4OCAxMC45NTM5IDMuMTg1NTJDMTEuODA0NiAzLjM5OTQxIDEyLjE3MDIgNC4zNzQ3NiAxMS42NjA2IDUuMDY4OUMxMS4zMzE4IDUuNTE2NDggMTEuMzUzMiA2LjEyMTQ5IDExLjcxMzcgNi41NDYyOUMxMi4yNzIzIDcuMjA0NzggMTEuOTc3MiA4LjIwMTkyIDExLjE0MzggOC40NzIyNUMxMC42MDY3IDguNjQ3NTIgMTAuMjU3NCA5LjE1MDU0IDEwLjI5MTEgOS42OTkxMkMxMC4zNDQyIDEwLjU0OTcgOS41MDE3NCAxMS4xODc0IDguNjYzMzIgMTAuOTMxOUM4LjEyMjA4IDEwLjc2NzYgNy41MzQ4OCAxMC45NzQ1IDcuMjI5NTQgMTEuNDM3OUM2Ljc1NjcyIDEyLjE1NjggNS42ODc1MSAxMi4xOTI1IDUuMTY0NjUgMTEuNTA4MkM0LjgyNjYzIDExLjA2NTYgNC4yMjYxNSAxMC44OTgzIDMuNjk4MTkgMTEuMTAwM0MyLjg4MDIgMTEuNDEyMiAxLjk5Mzc4IDEwLjgzMTkgMS45ODQ1OSA5Ljk4MDM0QzEuOTgwNTEgOS40Mjk3OCAxLjU5NTUxIDguOTUyNSAxLjA0NjEgOC44MTM4N0MwLjE5NTQyOCA4LjU5OTk5IC0wLjE3MDE2NiA3LjYyNjYxIDAuMzM5NDE5IDYuOTMyNDdDMC42NjgyNDkgNi40ODM5MSAwLjY0NjgwNCA1Ljg3NzkgMC4yODYzMTYgNS40NTMxQy0wLjI3MjI4NyA0Ljc5NDYxIDAuMDIyODQzIDMuNzk5NDUgMC44NTYxNTIgMy41MjcxNUMxLjM5MzMxIDMuMzUyODcgMS43NDM1OSAyLjg1MDgzIDEuNzA4ODYgMi4zMDEyN0MxLjY1NTc2IDEuNDUwNjggMi40OTgyNiAwLjgxMTk5MiAzLjMzNjY4IDEuMDY4NDZDMy44Nzc5MiAxLjIzMjgzIDQuNDY1MTIgMS4wMjU4OCA0Ljc3MDQ2IDAuNTYyNDU5WiIgZmlsbD0iI0Y3MTc1QSIvPgogIDxwYXRoIGZpbGwtcnVsZT0iZXZlbm9kZCIgY2xpcC1ydWxlPSJldmVub2RkIiBkPSJNNS4xNjA2MSA4LjMyODk1QzUuMDM5ODcgOC4zMjg5NSA0LjkyNDU4IDguMjgwODMgNC44MzkyNCA4LjE5NjRMMy4xMzM0NSA2LjQ4ODhDMi45NTU1MiA2LjMxMDg2IDIuOTU1NTIgNi4wMjM5OSAzLjEzMzQ1IDUuODQ2OTdDMy4zMTA0NyA1LjY2OTA0IDMuNTk3MzQgNS42NjkwNCAzLjc3NTI4IDUuODQ2OTdMNS4xNjA2MSA3LjIzMzIxTDguMjI0NSA0LjE2ODQxQzguNDAyNDMgMy45OTEzOSA4LjY4OTMgMy45OTEzOSA4Ljg2NzIzIDQuMTY4NDFDOS4wNDQyNiA0LjM0NTQ0IDkuMDQ0MjYgNC42MzMyMiA4Ljg2NzIzIDQuODEwMjRMNS40ODE5OCA4LjE5NjRDNS4zOTY2NCA4LjI4MDgzIDUuMjgxMzUgOC4zMjg5NSA1LjE2MDYxIDguMzI4OTVaIiBmaWxsPSJ3aGl0ZSIvPgogIDxwYXRoIGQ9Ik01LjE2MDYxIDguMzI4OTVWOC4zMjg5NUM1LjAzOTg3IDguMzI4OTUgNC45MjQ1OCA4LjI4MDgzIDQuODM5MjQgOC4xOTY0TDMuMTMzNDUgNi40ODg4QzIuOTU1NTIgNi4zMTA4NiAyLjk1NTUyIDYuMDIzOTkgMy4xMzM0NSA1Ljg0Njk3QzMuMzEwNDcgNS42NjkwNCAzLjU5NzM0IDUuNjY5MDQgMy43NzUyOCA1Ljg0Njk3TDUuMTYwNjEgNy4yMzMyMUw4LjIyNDUgNC4xNjg0MUM4LjQwMjQzIDMuOTkxMzkgOC42ODkzIDMuOTkxMzkgOC44NjcyMyA0LjE2ODQxQzkuMDQ0MjYgNC4zNDU0NCA5LjA0NDI2IDQuNjMzMjIgOC44NjcyMyA0LjgxMDI0TDUuNDgxOTggOC4xOTY0QzUuMzk2NjQgOC4yODA4MyA1LjI4MTM1IDguMzI4OTUgNS4xNjA2MSA4LjMyODk1IiBzdHJva2U9IndoaXRlIiBzdHJva2Utd2lkdGg9IjAuMjUiLz4KPC9zdmc+Cg=="
											class="css-114ywgf"></span> <span
											src="data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTIiIGhlaWdodD0iMTIiIHZpZXdCb3g9IjAgMCAxMiAxMiIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KICA8cGF0aCBmaWxsLXJ1bGU9ImV2ZW5vZGQiIGNsaXAtcnVsZT0iZXZlbm9kZCIgZD0iTTQuNzcwNDYgMC41NjI0NTlDNS4yNDMyOCAtMC4xNTY0MzIgNi4zMTE0NyAtMC4xOTMwNyA2LjgzNTM1IDAuNDkyMTU1QzcuMTczMzcgMC45MzM3ODggNy43NzM4NSAxLjEwMTEzIDguMzAxODEgMC45MDAxMjFDOS4xMTk4IDAuNTg4MjA1IDEwLjAwNjIgMS4xNjc0OCAxMC4wMTQ0IDIuMDIxMDRDMTAuMDE5NSAyLjU2OTYxIDEwLjQwNTUgMy4wNDc4OCAxMC45NTM5IDMuMTg1NTJDMTEuODA0NiAzLjM5OTQxIDEyLjE3MDIgNC4zNzQ3NiAxMS42NjA2IDUuMDY4OUMxMS4zMzE4IDUuNTE2NDggMTEuMzUzMiA2LjEyMTQ5IDExLjcxMzcgNi41NDYyOUMxMi4yNzIzIDcuMjA0NzggMTEuOTc3MiA4LjIwMTkyIDExLjE0MzggOC40NzIyNUMxMC42MDY3IDguNjQ3NTIgMTAuMjU3NCA5LjE1MDU0IDEwLjI5MTEgOS42OTkxMkMxMC4zNDQyIDEwLjU0OTcgOS41MDE3NCAxMS4xODc0IDguNjYzMzIgMTAuOTMxOUM4LjEyMjA4IDEwLjc2NzYgNy41MzQ4OCAxMC45NzQ1IDcuMjI5NTQgMTEuNDM3OUM2Ljc1NjcyIDEyLjE1NjggNS42ODc1MSAxMi4xOTI1IDUuMTY0NjUgMTEuNTA4MkM0LjgyNjYzIDExLjA2NTYgNC4yMjYxNSAxMC44OTgzIDMuNjk4MTkgMTEuMTAwM0MyLjg4MDIgMTEuNDEyMiAxLjk5Mzc4IDEwLjgzMTkgMS45ODQ1OSA5Ljk4MDM0QzEuOTgwNTEgOS40Mjk3OCAxLjU5NTUxIDguOTUyNSAxLjA0NjEgOC44MTM4N0MwLjE5NTQyOCA4LjU5OTk5IC0wLjE3MDE2NiA3LjYyNjYxIDAuMzM5NDE5IDYuOTMyNDdDMC42NjgyNDkgNi40ODM5MSAwLjY0NjgwNCA1Ljg3NzkgMC4yODYzMTYgNS40NTMxQy0wLjI3MjI4NyA0Ljc5NDYxIDAuMDIyODQzIDMuNzk5NDUgMC44NTYxNTIgMy41MjcxNUMxLjM5MzMxIDMuMzUyODcgMS43NDM1OSAyLjg1MDgzIDEuNzA4ODYgMi4zMDEyN0MxLjY1NTc2IDEuNDUwNjggMi40OTgyNiAwLjgxMTk5MiAzLjMzNjY4IDEuMDY4NDZDMy44Nzc5MiAxLjIzMjgzIDQuNDY1MTIgMS4wMjU4OCA0Ljc3MDQ2IDAuNTYyNDU5WiIgZmlsbD0iIzBFMEYxMCIvPgogIDxwYXRoIGQ9Ik03LjY5NzMzIDIuNDUwMkw3LjI4NjEyIDcuNzkzOTJMNy4xNzc3NCA3Ljc5ODI4TDYuNDUyMjYgMy45Nzk3NUg1LjI2MTIzTDQuNjY1NTggNy44OTE1N0w0LjUzNTc1IDcuODk2OEwzLjk1MDk2IDMuOTc5NzVIMi41TDMuODEwMjcgOS43MTU4Mkw1LjMxNTI4IDkuNjE0MzlMNS44NDU3NCA1Ljk3MTdINS45NjQ5OEw2LjU2MDM1IDkuNTMwMTFMOC4wNzY1MSA5LjQyNzIzTDkuMTA1MTEgMi40NTAySDcuNjk3MzNaIiBmaWxsPSIjRkYwNTU4Ii8+Cjwvc3ZnPgo="
											class="css-amcv0d"></span>
									</div>
								</a>
							</div>
							<c:if test="${cmtLikeList.star > 0 }">
								<div class="css-yqs4x12">
									<img
										src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyNCIgaGVpZ2h0PSIyNCIgdmlld0JveD0iMCAwIDI0IDI0Ij4KICAgIDxwYXRoIGZpbGw9IiM0QTRBNEEiIGZpbGwtcnVsZT0iZXZlbm9kZCIgZD0iTTEyIDE3Ljk4bC02LjAxNSA0LjM5MmMtLjUwOC4zNzItMS4xOTQtLjEyNi0uOTk4LS43MjVsMi4zMTctNy4wODEtNi4wMzUtNC4zNjdjLS41MS0uMzY5LS4yNDctMS4xNzUuMzgyLTEuMTc0bDcuNDQ3LjAxNiAyLjI4Ni03LjA5MWMuMTkyLS42IDEuMDQtLjYgMS4yMzMgMGwyLjI4NiA3LjA5IDcuNDQ3LS4wMTVjLjYyOS0uMDAxLjg5LjgwNS4zOCAxLjE3NGwtNi4wMzMgNC4zNjcgMi4zMTYgNy4wOGMuMTk2LjYtLjQ5IDEuMDk4LS45OTkuNzI2TDEyIDE3Ljk4eiIvPgo8L3N2Zz4K"
										width="16px" height="16px" alt="star"><span>${cmtLikeList.star}</span>
								</div>
							</c:if>
						</div>
						<div class="css-4tkoly">
							<a class="css-1f9m1s4-StylelessLocalLink eovgsd01"
								href="${pageContext.request.contextPath}/contents/detail.do?contents_type=${cmtLikeList.contents_type }&contents_num=${cmtLikeList.contents_num}">
								<div class="css-1g78l7j" style="display: flex;">
									<img class="css-qhzw1o-StyledImg"
										style="max-height: 520px; width: 80px;"
										src="${ contentsList[status.index].poster_path }">
									<div style="margin-left: 10px;">
										<span style="font-size: 14pt;">${ contentsList[status.index].title }</span>
										<div class="css-1g78l7j">
											<span style="font-size: 9pt; color: gray;"> <c:if
													test="${contentsList[status.index].contents_type eq 'movie' }">영화</c:if>
												<c:if
													test="${contentsList[status.index].contents_type eq 'tv' }">TV 시리즈</c:if>
												· <fmt:formatDate
													value="${contentsList[status.index].release_date }"
													pattern="yyyy" />

											</span>
										</div>
										<div class="css-1g78l7j">
											<a class="css-1f9m1s4-StylelessLocalLink eovgsd01"
												href="${pageContext.request.contextPath}/contents/cmtDetail.do?contents_type=${cmtLikeList.contents_type }&contents_num=${cmtLikeList.contents_num }&comment_num=${cmtLikeList.comment_num }">
												<span>${cmtLikeList.content}</span>
											</a>
										</div>
									</div>
								</div>

							</a>
						</div>
						<div class="css-1atijos">
							<span
								src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyNCIgaGVpZ2h0PSIyNCIgdmlld0JveD0iMCAwIDI0IDI0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPGcgZmlsbD0iIzc4Nzg3OCI+CiAgICAgICAgICAgIDxwYXRoIGQ9Ik02Ljc1IDkuNDg1aC0zYTEgMSAwIDAgMC0xIDF2MTBhMSAxIDAgMCAwIDEgMWgzYTEgMSAwIDAgMCAxLTF2LTEwYTEgMSAwIDAgMC0xLTFNMjAuNjU3IDguNTY2YTIuMzYzIDIuMzYzIDAgMCAwLTEuNzc5LS44MTNIMTYuNjJsLjE2NC0uNjI3Yy4xMzctLjUyOC4yMDEtMS4xMi4yMDEtMS44NjMgMC0xLjkxOS0xLjM3NS0yLjc3OC0yLjczOC0yLjc3OC0uNDQ0IDAtLjc2Ni4xMjMtLjk4Ni4zNzYtLjIuMjI3LS4yODIuNTMtLjI0My45MzVsLjAzIDEuMjMtMi45MDMgMi45NGMtLjU5My42LS44OTQgMS4yMy0uODk0IDEuODcydjkuNjQ3YS41LjUgMCAwIDAgLjUuNWg3LjY4N2EyLjM4OCAyLjM4OCAwIDAgMCAyLjM0OC0yLjA3bDEuNDQ1LTcuNDUyYTIuNDQgMi40NCAwIDAgMC0uNTc0LTEuODk3Ii8+CiAgICAgICAgPC9nPgogICAgPC9nPgo8L3N2Zz4K"
								width="18px" height="18px" class="css-64x8kr"></span> <em
								class="countLike">${cmtLikeList.countLike}</em> <span
								src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyNCIgaGVpZ2h0PSIyNCIgdmlld0JveD0iMCAwIDI0IDI0Ij4KICAgIDxwYXRoIGZpbGw9IiM3ODc4NzgiIGZpbGwtcnVsZT0iZXZlbm9kZCIgZD0iTTkuODU3IDE3Ljc4Nkw2IDIxdi00LjkxYy0xLjg0MS0xLjM3My0zLTMuMzY5LTMtNS41OUMzIDYuMzU4IDcuMDMgMyAxMiAzczkgMy4zNTggOSA3LjVjMCA0LjE0Mi00LjAzIDcuNS05IDcuNS0uNzM5IDAtMS40NTYtLjA3NC0yLjE0My0uMjE0eiIvPgo8L3N2Zz4K"
								width="18px" height="18px" class="css-q0vi8"></span> <em>${cmtLikeList.countReply}</em>
						</div>
						<div class="css-hy68ty">
							<input type="hidden" value="${cmtLikeList.comment_num}"
								class="comment_num"> <input type="hidden" value="1"
								class="checkCmtLike">
							<button
								class="css-jj4q3s-StylelessButton-UserActionButton cmtLike">좋아요</button>
						</div>
					</div>
				</c:forEach>
		</div>
		<div class="css-1ivxssh-StyledInfinityScroll eu826xw0"></div>
		</ul>
	</div>
</div>
<input type="hidden" value="${user_num}" id="user_num">