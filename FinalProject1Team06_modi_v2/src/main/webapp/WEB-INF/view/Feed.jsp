<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Feed.jsp</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/list-groups.css">
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/feed.css">

<!-- jQuery  -->
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
 
<!-- bootstrap 소스 넣기 (bootstrap v5.0 버전)  -->
<!--
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
 -->
<!-- icon 부트스트랩 신버전 소스  -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">

<script type="text/javascript">

	$(function()
	{
		/* $('.peed_content').scrollTop($('.peed_content')[0].scrollHeight); */
		$(".peed_content").animate(
		{
			scrollTop: $(".peed_content")[0].scrollHeight
		}, 800);

		$(".btnDel").click(function()
		{
			if (confirm("삭제하시겠습니까?"))
			{
				$(location).attr("href", "deletefeed.action?feedNum=" + $(this).val()+"&room_num="+$("#room_num").val());
			}
		});
	});

</script>
<script type="text/javascript">

	function contentAjax()
	{
		var params = "content=" + $("#content").val()+"&room_num="+$("#room_num").val();
	      
		$.ajax(
		{
			type:"GET"                        
			, url:"insertcontent.action"            
			, data:params
			, success:function(args)
			{
		      	$(".peed_content").html(args);
		      	$("#content").val("");
		      	$("#content").focus();
		      	
		      	$('.peed_content').scrollTop($('.peed_content')[0].scrollHeight);
		      	
		      	$(".btnDel").click(function()
      			{
      				if (confirm("삭제하시겠습니까?"))
      				{
      					$(location).attr("href", "deletefeed.action?feedNum=" + $(this).val()+"&room_num="+$("#room_num").val());
      				}
      			});
		      	
			}                                 
			, error:function(e)
			{
		      	alert(e.responseText);
			}
		});
	
	}

</script>

/

</head>
<body>
<div class="container-fluid" style="width: 80%">
	<div>
		<jsp:include page="/WEB-INF/view/Room_Ongoing_Header.jsp"/>
	</div>
	
	<div class="p-lg-5 mx-auto my-auto peed_position_relative">
		<div class="peed_content">
			
			<c:forEach var="list" items="${feedList }">
			
			<div class="mooon">
				<div class="peed_profile" style="margin-top: 1vh; margin-bottom: 0px;">
					<img alt="" src="${list.photo }" style="width: 70px; height: 70px; border-radius: 50%;">
					<p style="color: white; text-align: center;">${list.nickName }</p>
				</div>
				<div class="mooon2">
					<div class="peed_content_content">
						<p style="color: white; width: 800px; text-align: left;">${list.content }</p>
					</div>
					<div class="peed_time">
						<p style="color: white;">${list.writeTime }</p>
					</div>
					<div class="contentDelete">
						<c:if test="${list.nickName == feedDto.nickName && list.count== '0'}">
							<button type="button" class="btn btn-success btnDel" id="btnDel" name="btnDel" value="${list.feedNum }">삭제</button>
						</c:if>
						<c:if test="${list.nickName == feedDto.nickName && list.count== '1'}">
							<button type="button" disabled="disabled" class="btn btn-success btnDel" id="btnDel" name="btnDel" value="${list.feedNum }">삭제</button>
						</c:if>
						<c:if test="${list.nickName != feedDto.nickName }">
							<button type="button" class="btn btn-danger" id="btnReport" name="btnReport">신고</button>
						</c:if>
					</div>
				</div>
			</div>
			</c:forEach>
		</div>
		<div class="peed_insert">
			<!-- <form action="" method="post"> -->
				<div class="insert_form">
					<div style="margin-top: 2.5px;">
						<img alt="" src="${feedDto.photo }" style="width: 70px; height: 70px; border-radius: 50%;">
						<p style="color: white; text-align: center;">${feedDto.nickName }</p>
					</div>
					<div style="margin-top: 2vh;">
						<!-- 참여 중일 때 -->
						<input type="text" class="form-control" name="content" id="content" style="text-align: left;">
						
						<!-- 참여 중이 아닐 때 -->
						<!-- 
						<input type="text" class="form-control" name="content" id="content" placeholder="작성 권한이 없습니다."
						disabled="disabled" style="text-align: left;">
						-->
					</div>
					<div>
						<!-- 참여 중일 때 -->
						<button type="button" class="btn btn-success" id="btnSendContent" name="btnSendContent" onclick="contentAjax()">Send</button>
						<input type="hidden" id="room_num" name="room_num" value="${feedDto.roomNum }">
						<!-- 참여 중이 아닐 때 -->
						<!-- <button type="button" class="btn btn-success" id="btnSendContent" name="btnSendContent" disabled="disabled">Send</button> -->
					</div>
				</div>
			<!-- </form> -->
		</div>
	</div>
</div>

</body>
</html>