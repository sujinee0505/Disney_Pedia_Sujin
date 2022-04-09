<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">
  $(function() {
	  //커서
	 $('#commentModal').on('shown.bs.modal', function() {
			$('#comment').trigger('focus')
	 });
	  //글자수카운트
 	 $(document).on('keyup','textarea',function(){
		//입력한 글자수를 구함
		let inputLength = $(this).val().length;
		
		if(inputLength > 1000){//1000자를 넘어선 경우
			$(this).val($(this).val().substring(0,1000));
		}else{//1000자 이하인 경우
			inputLength += '/1000';
			if($(this).attr('id') == 'comment'){
				$('#count_area .letter-count').text(inputLength);
			};
		}
	  }); //end of count

 	//코멘트 등록
 	cmtSubmit = function() {
		  
 		 var user_num = ${user_num};
 		 var star_num = $('#starnum_star').val();
 		 if (star_num == null || star_num=='') {
 			star_num = 0;
		}
		 $.ajax({
				url:'commentWrite.do',
				type:'post',
				data: {
					contents_num : $('#contents_num_comment').val(),				
					contents_type : $('#contents_type_comment').val(),
					content : $('#comment').val(),
					star_num : star_num
					},
				dataType: 'json',
				cache:false,
				timeout:30000,
				success:function(param){
					if(param.result == 'logout'){
						Swal.fire({			
							  title: ' ',						  
							  text: '코멘트를 작성하시려면 로그인이 필요해요.',
							  imageUrl: '${pageContext.request.contextPath}/resources/images/comment_icon.png',
							  imageWidth: 70,
							  imageHeight: 70,						  
							  imageAlt: 'Custom image',
							  confirmButtonColor: '#84d7fa',
							  confirmButtonText: '알겠어요',
							  width: 400,
							  padding: '2em'
							  }).then((result) => {
							      if (result.isConfirmed) {
								    	 location.reload(true);
								      }
								    })
						//alert('코멘트를 작성하시려면 로그인이 필요해요.');					
					}else if(param.result == 'success'){
						Swal.fire({			
							  title: ' ',						  
							  text: '코멘트를 등록했습니다.',
							  imageUrl: '${pageContext.request.contextPath}/resources/images/comment_icon.png',
							  imageWidth: 70,
							  imageHeight: 70,						  
							  imageAlt: 'Custom image',
							  confirmButtonColor: '#84d7fa',
							  confirmButtonText: '확인',
							  width: 400,
							  padding: '2em'
							  }).then((result) => {
							      if (result.isConfirmed) {
								    	 location.reload(true);
								      }
								    })
						//alert('코멘트를 등록했습니다.');	 
					}else{
						alert('코멘트 등록 오류 발생');
					}
				},
				error:function(){
					alert('네트워크 오류 발생');
				}
		}); //end of comment ajax
 	}
  });
</script>
      <!-- Modal Header -->
      <div class="modal-header border-0" id="comment-header">
        <p class="modal-title2"><b>${contents.title }</b></p>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <!-- Modal body -->
      <div class="modal-body comment-body">
      	<form action="" method="post" role="form" id="comment_form">
      	<input type="hidden" value="${contents.contents_num}" id="contents_num_comment">
		<input type="hidden" value="${contents.contents_type}" id="contents_type_comment">	
      	<textarea autofocus required cols="30" rows="10" id="comment" name="comment" 
      	placeholder="이 작품에 대한 생각을 자유롭게 표현해주세요." spellcheck="false"></textarea>
      	<div class="float_right">
			<div id="count_area">
			<span class="letter-count">0/1000</span>
			</div> 
			<button type="button" id="comment_btn" onclick="cmtSubmit()" class="btn btn-dark-blue">저장</button>			
			<!-- btn-hover color-9 -->
		</div>
		</form> 		
	  </div>	    