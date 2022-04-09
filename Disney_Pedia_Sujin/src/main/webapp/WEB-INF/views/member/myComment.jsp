<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/scroll.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/cmtLike.js"></script>
<script type="text/javascript">
	$(function() {
		//코멘트 삭제
		$('.cmt_delbtn').click(
				function(event) {
					var user_num = ${user_num};
					$.ajax({
						url : 'commentDelete.do',
						type : 'post',
						data : {
							contents_num : $(event.target).parent().find(
									'.contents_num').val(),
							contents_type : $(event.target).parent().find(
									'.contents_type').val(),
							mem_num : user_num
						},
						dataType : 'json',
						cache : false,
						timeout : 30000,
						success : function(param) {
							if (param.result == 'logout') {
								alert('로그인 후 사용하세요');
							} else if (param.result == 'success') {
								Swal.fire({
                                    title: ' ',
                                    text: '성공적으로 삭제했습니다.',
                                    imageUrl: '${pageContext.request.contextPath}/resources/images/ok_icon.png',
                                    imageWidth: 100,
                                    imageHeight: 100,
                                    imageAlt: 'Custom image',
                                    confirmButtonColor: '#84d7fa',
                                    confirmButtonText: '확인',
                                    width: 400,
                                    padding: '2em'
                                }).then((result) => {
                                    if (result.isConfirmed) {
                                        location.reload(true);
                                    }
                                }) // sweet alert 끝
							} else {
								alert('코멘트 삭제 오류 발생');
							}
						},
						error : function() {
							alert('네트워크 오류 발생');
						}
					}); //end of comment delete ajax
				}); //end of click
	});
</script>
<style>
* {
	font-family: 'SUIT-Medium';
}
</style>
<section class="css-18gwkcr">
	<section class="css-le8j8b">
		<div class="css-1jehmiq"
			style="background: transparent; border-bottom: 1px solid #e3e3e3;">
			<div class="css-10zg79x-pageMarginStyle"
				style="font-weight: 700; font-size: 22px; color: black;">
				<c:if test="${param.mem_num == user_num }">마이 코멘트</c:if>
				<c:if test="${empty user_num || param.mem_num != user_num }">${name }님의 코멘트</c:if>
				</div>
		</div>
		<div class="css-ipmqep-StyledTabContentContainer e1szkzar3">
			<div class="css-12hxjcc-StyledHideableBlock e1pww8ij0">
				<section class="css-9ebwyf-pageMarginStyle">
					<section class="css-1s4ow07">
						<div class="css-usdi1z">
							<div class="css-9dnzub scroll"
								style="display: flex; justify-content: space-around;">
								<div class="css-174lxc3" style="width: 500px;">
									<ul class="css-1bk3hui-VisualUl" style="white-space: normal;">
										<c:forEach var="commentList" items="${ commentList }"
											varStatus="status">
											<li class="css-8y23cj"
												style="background-color: rgb(242, 242, 242); box-sizing: border-box; padding: 15px 15px 0px 15px; border-radius: 6px; overflow: hidden; margin: 0px 0px 20px; width: 600px !important; text-align: left;">
												<div class="css-4obf01">
													<div
														style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 8px;">
														<div class="css-1agoci2">
															<a style="color: #74747B;"
																href="${pageContext.request.contextPath}/contents/detail.do?contents_type=${commentList.contents_type }&contents_num=${commentList.contents_num}">
																${contentsList[status.index].title} :: <span><c:if
																	test="${commentList.contents_type eq 'movie' }">영화</c:if>
																<c:if
																	test="${commentList.contents_type eq 'tv' }">TV 시리즈</c:if></span>
																<span
																src="data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTIiIGhlaWdodD0iMTIiIHZpZXdCb3g9IjAgMCAxMiAxMiIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KICA8cGF0aCBmaWxsLXJ1bGU9ImV2ZW5vZGQiIGNsaXAtcnVsZT0iZXZlbm9kZCIgZD0iTTQuNzcwNDYgMC41NjI0NTlDNS4yNDMyOCAtMC4xNTY0MzIgNi4zMTE0NyAtMC4xOTMwNyA2LjgzNTM1IDAuNDkyMTU1QzcuMTczMzcgMC45MzM3ODggNy43NzM4NSAxLjEwMTEzIDguMzAxODEgMC45MDAxMjFDOS4xMTk4IDAuNTg4MjA1IDEwLjAwNjIgMS4xNjc0OCAxMC4wMTQ0IDIuMDIxMDRDMTAuMDE5NSAyLjU2OTYxIDEwLjQwNTUgMy4wNDc4OCAxMC45NTM5IDMuMTg1NTJDMTEuODA0NiAzLjM5OTQxIDEyLjE3MDIgNC4zNzQ3NiAxMS42NjA2IDUuMDY4OUMxMS4zMzE4IDUuNTE2NDggMTEuMzUzMiA2LjEyMTQ5IDExLjcxMzcgNi41NDYyOUMxMi4yNzIzIDcuMjA0NzggMTEuOTc3MiA4LjIwMTkyIDExLjE0MzggOC40NzIyNUMxMC42MDY3IDguNjQ3NTIgMTAuMjU3NCA5LjE1MDU0IDEwLjI5MTEgOS42OTkxMkMxMC4zNDQyIDEwLjU0OTcgOS41MDE3NCAxMS4xODc0IDguNjYzMzIgMTAuOTMxOUM4LjEyMjA4IDEwLjc2NzYgNy41MzQ4OCAxMC45NzQ1IDcuMjI5NTQgMTEuNDM3OUM2Ljc1NjcyIDEyLjE1NjggNS42ODc1MSAxMi4xOTI1IDUuMTY0NjUgMTEuNTA4MkM0LjgyNjYzIDExLjA2NTYgNC4yMjYxNSAxMC44OTgzIDMuNjk4MTkgMTEuMTAwM0MyLjg4MDIgMTEuNDEyMiAxLjk5Mzc4IDEwLjgzMTkgMS45ODQ1OSA5Ljk4MDM0QzEuOTgwNTEgOS40Mjk3OCAxLjU5NTUxIDguOTUyNSAxLjA0NjEgOC44MTM4N0MwLjE5NTQyOCA4LjU5OTk5IC0wLjE3MDE2NiA3LjYyNjYxIDAuMzM5NDE5IDYuOTMyNDdDMC42NjgyNDkgNi40ODM5MSAwLjY0NjgwNCA1Ljg3NzkgMC4yODYzMTYgNS40NTMxQy0wLjI3MjI4NyA0Ljc5NDYxIDAuMDIyODQzIDMuNzk5NDUgMC44NTYxNTIgMy41MjcxNUMxLjM5MzMxIDMuMzUyODcgMS43NDM1OSAyLjg1MDgzIDEuNzA4ODYgMi4zMDEyN0MxLjY1NTc2IDEuNDUwNjggMi40OTgyNiAwLjgxMTk5MiAzLjMzNjY4IDEuMDY4NDZDMy44Nzc5MiAxLjIzMjgzIDQuNDY1MTIgMS4wMjU4OCA0Ljc3MDQ2IDAuNTYyNDU5WiIgZmlsbD0iIzBFMEYxMCIvPgogIDxwYXRoIGQ9Ik03LjY5NzMzIDIuNDUwMkw3LjI4NjEyIDcuNzkzOTJMNy4xNzc3NCA3Ljc5ODI4TDYuNDUyMjYgMy45Nzk3NUg1LjI2MTIzTDQuNjY1NTggNy44OTE1N0w0LjUzNTc1IDcuODk2OEwzLjk1MDk2IDMuOTc5NzVIMi41TDMuODEwMjcgOS43MTU4Mkw1LjMxNTI4IDkuNjE0MzlMNS44NDU3NCA1Ljk3MTdINS45NjQ5OEw2LjU2MDM1IDkuNTMwMTFMOC4wNzY1MSA5LjQyNzIzTDkuMTA1MTEgMi40NTAySDcuNjk3MzNaIiBmaWxsPSIjRkYwNTU4Ii8+Cjwvc3ZnPgo="
																class="css-amcv0d"> </span>
														</div>
														<c:if
															test="${!empty commentList.star && commentList.star != 0}">
															<div class="css-yqs4xl" style="margin: 0;">
																<div id="myPageStar">★ ${commentList.star}</div>
															</div>
														</c:if>
														<c:if test="${param.mem_num == user_num }">
															<c:if
																test="${empty commentList.star || commentList.star == 0}">
																<div class="css-yqs4xl"
																	style="margin: 0; color: #68b4ed; font-size: 13px;">
																	&nbsp;평가하기&nbsp;</div>
															</c:if>
														</c:if>
														</a>
													</div>
												</div>
												<div class="css-4tkoly" style="margin: 12px 0 0;">
													<a class="css-1f9m1s4-StylelessLocalLink eovgsd01"
														href="/ko-KR/comments/6aLMPoKyrZ2Ow">
														<div class="css-1g78l7j">
															<div class="css-1g78l7j">
																<div class="css-1v2z0uj-ProfilePhotoImage">
																	<!-- 포스터 이미지-->
																	<div class="float_left">
																		<a
																			href="${pageContext.request.contextPath}/contents/detail.do?contents_type=${commentList.contents_type }&contents_num=${commentList.contents_num}">
																			<img class="css-qhzw1o-StyledImg"
																			style="max-height: 520px; width: 100px; margin-right: 15px;"
																			src="${ contentsList[status.index].poster_path }">
																		</a>
																	</div>
																	<!-- 코멘트 내용 -->
																	<div class="float_left" style="max-width: 450px;">
																		<a class="css-1f9m1s4-StylelessLocalLink eovgsd01"
																			href="${pageContext.request.contextPath}/contents/cmtDetail.do?contents_type=${commentList.contents_type }&contents_num=${commentList.contents_num }&comment_num=${commentList.comment_num }">
																			<div
																				style="word-break: break-all; max-height: 500px px; margin: 0; overflow: hidden; text-overflow: ellipsis; display: -webkit-box; -webkit-line-clamp: 10; -webkit-box-orient: vertical; line-height: 1.7;">${commentList.content}</div>
																		</a>
																	</div>

																	<div class="css-1atijos"
																		style="clear: both; border-top: none; border-bottom: 1px solid #e5e5e5;">
																		<div style="display: flex; align-items: center;">
																			<span
																				src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyNCIgaGVpZ2h0PSIyNCIgdmlld0JveD0iMCAwIDI0IDI0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPGcgZmlsbD0iIzc4Nzg3OCI+CiAgICAgICAgICAgIDxwYXRoIGQ9Ik02Ljc1IDkuNDg1aC0zYTEgMSAwIDAgMC0xIDF2MTBhMSAxIDAgMCAwIDEgMWgzYTEgMSAwIDAgMCAxLTF2LTEwYTEgMSAwIDAgMC0xLTFNMjAuNjU3IDguNTY2YTIuMzYzIDIuMzYzIDAgMCAwLTEuNzc5LS44MTNIMTYuNjJsLjE2NC0uNjI3Yy4xMzctLjUyOC4yMDEtMS4xMi4yMDEtMS44NjMgMC0xLjkxOS0xLjM3NS0yLjc3OC0yLjczOC0yLjc3OC0uNDQ0IDAtLjc2Ni4xMjMtLjk4Ni4zNzYtLjIuMjI3LS4yODIuNTMtLjI0My45MzVsLjAzIDEuMjMtMi45MDMgMi45NGMtLjU5My42LS44OTQgMS4yMy0uODk0IDEuODcydjkuNjQ3YS41LjUgMCAwIDAgLjUuNWg3LjY4N2EyLjM4OCAyLjM4OCAwIDAgMCAyLjM0OC0yLjA3bDEuNDQ1LTcuNDUyYTIuNDQgMi40NCAwIDAgMC0uNTc0LTEuODk3Ii8+CiAgICAgICAgPC9nPgogICAgPC9nPgo8L3N2Zz4K"
																				width="18px" height="18px" class="css-64x8kr"></span>
																			<em class="countLike"> <c:if
																					test="${commentList.countLike >0}">${commentList.countLike}</c:if>
																				<c:if test="${commentList.countLike ==0 }">0</c:if></em>
																			<span
																				src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyNCIgaGVpZ2h0PSIyNCIgdmlld0JveD0iMCAwIDI0IDI0Ij4KICAgIDxwYXRoIGZpbGw9IiM3ODc4NzgiIGZpbGwtcnVsZT0iZXZlbm9kZCIgZD0iTTkuODU3IDE3Ljc4Nkw2IDIxdi00LjkxYy0xLjg0MS0xLjM3My0zLTMuMzY5LTMtNS41OUMzIDYuMzU4IDcuMDMgMyAxMiAzczkgMy4zNTggOSA3LjVjMCA0LjE0Mi00LjAzIDcuNS05IDcuNS0uNzM5IDAtMS40NTYtLjA3NC0yLjE0My0uMjE0eiIvPgo8L3N2Zz4K"
																				width="18px" height="18px" class="css-q0vi8"></span><em><c:if
																					test="${commentList.countReply >0}">${commentList.countReply}</c:if>
																				<c:if test="${commentList.countReply ==0 }">0</c:if></em>
																		</div>
																	</div>
																	<c:if test="${param.mem_num != user_num || empty user_num}">
																		<div class="css-hy68ty">
																			<input type="hidden"
																				value="${commentList.comment_num}"
																				class="comment_num"> <input type="hidden"
																				value="${checkCmtLike[status.index]}"
																				class="checkCmtLike">
																			<button
																				class="<c:if test="${checkCmtLike[status.index] == 1}">css-jj4q3s-StylelessButton-UserActionButton cmtLike</c:if>
																			<c:if test="${checkCmtLike[status.index] == 0 || empty user_num}">css-1h18l7j-StylelessButton cmtLike</c:if>"
																				style="margin-left: 5px; font-size: 13px;">&nbsp;좋아요&nbsp;</button>

																		</div>
																	</c:if>
																</div>
															</div>
														</div>
													</a>
												</div> <c:if
													test="${!empty user_num && user_num == param.mem_num}">
													<div class="css-hy68ty"
														style="display: flex; justify-content: flex-end;">
														<button data-bs-target="#commentUpdateModal"
															data-bs-toggle="modal"
															class="css-jj4q3s-StylelessButton-UserActionButton updateBtn"
															style="margin-right: 5px; font-size: 13px;">
															&nbsp;&nbsp;수정&nbsp;&nbsp;</button>
														<input type="hidden" value="${commentList.contents_type }"
															class="contents_type"> <input type="hidden"
															value="${commentList.contents_num }" class="contents_num">
														<input type="hidden"
															value="${contentsList[status.index].title}"
															class="contents_title"> <input type="hidden"
															value="${commentList.content}" class="reply_content">
														<input type="hidden" value="0" class="status">
														<button
															class="css-jj4q3s-StylelessButton-UserActionButton cmt_delbtn"
															style="font-size: 13px; background-color: #a8a8a8;">
															&nbsp;&nbsp;삭제&nbsp;&nbsp;</button>
													</div>
												</c:if>
											</li>
										</c:forEach>
									</ul>
								</div>
					</section>
				</section>
			</div>
		</div>
	</section>
</section>
<div class="modal fade commentUpdateModal" id="commentUpdateModal"
	tabindex="-1" role="dialog">
	<div class="modal-dialog modal-dialog-centered modal-comment">
		<div class="modal-content">
			<jsp:include page="/WEB-INF/views/member/commentUpdate.jsp" />
		</div>
	</div>
</div>
<script type="text/javascript">
    $(function() {
    	 $(document) .on('click',
    		     '.updateBtn',
    		     function(event) {
                    	var contents_title=$(event.target).siblings('.contents_title').val();
                    	var contents_type=$(event.target).siblings('.contents_type').val();
                    	var contents_num=$(event.target).siblings('.contents_num').val();

                    	var user_num = $('#user_num').val();

                        $('.commentUpdateModal') .on('shown.bs.modal',
                        	    function(event) {
                        	  		$(this).find('form')[0].reset();
                        	  		
                        	        $(event.target).find('.reply_title').text(contents_title);
                        	        $(event.target).find('.update_type').val(contents_type);
                        	        $(event.target).find('.update_num').val(contents_num);

                        	        $.ajax({
                        	                type: 'post',
                        	                data: {
                        	                    contents_num: contents_num,
                        	                    contents_type: contents_type,
                        	                    mem_num: user_num
                        	                },
                        	                url: 'getComment.do',
                        	                dataType: 'json',
                        	                cache: false,
                        	                timeout: 30000,
                        	                success: function(param) {
                        	                    if (param.result=='logout') {
                        	                        alert('로그인 후 사용하세요');
                        	                    } else if (param.result=='success') {
                        	                        $(event.target).find('.comment2').text('');
                        	                        $(event.target).find('.comment2').append(param.content);
                        	                        let LengthNow=param.content.length;
                        	                        $('.letter-count').text(LengthNow + '/1000');
                        	                    } else {
                        	                        alert('수정폼 호출 오류 발생');
                        	                    }
                        	                },
                        	                error: function() {
                        	                    alert('네트워크 오류 발생!');
                        	                }
                        	            });
                        	  });
                 });
        });
</script>
<input type="hidden" value="${user_num}" id="user_num">