<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><!-- jstl -->
<!-- <link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous"> -->
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/mj.css" />
<script type="text/javascript">
$(function() {
	var user_num = ${user_num}
	$(document).on('click','#chatboardList', function() {
		if (user_num == 0 ) {
			document.getElementById('login-btn').click();
		}
	})
		
	$('#list_search_form').submit(function () {				
		if($('#keyword').val()==''){
			//alert('검색어필수');
			 Swal.fire({
			      icon: 'warning',
			      title: '검색어를 입력하세요!',
			      text: '찾을 수가 없네요',
			  }); 
			return false;
		}
	});//end of search submit
});//end of function	
</script>

<style>
*{
	font-family: 'SUIT-Medium';
}
</style>
<!-- 중앙 컨텐츠 시작 -->
<div class="page-main" id="chatBoardList_main">
	<div class="carousel-bg">
		<!-- 캐러셀 -->
		<div id="carouselExampleFade" class="carousel slide carousel-fade "
			data-bs-ride="carousel">
			<div class="carousel-inner">
				<div class="carousel-item active carousel-fade"
					data-bs-interval="2000">
					<img
						src="${pageContext.request.contextPath}/resources/images/board/1woody_br.jpg"
						class="img-responsive d-block img-rounded" id="woody">
				
					<div class="align-center carousel-caption " >
						<h2>
							<b>디즈니 메이트</b>
						</h2>
						<p>혼자 디즈니플러스를 이용하기 부담스럽다면?!</p>
					</div>
				</div>
				<div class="carousel-item carousel-fade" data-bs-interval="2500">
					<img
						src="${pageContext.request.contextPath}/resources/images/board/2disney_br.jpg"
						class="d-block img-rounded" id="disney">
					<div class="align-center carousel-caption d-none d-md-block ">
						<h2>
							<b>구해보세요</b>
						</h2>
						<p>게시글을 등록해 보세요. 메이트를 구하실 수 있습니다!</p>
					</div>
				</div>
				<div class="carousel-item carousel-fade" data-bs-interval="2500">
					<img
						src="${pageContext.request.contextPath}/resources/images/board/3starwars_br.jpg"
						class="d-block img-rounded" id="starwars">
					<div class="align-center carousel-caption d-none d-md-block ">
						<h2>
							<b>채팅 기능으로 연락해 보세요</b>
						</h2>
						<p>누군가가 당신과 메이트 하기를 기다리고 있어요!</p>
					</div>
				</div>
				<div class="carousel-item carousel-fade" data-bs-interval="2500">
					<img
						src="${pageContext.request.contextPath}/resources/images/board/4marvel_br.jpg"
						class="d-block img-rounded" id="marvel">
					<div class="align-center carousel-caption d-none d-md-block ">
						<h2>
							<b>내가 만들어가는 디즈니 피디아!</b>
						</h2>
						<p>평점을 등록하고 리뷰도 작성하세요! 캘린더에 나만의 시청내역을 기록할 수 도 있어요.</p>
					</div>
				</div>
			</div>
		</div>
		<!-- 캐러셀 -->
	</div>
	<div class="test"></div>


	<!--======검색창======= :  유효성체크를 자바스크립트로 사용할 것이기에 form HTML태그 사용-->
	<div id="container_table">
		<form action="list.do" id="list_search_form" method="get">
			<ul class="search" id="list_search">
				<li><select name="keyfield" id="keyfield" class="form-control" >
						<option value="1"
							<c:if test="${param.keyfield==1}">selected</c:if>>제목</option>
						<option value="2"
							<c:if test="${param.keyfield==2}">selected</c:if>>닉네임</option>
						<option value="3"
							<c:if test="${param.keyfield==3}">selected</c:if>>내용</option>
						<option value="4"
							<c:if test="${param.keyfield==4}">selected</c:if>>제목+내용
						</option>
				</select></li>

				<li>
					<%-- <input type="search" name="keyword" id="keyword" value="${param.keyword}"> --%>
					<input type="search" class="col-sm-2 form-control" name="keyword"
					id="keyword" value="${param.keyword}">
				</li>
				<!-- =====검색버튼===== -->
				<li>
					<button type="submit" class="btn btn-outline-primary"
					style="margin-top:-4px;font-size: 14px; height:38px;">
						검색
					</button>
				</li>
				<li>
					<button type="button" class="btn btn-outline-secondary"
						onclick="location.href='list.do'"
						style="margin-top:-4px;font-size: 14px; height:38px;">
						목록
					</button>
				</li>
			</ul>
		</form>
		<br>
		<hr style="size: 2px; width: 100%; align: center;" />
		<br>


		<!-- 정렬과 게시글 작성 -->
		<div  class="col-md-9 mx-auto row_write">
			<div id="sort01">
				<form action="list.do" id="table_sort " method="post" class="">
					<select name="sort" class="form-control" id="form-control"
						onchange="this.form.submit()">
						<option value="1" <c:if test="${param.sort == 1}">selected</c:if>>
							최신순</option>
						<option value="2" <c:if test="${param.sort == 2}">selected</c:if>>
							인기순</option>
					</select>
				</form>
			</div>
			
			<!-- ======글쓰기버튼====== -->
			<div id="sort02">
				<button class="btn btn-primary" id="write_btn"
					onclick="location.href='write.do'" style="<c:if test="${empty user_num || user_num == 0}">display : none;</c:if>">
					게시글 작성
				</button> 
			</div>
		</div>



		<c:if test="${count==0}">
			<div class="result-display">
				<div id="font01">" 앗! "</div>
				<div id="font02">표시할 게시물이 없습니다</div>
			</div>
		</c:if>
		<!-- !!!!!!!버튼테스트!!!!!!!! -->
		<!-- <button type="button" class="btn btn-error" id="latest">최신순버튼테스트</button> -->

		<c:if test="${count > 0}">
			<div class="row" id="table_header">

				<div class="table-responsive-md col-md-9 mx-auto"
					id="chatBoardList1">
					<table class="table" id="table_header" style="table-layout: fixed">
						<tr class="table-primary">
							<th style="width: 10%">번호</th>
							<th style="width: 35%">제목</th>
							<th style="width: 15%">작성자</th>
							<th style="width: 15%">등록일</th>
							<th style="width: 15%">메이트현황</th>
							<th style="width: 10%">조회수</th>
						</tr>
					</table>


					<table class="table  table-hover" id="table_body"
						style="table-layout: fixed">
						<c:forEach var="dchatboard" items="${list}">
							<tr id="chatboardList"
								<c:if test="${user_num != 0 }">onClick="location.href='detail.do?chatboard_num=${dchatboard.chatboard_num}'"</c:if>>
								<td style="width: 10%">${dchatboard.chatboard_num}</td>
								<td style="width: 35%">${dchatboard.title}</td>
								<td style="width: 15%">${dchatboard.name}</td>
								<td style="width: 15%">${dchatboard.reg_date}</td>
								<!-- mate_state : 0 모집중/1 모집완료 -->
								<c:if test="${dchatboard.mate_state==0}">
									<td style="width: 15%"><span
										class="badge rounded-pill bg-danger">모집 중!</span></td>
								</c:if>
								<c:if test="${dchatboard.mate_state==1}">
									<td style="width: 15%"><span
										class="badge rounded-pill bg-light text-dark">모집 마감</span></td>
								</c:if>

								<td style="width: 10%">${dchatboard.hit}</td>
							</tr>
						</c:forEach>
					</table>

				</div>
			</div>

			<div class="align-center pagination row">
				<ul class="pagination pagination-sm"
					style="justify-content: center;">
					<li class="page-item"><a class="page-link" href="#">&laquo;</a></li>
					<li class="page-item page-link">${pagingHtml}</li>
					<li class="page-item"><a class="page-link" href="#">&raquo;</a></li>
				</ul>
			</div>
			<!-- <div class="align-center">${pagingHtml}</div> -->

		</c:if>
	</div>

</div>

<!-- 중앙 컨텐츠 끝 -->
