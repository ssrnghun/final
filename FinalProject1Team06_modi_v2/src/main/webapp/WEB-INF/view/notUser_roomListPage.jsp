<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>notUser_roomListPage.jsp</title>

<!-- jQuery  -->
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>

<!-- bootstrap 소스 넣기 (bootstrap v5.0 버전)  --> <!-- include 된 곳에서 끌어다쓰고 있다.  -->


<!-- icon 부트스트랩 신버전 소스  -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">

<!-- 모달창 스크립트  -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>  
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.1/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>


<style type="text/css">
	
	#background_img { 
		background-image: url("images/korea.jpg");
		background-position: center top;	
	}
	
	h1 { 
		color: white;
	 }
	 
	.search {
	  position: relative;
	  width: 800px;
	  
	}
	
	input {
	  width: 100%;
	  border: none; 
	  border-radius: 45px;
	  padding: 10px 12px;
	  font-size: 14px;
	  height: 60px;
	  text-align: center;
	  overflow: auto;
	  font-size: 100px;
	}
	
	#trip_search {
		border-radius: 45px;
		color : black; 		
	}
	
	#btn_title {
		position: absolute;
		margin: 0;
		background-color: #FF9966;
		top : 10px;
		left: 25px;
		width: 80px;
		height: 40px;
		border-radius: 45px;
	}
	
	.bi-funnel-fill:hover {
		color: #49AFB4;
	}
	
	#btn_make {
		border-radius: 45px;
		font-weight: bold;
		width : 150px; 
		height: 40px;
		border: solid 2px #E5E5E5;
		background-color: white;
	}
	
	#btn_make:hover {
		font-weight: bold;
		width: 152px;
		height: 43px;
		background-color: #FBBF66;
	}
	
	#btn_div_make {
		top: 0;
		right : 50px;
	}
	
	#regionBtn:hover {
		font-weight: bold;
		width: 60px;
		height: 40px;
	}
	
	#budget:hover {
		font-weight: bold;
		width: 60px;
		height: 40px;
	}
	
	.bi-search {
	  position : absolute;
	  width: 17px;
	  top: 5px;
	  right: 50px;
	  margin: 0;
	  color: #B4B4B4;
	  font-size: 30px;
	}
	
	.bi-funnel-fill {
	  color: #B4B4B4;
	  font-size: 30px;
	}
	
	.bi-search:hover {
  		 color : #FF9966;
  	}
  	
  	.search_box:focus {outline: 2px solid #FFB895;}
	
	/* 부트스트랩 리스트 스타일 */
	
      .bd-placeholder-img {
        font-size: 1.125rem;
        text-anchor: middle;
        -webkit-user-select: none;
        -moz-user-select: none;
        user-select: none;
      }

      @media (min-width: 768px) {
        .bd-placeholder-img-lg {
          font-size: 3.5rem;
        }
      }

      .b-example-divider {
        height: 3rem;
        background-color: rgba(0, 0, 0, .1);
        border: solid rgba(0, 0, 0, .15);
        border-width: 1px 0;
        box-shadow: inset 0 .5em 1.5em rgba(0, 0, 0, .1), inset 0 .125em .5em rgba(0, 0, 0, .15);
      }

      .b-example-vr {
        flex-shrink: 0;
        width: 1.5rem;
        height: 100vh;
      }

      .bi {
        vertical-align: -.125em;
        fill: currentColor;
      }

      .nav-scroller {
        position: relative;
        z-index: 2;
        height: 2.75rem;
        overflow-y: hidden;
      }

      .nav-scroller .nav {
        display: flex;
        flex-wrap: nowrap;
        padding-bottom: 1rem;
        margin-top: -1px;
        overflow-x: auto;
        text-align: center;
        white-space: nowrap;
        -webkit-overflow-scrolling: touch;
      }
	
	.city
	{
	   margin-top: 5px;
	   vertical-align: center;
	}
	
	.roomList:hover
	{	
		color : #FF9966;
	}
	.pagination-container 
	{
  		text-align: center;
	}

	.pagination .page-item.active .page-link 
	{
	  	background-color: #e5e5e5;
	  	border-color: #e5e5e5; 
	}
	
	#roomListPage
	{
		overflow-y: scroll; 
		height: 800px;
		width: 1000px;
	}
	
	
	

</style>

<script type="text/javascript">
	
	// 룸리스트 클릭 시 로그인 으로 이동하는 알림창 띄우기
	function loginCheck()
	{	
		var req = confirm(" 회원 서비스입니다.\n 로그인 하시겠습니까?");
		
		if (req)
		{
			location.href = "loginform.action";
		}
	}
	
	// 예산 선택 시 범위 조정하는 함수 
	function select(obj)
	{
	   var budgetMinValue = obj.value;
	   //alert(budgetMinValue);
	   var budgetMax = document.getElementById("budgetMax");
	   var budgetOption = budgetMin.value;
	   
	   budgetMax.innerHTML = "";
	   
	   for (var i = parseInt(budgetMinValue); i <= 10; i++)
	   {
	      var option = document.createElement("option");
	      option.value = i;
	      option.text = (i*100000).toLocaleString('ko-KR');
	      budgetMax.add(option);
	   }
	   
	}
	
	// 지역 입력하지 않은 채 검색 버튼 누를경우 (ajax 로 요청보내기전 확인하는 함수) 
	function showRequest()
	{
		if (!$.trim($("#trip_search").val()))  
		{
			alert("지역을 입력해주세요.");
			$("#trip_search").focus();
			
			return false; 
		}
		
		return true;
	}
	
	
	// 페이지가 로드될 때 캘린더 기존옵션 설정
	function searchDate()
	{	
		// 현재 날짜
		var today = new Date();
		
		// 현재 날짜를 startDate 에 넣는 구문
		//document.getElementById("search_startDate").valueAsDate = today;
		startDate = document.getElementById("search_startDate");
		// 여행시작일 최소 날짜 제한 		
		startDate.setAttribute("min", startDate.value);
		
		// 여행종료일 기본옵션 
		//document.getElementById("search_endDate").value = startDate.value;
		
		// 처음 로드 될때 여행 종료일이 여행시작일로 최소 날짜 제한
		endDate = document.getElementById("search_endDate");
		endDate.setAttribute("min", startDate.value);
		
		
		var startDateVal = new Date(startDate.value);
		var maxEndDate = new Date(endDate.value);
		//alert("날짜지정중 : " + maxEndDate);
		var maxMax = maxEndDate.setDate(startDateVal.getDate() + 30);
		//alert("최대날짜제한중 : " + maxMax);    //  1693958400000
		var timeOffMax = new Date(endDate.value).getTimezoneOffset()*60000;  // -32400000
		//alert("최대시간과의 차이를 분 단위로 반환 : " + timeOffMax);
		if (startDate.value != "")
		{
			var max = new Date(maxMax-timeOffMax).toISOString().substring(0, 10);
		}
		//alert("최대날짜 구하기1 : " + max); // 2023-09-06 
		
		// 여행 종료일에 최대 범위 구한 값 넣어주기
		endDate.setAttribute("max", max);
		
	}
	
	// 여행 시작일 일정이 change 버튼눌렸을 경우 
	function startChange()
	{	
		
		// 여행종료일 변수설정
		var endFirstDate = document.getElementById("search_endDate").value
		
		// 여행종료일이 여행시작일보다 작거나 같을 경우	
		if (endFirstDate <= startDate.value)
		{	
			// 여행종료일 최소값에 여행시작일의 value 값을 넣어준다.
			endFirstDate = startDate.value;
			endDate.setAttribute("min", endFirstDate);
			
			
			var startDateVal = new Date(startDate.value);
			var maxEndDate = new Date(endDate.value);
			//alert("날짜지정중 : " + maxEndDate);
			var maxMax = maxEndDate.setDate(startDateVal.getDate() + 30);
			//alert("최대날짜제한중 : " + maxMax);    //  1693958400000
			var timeOffMax = new Date(endDate.value).getTimezoneOffset()*60000;  // -32400000
			//alert("최대시간과의 차이를 분 단위로 반환 : " + timeOffMax);
			var max = new Date(maxMax-timeOffMax).toISOString().substring(0, 10);
			
			//alert("여행종료일 최대 범위2 : " + max);
			endDate.setAttribute("max", max);
			
		}
		else
		{
			// 여행 시작일에 맞춰 최소범위 조절
			endDate.setAttribute("min", startDate.value);
			
			var startDateVal = new Date(startDate.value);
			var maxEndDate = new Date(endDate.value);
			//alert("날짜지정중 : " + maxEndDate);
			var maxMax = maxEndDate.setDate(startDateVal.getDate()+30);
			//alert("최대날짜제한중 : " + maxMax);    //  1693958400000
			var timeOffMax = new Date(endDate.value).getTimezoneOffset()*60000;  // -32400000
			//alert("최대시간과의 차이를 분 단위로 반환 : " + timeOffMax);
			var max = new Date(maxMax-timeOffMax).toISOString().substring(0, 10);
			
			//alert("여행종료일 최대 범위3 : " + max);
			endDate.setAttribute("max", max);
		}
		
	}
	
</script>



<script type="text/javascript">
	$(function()
	{	
		// 툴팁 
		$('[data-toggle="tooltip"]').tooltip();
		
		
	    /* 모달창이 클릭되었을 때 스크롤 되지 않게 하는 기능  */
	    // → 상세히 설명하자면, 새로고침되지 않게 하는 기능이다.
	    $('#btnStyle').click(function()
		{
			event.preventDefault();
		});
	    
	    /* 예산 글자 범위에 대해서 글자 조정을 위한 CSS 기능 */
	    $('#budgetApply').click(function()
        {
	         if($("#budgetMin").val()=='0' && $("#budgetMax").val()=='0')
	         {
	            //$("#budget").text((parseInt($("#budgetMin").val())*10)+"~"+(parseInt($("#budgetMax").val())*10));
	            $("#budget").text("예산");
	         }
	         else if($("#budgetMin").val()=='0' && $("#budgetMax").val()!='0')
	         {
	            $("#budget").text((parseInt($("#budgetMin").val())*10)+"~"+(parseInt($("#budgetMax").val())*10)+"만");
	         }
	         else
	         {
	            $("#budget").text((parseInt($("#budgetMin").val())*10)+"만~"+(parseInt($("#budgetMax").val())*10)+"만");
	         }
        });
	         
	    
	    /* 지역내 기초자치단체 검색 되는 기능 구현  */
	    $('#InRegionSearch').click(function()
		{
			//  검색창에 입력한 value값 확인하기 
			var region = $.trim($("#trip_search").val());
			
			alert(region);
			
			$.ajax(
	    			{
	    				type:"GET" 					
	    				, url: "regionsearch.action" 		
	    				, data: 
	    				{
	    				 	tripSearch: region,
	    				}
	    				, success:function(response)
	    				{	
	    					console.log(response);
	    					$("#regionResult").html(response);
	    					
	    					$("#trip_search").val("");
	    					$("#trip_search").focus();
	    					
	    				}  
	    				, beforeSend:showRequest 
	    				, error:function(e)
	    				{
	    					console.log(e.responseText); 
	    				}			
	    			});
			
	    	
		});
	    
	    
	    // 지역검색 내의 선택버튼을 눌렀을 때의 기능 구현 
	    $('#regionSelect').click(function()
   		{
   	    	// 자신이 검색하거나, 추천지로 있는 지역 버튼을 누른 것의 지역텍스트를 가져옴
   	    	result = $(':radio[name=options-outlined]:checked').next().text();
   			
   			// 지역 버튼을 누르지않고 선택버튼을 눌렀을 경우 
   			if (result == "")
   				alert("지역을 선택해주세요.");
   			else // 그게 아니라면, 
   			{	
   				// 모달창 닫기 
   				$('#regionSearch').modal("hide");
   				// 지역검색 버튼을 사용자가 선택한 지역으로 변경
   				$('#regionBtn').text(result);
   			}
   			
   		});
	    
	    
	    // 방 개설일, 여행시작일 순 정렬을 위한 기능 구현
		$("#sort").change(function()
		{
			var sort = ($("#sort").val());
			
			// 새로고침하는 방향으로 시도
			$(location).attr("href","not_roomlist.action?sort="+sort);
			
		});
	    
	    
	    
	    // 여행스타일 검색버튼을 눌렀을 때
	    $("#styleSearch").click(function()
		{	
	    	// 여행 스타일 옵션 value 값 가져오기 
			var plan = $("input[name=planRadio]:checked").val();
			var pay = $("input[name=payRadio]:checked").val();
			var stay = $("input[name=stayRadio]:checked").val();
			var tfc = $("input[name=trafficRadio]:checked").val();
			var cycle = $("input[name=cycleRadio]:checked").val();
			var face = $("input[name=faceRadio]:checked").val();
			var trip = $("input[name=tripLocRadio]:checked").val();
			var toDo = $("input[name=toDoRadio]:checked").val();
			var toSee= $("input[name=toSeeRadio]:checked").val();
			var food = $("input[name=foodRadio]:checked").val();
			var meal = $("input[name=mealCountRadio]:checked").val();
			var supply = $("input[name=supplyRadio]:checked").val();
			var photo = $("input[name=photoRadio]:checked").val();
			
			// 여행 스타일 개수 세기 위한 변수설정
			var i = 1;
			var sum = 0;
			
			
			// 각 항목마다 무관이 아닐때만 누적 
			if (plan != 4)
				sum += i;
			if (pay != 4)
				sum += i;
			if (stay != 5)
				sum += i;
			if (tfc != 4)
				sum += i;
			if (cycle != 3)
				sum += i;
			if (face != 3)
				sum += i;
			if (trip != 5)
				sum += i;
			if (toDo != 7)
				sum += i;
			if (toSee != 5)
				sum += i;
			if (food != 5)
				sum += i;
			if (meal != 4)
				sum += i;
			if (supply != 4)
				sum += i;
			if (photo != 4)
				sum += i;
			
			// html 단에 출력
			$("#filterCount").html(sum);
			
			// 모달창 닫기 
			$('#tripStyleSearch').modal("hide");
			
		});
	    
	    
		// 총 검색	 
	    $(".bi-search").click(function()
		{	
	    	
	    	// 제목 검색창 텍스트 
	    	var title = $("#titleSearch").val();
	    	
			// 지역검색 - 지역 번호 
			var regionNum = $(":radio[name=options-outlined]:checked").attr("id");
			if (regionNum == undefined)
				regionNum = 0;		
						
			// 예산검색 - 예약 옵션 번호 양쪽
			var budgetMin = ($("#budgetMin").val()) * 100000;
			var budgetMax = ($("#budgetMax").val()) * 100000;
			
			// 성별검색
			var gender = $("#genderOnOff").val();
			
			// 연령검색
			var age = $("#ageOnOff").val();
			
			// 방 공개 여부 검색 
			var roomOnOff = $("#roomOnOff").val();    // YES, NO --> pw_code 와 비교 
			
			// 계획 참여여부 검색
			var planOnOff = $("#planOnOff").val();
			
			// 일정 검색
			var startDate = $("#search_startDate").val();
			
			var endDate = $("#search_endDate").val();
			
			// 여행 스타일 검색 - 사용자가 선택한 옵션 
			var plan = $("input[name=planRadio]:checked").val();
			var pay = $("input[name=payRadio]:checked").val();
			var stay = $("input[name=stayRadio]:checked").val();
			var tfc = $("input[name=trafficRadio]:checked").val();
			var cycle = $("input[name=cycleRadio]:checked").val();
			var face = $("input[name=faceRadio]:checked").val();
			var trip = $("input[name=tripLocRadio]:checked").val();
			var toDo = $("input[name=toDoRadio]:checked").val();
			var toSee= $("input[name=toSeeRadio]:checked").val();
			var food = $("input[name=foodRadio]:checked").val();
			var meal = $("input[name=mealCountRadio]:checked").val();
			var supply = $("input[name=supplyRadio]:checked").val();
			var photo = $("input[name=photoRadio]:checked").val();
			
			$(location).attr("href","not_roomlist.action?room_title="+title+
							"&region_num="+regionNum+"&budget_min="+budgetMin+"&budget_max="+budgetMax+
							"&gender_limit_num="+gender+"&age_limit_num="+age+"&trip_start_date="+startDate+
							"&trip_end_date="+endDate+"&plan_onoff_num="+planOnOff+"&room_onoff_name="+roomOnOff+
							"&plan_num="+plan+"&money_option_num="+pay+"&stay_type_num="+stay+"&traffic_num="+tfc+
							"&cycle_num="+cycle+"&pace_num="+face+"&desti_type_num="+trip+"&to_do_num="+toDo+
							"&to_see_num="+toSee+"&food_num="+food+"&meal_count_num="+meal+"&supply_num="+supply+"&photo_num="+photo);
	    	
		});
	});
	


</script>

 <!-- Custom styles for this template -->
<link href="css/list-groups.css" rel="stylesheet">

</head>
<body onload="searchDate()">

	<!-- 메뉴바 include  -->
	<nav>
		<jsp:include page="notUser_menuBar.jsp"></jsp:include>
	</nav>
	
  
	<main>
	
	
   <!-- <form action="room_search.action" method="get"> -->
	<div class="position-relative">
		<div class="position-relative overflow-hidden p-3 p-md-5 m-md-3 text-center bg-light shadow" id="background_img">
	    <div class="col-md-5 p-lg-5 mx-auto my-5">
	    
	    <!-- 페이지 명 -->
	      <h1 class="display-4 fw-normal">
	      	<a class="roomList" href="not_roomlist.action" style="text-decoration-line: none; font-weight: bold;">ROOM LIST</a>
	      </h1>
	    </div>
	    <div class="product-device shadow-sm d-none d-md-block"></div>
	    <div class="product-device product-de vice-2 shadow-sm d-none d-md-block"></div>
	  </div>
	
	    
	    
	  <!-- 검색창  -->
	   <div class="position-absolute top-100 start-50 translate-middle">
		    <div class="search">
			  <input type="text" class="search_box shadow" id="titleSearch">	
			  <button type="button" class="btn btn-md shadow" id="btn_title">
			  	<span style="color: white;">제목</span>
			  </button>
			  <button type="submit" class="bi bi-search" style="background-color:transparent; border: none;"></button>
			</div>
	    </div>
	 </div>
	
	
	
	<!-- 지역검색부터 여행스타일 필터  -->
	<div class="d-flex justify-content-center" id="filter">
		
		<div class="row gap-3">
		
		<div class="col-md-1 mt-4" style="margin-left:0px; padding: 0;">
	           <!-- 지역검색 -->
				<button type="button" class="btn w-auto shadow-sm" style="background-color: #FF9966; color: white; border-radius: 45px;" 
				data-toggle="modal" data-target="#regionSearch" id="regionBtn">
					지역검색
				</button>


	           <!-- 지역검색 모달창 -->
					<div class="modal" id="regionSearch" tabindex="-1" role="dialog">
					  <div class="modal-dialog modal-dialog-centered" role="document">
					    <div class="modal-content">
					      <div class="modal-body">
					      <div class="input-group">
					         <input type="text" name="search" class="form-control" placeholder="어디로 여행을 떠나시나요?" id="trip_search">
					      <div class="input-group-append">
					              <input type="button" class="btn btn-default" id="InRegionSearch" value="검색">
					      </div>
					   	  </div><!-- .input-group  -->
					   <br>
					   <span>인기 여행지</span><br>
					   
						   <input type="radio" class="btn-check" name="options-outlined" id="2" autocomplete="off" >
						   <label class="btn btn-outline-success" for="2">부산광역시</label>
						     <input type="radio" class="btn-check" name="options-outlined" id="169" autocomplete="off" >
						   <label class="btn btn-outline-success" for="169">제주특별자치도</label>
						     <input type="radio" class="btn-check" name="options-outlined" id="129" autocomplete="off" >
						   <label class="btn btn-outline-success" for="129">경주시</label>
						     <input type="radio" class="btn-check" name="options-outlined" id="151" autocomplete="off" >
						   <label class="btn btn-outline-success" for="151">양양군</label>
						     <input type="radio" class="btn-check" name="options-outlined" id="163" autocomplete="off" >
						   <label class="btn btn-outline-success" for="163">속초시</label>
						     <input type="radio" class="btn-check" name="options-outlined" id="166" autocomplete="off" >
						   <label class="btn btn-outline-success" for="166">강릉시</label>
						       <br><br>
						    <span>검색 결과</span><br>
						     <div id = "regionResult"></div> 
						      
							    <div class="modal-footer">
							      <button type="button" class="btn btn-primary" id="regionSelect" data-dismiss="modal">선택</button>
					      		</div>
					    	</div><!--.modal-body  -->
						  </div><!--.modal-content  -->
						</div><!-- .modal-dialog  -->
					</div><!--.modal  -->
	         </div><!-- region div  -->
		
		
		
			 <!-- 예산 검색 -->		
	         <div class="col-md-1 mt-4 d-flex justify-content-center" >
             <ul style="padding: 0" >
            
               <button type="button" class="btn w-5 h-5 " style="background-color: #FF9966; color: white; 
               border-radius: 45px;" data-bs-toggle="dropdown" aria-expanded="false" id="budget">
               예산
               </button>
                 <ul class="dropdown-menu align-items-stretch rounded-3 w-200px budgetMenu">
                    <li class="nav-item d-flex">
                       <a class="dropdown-item rounded-2 d-flex" href="#" >
                       <div class="row">
                          <div class="col-md-5 text-center" style="padding: 0">
                             최소 금액
                             <select class="form-select d-block shadow-sm text-end w-auto" id="budgetMin" onchange="select(this)">
                                <c:forEach var="i" step="1" begin="0" end="10">
                                   <option value="${i }"><fmt:formatNumber value="${i*100000 }" /></option>
                                </c:forEach>
                            </select>
                          </div>
                          <div class="col-md-2">
                          ~
                          </div>
                          <div class="col-md-5 text-center" style="padding: 0">
                              최대 금액
                            <select class="form-select d-block shadow-sm text-end w-auto" id="budgetMax">
                                <c:forEach var="i" step="100000" begin="0" end="1000000">
                                   <option value="${i }"><fmt:formatNumber value="${i }" /></option>
                                </c:forEach>
                            </select>
                       	  </div>
                      </div>
                     </a>
                    </li>
                    <li class="d-inline-flex">
                       <a class="dropdown-item rounded-2 d-inline-flex float-end mt-3" href="#" >
                          <button type="button" class="btn float-end" id="budgetApply" 
                          style="background-color: #FF9966; color: white; border-radius: 45px">
                          적용
                          </button>
                       </a>
                    </li>
              	</ul>
              </ul>
            </div>
	         
			<div class="col-md-1 mt-4">
	           <select class="form-select d-block w-auto shadow-sm" id="genderOnOff" 
	           style="border-radius: 45px;">
	               <option value="0">성별검색</option>
	               <option value="1">동일성별</option>
	               <option value="2">성별무관</option>
	             </select>
	         </div>
	
	         <div class="col-md-1 mt-4" style="margin-right: 20px;">
	           <select class="form-select d-block w-auto shadow-sm" id="ageOnOff"
	           style="border-radius: 45px;">
	               <option value="0">연령검색</option>
	               <option value="1">유사연령대</option>
	               <option value="2">연령무관</option>
	           </select>
	         </div>
	         
	         
	         
	         <!-- 방 공개여부  -->
	         <div class="col-md-1 mt-4" style="margin-right: 20px;">
	           <select class="form-select d-block w-auto shadow-sm" id="roomOnOff"
	           style="border-radius: 45px;">
	               <option value="0">방 공개여부</option>
	               <option value="YES">비공개방</option>
	               <option value="NO">공개방</option>
	           </select>
	         </div>
	         
	         <!-- 계획참여여부  -->
	         <div class="col-md-1 mt-4" style="margin-right: 20px;">
	           <select class="form-select d-block w-auto shadow-sm" id="planOnOff"
	           style="border-radius: 45px;">
	               <option value="0">계획 참여여부</option>
	               <option value="1">계획공유방</option>
	               <option value="2">계획전달방</option>
	           </select>
	         </div>
	         
	         <!-- 일정 -->
	         <div class="col-md-1 mt-4 ms-3 w-auto">
		          <div class="row">
			           <div class="col-md-6">
				           <input type="date" class="form-control shadow-sm" data-toggle="tooltip" title="여행시작일" 
				           id="search_startDate" aria-required="true" 
				           value="" onChange="startChange()" style="width: 150px; height: 40px;">
			           </div> 
			           
			           <div class="col-md-6">
			           <input type="date" class="form-control shadow-sm" data-toggle="tooltip" title="여행종료일" 
			           id="search_endDate" aria-required="true" 
			           value="" onChange="" style="width: 150px; height: 40px;">
			         </div>            
			           </div>   
	         </div>
	        
	       <!--  </form>    -->
	         
			<!-- 여행 필터 -->
			<div class="col-md-1 mt-4 w-auto">
				<a class="btn" data-bs-toggle="modal" href="#tripStyleSearch" role="button">
					<div class="position-relative">
						<i class="bi bi-funnel-fill "></i>
						 <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill"
						 style="background-color: #FF9966;">
						 	<!--  여행스타일 옵션 선택 개수 출력 코드  -->
						     <span id="filterCount">0</span>
						  </span>
					</div>
				</a>
			</div>
		</div>
	</div>
	
		 
	<!-- 첫번째 모달창 -->
	<div class="modal fade" id="tripStyleSearch" aria-hidden="true" aria-labelledby="tripStyleSearch_Label" tabindex="-1">
	  <div class="modal-dialog modal-dialog-scrollable modal-lg">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h1 class="modal-title fs-3" id="tripStyleSearch_Label" style="color: black; font-weight: bold;" data-dismiss= "modal">여행스타일 검색</h1>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
				<!-- 계획 -->
				<div>
					<div class="plan">
						<h5 style="font-weight: bold;">계획</h5>
					</div>
					
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="planRadio" id="perfectPlan" value="1">
					  <label class="form-check-label" for="perfectPlan">완벽한 계획</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="planRadio" id="roughPlan" value="2">
					  <label class="form-check-label" for="roughPlan">대략적인 계획</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="planRadio" id="noPlan" value="3">
					  <label class="form-check-label" for="noPlan">계획 없음</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="planRadio" id="unPlan" value="4" checked="checked">
					  <label class="form-check-label" for="unPlan">무관</label>
					</div>
				</div>	
				
				<br>
				<!-- 경비 -->
				
				<div>
					<div class="pay">
						<h5 style="font-weight: bold;">경비</h5>
					</div>
					
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="payRadio" id="dutchPay" value="1">
					  <label class="form-check-label" for="dutchPay">N분의 1</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="payRadio" id="eachPay" value="2">
					  <label class="form-check-label" for="eachPay">각자 계산</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="payRadio" id="afterPay" value="3">
					  <label class="form-check-label" for="afterPay">후청구</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="payRadio" id="unPay" value="4" checked="checked">
					  <label class="form-check-label" for="unPay">무관</label>
					</div>
				</div>	
				
				
				<br>
				<!-- 숙소형태  -->
				
				<div>
					<div class="stay">
						<h5 style="font-weight: bold;">숙소형태</h5>
					</div>
					
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="stayRadio" id="resortStay" value="1">
					  <label class="form-check-label" for="resortStay">리조트</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="stayRadio" id="hotelStay" value="2">
					  <label class="form-check-label" for="hotelStay">호텔</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="stayRadio" id="youthStay" value="3">
					  <label class="form-check-label" for="youthStay">호스텔 </label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="stayRadio" id="homeStay" value="4">
					  <label class="form-check-label" for="homeStay">민박</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="stayRadio" id="unStay" value="5" checked="checked">
					  <label class="form-check-label" for="unStay">무관</label>
					</div>
				</div>	
				
				<br>
				<!-- 교통 -->
				
				<div>
					<div class="traffic">
						<h5 style="font-weight: bold;">교통</h5>
					</div>
					
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="trafficRadio" id="rentTraffic" value="1">
					  <label class="form-check-label" for="rentTraffic">렌트</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="trafficRadio" id="walkTraffic" value="2">
					  <label class="form-check-label" for="walkTraffic">뚜벅이 선호</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="trafficRadio" id="publicTraffic" value="3">
					  <label class="form-check-label" for="publicTraffic">대중교통(택시포함)</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="trafficRadio" id="unTraffic" value="4" checked="checked">
					  <label class="form-check-label" for="unTraffic">무관</label>
					</div>
				</div>	
				
				<br>
				<!-- 사이클  -->
				<div>
					<div class="cycle">
						<h5 style="font-weight: bold;">사이클</h5>
					</div>
					
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="cycleRadio" id="lateCycle" value="1">
					  <label class="form-check-label" for="lazyCycle">늦은취침,늦은기상</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="cycleRadio" id="earlyCycle" value="2">
					  <label class="form-check-label" for="fastCycle">이른취침,이른기상</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="cycleRadio" id="unCycle" value="3" checked="checked">
					  <label class="form-check-label" for="unCycle">무관</label>
					</div>
				</div>	
				
				<br>
				<!--속도  -->
				<div>
					<div class="face">
						<h5 style="font-weight: bold;">속도</h5>
					</div>
					
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="faceRadio" id="slowFace" value="1">
					  <label class="form-check-label" for="slowFace">느긋함 선호</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="faceRadio" id="tightFace" value="2">
					  <label class="form-check-label" for="tightFace">촘촘한 일정 선호</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="faceRadio" id="unFace" value="3" checked="checked">
					  <label class="form-check-label" for="unFace">무관</label>
					</div>
				</div>	
				
				<br>
				<!-- 여행지 -->
				<div>
					<div class="tripLoc">
						<h5 style="font-weight: bold;">여행지</h5>
					</div>
					
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="tripLocRadio" id="natureTripLoc" value="1">
					  <label class="form-check-label" for="natureTripLoc">자연</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="tripLocRadio" id="cityTripLoc" value="2">
					  <label class="form-check-label" for="cityTripLoc">도시</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="tripLocRadio" id="restTripLoc" value="3">
					  <label class="form-check-label" for="restTripLoc">휴양지</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="tripLocRadio" id="historyTripLoc" value="4">
					  <label class="form-check-label" for="historyTripLoc">역사유적지</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="tripLocRadio" id="unTripLoc" value="5" checked="checked">
					  <label class="form-check-label" for="unTripLoc">무관</label>
					</div>
				</div>	
				
				
				<br>
				<!-- 할것  -->
				<div>
					<div class="toDo">
						<h5 style="font-weight: bold;">할 것</h5>
					</div>
					
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="toDoRadio" id="restToDo" value="1">
					  <label class="form-check-label" for="restToDo">휴식</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="toDoRadio" id="shoppingToDo" value="2">
					  <label class="form-check-label" for="shoppingToDo">쇼핑</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="toDoRadio" id="activityToDo" value="3">
					  <label class="form-check-label" for="activityToDo">액티비티</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="toDoRadio" id="movieToDo" value="4">
					  <label class="form-check-label" for="movieToDo">여행영상 촬영</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="toDoRadio" id="foodToDo" value="5">
					  <label class="form-check-label" for="foodToDo">맛집 탐방</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="toDoRadio" id="friendToDo" value="6">
					  <label class="form-check-label" for="friendToDo">새친구 만들기</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="toDoRadio" id="unToDo" value="7" checked="checked">
					  <label class="form-check-label" for="unToDo">무관</label>
					</div>
				</div>	
				
				<br>
				<!-- 볼것  -->
				<div>
					<div class="toSee">
						<h5 style="font-weight: bold;">볼 것</h5>
					</div>
					
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="toSeeRadio" id="historyToSee" value="1">
					  <label class="form-check-label" for="historyToSee">역사</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="toSeeRadio" id="artToSee" value="2">
					  <label class="form-check-label" for="artToSee">예술</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="toSeeRadio" id="cultureToSee" value="3">
					  <label class="form-check-label" for="cultureToSee">문화</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="toSeeRadio" id="naturalToSee" value="4">
					  <label class="form-check-label" for="naturalToSee">자연경관</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="toSeeRadio" id="unToSee" value="5" checked="checked">
					  <label class="form-check-label" for="unToSee">무관</label>
					</div>
				</div>	
				
				<br>
				<!-- 음식 -->
				<div>
					<div class="food">
						<h5 style="font-weight: bold;">음식점 선정기준</h5>
					</div>
					
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="foodRadio" id="koreaFood" value="1">
					  <label class="form-check-label" for="koreaFood">SNS맛집</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="foodRadio" id="localFood" value="2">
					  <label class="form-check-label" for="localFood">현지인맛집</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="foodRadio" id="regionFood" value="3">
					  <label class="form-check-label" for="regionFood">지역특산물위주</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="foodRadio" id="actFood" value="4">
					  <label class="form-check-label" for="actFood">즉흥적으로</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="foodRadio" id="unFood" value="5" checked="checked">
					  <label class="form-check-label" for="unFood">무관</label>
					</div>
				</div>	
				
				<br>
				<!-- 식사횟수  -->
				<div>
					<div class="mealCount">
						<h5 style="font-weight: bold;">식사 횟수</h5>
					</div>
					
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="mealCountRadio" id="oftenFoodCount" value="1">
					  <label class="form-check-label" for="oftenFoodCount">자주, 적게</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="mealCountRadio" id="onceFoodCount" value="2">
					  <label class="form-check-label" for="onceFoodCount">한번에 많이</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="mealCountRadio" id="dietFoodCount" value="3">
					  <label class="form-check-label" for="dietFoodCount">다이어트</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="mealCountRadio" id="unFoodCount" value="4" checked="checked">
					  <label class="form-check-label" for="unFoodCount">무관</label>
					</div>
				</div>
				
				
				<br>
				<!-- 준비물  -->	
				<div>
					<div class="supply">
						<h5 style="font-weight: bold;">준비물</h5>
					</div>
					
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="supplyRadio" id="allSupply" value="1">
					  <label class="form-check-label" for="allSupply">모두 챙김</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="supplyRadio" id="halfSupply" value="2">
					  <label class="form-check-label" for="halfSupply">반반</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="supplyRadio" id="localSupply" value="3">
					  <label class="form-check-label" for="localSupply">현지조달</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="supplyRadio" id="unSupply" value="4" checked="checked">
					  <label class="form-check-label" for="unSupply">무관</label>
					</div>
				</div>	
				
				<br>
				<!-- 사진 -->
				<div>
					<div class="photo">
						<h5 style="font-weight: bold;">사진</h5>
					</div>
					
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="photoRadio" id="lifePhoto" value="1">
					  <label class="form-check-label" for="lifePhoto">인생샷을 위해</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="photoRadio" id="roughPhoto" value="2">
					  <label class="form-check-label" for="roughPhoto">대충 흔적만</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="photoRadio" id="viewPhoto" value="3">
					  <label class="form-check-label" for="viewPhoto">풍경 위주</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="photoRadio" id="unPhoto" value="4" checked="checked">
					  <label class="form-check-label" for="unPhoto">무관</label>
					</div>
				</div>	
				
			</div><!-- .modal-body  -->
	      <div class="modal-footer">
	        <button class="btn btn-primary btn-lg shadow-sm" id="styleSearch">여행스타일 검색</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	
	<br><br> 
		<div class="container-">
			<div class="list-group w-auto d-grid gap-5 border-0 position-relative mt-0">
				
				<!-- 정렬순  -->
				<div class="row">
					<div class="d-flex justify-content-start">
						<select class="form-select form-select-lg mb-3 col-md-3 w-auto shadow-sm" 
						id="sort"  name="sort" aria-label=".form-select-lg example">
						  <option ${sortList == null || sortList == 1 ? "selected" : "" } value="1">방 개설일</option>
						  <option ${sortList == 2 ? "selected" : "" } value="2">여행 시작일</option>
						</select>
					</div>
				</div>
				
				
				<!-- 리스트 출력 -->
				<!-- 룸 리스트 데이터 삽입  -->
				<div id="roomListPage">
				<c:forEach var="roomDTO" items="${searchList }">
				<div class="position-relative" style="margin-top: 4vh;">
				
					  
					  <!-- 룸리스트 클릭부분  -->
<!-- 					  <a href="#" class="list-group-item list-group-item-action d-flex gap-4 py-4 pe-5 border-5 shadow" 
					  aria-current="true" id="User_attendPlan"> -->
					  <div class="list-group-item list-group-item-action d-flex gap-4 py-4 pe-5 border-5 shadow" 
					  aria-current="true" id="User_attendPlan" onclick="loginCheck()">
							 
							
					    <!-- <img src="images/User_PF_1.png" alt="User_PF_1" width="60" height="60" class="rounded-circle flex-shrink-0"> -->
					    <img src="${roomDTO.profile_photo}" alt="User_PF_1" width="60" height="60" class="rounded-circle flex-shrink-0">
					    <div class="d-flex gap-1 w-100 justify-content-between">
					    
					      <!-- 여행 방의 정보(닉네임,공유여부, 제목, 인원수)  -->
					      <div class="position-absolute bottom-0 start-0 mt-2">
					      	<!-- <p id="nickName">그로밋</p> -->
					      	<p id="nickName">${roomDTO.nikname }</p>
					      </div>
					      <div>
					        <!-- <h6 class="mb-0">[계획공유방]</h6> -->
					        <h6 class="mb-0">
							<c:if test="${roomDTO.plan_onoff=='계획공유' }">계획공유방</c:if>
							<c:if test="${roomDTO.plan_onoff=='계획전달' }">계획전달방</c:if>
							</h6>
					        <!-- <p class="mb-0 opacity-75" id="title">벚꽃여행 가요!</p> -->
					        <p class="mb-0 opacity-75" id="title">${roomDTO.room_title }</p>
					      </div>
					      	<input id="BMroom_num" type="hidden" value="${roomDTO.room_num }">
					      <ul>
					      	<li>
						      <!-- <p class="opacity-50 text-nowrap">1/2</p> -->
						      <p class="opacity-50 text-nowrap">${roomDTO.mem_curr} / ${roomDTO.mem_max }</p>
					      	</li>
					      </ul>
					      <div class="position-absolute top-0 end-0 mt-2">
					      	<!-- <i class="bi bi-unlock"></i> -->
					      	<c:if test="${roomDTO.pw_code =='YES' }"><i class="bi bi-lock"></i></c:if>
					      	<c:if test="${roomDTO.pw_code =='NO' }"><i class="bi bi-unlock"></i></c:if>
					      </div>
					      
					      <!-- 여행 방의 조건(여행기간,성별,연령,지역,예산) -->
					      <div class="position-absolute bottom-0 mb-1">
					      	<ul>
					        	<li>
					       			 <span class="d-block" style="color:#4E9492;">
								       <!-- <i class="bi bi-calendar2-event"></i> 08/18 ~ 08/19 -->
								       <i class="bi bi-calendar2-event"></i>&nbsp;${roomDTO.trip_start_date } ~ ${roomDTO.trip_end_date }
								     </span> 	
					        	</li>
					        	<li>
					       			 <span class="d-block" style="font-weight: bold; color: #8C5B3A;">
								       <!-- 동일성별 -->
								       <c:if test="${roomDTO.gender_limit =='동성' }">동일성별</c:if>
								       <c:if test="${roomDTO.gender_limit =='무관' }">성별무관</c:if>
								     </span> 	
					        	</li>
					        	<li>
					       			 <span class="d-block" style="font-weight: bold; color: #8C5B3A;">
								       <!-- 유사연령 -->
								       <c:if test="${roomDTO.age_limit == '유사연령대'}">유사연령</c:if>
								       <c:if test="${roomDTO.age_limit == '무관'}">연령무관</c:if>
								     </span>
					        	</li>
					        	<li>
					       			 <span class="d-block" style="font-weight: bold; color: #8C5B3A;">
								       <!-- 서울 -->
								       ${roomDTO. region}
								     </span> 	
					        	</li>
					        	<li>
					       			 <span class="d-block" style="font-weight: bold; color: #8C5B3A;">
								       <!-- 300,000 -->
								       ${roomDTO.budget }
								     </span> 	
					        	</li>
					        </ul>
					      </div>
					      
					      
					      <!-- 모달창버튼 -->
					      <div class="position-absolute bottom-0 end-0">
					      	<button type="button" class="btn" id="btnStyle" 
					      	data-toggle="modal" data-target="#${roomDTO.room_num}">   <!--data-target="#myModal"   -->
				 					 Style
							</button>
						  </div>
					    </div>
					  </div><!--★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★  -->
						
					  <!-- 모달창 -->
						<div class="modal" id="${roomDTO.room_num}" tabindex="-1" role="dialog"> <!-- id="myModal" -->
						  <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable" role="document">
						    <div class="modal-content">
						      <div class="modal-header">
						        <h4 class="modal-title"  style="font-weight: bold; color:#15232E;">${roomDTO.nikname }님의 여행스타일</h4>
						        <button type="button" class="btn-close" data-dismiss="modal" aria-label="Close" id="fix_modal">
						        </button>
						      </div>
						      <div class="modal-body">
						      	<div id="content">
									<div class="row">
										<div class="ML1_plan col-5">
											<h5 style="font-weight: bold;">계획</h5>
										</div>
										<div class="col-7">
											<!-- <span>완벽한 계획</span> -->
											 <span>${roomDTO.plan }</span> 
										</div>
									</div>
									<div class="row">
										<div class="ML1_pay col-5">
											<h5 style="font-weight: bold;">경비</h5>
										</div>
										<div class="col-7">
											<!-- <span>N분의 1</span> -->
											<span>${roomDTO.money_option }</span>
										</div>
									</div>
									<div class="row">
										<div class="ML1_stay col-5">
											<h5 style="font-weight: bold;">숙소형태</h5>
										</div>
										<div class="col-7">
											<!-- <span>호텔</span> -->
											<span>${roomDTO.stay_type }</span>
										</div>
									</div>
									<div class="row">
										<div class="ML1_traffic col-5">
											<h5 style="font-weight: bold;">교통</h5>
										</div>
										<div class="col-7">
											<!-- <span>뚜벅이 선호</span> -->
											<span>${roomDTO.traffic }</span>
										</div>
									</div>
									<div class="row">
										<div class="ML1_cycle col-5">
											<h5 style="font-weight: bold;">사이클</h5>
										</div>
										<div class="col-7">
											<!-- <span>무관</span> -->
											<span>${roomDTO.cycle }</span>
										</div>
									</div>
									<div class="row">
										<div class="ML1_face col-5">
											<h5 style="font-weight: bold;">속도</h5>
										</div>
										<div class="col-7">
											<!-- <span>느긋함 선호</span> -->
											<span>${roomDTO.pace }</span> 
										</div>
									</div>
									<div class="row">
										<div class="ML1_tripLoc col-5">
											<h5 style="font-weight: bold;">여행지</h5>
										</div>
										<div class="col-7">
											<!-- <span>도시</span> -->
											<span>${roomDTO.desti_type }</span>
										</div>
									</div>
									<div class="row">
										<div class="ML1_toDo col-5">
											<h5 style="font-weight: bold;">할 것</h5>
										</div>
										<div class="col-7">
											<!-- <span>쇼핑</span> -->
											<span>${roomDTO.to_do }</span>
										</div>
									</div>
									<div class="row">
										<div class="ML1_toSee col-5">
											<h5 style="font-weight: bold;">볼 것</h5>
										</div>
										<div class="col-7">
											<!-- <span>문화</span> -->
											<span>${roomDTO.to_see }</span>
										</div>
									</div>
									<div class="row">
										<div class="ML1_food col-5">
											<h5 style="font-weight: bold;">음식점 선정기준</h5>
										</div>
										<div class="col-7">
											<!-- <span>SNS맛집</span> -->
											<span>${roomDTO.food }</span>
										</div>
									</div>
									<div class="row">
										<div class="ML1_foodCount col-5">
											<h5 style="font-weight: bold;">식사횟수</h5>
										</div>
										<div class="col-7">
											<!-- <span>무관</span> -->
											<span>${roomDTO.meal_count }</span>
										</div>
									</div>
									<div class="row">
										<div class="ML1_supply col-5">
											<h5 style="font-weight: bold;">준비물</h5>
										</div>
										<div class="col-7">
											<!-- <span>현지조달</span> -->
											<span>${roomDTO.supply }</span>
										</div>
									</div>
									<div class="row">
										<div class="ML1_photo col-5">
											<h5 style="font-weight: bold;">사진</h5>
										</div>
										<div class="col-7">
											<!-- <span>인생샷을 위해</span> -->
											<span>${roomDTO.photo }</span> 
										</div>
									</div>
						      	</div>
						      </div>
						    </div>
						  </div>
						</div>
						</div>
					
			  </c:forEach>
			  </div>
			  <br><br><br><br>
			  
			</div>
		</div>
	</main>
			

</body>
</html>