<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
$(function() {	
	
	//글자수 불러오기
	$('.commentUpdateModal').on('shown.bs.modal', function(event) {
		let LengthNow = $('.comment2').val().length;
		$('.letter-count').text(LengthNow+'/1000');
		
		
	 });
			 
	 //글자수카운트
 	 $(document).on('keyup','textarea',function(){
		//입력한 글자수를 구함
		let inputLength = $(this).val().length;
		
		if(inputLength > 1000){//1000자를 넘어선 경우
			$(this).val($(this).val().substring(0,1000));
		}else{//1000자 이하인 경우
			inputLength += '/1000';
			if($(this).attr('class') == 'comment2'){
				$('.count_area .letter-count').text(inputLength);
			};
		}
	  }); //end of count

 	//코멘트 수정
 	$('.commentUpdate_form').submit(function(event){
 		 var user_num = ${user_num};
		 $.ajax({
				url:'commentUpdate.do',
				type:'post',
				data: {
					contents_num : $(event.target).parent().find('.update_num').val(),	 		
					contents_type : $(event.target).parent().find('.update_type').val(),
					content : $(event.target).parent().parent().find('.comment2').val(),
					mem_num : user_num
					},
				dataType: 'json',
				cache:false,
				timeout:30000,
				success:function(param){
					if(param.result == 'logout'){
						alert('로그인 후 사용하세요');					
					}else if(param.result == 'success'){
						 alert('코멘트를 수정했습니다.');	
						 location.reload(true); 
					}else{
						 alert('코멘트 수정 오류 발생'); 
					}
				},
				error:function(){
					alert('네트워크 오류 발생');
				}
		}); //end of comment update ajax
 	}); //end of submit
 	
 	
 	
  });
</script>
<!DOCTYPE html>
<body>
	<!-- Modal Header -->
	<div class="modal-header border-0" id="comment-header">
		<p class="modal-title2">
			<b class="reply_title"></b>
		</p>
		<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
	</div>
	<!-- Modal body -->
	<div class="modal-body comment-body">
		<form method="post" role="form" id="commentUpdate_form"
			class="commentUpdate_form">
			<textarea autofocus required cols="30" rows="10" id="comment2"
				name="comment" placeholder="이 작품에 대한 생각을 자유롭게 표현해주세요."
				class="comment2"></textarea>
			<div class="float_right">
				<!-- 글자수 체크 -->
				<div id="count_area" class="count_area">
					<span class="letter-count">0/1000</span>
				</div>
				<!-- 삭제 아이콘 -->
				<input type="hidden" value="" class="update_num"> <input
					type="hidden" value="" class="update_type">
				<button type="submit" id="comment_btn"
					class="btn btn-dark-blue comment_btn">수정</button>

			</div>
		</form>
	</div>
</body>
</html>