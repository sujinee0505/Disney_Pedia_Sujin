<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script type="text/javascript">
	$(function() {
		$('#calendarModal').on('shown.bs.modal', function() {
			  if ($('.day').hasClass('day-active')) {
				  $('.day').removeClass('day-active');
			  }
		});
		
	    let user_num = $('#user_num').val();

		// 캘린더 등록    
	    insertCal = function() {
	    
	    	// 현재 열람중인 달력의 연,월
	        var year = $('.cal-year').text();
	        var month = $('.cal-month').text();
	        
	        // 클릭된 date
	        var day = $('.day-active').text();
	        // 한자릿수 숫자 앞에 0 붙여주기
	        if ($('.day-active').text() < 10) {
	            day = '0' + $('.day-active').text();
	        }
			
			// yyyy-mm-dd 형태로 만들어주기
	        var custom_date = year + '-' + month + '-' + day;
	        
	        // 일단 hidden으로 값을 숨겨서 저장해놓는다
	        $('#custom_date').val(custom_date);
	        
	        // 로그인 안된 상태
	        if (user_num == 0) {
	            Swal
	                .fire({
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
	                }) // sweet alert 끝
	            return false;
	        }
	        
	        // 로그인 된 상태
	        if (user_num != 0) {
	        	// 날짜 선택 안하고 등록 버튼 눌렀을 경우
	            if ($('.day').hasClass('day-active') == false) {
	                Swal.fire({
	                    title: ' ',
	                    text: '날짜를 선택해주세요.',
	                    confirmButtonColor: '#84d7fa',
	                    confirmButtonText: '확인',
	                    width: 400,
	                    padding: '2em'
	                }).then((result) => {
	                    if (result.isConfirmed) {
	                        return false;
	                    }
	                }) // sweet alert 끝
				
				// 캘린더 기등록여부를 먼저 체크, 데이터가 있는 경우
	            } else if ($('#dateCheck').val() != 'noData') {
	                Swal.fire({
	                    title: ' ',
	                    text: '수정하시겠습니까?',
	                    confirmButtonColor: '#84d7fa',
	                    showCancelButton: true,
	                    confirmButtonText: '예',
	                    cancelButtonText: '아니오',
	                    width: 400,
	                    padding: '2em'
	                }).then((result) => {
	                
	                	// 수정 안함
	                    if (result.isConfirmed == false) {
	                        return false;
	                        
	                    // 수정  함 
	                    } else {
	                        $.ajax({
	                            type: 'post',
	                            data: {
	                                contents_num: $('#contents_num_calendar')
	                                    .val(),
	                                custom_date: $('#custom_date').val(),
	                                contents_type: $('#contents_type_calendar')
	                                    .val(),
	                                poster_path: $('#poster_path').val()
	                            },
	                            url: 'updateCal.do',
	                            dataType: 'json',
	                            cache: false,
	                            timeout: 30000,
	                            success: function(param) {
	                            
	                                if (param.result == 'logout') {
	                                	 Swal
	     	         	                .fire({
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
	     	         	                }) // sweet alert 끝
	     	         	              	location.reload(true);
	                                } else if (param.result == 'success') {
	                                    Swal.fire({
	                                        title: ' ',
	                                        text: '성공적으로 수정했습니다.',
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
	                                    alert('수정시 오류 발생');
	                                }
	                            },
	                            error: function() {
	                                alert('네트워크 오류 발생!');
	                            }
	                        }); // ajax 끝
	                    } // else 끝

	                }) // sweet alert의 then 끝
	             
	            // 캘린더 기등록여부를 먼저 체크, 데이터가 없는 경우 (최초 등록)    
	            } else {
	                $.ajax({
	                    type: 'post',
	                    data: {
	                        contents_num: $('#contents_num_calendar').val(),
	                        custom_date: $('#custom_date').val(),
	                        contents_type: $('#contents_type_calendar').val(),
	                        poster_path: $('#poster_path').val()
	                    },
	                    url: 'insertCal.do',
	                    dataType: 'json',
	                    cache: false,
	                    timeout: 30000,
	                    success: function(param) {
	                        if (param.result == 'logout') {
	                        	 Swal
	         	                .fire({
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
	         	                }) // sweet alert 끝
	         	            	return false;
	                        } else if (param.result == 'count_over') {
	                        	Swal
	         	                .fire({
	         	                    title: ' ',
	         	                    text: '같은 날짜에는 최대 4개까지의 컨텐츠만 등록하실수 있습니다.',
	         	                    imageUrl: '${pageContext.request.contextPath}/resources/images/cal_icon2.png',
	         	                    imageWidth: 70,
	         	                    imageHeight: 70,
	         	                    imageAlt: 'Custom image',
	         	                    confirmButtonColor: '#84d7fa',
	         	                    confirmButtonText: '알겠어요',
	         	                    width: 400,
	         	                    padding: '2em'
	         	                }) // sweet alert 끝
	         	            	return false;
							} else if (param.result == 'success') {
	                            Swal.fire({
	                                title: ' ',
	                                text: '성공적으로 등록했습니다.',
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
	                            alert('등록시 오류 발생');
	                        }
	                    },
	                    error: function() {
	                        alert('네트워크 오류 발생!');
	                    }
	                }); // ajax 끝
	            } // else 끝
	        } // if 끝
	    } // 함수 선언 끝

		// 이미 등록된 날짜를 클릭하는 경우 → 삭제
	    $('.dayMark').click(function() {
	        Swal.fire({
	            title: ' ',
	            text: '삭제하시겠습니까?',
	            confirmButtonColor: '#84d7fa',
	            showCancelButton: true,
	            confirmButtonText: '예',
	            cancelButtonText: '아니오',
	            width: 400,
	            padding: '2em'
	        }).then((result) => {
	        
	        	// 삭제 안함
	            if (result.isConfirmed == false) {
	                return false;
	            
	            // 삭제
	            } else {
	                $.ajax({
	                    type: 'post',
	                    data: {
	                        contents_num: $('#contents_num').val(),
	                        custom_date: $('#custom_date').val(),
	                        contents_type: $('#contents_type').val(),
	                        poster_path: $('#poster_path').val()
	                    },
	                    url: 'deleteCal.do',
	                    dataType: 'json',
	                    cache: false,
	                    timeout: 30000,
	                    success: function(param) {
	                        if (param.result == 'logout') {
	                        	 Swal
	         	                .fire({
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
	         	                }) // sweet alert 끝
	         	            	return false;
	                        } else if (param.result == 'success') {
	                            Swal.fire({
	                                title: ' ',
	                                text: '성공적으로 삭제했습니다.',
	                                imageUrl:  '${pageContext.request.contextPath}/resources/images/ok_icon.png',
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
	                            alert('삭제시 오류 발생');
	                        }
	                    },
	                    error: function() {
	                        alert('네트워크 오류 발생!');
	                    }
	                }); // ajax 끝
	            } // else 끝
	        }) // sweet alert의 then 끝
	    }); // 클릭 이벤트 발생 시의 함수 선언 끝
	    
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
				<input class="btn btn-dark-blue"" type="button" value="등록" onclick="insertCal();"style="color: white;">
			</div>
		</form>
	</div>
</body>
</html>