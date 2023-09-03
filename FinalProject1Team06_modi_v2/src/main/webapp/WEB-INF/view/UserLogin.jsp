<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="Mark Otto, Jacob Thornton, 그리고 Bootstrap 기여자들">
<meta name="generator" content="Hugo 0.104.2">
<title>UserLogin.jsp</title>

<!-- Custom styles for this template -->
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/signin.css">

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.1/dist/umd/popper.min.js"></script>

<!-- bootstrap 소스 넣기 (bootstrap v5.0 버전)  -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>

<!-- icon 부트스트랩 신버전 소스  -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">

<link rel="canonical" href="https://getbootstrap.kr/docs/5.2/examples/sign-in/">

<!-- Favicons -->
<link rel="apple-touch-icon" href="/docs/5.2/assets/img/favicons/apple-touch-icon.png" sizes="180x180">
<link rel="icon" href="/docs/5.2/assets/img/favicons/favicon-32x32.png" sizes="32x32" type="image/png">
<link rel="icon" href="/docs/5.2/assets/img/favicons/favicon-16x16.png" sizes="16x16" type="image/png">
<link rel="manifest" href="/docs/5.2/assets/img/favicons/manifest.json">
<link rel="mask-icon" href="/docs/5.2/assets/img/favicons/safari-pinned-tab.svg" color="#712cf9">
<link rel="icon" href="/docs/5.2/assets/img/favicons/favicon.ico">
<meta name="theme-color" content="#712cf9">

<style>

	.bd-placeholder-img 
	{
		font-size: 1.125rem;
		text-anchor: middle;
		-webkit-user-select: none;
		-moz-user-select: none;
		user-select: none;
	}
	
	@media (min-width: 768px) 
	{
		.bd-placeholder-img-lg 
		{
		  	font-size: 3.5rem;
		}
	}
	
	.b-example-divider 
	{
		height: 3rem;
		background-color: rgba(0, 0, 0, .1);
		border: solid rgba(0, 0, 0, .15);
		border-width: 1px 0;
		box-shadow: inset 0 .5em 1.5em rgba(0, 0, 0, .1), inset 0 .125em .5em rgba(0, 0, 0, .15);
	}
	
	.b-example-vr 
	{
		flex-shrink: 0;
		width: 1.5rem;
		height: 100vh;
	}
	
	.bi 
	{
		vertical-align: -.125em;
		fill: currentColor;
	}
	
	.nav-scroller 
	{
		position: relative;
		z-index: 2;
		height: 2.75rem;
		overflow-y: hidden;
	}
	
	.nav-scroller .nav 
	{
		display: flex;
		flex-wrap: nowrap;
		padding-bottom: 1rem;
		margin-top: -1px;
		overflow-x: auto;
		text-align: center;
		white-space: nowrap;
		-webkit-overflow-scrolling: touch;
	}
	
	th, td {font-size: small;}

</style>



<script type="text/javascript">

	$(function()
	{
		if ($("#count").val() == 1)
		{
			$('#myModal').show();
			$('#myModal').on('show.bs.modal', function () 
		   	{
		     	$('#backdrop').show();
		   	});
			
			$("#myModal #btnClose").on("click",function(){
				$('#myModal').hide();
				$('#myModal').on('show.bs.modal', function () 
			   	{
			     	$('#backdrop').hide();
			   	});
				
			});
			
			$("#myModal .close").on("click",function(){
				$('#myModal').hide();
				$('#myModal').on('show.bs.modal', function () 
			   	{
			     	$('#backdrop').hide();
			   	});
				
			});
			
		}
		
		$("#submitBtn").click(function()
		{
			//alert("확인");
			if ($("#floatingInput").val() == "" || $("#floatingPassword").val() == "")
			{
				
				$("#err").html("항목을 모두 입력해야 합니다.").css("display", "inline");
				return;
			}
			
			$("#loginForm").submit();
			
		});
	});

</script>


</head>
<body class="text-center">

<nav>
	<jsp:include page="notUser_menuBar.jsp"></jsp:include>
</nav>
    
<main class="form-signin w-100 m-auto">
	<form action="login.action" method="get" id="loginForm">
		<img class="mb-4" src="images/pngwing.com.png" alt="">
		<h1 class="h3 mb-3 fw-normal"></h1>
		<div class="form-floating">
			<input type="text" class="form-control" name="id" id="floatingInput" placeholder="ID" required="required">
			<label for="floatingInput">ID</label>
		</div>
		
		<div class="form-floating">
			<input type="password" class="form-control" name="pw" id="floatingPassword" placeholder="Password" required="required">
			<label for="floatingPassword">Password</label>
			<p><span style="color: red; font-size: red;">${str }</span></p>
		</div>
		
		<div class="forgot">
			<div class="checkbox mb-3">
				<button type="button" class="btn btn-default" onclick="location.href='findidform.action'">아이디찾기</button>
				<button type="button" class="btn btn-default" onclick="location.href='findpwform.action'">비밀번호찾기</button>
			</div>
		</div>
	
		<button class="w-100 btn btn-lg btn-primary" type="submit" id="submitBtn">로그인</button>
		</form>
		<button class="w-100 btn btn-lg btn-primary" type="submit" onclick="location.href='signup.action'">회원가입</button>
		<span id="err" style="color: red; display: none;"></span>
		
		<p class="mt-5 mb-3 text-muted"><a href="adminloginform.action" class="link-admin">관리자 로그인</a></p>
		<input type="hidden" id="count" name="count" value="${count }">
		
		<!-- 모달창 -->
<div class="modal" id="myModal" tabindex="-1" role="dialog">
	<div class="modal-dialog" role="document">
    	<div class="modal-content">
    	
      		<div class="modal-header">
        		<h5 class="modal-title">계정정지안내</h5>
        		<button type="button" class="close" data-dismiss="modal" aria-label="Close">
          		<span aria-hidden="true">&times;</span>
        		</button>
      		</div>
      		
      		<div class="modal-body">
      			<div>
					<p style="font-weight: bold;">회원님께서는 현재 <span style="color: red;">계정정지</span> 기간입니다.</p>
        			<table class="table">
        				<tr>
        					<th>정지 사유</th>
        					<th>정지 기간</th>
        				</tr>
        				<c:forEach var="list" items="${list }">
        				<tr>
	       					<td>${list.reason }</td>
	       					<td>${list.startDate } ~ ${list.endDate }</td>
        				</tr>
        				</c:forEach>
        			</table>
        		</div>
        		<div>
        			<p>남은 계정정지 기간은 <span style="color: red; font-weight: bold;">${total.total } 일</span> 이고,</p>
        			<p>정상 이용 가능 일자는 <span style="color: blue; font-weight: bold;">${useStart }</span> 일 입니다.
        		</div>
    		</div>
      
      		<div class="modal-footer">
        		<button type="button" class="btn btn-primary" data-dismiss="modal" id="btnClose">확인</button>
      		</div>
    	</div>
  	</div>
</div>

<!-- 뒷 배경을 가리는 투명한 레이어 -->
<div class="modal-backdrop show" id="backdrop" style="display: none;"></div>

</main>

</body>
</html>
