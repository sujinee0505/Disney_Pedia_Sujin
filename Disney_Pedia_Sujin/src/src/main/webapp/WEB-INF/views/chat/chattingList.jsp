<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<style>

h2 { 
text-align: center; 
margin: 50px;

}	
ul.chat-other {
    text-align:center;
	margin: 0px auto;
	padding: 0;
	width: 490px;
	height: 720px;
	overflow-y: auto;
	margin-top: 85px;
}

@font-face{
font-family: 'SUIT-Medium';
}

</style>
	
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(function() {
		function selectData(pageNum){
		   
		   $('#output').empty();
		   
		   $.ajax({
		      url:'chattingList.do',
		      type:'post',
		      data:{chatboard_num:${param.chatboard_num}},
		      dataType:'json',
		      cache:false,
		      timeout:30000,
		      success:function(param){
		         if(param.result == 'logout'){
		            alert('로그인해야 채팅 목록을 볼 수 있습니다.');
		         }else if(param.result == 'success'){
		            $(param.chattingList).each(function(index,item){
		            	let output = '<a href="chatting.do?chatboard_num=${chatboard.chatboard_num}&trans_num='+item.from_num+'" class="list-group-item list-group-item-action">';
			               output += '<div class="d-flex w-100 justify-content-between">';
			               output += '<h5 class="mb-1"></h5>';
			               output += '<img class="fit-picture" src="${pageContext.request.contextPath}/resources/images/disney.png">';
			               output += '<small class="text-muted"></small>';
			               output += '</div>';
			               output += '<p class="mb-1">' + item.name + '님과 대화해 보세요.</p>';
			               output += '<small class="text-muted">DisneyPedia</small>';
			               output += '</a>';
		               
		               //문서 객체에 추가
		               $('#output').append(output);
		            });
		         }
		         
		      },
		      error:function(){
		         alert('네트워크 오류 발생');
		      }
		   });
		   
		}
		selectData(); 
	});
</script>
<ul class="chat-other">
<div class="page-main-chat" id="main-chat" style="margin-top: 100px;">
	<h2>
	    <img class="fit-picture" src="${pageContext.request.contextPath}/resources/images/disney1.png">
		<br><big><b>${chatboard.name}님 환영합니다!</b></big>
	</h2>
	
	<div class="list-group" id="output"></div>
</div>
</ul>

