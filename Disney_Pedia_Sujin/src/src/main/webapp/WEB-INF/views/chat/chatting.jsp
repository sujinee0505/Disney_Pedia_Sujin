<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/mj.css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>

<script type="text/javascript">



let namecount = 0;
   $(function(){
	let chatboard_num = $('#chatboard_num').val();
    let count=0;
    let scroll_check;
    let loop_check = true;
    let date = '';
    
    	$('#content').keydown (function(event){
			if(event.keyCode == 13 && !event.shiftKey) { //.event.keyCode == 13 : 엔터키눌렀을 때 이벤트
				$('#chatting_form').trigger('submit');
				$('#enter img').fadeIn();
				setTimeout(function(){
					$('#enter img').fadeOut();
					}, 600)
			}
   		});
    	$('#chatting_form').submit(function() {
    		$('#enter img').fadeIn();
			setTimeout(function(){
				$('#enter img').fadeOut();
				}, 600)
		});
/*
 * to_num; > 메시지수신번호(글 작성자 회원번호) / {trans_num}
 * from_num; > 메시지발신번호(선 채팅자 회원번호) / {user_num}
 * 우측 .from-position
 * 좌측.to-position
 */
		// *** 1)채팅 내용 불러오기 ***
		selectData = function() {
			$('#enter').show();
			$.ajax({
				url:'getChatting.do',
				type:'post',
				//채팅 이력들을 불러오기 위해  chatboard_num/user_num(로그인 한 유저:채팅보낸사람)/trans_num(글 작성자)을 인자로 전송
				data:{chatboard_num:chatboard_num, from_num:${user_num}, to_num:${trans_num}}, 
				dataType:'json',
				cache:false,
				timeout:30000,
				success:function(param){
					if(param.result == 'logout'){
						loop_check = false;
						alert('로그인 후 사용하세요!');   
					}else if(param.result == 'success'){
						scroll_check = true;
						$('#chatting_message').empty();
						$(param.getChatting).each(function(index,item){
							let output2 = '';
							let output = '';
							//날짜
							if(item.date!=date){
								output += 	'<div class="item-date">'+item.date+'</div>';
								date =item.date;
							}
							//우측
							if(item.from_num == ${user_num}){ 
								output += '<div style="display: flex; justify-content: flex-end; flex-direction: column;">';
								output += '<div style="display: flex; justify-content: flex-end; "><span id="from_name">'+item.name+'</span></div>';
								output += 	'<div class="from-position"><div class="item" id="from_item">';
								output +=   '<span>' + item.content +'</span>';
								output += 	'</div><span class="from_position-date" >'+item.time+'</span></div>';
							
							//좌측(item.to_num == ${user_num}) 
							}else{   
								output += '<div style="display: flex; justify-content: flex-start; flex-direction: column;">';
								output += '<div style="display: flex; justify-content: flex-start; "><span id="to_name">'+item.name+'</span></div>';
								output += 	'<div class="to-position"><div class="item" id="to_item">';
								output +=   '<span>' + item.content +'</span>';
								output += 	'</div><span id="to_position-date" >'+item.time+'</span></div>';
								if(namecount<1){//메세지쪽 말고 왼쪽 상단
									output2 = '<div id="trans_id"><b>'+item.name+'님과의 대화방입니다.<b></div>';
								}
							}
								
							output += '</div>';
						
							
							//문서 객체에 추가
							$('#chatting_message').append(output);
							if(namecount<1){
								$('#chat01-01').append(output2);
							}
							namecount++;
							if(scroll_check){
								//스크롤를 하단으로 위치시킴
								//$('#chatting_message').scrollTop($("#chatting_message").scrollHeight); //jQeury방식
								var scrollDown = document.getElementById("chatting_message"); //js방식
								scrollDown.scrollTop = scrollDown.scrollHeight;
							}
						});
						
					}else{
					loop_check = false;
					alert('오류가 발생했습니다!');   
					}
				}, //end of success
				error:function(){
				loop_check = false;
				alert('네트워크 오류 발생');
				}
			}); //end of Ajax
			
		} //end of selectData function
		
	selectData(); //페이지에서 항상 대화기록을 불러오고 시작
	    
		// *** 2)채팅 메세지 전송  ***
		$('#chatting_form').submit(function(event){
			if($('#content').val().trim() == ''){
			alert('내용을 입력하세요!');
			$('#content').val('').focus();
			return false;
			}
			
			$.ajax({
			url:'writeChat.do',
			type:'post',
			data:{chatboard_num:chatboard_num,from_num:${user_num},to_num:${trans_num},content:$('#content').val()}, // dchatting 테이블에 저장돼야하는 값들을 넘겨줍니다
			dataType:'json',
			cache:false,
			timeout:30000,
			success:function(param){
				if(param.result == 'logout'){
					alert('로그인해야 작성할 수 있습니다.');
				}else if(param.result == 'success'){
					//폼 초기화
					$('#content').val('').focus();
					selectData();
				}else{
					alert('등록시 오류 발생');
				}
			},

			error:function(){
				alert('네트워크 오류!');
			}
			});
			event.preventDefault();
		});
		
		// *** 3)모집 상태 변경  ***
		$('#mate').click(function() {
			var check = 0;
			if ($(this).text()=='모집 중') {
				check = 0;
			}else if($(this).text()=='모집 완료'){
				check = 1;
			} 

			//alert('check 0:모집중/1:완료 = '+check);
			$.ajax({
				url:'updateMateState.do',
				type:'post',
				data:{chatboard_num:chatboard_num, check : check }, // dchatting 테이블에 저장돼야하는 값들을 넘겨줍니다
				dataType:'json',
				cache:false,
				timeout:30000,
				success:function(param){
					
					if(param.result == 'logout'){
						alert('로그인해야 작성할 수 있습니다.');
					}else if(param.result == 'success'){
						let stateNotice = '';
						<!-- mate_state : 0 모집중/1 모집완료 -->
						if (check==0) { /* 모집중(0)->모집완료(1)  */
							stateNotice = '<span>'+'모집 중으로 변경하려면 <b>클릭</b>하세요!'+'</span>';
						
							alert("모집 완료로 변경되었습니다!")
							$('#mate').text('모집 완료');
							$('#mate').removeClass('bg-danger').addClass('bg-light text-dark');
							check = 1; //check변수로 모집 현황을 구분하므로 check값도 바꿔준다.
						
						}else if (check==1) { /* 모집완료(1)->모집중(0)  */
							stateNotice = '<span>'+'모집 완료로 변경하려면 <b>클릭</b>하세요!'+'</span>';
							alert("모집 중으로 변경되었습니다!")
							$('#mate').text('모집 중');
							$('#mate').removeClass('bg-light text-dark').addClass('bg-danger');
							check = 0; //check변수로 모집 현황을 구분하므로 check값도 바꿔준다.
						}else{
							alert("check오류");
						}
						
						$('#state_notice span').remove('#state_notice span')
						$('#state_notice').append(stateNotice);
						
					}else{
						alert('모집완료로 변경시 오류 발생');
					}

				}, 
				error:function(){
					alert('네트워크 오류!');
				}

			});	//end of ajax	
		});	//end of click function
		
		
	});   
	
</script>

<div id="bg">
<!-- <div class="page-main-chat border border-primary border-2 rounded"> -->
	<div class="page-main-chat">
		
		<div id="page-main-chat01" >
			<div class="chat01 ">
			<img id="chat01img" src="${pageContext.request.contextPath}/resources/images/board/chatstate_num.png">
				
				<!-- 1.글 작성자와 로그인자가 다른 경우 -->
				<c:if test="${user_num != chatBoard.mem_num}"> 
					<div id="trans_id"> <small>${chatBoard.title}의 작성자 </small><br>
										<b>${chatBoard.name}님과의 채팅방입니다.</b> 
					</div>
				</c:if>
				
				<!-- 2.글 작성자와 로그인자가 같은 경우 -->
				<!-- mate_state : 0 모집중/1 모집완료 -->
				<c:if test="${user_num == chatBoard.mem_num}">
				<div id="chat01-01"></div>
					<button id="mate"
						class="badge rounded-pill <c:if test="${chatBoard.mate_state == 0}">bg-danger</c:if><c:if test="${chatBoard.mate_state == 1}">bg-light text-dark</c:if>">
						<c:if test="${chatBoard.mate_state == 0}">모집 중</c:if>
						<c:if test="${chatBoard.mate_state == 1}">모집 완료</c:if>
					</button>
				</c:if>
				
				<div id="state_notice">
					<c:if test="${chatBoard.mate_state == 0 && user_num == chatBoard.mem_num}">
						<img id="arrow" src="${pageContext.request.contextPath}/resources/images/board/arrow.gif">
						<span>모집 완료로 변경하려면 <b>클릭</b>하세요!</span>
					</c:if>
					<c:if test="${chatBoard.mate_state == 1 && user_num == chatBoard.mem_num}">
						<img id="arrow" src="${pageContext.request.contextPath}/resources/images/board/arrow.gif">
						<span>모집 중으로 변경하려면 <b>클릭</b>하세요!</span>
					</c:if>
				</div>
			</div>
	
			<div id="page-main-chat02">
				<div class="chat02">
					
					<div id="chatting_message" class="overflow-auto"> </div>
					
					<div id="chatting_form">
						<form method="post" id="chatting_form">
							<input type="hidden" id="chatboard_num" name="chatboard_num" 
									value="${chatBoard.chatboard_num}">
							
							<c:if test="${user_num != chatBoard.mem_num}">
								<input type="hidden" id="to_num" name="to_num" value="${chatBoard.mem_num}">
							</c:if>
							
							<c:if test="${user_num == chatBoard.mem_num}">
								<input type="hidden" name="to_num" value="${member.mem_num}">
							</c:if>
							
							<div id="enter" >
								<img src="${pageContext.request.contextPath}/resources/images/board/chipNdale.gif">
								<textarea name="content" id="content" class="form-control no_resize" cols="70" rows="5" ></textarea>
								<button type="submit" class="btn-chat btn-outline-primary rounded-pill" id="submit_btn">전송</button>
							</div>
						</form>
					</div>
				</div>
				</div>
		</div>
		
	</div>
</div>

