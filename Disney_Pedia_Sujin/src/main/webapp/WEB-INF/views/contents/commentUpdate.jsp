<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">
$(function() {

    //글자수 불러오기
    $('#commentUpdateModal').on('shown.bs.modal', function() {
        let LengthNow = $('#comment2').val().length;
        $('.letter-count').text(LengthNow + '/1000');
    });

    //글자수카운트
    $(document).on('keyup', 'textarea', function() {
        //입력한 글자수를 구함
        let inputLength = $(this).val().length;

        if (inputLength > 1000) { //1000자를 넘어선 경우
            $(this).val($(this).val().substring(0, 1000));
        } else { //1000자 이하인 경우
            inputLength += '/1000';
            if ($(this).attr('id') == 'comment2') {
                $('#count_area .letter-count').text(inputLength);
            };
        }
    }); //end of count

    //코멘트 수정
    cmtUpdate = function() {
    	let user_num = $('#user_num').val();
        $.ajax({
            url: 'commentUpdate.do',
            type: 'post',
            data: {
                contents_num: $('#contents_num').val(),
                contents_type: $('#contents_type').val(),
                content: $('#comment2').val(),
                mem_num: user_num
            },
            dataType: 'json',
            cache: false,
            timeout: 30000,
            success: function(param) {
                if (param.result == 'logout') {
                    alert('로그인 후 사용하세요');
                } else if (param.result == 'success') {
                    Swal.fire({
                        title: ' ',
                        text: '코멘트를 수정했습니다.',
                        imageUrl: '${pageContext.request.contextPath}/resources/images/ok_icon.png',
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

                } else {
                    alert('코멘트 수정 오류 발생');
                }
            },
            error: function() {
                alert('네트워크 오류 발생');
            }
        }); //end of comment update ajax
    }; //end of submit

    //코멘트 삭제
    cmtDel = function() {
    	let user_num = $('#user_num').val();
        $.ajax({
            url: 'commentDelete.do',
            type: 'post',
            data: {
                contents_num: $('#contents_num').val(),
                contents_type: $('#contents_type').val(),
                mem_num: user_num
            },
            dataType: 'json',
            cache: false,
            timeout: 30000,
            success: function(param) {
                if (param.result == 'logout') {
                    alert('로그인 후 사용하세요');
                } else if (param.result == 'success') {
                	Swal.fire({
                        title: ' ',
                        text: '코멘트를 삭제했습니다.',
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
                    })
                   // alert('코멘트를 삭제했습니다.');
                    //location.reload(true);
                } else {
                    alert('코멘트 삭제 오류 발생');
                }
            },
            error: function() {
                alert('네트워크 오류 발생');
            }
        }); //end of comment delete ajax
    }; //end delete

});
</script>
    <!-- Modal Header -->
    <div class="modal-header border-0" id="comment-header">
        <p class="modal-title2"><b>${contents.title }</b></p>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
    </div>
    <!-- Modal body -->
    <div class="modal-body comment-body">
        <form action="" method="post" role="form" id="commentUpdate_form">
            <input type="hidden" value="${contents.contents_num}" id="contents_num">
            <input type="hidden" value="${contents.contents_type}" id="contents_type">
            <input type="hidden" value=${getComment.star_num } id="starnum_comment">
            <textarea autofocus required cols="30" rows="10" id="comment2" name="comment" placeholder="이 작품에 대한 생각을 자유롭게 표현해주세요." spellcheck="false">${getComment.content }</textarea>
            <div class="float_right">
                <!-- 글자수 체크 -->
                <div id="count_area">
                    <span class="letter-count">0/1000</span>
                </div>
                <!-- 삭제 아이콘 -->
                <a>
                    <img src="${pageContext.request.contextPath}/resources/images/trash.png" 
                    onclick="cmtDel()"
                    id="cmt_delbtn">
                </a>
                <button type="button" onclick="cmtUpdate()" id="comment_btn" class="btn btn-dark-blue">수정</button>

            </div>
        </form>
    </div>