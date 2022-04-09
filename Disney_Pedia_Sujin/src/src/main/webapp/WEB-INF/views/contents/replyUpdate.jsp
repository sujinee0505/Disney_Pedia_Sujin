<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">
$(function() {	
	
	//글자수 불러오기
	$('#replytUpdateModal').on('shown.bs.modal', function() {
		let LengthNow = $('#comment2').val().length;
		$('.letter-count').text(LengthNow+'/300');
	 });
	
	 $(document).on('click','.update', function() {
		var original_content = $(event.target).parent().parent().parent().parent().parent().find('.css-yb0jaq').text();
		$('#comment2').val(original_content);
		$('#reply_num').val($(event.target).parent().find('.reply_num').val());
	}); 
			 
	 //글자수카운트
	$(document).on('keyup', 'textarea', function() {
			//입력한 글자수를 구함
			let inputLength = $(this).val().length;

			if (inputLength > 300) {//300자를 넘어선 경우
				$(this).val($(this).val().substring(0, 300));
			} else {//300자 이하인 경우
				inputLength += '/300';
				if ($(this).attr('id') == 'comment2') {
					$('#count_area .letter-count').text(inputLength);
				}
			}
		});

		//코멘트 댓글
		$('#commentUpdate_form').submit(function(event) {
			$.ajax({
				url : 'replyUpdate.do',
				type : 'post',
				data : {
					content : $('#comment2').val(),
					reply_num : $('#reply_num').val()
				},
				dataType : 'json',
				cache : false,
				timeout : 30000,
				success : function(param) {
					if (param.result == 'logout') {
						alert('로그인 후 사용하세요');
					} else if (param.result == 'success') {
						alert('댓글을 수정했습니다.');
					} else {
						alert('댓글 수정 오류 발생');
					}
				},
				error : function() {
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
        <p class="modal-title2"><b>댓글</b></p>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <!-- Modal body -->
      <div class="modal-body comment-body">
      	<form action="" method="post" role="form" id="commentUpdate_form">
      	<input type="hidden" value="" id="reply_num">
      	<textarea autofocus required cols="30" rows="10" id="comment2" name="comment" 
      	placeholder="이 작품에 대한 생각을 자유롭게 표현해주세요." ></textarea>
      	<div class="float_right">
      		<!-- 글자수 체크 -->
			<div id="count_area">
			<span class="letter-count">0/300</span>
			</div> 
			<button type="submit" id="comment_btn" class="btn btn-dark-blue">수정</button>
		</div>
		</form> 		
	  </div>	    
	 
</body>
</html>