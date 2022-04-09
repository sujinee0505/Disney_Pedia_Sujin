<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<script type="text/javascript">
	$(function() {
		var user_num = ${user_num};
	
		$('#calendarModal').on(
					'shown.bs.modal',
					function() {
						document.getElementById('path').value = location.pathname
								+ location.search;						
					});

		$('#insertCal')
				.submit(
						function(event) {
							var year = $('.cal-year').text();
							var month = $('.cal-month').text();
							var day = $('.day-active').text();
							if ($('.day-active').text() < 10) {
								day = '0' + $('.day-active').text();
							}

							var custom_date = year + '-' + month + '-' + day;
							$('#custom_date').val(custom_date);
							if (user_num == 0) {
								Swal.fire({			
									  title: ' ',						  
									  text: '로그인이 필요한 기능이에요',
									  imageUrl: '${pageContext.request.contextPath}/resources/images/cal_icon2.png',
									  imageWidth: 70,
									  imageHeight: 70,						  
									  imageAlt: 'Custom image',
									  confirmButtonColor: '#84d7fa',
									  confirmButtonText: '알겠어요',
									  width: 400,
									  padding: '2em'
									  })
								return false;
							}
							if (user_num != 0) {
								if ($('.day').hasClass('day-active') == false) {
									alert('날짜를 선택해주세요.');
									return false;
								} else if ($('#dateCheck').val() != 'noData') {
									let choice = confirm('수정하시겠습니까?');
									if (choice == false) {
										return false;
									} else {
										$
												.ajax({
													type : 'post',
													data : {
														contents_num : $(
																'#contents_num_calendar')
																.val(),
														custom_date : $(
																'#custom_date')
																.val(),
														contents_type : $(
																'#contents_type_calendar')
																.val(),
														poster_path : $(
																'#poster_path')
																.val(),
														path : $('#path').val()
													},
													url : 'updateCal.do',
													dataType : 'json',
													cache : false,
													timeout : 30000,
													success : function(param) {
														if (param.result == 'logout') {
															alert('로그인후 등록할 수 있습니다.');
														} else if (param.result == 'success') {
															alert('수정되었습니다.');
															location.replace('/project' + param.path);
														} else {
															alert('수정시 오류 발생');
														}
													},
													error : function() {
														alert('네트워크 오류 발생!');
													}
												});
									}
								} else {
									$
											.ajax({
												type : 'post',
												data : {
													contents_num : $(
															'#contents_num_calendar')
															.val(),
													custom_date : $(
															'#custom_date')
															.val(),
													contents_type : $(
															'#contents_type_calendar')
															.val(),
													poster_path : $(
															'#poster_path')
															.val(),
												    path : $('#path').val()
												},
												url : 'insertCal.do',
												dataType : 'json',
												cache : false,
												timeout : 30000,
												success : function(param) {
													if (param.result == 'logout') {
														alert('로그인후 등록할 수 있습니다.');
													} else if (param.result == 'success') {
														alert('등록되었습니다.');
														location.replace('/project' + param.path);
													} else {
														alert('등록시 오류 발생');
													}
												},
												error : function() {
													alert('네트워크 오류 발생!');
												}
											});
								}
							}
						});
		$('.dayMark')
				.click(
						function() {
							let choice = confirm('삭제하시겠습니까?');
							if (choice == false) {
								return false;
							} else {
								$
										.ajax({
											type : 'post',
											data : {
												contents_num : $(
														'#contents_num').val(),
												custom_date : $('#custom_date')
														.val(),
												contents_type : $(
														'#contents_type').val(),
												poster_path : $('#poster_path')
														.val(),
												path : $('#path').val()
											},
											url : 'deleteCal.do',
											dataType : 'json',
											cache : false,
											timeout : 30000,
											success : function(param) {
												if (param.result == 'logout') {
													alert('로그인후 삭제할 수 있습니다.');
												} else if (param.result == 'success') {
													alert('삭제되었습니다.');
													location.replace('/project' + param.path);
												} else {
													alert('삭제시 오류 발생');
												}
											},
											error : function() {
												alert('네트워크 오류 발생!');
											}
										});
							}

						});

	});
</script>
<!DOCTYPE html>
<body>
	<!-- Modal body -->
	<div class="modal-body calendar-body">
		<form id="insertCal"
			style="display: flex; flex-direction: column; align-items: center;">
			<input type="hidden" value="${dateCheck }" id="dateCheck"> <input
				type="hidden" value="${contents.contents_num }" id="contents_num_calendar">
			<input type="hidden" value="${contents.contents_type }"
				id="contents_type_calendar"> <input type="hidden"
				value="${contents.poster_path }" id="poster_path"> <input
				type="hidden" value="" id="custom_date">
			<div class="my-calendar clearfix">
				<div class="clicked-date" style="display: none;">
					<div class="cal-day"></div>
					<div class="cal-date"></div>
				</div>
				<div class="calendar-box">
					<div class="ctr-box clearfix">
						<button type="button" title="prev" class="btn-cal prev"></button>
						<span class="cal-year"></span> <span class="cal-month"></span>
						<button type="button" title="next" class="btn-cal next"></button>
					</div>
					<table class="cal-table">
						<thead>
							<tr>
								<th>S</th>
								<th>M</th>
								<th>T</th>
								<th>W</th>
								<th>T</th>
								<th>F</th>
								<th>S</th>
							</tr>
						</thead>
						<tbody class="cal-body"></tbody>
					</table>
				</div>
			</div>
			<div style="display: flex; justify-content: center;">
				<input class="css-1ukikc-StylelessButton" type="submit" value="등록">
			</div>
		</form>
	</div>
</body>
</html>