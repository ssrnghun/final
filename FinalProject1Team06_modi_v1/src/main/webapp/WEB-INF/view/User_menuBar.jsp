<%@page import="com.final1.logic.RoomMemberDTO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.final1.util.DBConn"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	HttpSession session1 = request.getSession();
	String id = (String)session1.getAttribute("id");
	
	Connection conn = DBConn.getConnection();
	
	String sql = "SELECT NIKNAME,PHOTO FROM MEMBER WHERE ID_NUM = (SELECT ID_NUM FROM MEM_REGI WHERE ID =?)";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, id);
	
	ResultSet rs =  pstmt.executeQuery();
	RoomMemberDTO dto = new RoomMemberDTO();
	while(rs.next())
	{
		dto.setNickname(rs.getString(1));
		dto.setPhoto(rs.getString(2));
	}
	String nikname = dto.getNickname();
	String photo = dto.getPhoto();
	
	//rs.close();
	//pstmt.close();
	//conn.close();
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>User_menuBar.jsp</title>
<link rel="stylesheet" type="text/css" href="css/main.css">

<!-- bootstrap 소스 넣기 (bootstrap v5.0 버전)  -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>

<!-- icon 부트스트랩 신버전 소스  -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
<script type="text/javascript">
   
   $(function()
   {   
	   $("#rightMenu").click(function()
		{
		     // 토스트 보여주기
		     $('.toast').toast('show');
			
		});
	   
   });
</script>

</head>
<body>


<nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top bg-light">
  <div class="container-fluid">
    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header">
      <!-- 브랜드로고 이미지 및 메이트립 표시 -->
      <a class="navbar-brand" href="#">
		<img alt="Brand" src="images/trip_logo.png" alt="" width="30" height="30" style="border-radius: 100%;">
    	<span style="font-weight: bold;">MateTrip</span>
     </a>
    </div>

    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="collapse navbar-collapse" id="RoomList">
      <!-- 룸리스트 메뉴 구성  -->
      <ul class="nav navbar-nav">
         <li class="nav-item">
         	<a class="nav-link" href="#">
         		<span style="font-weight: bold;">Room List</span>
         	</a>
         </li>
         
      </ul>
    </div><!-- /.navbar-collapse -->
    
    <!--
    <div>
      <ul class="nav navbar-nav navbar-right justify-content-end" id="rightMenu">
         알림 및 북마크
        <li class="nav-item">
        	<a class="nav-link"><i class="bi bi-bell"></i></a>
        </li>
        <li class="nav-item">
            <a class="nav-link"><i class="bi bi-bookmark"></i></a>
        </li>
         로그아웃 / 참여 중 계획목록 드롭다운
         <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-bs-toggle="dropdown" aria-expanded="false">
          	<img alt="User_profile" src="images/User_profile.jpg" width="30" height="30" style="border-radius: 100%" >
      		<span style="font-weight: bold;">NicName</span>
          </a>
          <ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
            <li><a class="dropdown-item" href="#">참여 중 계획목록</a></li>
            <li><hr class="dropdown-divider"></li>  분할 줄 
            <li><a class="dropdown-item" href="#">Logout</a></li>
          </ul>
        </li>
      </ul>
     </div>
      --> 
  
  <div class="d-flex gap-5 justify-content-center">
  	<ul class="nav navbar-nav navbar-right justify-content-end" id="rightMenu">
  		<!-- 알림 아이콘  -->
  		  <!-- <li class="nav-item"> -->
      <li class="nav-item dropdown dropstart">
          <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink1" role="button" data-bs-toggle="dropdown" data-bs-auto-close="false" aria-expanded="false">
          <i class="bi bi-bell"></i>
          </a>
           <ul class="dropdown-menu align-items-stretch  rounded-3 shadow-lg w-400px" aria-labelledby="navbarDropdownMenuLink1">
              <li><a class="dropdown-item rounded-2 d-flex" href="#" >
                    <div class="toast " role="alert"  aria-atomic="true" aria-live="assertive" data-bs-autohide="false"  >
                   <div class="toast-header">
                     <i class="bi bi-info-circle" style="color:#48AFB4; font-size: 20px;"></i><!-- 아이콘 -->
                     <strong class="me-auto">&nbsp;&nbsp;대구공항으로 모여랏</strong><!-- 방 제목  -->
                     <small class="text-muted">just now</small><!-- 알림이 언제왔는지. --> 
                     <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
                   </div>
                   <div class="toast-body">
                     방장이 7월 27일에 패스를 눌렀습니다.
                   </div>
                 </div></a></li>
                 </ul>
                 </li>

        <!-- 북마크 아이콘 -->
       <!--  <li class="nav-item">
            <a class="nav-link"><i class="bi bi-bookmark"></i></a>
        </li> -->
         <!-- 로그아웃 / 참여 중 계획목록 드롭다운 -->
         <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-bs-toggle="dropdown" aria-expanded="false">
          	<img alt="User_profile" src="<%=photo %>" width="30" height="30" style="border-radius: 100%" >
      		<span style="font-weight: bold;"><%=nikname %></span>
          </a>
	  		<ul class="dropdown-menu gap-1 p-2 rounded-3 mx-0 shadow w-220px" aria-labelledby="navbarDropdownMenuLink">
	    		<li><a class="dropdown-item rounded-2" href="mypage1.action">마이페이지</a></li>
	   	   	 	<li><hr class="dropdown-divider"></li> <!-- 분할 줄 -->
	        	<li><a class="dropdown-item rounded-2" href="logout.action">Logout</a></li>
	  		</ul>
  		</li>
  	</ul>
  </div>
      
      
  </div><!-- /.container-fluid -->
</nav>


</body>
</html>