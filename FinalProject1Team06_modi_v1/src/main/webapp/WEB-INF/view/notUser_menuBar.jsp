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
<title>notUser_menuBar.jsp</title>

<!-- bootstrap 소스 넣기 (bootstrap v5.0 버전)  -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>

<!-- icon 부트스트랩 신버전 소스  -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">

<style>
	span
	{
		font-weight: bold;
	}
	
	 .Qleft
	{
		font-size: 50px; 
		color: #6BC6C8;
		position: fixed;
		bottom: 0;
		width: 100%;
		left: 20px;
	} 
	.bi-question-circle fs-5
	{
		font-size: 50px; 
		color: #6BC6C8;
		position: fixed;
		bottom: 0;
		width: 100%;
		left: 20px;
	} 
	
	.span
	{
		font-size : 100px;
	}
	
	.bi-arrow-up-circle-fill 
	{
		font-size: 50px;
		color: #6BC6C8;
		position: fixed;
		bottom: 0;
		width: 100%;
		left: 80px;
	}
	
	a {	color: inherit;}
	
	
</style>

</head>
<body>


<nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top bg-light">
  <div class="container-fluid shadow">
    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header">
      <!-- 브랜드로고 이미지 및 메이트립 표시 -->
      <a class="navbar-brand" href="#">
      	<img alt="Brand" src="images/trip_logo.png" width="30" height="30">
      	<span>MateTrip</span>
      </a>
    </div>
    
    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="collapse navbar-collapse" id="RoomList">
      <!-- 룸리스트 메뉴 구성  -->
      <ul class="nav navbar-nav">
        <li class="nav-item">
        	<a class="nav-link" href="not_roomlist.action">
        		<span>Room List</span>
        	</a>
        </li>
      </ul>
    </div><!-- /.navbar-collapse -->
      
      <!-- 비회원 프로필 및 로그인 메뉴 구성 -->
     <div>
      <ul class="nav navbar-nav navbar-right justify-content-end">
      	<li class="nav-item">
      		<a class="nav-link" href="loginform.action">
      			<img alt="not_profile" src="images/notUser.png" width="30" height="30">
      			<span>Login</span>
      		</a>
      	</li>
      </ul>
     </div><!-- /.Login -->
  </div><!-- /.container-fluid -->
</nav>

<!-- 물음표 구성 및 top 구성-->
<main>
	<!-- offcanvas 창 버튼 -->  
	<!-- <div class="float-end Qleft">
		<button type="button" class="btn btn-lg" data-bs-toggle="offcanvas" data-bs-target="#offcanvasBottom" aria-controls="offcanvasBottom">
			 <i class="bi bi-question-circle fs-5" ></i> 
		</button>
	</div>  -->
	
	
	<!-- offcanvas 창 열림  -->
	<!-- <div class="offcanvas offcanvas-bottom" tabindex="-1" id="offcanvasBottom" aria-labelledby="offcanvasBottomLabel">
 		<div class="offcanvas-header">
    		<h3 class="offcanvas-title" id="offcanvasBottomLabel">여행메이트 설명서</h3>
    		<button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
  		</div>
  		<div class="offcanvas-body small">
    	<span>PASS</span> : 메이트리더가 한 일차에 대해 선 PASS 를 할 경우,<br>
    						메이트들이 후 PASS 로 일자별 여행 계획에 동의하는 것을 말합니다.
    						<br><br>
    	<span>FIX</span> : 모든 메이트리더 및 메이트가 PASS 를 했을 때 <br>
    					   일자별 여행 계획이 자동 확정되는 것을 말합니다.<br>
    	<span>READY</span> : 여행 Room의 변경된 상태에 대해 확인하고 여전히 참여하기로 동의하는 것으로<br>
    					     여행 Room의 상태가 하나라도 바뀌면 자동 Ready 해제가 됩나다. 
    					     <br><br>
    	
    	<span>GO</span> : 방장이 계획과 인원을 최종 확정하는 것으로 모든 일정이 픽스되고<br>
    					 (올픽스) 동시에 모든 메이트가 레디한 상태일 때 (올레디) 할 수 있습니다.<br>
    					 여행 시작예정일 하루 전까지 출발해야 하며 이 기간을 넘길 경우 여행이 취소된 것으로 보아<br> 
    					 여행 시작예정일 이후 방이 자동 삭제됩니다.
    					 <br><br>
    	* 여행 Room 의 상태란, <br>
    	① 계획에 참여하거나, 취소한 사용자가 있을 경우<br>
    	② 일정이 수정 됐을 경우 <br>
    	③ 일정이 FIX 됐을 경우 <br>
    	④ 여행 Room 의 기본정보가 바뀌었을 경우<br> 
    	
  		</div>
	</div>

	</p> 
	<p class="float-end Tright">
		<a href="#"><i class="bi bi-arrow-up-circle-fill"></i></a>
	</p> -->
	
	
</main>


</body>
</html>