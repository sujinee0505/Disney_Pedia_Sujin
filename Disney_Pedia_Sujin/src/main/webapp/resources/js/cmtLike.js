$(function() {

	// 이미지 호출을 위한 작업
    function getContextPath() {
        return sessionStorage.getItem("contextpath");
    }
    let ctx = getContextPath();

    var user_num = $('#user_num').val();
    
    // 좋아요 버튼에 클릭 이벤트 발생 시
    $(document)
        .on(
            'click',
            '.cmtLike',
            function(event) {
				
				// 로그인 안된 상태
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
                    }) // sweete alert 끝
                    return;
                }
                
                // 로그인 된 상태
                if (user_num != 0) {
                
                    var comment_num = $(event.target).parent().find('.comment_num').val();
                    var checkCmtLike = $(event.target).parent().find('.checkCmtLike').val(); // 좋아요 기등록 여부 확인, 1 → 기등록 상태 / 0 → 최초 등록
                    
                    $.ajax({
                        url: 'cmtLike.do',
                        type: 'post',
                        dataType: 'json',
                        data: {
                            comment_num: comment_num,
                            mem_num: user_num,
                            checkCmtLike: checkCmtLike
                        },
                        success: function(param) {
                        	
                        	// 좋아요
                            if (param.result == 'success') { 
                            
                            	// 반복해서 이벤트가 발생할 경우 계속해서 데이터가 입력되지 않도록 강제로 checkCmtLike의 값을 1로 설정해준다
                                $(event.target).parent().find('.checkCmtLike').val(1);
                                
                                // 좋아요 버튼의 css 스타일 변경
                                $(event.target)
                                    .removeClass(
                                        'css-1h18l7j-StylelessButton cmtLike')
                                    .addClass(
                                        'css-jj4q3s-StylelessButton-UserActionButton cmtLike');
                                        
                                // 좋아요 갯수 새롭게 반영
                                $(event.target)
                                    .parent()
                                    .siblings(
                                        '.css-1atijos')
                                    .find('.countLike')
                                    .text(
                                        param.countLike);
                            
                            // 좋아요 취소            
                            } else if (param.result == 'cancel') { 
                            
                            	// 반복해서 이벤트가 발생할 경우 계속해서 데이터가 삭제되지 않도록 강제로 checkCmtLike의 값을 0으로 설정해준다
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
                    }); // ajax 끝
                } // if 끝
            }); // 함수 선언 끝

});