<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">
	$(function() {
		var user_num = ${user_num};
		var checkCmtLike = ${checkCmtLike};
		var comment_num = ${comment.comment_num};

	cmtlike = function() {
			if (user_num == 0 || user_num == null) {
				Swal.fire({			
					  title: ' ',						  
					  text: '좋아요를 누르려면 로그인이 필요해요.',
					  imageUrl: '${pageContext.request.contextPath}/resources/images/like_icon.png',
					  imageWidth: 70,
					  imageHeight: 70,						  
					  imageAlt: 'Custom image',
					  confirmButtonColor: '#84d7fa',
					  confirmButtonText: '알겠어요',
					  width: 400,
					  padding: '2em'
					  })
			return;
			}
			if (user_num != 0 && user_num != null) {
				$
						.ajax({
							url : 'cmtLike.do',
							type : 'post',
							dataType : 'json',
							data : {
								comment_num : comment_num,
								mem_num : user_num,
								checkCmtLike : checkCmtLike
							},
							success : function(param) {
								if (param.result == 'success') { // 코멘트 좋아요
									checkCmtLike = 1;
									$('#cmtLike')
											.removeClass(
													'css-135c2b4-StylelessButton-StyledActionButton')
											.addClass(
													'css-3w1nnz-StylelessButton-StyledActionButton e19d4hrp0');
									$('#countLike').text(
											'좋아요 ' + param.countLike);
									$('#off').hide();
									$('#on').show();
								} else if (param.result == 'cancel') { // 코멘트 좋아요 취소
									checkCmtLike = 0;
									$('#cmtLike')
											.removeClass(
													'css-3w1nnz-StylelessButton-StyledActionButton e19d4hrp0')
											.addClass(
													'css-135c2b4-StylelessButton-StyledActionButton');
									$('#countLike').text(
											'좋아요 ' + param.countLike);
									$('#on').hide();
									$('#off').show();
								}
							}
						});
			}
		}
		toggle = function() {
			if (checkCmtLike == 1) {
				$('#on').show();
				$('#off').hide();
			} else if (checkCmtLike == 0) {
				$('#off').show();
				$('#on').hide();
			}
		}
		toggle();
		

	//댓글 목록
		selectData = function() {
			$
					.ajax({
						type : 'post',
						data : {
							comment_num : comment_num
						},
						url : 'listReply.do',
						dataType : 'json',
						cache : false,
						timeout : 30000,
						success : function(param) {
							//댓글 목록 작업
							$(param.reply)
									.each(
											function(index, item) {
												
												let output = '<div class="css-1m1whp6">';
												output += '<div class="css-ov1ktg">';
												output += '<a class="css-255jr8" href="${pageContext.request.contextPath}/member/myPage.do?user_num='
														+ item.mem_num + '">';
												output += '<div class="css-1l9hju7-ProfilePhotoImage">';
												if (item.photo_name == null) {
													output += '<img src="${pageContext.request.contextPath}/resources/images/face.png" width="20" height="20" class="my-photo">';
												} else {
													output += '<img width="32" height="32" class="my-photo" src="${pageContext.request.contextPath}/member/photoView.do?user_num='
															+ item.mem_num
															+ '">';
												}
												output += '</div></a>';
												output += '<div class="css-199ku80">';
												output += '<div class="css-1sg2lsz" style="justify-content: space-between;">';
												output += '<a class="css-255jr8" href="${pageContext.request.contextPath}/member/myPage.do?user_num='
														+ item.mem_num
														+ '" style="text-decoration: none;">';
												output += '<div class="css-72k174">'
														+ item.name
														+ '</div></a>';
												if (item.modify_date) {
													output += '<div class="css-maxfbg">'
															+ item.modify_date
															+ '</div></div>';
												} else {
													output += '<div class="css-maxfbg">'
															+ item.reg_date
															+ '</div></div>';
												}
												output += '<div class="css-ov1ktg" style="margin-top: 8px;">';
												output += '<div class="css-yb0jaq">'
														+ item.content
																.replace(
																		/\r\n/g,
																		'<br>')
														+ '</div>';
												output += '<div class="css-4ygot5">';
												if (user_num == item.mem_num) {
													output += '<button class="Icon more css-1b4hoch-SVG e1282e850" style="border: none; background-color: transparent;">';
													output += '<div>';
													output += '<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 20 20" fill="none" class="injected-svg" data-src="data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjAiIGhlaWdodD0iMjAiIHZpZXdCb3g9IjAgMCAyMCAyMCIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KPHBhdGggZmlsbC1ydWxlPSJldmVub2RkIiBjbGlwLXJ1bGU9ImV2ZW5vZGQiIGQ9Ik0xMS4yNTEgNS40MjY3NkMxMS4yNTEgNi4xMTc1OSAxMC42OTEgNi42NzY3NiAxMC4wMDEgNi42NzY3NkM5LjMxMDE0IDYuNjc2NzYgOC43NTA5OCA2LjExNzU5IDguNzUwOTggNS40MjY3NkM4Ljc1MDk4IDQuNzM2NzYgOS4zMTAxNCA0LjE3Njc2IDEwLjAwMSA0LjE3Njc2QzEwLjY5MSA0LjE3Njc2IDExLjI1MSA0LjczNjc2IDExLjI1MSA1LjQyNjc2Wk0xMC4wMDEgOC43NDk5M0M5LjMxMDE0IDguNzQ5OTMgOC43NTA5OCA5LjMwOTkzIDguNzUwOTggOS45OTk5M0M4Ljc1MDk4IDEwLjY5MDggOS4zMTAxNCAxMS4yNDk5IDEwLjAwMSAxMS4yNDk5QzEwLjY5MSAxMS4yNDk5IDExLjI1MSAxMC42OTA4IDExLjI1MSA5Ljk5OTkzQzExLjI1MSA5LjMwOTkzIDEwLjY5MSA4Ljc0OTkzIDEwLjAwMSA4Ljc0OTkzWk0xMC4wMDEgMTMuMzIzMUM5LjMxMDE0IDEzLjMyMzEgOC43NTA5OCAxMy44ODIzIDguNzUwOTggMTQuNTczMUM4Ljc1MDk4IDE1LjI2MzkgOS4zMTAxNCAxNS44MjMxIDEwLjAwMSAxNS44MjMxQzEwLjY5MSAxNS44MjMxIDExLjI1MSAxNS4yNjM5IDExLjI1MSAxNC41NzMxQzExLjI1MSAxMy44ODIzIDEwLjY5MSAxMy4zMjMxIDEwLjAwMSAxMy4zMjMxWiIgZmlsbD0iI0EwQTBBMCIvPgo8L3N2Zz4K" xmlns:xlink="http://www.w3.org/1999/xlink">';
													output += '<path fill-rule="evenodd" clip-rule="evenodd" d="M11.251 5.42676C11.251 6.11759 10.691 6.67676 10.001 6.67676C9.31014 6.67676 8.75098 6.11759 8.75098 5.42676C8.75098 4.73676 9.31014 4.17676 10.001 4.17676C10.691 4.17676 11.251 4.73676 11.251 5.42676ZM10.001 8.74993C9.31014 8.74993 8.75098 9.30993 8.75098 9.99993C8.75098 10.6908 9.31014 11.2499 10.001 11.2499C10.691 11.2499 11.251 10.6908 11.251 9.99993C11.251 9.30993 10.691 8.74993 10.001 8.74993ZM10.001 13.3231C9.31014 13.3231 8.75098 13.8823 8.75098 14.5731C8.75098 15.2639 9.31014 15.8231 10.001 15.8231C10.691 15.8231 11.251 15.2639 11.251 14.5731C11.251 13.8823 10.691 13.3231 10.001 13.3231Z" fill="#A0A0A0"></path>';
													output += '</svg></div></button>';

													output += '<div class="css-aa3xw reply_more"><div class="css-6btlr7"><div class="css-ve4kut">';
													output += '<button data-bs-target="#replytUpdateModal" data-bs-toggle="modal" class="css-19hkid5 update" style="border: none;">댓글 수정</button>';
													output += '<input type="hidden" value="'+item.reply_num+'" class="reply_num"><button class="css-19hkid5 delete" style="border: none; background-color: transparent;">댓글 삭제</button></div></div></div>';
													output += '</div> </div></div></div></div></div>';
												}
												$('.cmtReply').append(output);
											});
						},
						error : function() {
							alert('네트워크 오류 발생!');
						}
					});

		}
		//초기 데이터(목록) 호출
		selectData();

		$(document).on('click', '.e1282e850', function() {
			$(this).siblings('.reply_more').toggle();
		});

		//댓글 삭제
		$(document).on(
				'click',
				'.delete',
				function(event) {
					$.ajax({
						url : 'replyDelete.do',
						type : 'post',
						data : {
							reply_num : $(event.target).parent().find(
									'.reply_num').val(),
							comment_num : comment_num
						},
						dataType : 'json',
						cache : false,
						timeout : 30000,
						success : function(param) {
							if (param.result == 'logout') {
								alert('로그인 후 사용하세요');
							} else if (param.result == 'success') {
								alert('댓글을 삭제했습니다.');
								location.reload(true);
							} else {
								alert('댓글 삭제 오류 발생');
							}
						},
						error : function() {
							alert('네트워크 오류 발생');
						}
					}); //end of comment delete ajax
				});
	});
</script>
<style>
*{
	font-family: 'SUIT-Medium';
}
</style>
<section class="css-18gwkcr">
	<section class="css-le8j8b">
		<div class="css-1jehmiq"
			style="background: transparent; border-bottom: 1px solid #e3e3e3;">
			<div class="css-10zg79x-pageMarginStyle"
				style="font-weight: 700; font-size: 22px; color: black;">코멘트 상세</div>
		</div>
	</section>
	<div class="css-fr521c-StyledSectionContainer e1rmcw6u2" style="width: 750px; margin: auto;">
		<div class="css-1d7xpnn-CommentContainer e1rmcw6u3">
			<section class="css-0">
				<div class="css-1p3jp2v">
					<div class="css-1cvf9dk">
						<a title="${member.name }"
							class="css-1f9m1s4-StylelessLocalLink eovgsd01"
							href="${pageContext.request.contextPath}/member/myPage.do?user_num=${comment.mem_num}">
							<div class="css-1byz60h">
								<div class="css-1l9hju7-ProfilePhotoImage">
									<c:if test="${empty member.photo_name}">
										<img
											src="${pageContext.request.contextPath}/resources/images/face.png"
											width="20" height="20" class="my-photo">
									</c:if>
									<c:if test="${!empty member.photo_name}">
										<img width="20" height="20" class="my-photo"
											src="${pageContext.request.contextPath}/member/photoView.do?user_num=${comment.mem_num}">
									</c:if>
								</div>
							</div>
							<div class="css-1sg2lsz">
								<div class="css-a7gqjg">
									${member.name }<span
										src="${pageContext.request.contextPath}/member/myPage.do?user_num=${comment.mem_num}"
										class="css-19w3a64"></span>
								</div>
								<div class="css-1hy7aba">
									${comment.reg_date }
								</div>
							</div>
						</a><a title="${contents.title}"
							class="css-1f9m1s4-StylelessLocalLink eovgsd01"
							href="detail.do?contents_type=${contents.contents_type }&contents_num=${contents.contents_num}"><div
								class="css-0">
								<div class="css-dbu6le">${contents.title}</div>
								<div class="css-1futg35">
									<c:if test="${contents.contents_type eq 'movie' }">영화</c:if>
									<c:if test="${contents.contents_type eq 'tv' }">시리즈</c:if>
									·
									<fmt:formatDate value="${contents.release_date }"
										pattern="yyyy/MM" />
								</div>
							</div></a>
						<c:if test="${comment.star > 0 }">
							<div class="css-1edcxeb">
								<div class="css-1cxhrll">
									<img
										src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyNCIgaGVpZ2h0PSIyNCIgdmlld0JveD0iMCAwIDI0IDI0Ij4KICAgIDxwYXRoIGZpbGw9IiM0QTRBNEEiIGZpbGwtcnVsZT0iZXZlbm9kZCIgZD0iTTEyIDE3Ljk4bC02LjAxNSA0LjM5MmMtLjUwOC4zNzItMS4xOTQtLjEyNi0uOTk4LS43MjVsMi4zMTctNy4wODEtNi4wMzUtNC4zNjdjLS41MS0uMzY5LS4yNDctMS4xNzUuMzgyLTEuMTc0bDcuNDQ3LjAxNiAyLjI4Ni03LjA5MWMuMTkyLS42IDEuMDQtLjYgMS4yMzMgMGwyLjI4NiA3LjA5IDcuNDQ3LS4wMTVjLjYyOS0uMDAxLjg5LjgwNS4zOCAxLjE3NGwtNi4wMzMgNC4zNjcgMi4zMTYgNy4wOGMuMTk2LjYtLjQ5IDEuMDk4LS45OTkuNzI2TDEyIDE3Ljk4eiIvPgo8L3N2Zz4K"
										width="16px" height="16px" alt="star"><span>
										${comment.star } </span>
								</div>
							</div>
						</c:if>
					</div>
					<a title="${contents.title}"
						class="css-1f9m1s4-StylelessLocalLink eovgsd01"
						href="detail.do?contents_type=${contents.contents_type }&contents_num=${contents.contents_num}"><div
							class=" css-mnjeq6-StyledLazyLoadingImage ezcopuc0">
							<img alt="${contents.title}의 포스터" src="${contents.poster_path }"
								class="css-qhzw1o-StyledImg ezcopuc1">
						</div></a>
				</div>
				<div class="css-cb09zq">
					<div class="css-1g78l7j">
						<span>${comment.content }</span>
					</div>
				</div>
				<div class="css-hkgyal">
					<div class="css-prw2jl">
						<span class="css-1n0dvqq" id="countLike">좋아요 <c:if
								test="${countLike >0}">${countLike}</c:if> <c:if
								test="${countLike ==0 }">0</c:if></span><span class="css-0"
							id="countReply">댓글 <c:if test="${countReply >0}">${countReply}</c:if>
							<c:if test="${countReply ==0 }">0</c:if></span>
					</div>
				</div>
				<section class="css-0">
					<hr class="css-god8tc">
					<div class="css-1gkas1x-Grid e1689zdh0">
						<div class="css-1y901al-Row emmoxnt0">
							<div class="css-cxqjs3">
								<button id="cmtLike" onclick="cmtlike()"
									class="<c:if test="${checkCmtLike >0}">css-3w1nnz-StylelessButton-StyledActionButton e19d4hrp0</c:if><c:if test="${checkCmtLike == 0 }">css-135c2b4-StylelessButton-StyledActionButton</c:if>">
									<div class="css-1umclh2-StyledIconContainer e19d4hrp1">

										<div id="off" style="display: none;">
											<svg viewBox="0 0 20 20" class="css-vkoibk"
												style="width: 20px;">
											<path class="fillTarget" fill-rule="evenodd"
													clip-rule="evenodd"
													d="M5.6252 7.9043H3.1252C2.6652 7.9043 2.29187 8.27763 2.29187 8.73763V17.071C2.29187 17.531 2.6652 17.9043 3.1252 17.9043H5.6252C6.08604 17.9043 6.45854 17.531 6.45854 17.071V8.73763C6.45854 8.27763 6.08604 7.9043 5.6252 7.9043Z"
													fill="#87898B"></path>
											<path class="fillTarget" fill-rule="evenodd"
													clip-rule="evenodd"
													d="M11.71 4.34525L11.7017 3.99359L11.6825 3.14525L11.6809 3.09692L11.6759 3.04942C11.6684 2.96942 11.6792 2.93442 11.6775 2.93275C11.6917 2.92442 11.7534 2.90442 11.8725 2.90442C12.115 2.90442 13.3225 2.97609 13.3225 4.38692C13.3225 4.93359 13.2775 5.35859 13.1809 5.72692L12.8375 7.03275C12.8034 7.16525 12.9025 7.29442 13.0392 7.29442H14.3892H15.7317C16.0575 7.29442 16.3684 7.43692 16.585 7.68442C16.7975 7.93025 16.9009 8.25609 16.87 8.58275L15.6717 14.7703L15.6634 14.8119L15.6584 14.8536C15.59 15.3961 15.0959 15.8211 14.5334 15.8211H8.54169V8.19942C8.54169 7.89109 8.71169 7.56275 9.04835 7.22359L11.3417 4.90025L11.5775 4.66109C11.71 4.52359 11.71 4.34525 11.71 4.34525ZM17.5275 6.86525C17.0734 6.34275 16.4184 6.04442 15.7317 6.04442H14.3892C14.5167 5.56025 14.5725 5.02942 14.5725 4.38692C14.5725 2.50942 13.1734 1.65442 11.8725 1.65442C11.3825 1.65442 11 1.80775 10.7367 2.11025C10.5667 2.30359 10.3792 2.64442 10.4325 3.17359L10.4517 4.02192L8.15835 6.34525C7.58335 6.92692 7.29169 7.55109 7.29169 8.19942V16.2378C7.29169 16.6978 7.66502 17.0711 8.12502 17.0711H14.5334C15.7342 17.0711 16.7559 16.1603 16.8992 15.0078L18.1067 8.77192C18.1925 8.08109 17.9809 7.38692 17.5275 6.86525Z"
													fill="#87898B"></path></svg>
										</div>

										<div id="on" style="display: none;">
											<svg fill="currentColor" viewBox="0 0 20 20"
												class="css-1jbpd60" style="width: 20px;">
											<path class="fillTarget" fill-rule="evenodd"
													clip-rule="evenodd"
													d="M5.6252 7.90479H3.1252C2.6652 7.90479 2.29187 8.27812 2.29187 8.73812V17.0715C2.29187 17.5315 2.6652 17.9048 3.1252 17.9048H5.6252C6.08604 17.9048 6.45854 17.5315 6.45854 17.0715V8.73812C6.45854 8.27812 6.08604 7.90479 5.6252 7.90479Z"
													fill="currentColor"></path>
											<path class="fillTarget" fill-rule="evenodd"
													clip-rule="evenodd"
													d="M17.2146 7.13879C16.8388 6.70796 16.2979 6.46129 15.7321 6.46129H13.8504L13.9871 5.93879C14.1013 5.49879 14.1546 5.00546 14.1546 4.38629C14.1546 2.78712 13.0088 2.07129 11.8729 2.07129C11.5029 2.07129 11.2346 2.17379 11.0513 2.38462C10.8846 2.57379 10.8163 2.82546 10.8488 3.16379L10.8738 4.18879L8.45459 6.63796C7.96043 7.13879 7.70959 7.66379 7.70959 8.19879V16.238C7.70959 16.4671 7.89626 16.6546 8.12626 16.6546H14.5321C15.5088 16.6546 16.3663 15.908 16.4888 14.9288L17.6929 8.71962C17.7646 8.14712 17.5888 7.57129 17.2146 7.13879Z"
													fill="currentColor"></path></svg>
										</div>

									</div>
									좋아요
								</button>
								<button data-bs-target="#cmtReplyModal" data-bs-toggle="modal"
									class="css-135c2b4-StylelessButton-StyledActionButton e19d4hrp0">
									<div class="css-1umclh2-StyledIconContainer e19d4hrp1">
										<svg viewBox="0 0 20 20" class="css-vkoibk"
											style="width: 20px;">
														<path class="fillTarget" fill-rule="evenodd"
												clip-rule="evenodd"
												d="M9.99963 2.08325C5.65046 2.08325 2.12546 5.02159 2.12546 8.64575C2.12546 10.5891 3.13962 12.3358 4.74962 13.5374L4.61129 17.2416C4.61129 17.4899 4.81462 17.6591 5.03046 17.6591C5.12129 17.6591 5.21462 17.6291 5.29462 17.5616L8.12462 15.0208C8.72629 15.1433 9.35379 15.2083 9.99963 15.2083C14.3496 15.2083 17.8746 12.2699 17.8746 8.64575C17.8746 5.02159 14.3496 2.08325 9.99963 2.08325ZM9.99962 3.33325C13.653 3.33325 16.6246 5.71659 16.6246 8.64575C16.6246 11.5749 13.653 13.9583 9.99962 13.9583C9.44962 13.9583 8.90296 13.9041 8.37379 13.7966C8.29129 13.7791 8.20796 13.7708 8.12462 13.7708C7.81962 13.7708 7.52046 13.8833 7.28962 14.0908L5.93462 15.3074L5.99879 13.5841C6.01462 13.1733 5.82712 12.7808 5.49796 12.5349C4.14879 11.5291 3.37546 10.1116 3.37546 8.64575C3.37546 5.71659 6.34712 3.33325 9.99962 3.33325Z"
												fill="#87898B"></path></svg>
									</div>
									댓글
								</button>
							</div>
						</div>
					</div>
					<hr class="css-god8tc">
				</section>
			</section>
			<section class="css-1r5nwql">
				<div class="cmtReply">
				</div>
			</section>
		</div>
	</div>
</section>
<!--코멘트 모달 틀-->
<div class="modal fade" id="cmtReplyModal" tabindex="-1" role="dialog">
	<div class="modal-dialog modal-dialog-centered modal-comment">
		<div class="modal-content">
			<jsp:include page="/WEB-INF/views/contents/reply.jsp" />
		</div>
	</div>
</div>
<!--코멘트 수정폼 모달 틀-->
<div class="modal fade" id="replytUpdateModal" tabindex="-1"
	role="dialog">
	<div class="modal-dialog modal-dialog-centered modal-comment">
		<div class="modal-content">
			<jsp:include page="/WEB-INF/views/contents/replyUpdate.jsp" />
		</div>
	</div>
</div>
