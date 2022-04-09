$(function() {
	function getContextPath() {
      return sessionStorage.getItem("contextpath");
   }
   let ctx = getContextPath();
   
    var user_num = $('#user_num').val();
	$(document)
	.on(
			'click',
			'.cmtLike',
			function(event) {
				
				if (user_num == 0) {
					Swal.fire({			
							  title: ' ',						  
							  text: '좋아요를 누르려면 로그인이 필요해요.',
							  imageUrl: ctx + '/resources/images/like_icon.png',
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
				if (user_num != 0) {
					var comment_num = $(event.target).parent().find('.comment_num').val();
					var checkCmtLike = $(event.target).parent().find('.checkCmtLike').val();
							$.ajax({
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
										$(event.target).parent().find('.checkCmtLike').val(1);
										$(event.target)
												.removeClass(
														'css-1h18l7j-StylelessButton cmtLike')
												.addClass(
														'css-jj4q3s-StylelessButton-UserActionButton cmtLike');
										$(event.target)
												.parent()
												.siblings(
														'.css-1atijos')
												.find('.countLike')
												.text(
														param.countLike);
									} else if (param.result == 'cancel') { // 코멘트 좋아요 취소
										$(event.target).parent().find('.checkCmtLike').val(0);
										$(event.target)
												.removeClass(
														'css-jj4q3s-StylelessButton-UserActionButton cmtLike')
												.addClass(
														'css-1h18l7j-StylelessButton cmtLike');
										$(event.target)
												.parent()
												.siblings(
														'.css-1atijos')
												.find('.countLike')
												.text(
														param.countLike);
									}
								}
							});
				}
			});
    
});