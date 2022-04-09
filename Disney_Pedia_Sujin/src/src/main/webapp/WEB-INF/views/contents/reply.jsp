<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">
  $(function() {
		//커서
		$('#cmtReplyModal').on('shown.bs.modal', function() {
			$('#comment').trigger('focus')
		});
		//글자수카운트
	$(document).on('keyup', 'textarea', function() {
			//입력한 글자수를 구함
			let inputLength = $(this).val().length;

			if (inputLength > 300) {//300자를 넘어선 경우
				$(this).val($(this).val().substring(0, 300));
			} else {//300자 이하인 경우
				inputLength += '/300';
				if ($(this).attr('id') == 'comment') {
					$('#count_area .letter-count').text(inputLength);
				}
			}
		});

	
	// 댓글 등록
		$('#comment_form').submit(function() {
			$.ajax({
				url : 'replyWrite.do',
				type : 'post',
				data : {
					comment_num : $('#comment_num').val(),
					content : $('#comment').val()
				},
				dataType : 'json',
				cache : false,
				timeout : 30000,
				success : function(param) {
					if (param.result == 'logout') {
						alert('댓글을 남기시려면 로그인이 필요해요.');
					} else if (param.result == 'success') {
						alert('댓글을 등록했습니다.');
					} else {
						alert('댓글 등록 오류 발생');
					}
				},
				error : function() {
					alert('네트워크 오류 발생');
				}
			});
		});
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
      	<form action="" method="post" role="form" id="comment_form">
      	<input type="hidden" value="${comment.comment_num}" id="comment_num">
      	<textarea autofocus required cols="30" rows="10" id="comment" name="comment" 
      	placeholder="${contents.title }에 대한 생각을 자유롭게 표현해주세요." ></textarea>
      	<div class="float_right">
			<div id="count_area">
			<span class="letter-count">0/300</span>
			</div> 
			<button type="submit" id="comment_btn" class="btn btn-dark-blue">저장</button>
		</div>
		</form> 		
	  </div>	    
	 
</body>
</html>