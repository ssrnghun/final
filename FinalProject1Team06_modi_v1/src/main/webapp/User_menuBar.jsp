<%@page import="com.final1.logic.RoomMemberDTO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.final1.util.DBConn"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
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
          <div class="collapse navbar-collapse justify-content-end px-3 py-2" >
					<ul class="nav navbar-nav">
						<li class="nav-item dropdown dropstart ">
						<a class="nav-link dropdown-toggle  position-relative" href="#"
							id="navbarDropdownMenuLink1" role="button"
							data-bs-toggle="dropdown" data-bs-auto-close="false"
							aria-expanded="false">
							<svg width="20" height="22" viewBox="0 0 20 22" fill="none" xmlns="http://www.w3.org/2000/svg">
			                  <path fill-rule="evenodd" clip-rule="evenodd" d="M5.05033 2.05025C6.36309 0.737498 8.14356 0 10.0001 0C11.8566 0 13.6371 0.737498 14.9498 2.05025C16.2626 3.36301 17.0001 5.14349 17.0001 7C17.0001 10.3527 17.7171 12.4346 18.378 13.6461C18.7098 14.2544 19.0329 14.6535 19.2573 14.8904C19.3698 15.0091 19.4581 15.0878 19.5114 15.1322C19.538 15.1544 19.5558 15.168 19.5635 15.1737C19.5647 15.1746 19.5657 15.1753 19.5664 15.1758C19.9249 15.4221 20.0835 15.8725 19.9572 16.2898C19.8295 16.7115 19.4407 17 19.0001 17H1.00008C0.559411 17 0.170684 16.7115 0.0429858 16.2898C-0.0833568 15.8725 0.0752824 15.4221 0.433767 15.1758C0.434469 15.1753 0.435424 15.1746 0.436625 15.1737C0.444325 15.168 0.462178 15.1544 0.4888 15.1322C0.542016 15.0878 0.6304 15.0091 0.742875 14.8904C0.967304 14.6535 1.29039 14.2544 1.62218 13.6461C2.28301 12.4346 3.00008 10.3527 3.00008 7C3.00008 5.14348 3.73758 3.36301 5.05033 2.05025ZM0.443875 15.169C0.443954 15.1689 0.444033 15.1688 0.444112 15.1688C0.444107 15.1688 0.444103 15.1688 0.444099 15.1688L0.443875 15.169ZM3.1494 15H16.8508C16.7747 14.8753 16.6983 14.7434 16.6222 14.6039C15.783 13.0654 15.0001 10.6473 15.0001 7C15.0001 5.67392 14.4733 4.40215 13.5356 3.46447C12.5979 2.52678 11.3262 2 10.0001 2C8.674 2 7.40223 2.52678 6.46454 3.46447C5.52686 4.40215 5.00008 5.67392 5.00008 7C5.00008 10.6473 4.21715 13.0654 3.37797 14.6039C3.30188 14.7434 3.22549 14.8753 3.1494 15ZM7.76831 19.135C8.24603 18.8579 8.85796 19.0205 9.13508 19.4982C9.22298 19.6498 9.34916 19.7756 9.50097 19.863C9.65277 19.9504 9.82489 19.9965 10.0001 19.9965C10.1753 19.9965 10.3474 19.9504 10.4992 19.863C10.651 19.7756 10.7772 19.6498 10.8651 19.4982C11.1422 19.0205 11.7541 18.8579 12.2318 19.135C12.7096 19.4121 12.8722 20.024 12.5951 20.5018C12.3314 20.9564 11.9528 21.3337 11.4974 21.5961C11.042 21.8584 10.5256 21.9965 10.0001 21.9965C9.47451 21.9965 8.95816 21.8584 8.50274 21.5961C8.04731 21.3337 7.66879 20.9564 7.40508 20.5018C7.12796 20.024 7.29058 19.4121 7.76831 19.135Z" fill="#101828"/>
			               </svg>
			                <span class="position-absolute top-10 start-80 translate-middle badge rounded-pill bg-danger">
							    ${alarmCount }
						    <span class="visually-hidden">????</span>
						  </span>
						</a>
							<ul class="dropdown-menu align-items-stretch  rounded-3 shadow-lg w-600px"
								aria-labelledby="navbarDropdownMenuLink1" style="overflow-y: scroll; height: 300px;">
								<c:forEach var="alarm" items="${alarmList }">
								<li><div class=" rounded-2 d-flex p-2"  style="text-decoration: none; ">
										<div class="toast " role="alert" aria-atomic="true"
											aria-live="assertive" data-bs-autohide="false">
											<div class="toast-header">
												<c:if test = "${fn:contains(alarm.title, '신고')}">
													<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16" fill="none">
													  <g clip-path="url(#clip0_280_5777)">
													    <path d="M7.9987 5.33398V8.00065M7.9987 10.6673H8.00536M14.6654 8.00065C14.6654 11.6826 11.6806 14.6673 7.9987 14.6673C4.3168 14.6673 1.33203 11.6826 1.33203 8.00065C1.33203 4.31875 4.3168 1.33398 7.9987 1.33398C11.6806 1.33398 14.6654 4.31875 14.6654 8.00065Z" stroke="#B22729" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
													  </g>
													  <defs>
													    <clipPath id="clip0_280_5777">
													      <rect width="16" height="16" fill="white"/>
													    </clipPath>
													  </defs>
													</svg>
												</c:if> 
											<c:if test = "${not fn:contains(alarm.title, '신고')}">
												<i class="bi bi-info-circle"style="color: #48AFB4; font-size: 20px;"></i>
											</c:if> 
													
												<!-- 아이콘 -->
												<span class="me-auto" style="font-weight: bold" >&nbsp;&nbsp;${alarm.title }</span>
												<!-- 방 제목  -->
												<small class="text-muted">${alarm.alarmDate }</small>
												<!-- 알림이 언제왔는지. -->
												<button type="button" class="btn-close alarmDel" id="${alarm.num }/${alarm.title }"
													data-bs-dismiss="toast" aria-label="Close" ></button>
											</div>
											<div class="toast-body">
											<c:if test="${alarm.roomTitle !=' '}">
												 <div style="font-weight: bold"> <i class="bi bi-house-fill"></i> ${alarm.roomTitle }</div>
											</c:if>
											
												<span id="alarmContext" style="font-size: 15px"> <i class="bi bi-arrow-return-right"></i> ${alarm.alarmContent }
												</span>
											</div>
										</div>
								</div>
								</li>
								</c:forEach>
							</ul>
							</li>
					</ul>
				</div>

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