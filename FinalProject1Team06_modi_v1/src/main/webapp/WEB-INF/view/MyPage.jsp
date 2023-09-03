<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MyPage.jsp</title>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r"	crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js" integrity="sha384-fbbOQedDUMZZ5KreZpsbe1LCZPVmfTnH7ois6mU1QK+m14rQ1l2bGBq41eYeM/fS" crossorigin="anonymous"></script>
<link rel="canonical" href="https://getbootstrap.kr/docs/5.2/examples/dashboard/">
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.1/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css">
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/mypage.css">
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

<style type="text/css">
	/* 스크롤바 생성 */
	.listbox {
	  overflow-y: scroll;
	  height: 250px; 
	  width: 400px; 
	  border: 3px solid gray; 
	  border-radius: 15px;
	  ms-overflow-style: none; /* IE and Edge */
      scrollbar-width: none; /* Firefox */
	}
	.listbox::-webkit-scrollbar {
	    display: none; /* Chrome, Safari, Opera*/
	}
</style>


<script type="text/javascript">
	$(document).ready(function()
	{
		// 여행 점수 정보 보여지기
		$("#popTrip").popover();
		// 에티켓 점수 정보 보여지기
		$("#popEti").popover();
		  
	
	    // 모달창이 열리고 닫힐 때 뒷 배경을 비활성화/활성화 처리
	    $('#myModal').on('show.bs.modal', function () 
	    {
	      	$('#backdrop').show();
	    });

	    $('#myModal').on('hidden.bs.modal', function () 
	    {
	      	$('#backdrop').hide();
	    });
	    
	    /*
	    // 프로필 사진 변경 모달창
	    $('#myModal2').on('show.bs.modal', function () 
	    {
	      	$('#backdrop').show();
	    });

	    $('#myModal2').on('hidden.bs.modal', function () 
	    {
	      	$('#backdrop').hide();
	    });
	    */
	    
	    
	 	// 이미지 업로드 설정 클릭 시 파일 선택 활성화	    
	    $("#flexRadioDefault1").click(function()
   		{
   			$("#inputGroupFile02").attr("disabled",true);
   		});
	    
	    // 이미지 업로드 설정 클릭 시 파일 선택 활성화	    
	    $("#flexRadioDefault2").click(function()
   		{
   			$("#inputGroupFile02").attr("disabled",false);
   		});
	    
	    // 차단 취소 버튼 클릭 시
	    $(".blockCle").click(function()
		{
			if(confirm("차단을 정말 취소하시겠습니까?"))
			{
				// 차단 계정 아이디 넘기면서 페이지 요청
				$(location).attr("href","blockcancle.action?blockedId="+$("#blockedId").val());
			}
		})
		
		
		// 통계 분류 SELECT BOX 옵션 바뀔 때
		$("#statistics").change(function()
		{
			// 여행 스타일 선택 시
			if($("#statistics").val()=="3")
			{
				// 여행 스타일 항목 disabled 취소
				$("#styleSelect").attr("disabled",false);
				alert("여행 스타일 항목을 선택해주세요");
	    		$("#styleSelect").focus();
				
	    		// 여행 스타일 항목 select box 옵션 바뀔 때 
				$("#styleSelect").change(function()
				{
					// 통계 분류 옵션 및 여행 스타일 항목 번호 넘기면서 페이지 요청
					if($("#styleSelect").val() != "0")
					{
						$(location).attr("href","statistic.action?option="+$("#statistics").val()+"&style="+$("#styleSelect").val());
					}
				});
			}
			// 횟수 또는 지역 선택시
			else
			{
				$("#styleSelect").attr("disabled",true);
				$(location).attr("href","statistic.action?option="+$("#statistics").val());
			}
			
		});
	    
	 	// 여행 스타일 항목 select box 옵션 바뀔 때  
	    $("#styleSelect").change(function()
		{
			if($("#styleSelect").val() != "0")
			{
				$(location).attr("href","statistic.action?option="+$("#statistics").val()+"&style="+$("#styleSelect").val());
			}
		});
	    
    	// 통계 옵션 값이 없을 때
    	if($("#option").val()=="")
    	{	
    		// 횟수별 통계 보여짐
    		$(location).attr("href","statistic.action?option=1");
    	}
    	// 통계 옵션 값이 있을 때
    	else
   		{
    		if(parseInt($("#option").val()) %10 != parseInt($("#option").val()))
    		{
    			$("#statistics").val("1");
    		}
    		
    		// 해당 통계 보여짐
   			$("#statistics").val($("#option").val());
    		
	    	if($("#option").val()=="3")
		    {
	    		$("#styleSelect").attr("disabled",false);
		    }
   		}
	    
    	// 여행 스타일 옵션 값 있을 때 
	    if($("#style").val()!="")
	    {
	    	$("#styleSelect").val($("#style").val());
	    }
	    
	});
</script>
</head>

	


<body id="body">

	<!-- 메인페이지 이동 -->
	<button class="float-start p-2"
		style="border: none; background-color: white; color: #48AFB4; font-family: Merriweather; font-size: 20px;" onclick="location.href='roomlist.action'">
		<i class="bi bi-arrow-bar-left"></i> ROOM LIST
	</button>
	
	<div class="container text-center">
		<div class="row" style="padding-top: 50px;">
			<div class="col-sm-4 col-md-4 col-lg-4">
			
				<!-- 프로필 사진 추후 변경 -->
				<img src="${info.photo }" style="width: 200px; height: 200px; border-radius: 50%;" ><br>
				
				<!-- 프로필 사진 변경 보류  -->				
				<!-- <a href="#" class="text-decoration-none" id="myModalPf" data-toggle="modal" data-target="#myModal2">
                	프로필 사진 변경
                	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-camera" viewBox="0 0 16 16">
				  		<path d="M15 12a1 1 0 0 1-1 1H2a1 1 0 0 1-1-1V6a1 1 0 0 1 1-1h1.172a3 3 0 0 0 2.12-.879l.83-.828A1 1 0 0 1 6.827 3h2.344a1 1 0 0 1 .707.293l.828.828A3 3 0 0 0 12.828 5H14a1 1 0 0 1 1 1v6zM2 4a2 2 0 0 0-2 2v6a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V6a2 2 0 0 0-2-2h-1.172a2 2 0 0 1-1.414-.586l-.828-.828A2 2 0 0 0 9.172 2H6.828a2 2 0 0 0-1.414.586l-.828.828A2 2 0 0 1 3.172 4H2z"/>
				  		<path d="M8 11a2.5 2.5 0 1 1 0-5 2.5 2.5 0 0 1 0 5zm0 1a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7zM3 6.5a.5.5 0 1 1-1 0 .5.5 0 0 1 1 0z"/>
					</svg>
              	</a> -->
              	<br><br>
              	<!-- 닉네임 -->
               	<span class="name">${info.nikname} 
               	
               	<c:if test="${info.gender == '여'}">
               		<i class="bi bi-gender-female" style="color:#87BDC7; "></i>
               	</c:if>
               	<c:if test="${info.gender == '남'}">
               		<i class="bi bi-gender-male" style="color:#87BDC7; "></i>
               	</c:if>
               	</span>
				<br><br>
				
				<!-- 자기소개 -->
				<div class="mb-3 d-flex" style="margin-left: 50px">
				  <label for="exampleFormControlTextarea1" class="form-label justify-content-center">자기소개
				  <textarea class="form-control justify-content-center" id="exampleFormControlTextarea1" rows="3" readonly="readonly" style="width: 300px">${info.introduce} </textarea>
				</div>
				
				<!-- 내 정보 수정 및 로그아웃 버튼 -->
				<button type="button" class="btn btn-light" onclick="location.href='infomodify.action'">내 정보 수정</button>
				<button type="button" class="btn btn-dark" onclick="location.href='logout.action'">로그아웃</button>
				<br><br>
				
				<!-- 여행 점수 -->
				<button type="button" class="btn btn-light" id="popTrip" data-bs-container="body" data-bs-toggle="popover"
					data-bs-placement="right" data-bs-content="여행 ${tripScore.tripCount }회 중 ${tripScore.inwonTrip }명 평가">
					여행 점수</button>
				<br> <i class="bi bi-star-fill"> ${tripScore.tripScore} 점</i>
				<br><br>

				<!-- 에티켓 점수 -->
				<button type="button" class="btn btn-light" id="popEti" data-bs-container="body" data-bs-toggle="popover"
					data-bs-placement="right" data-bs-content="${etiScore.inwonEti }명 평가">에티켓 점수</button>
				<br> <i class="bi bi-star-fill"> ${etiScore.etiScore} 점</i> 
				<br><br>
				
				
			    <!-- 프로필사진 모달창 보류 -->
				<!-- <div class="modal" id="myModal2" tabindex="-1" role="dialog">
					<div class="modal-dialog modal-dialog-centered" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title">프로필 사진 변경</h5>
								<button type="button" class="close" data-dismiss="modal"
									aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
							</div>
							<div class="modal-body">
								<form action="photoupdate.action" method="post"
									enctype="multipart/form-data">
									<div class="row">
										<div class="col-md-6">
											<div class="form-check">
												<input class="form-check-input" type="radio" name="photo"
													id="flexRadioDefault1" value="default" checked> <label
													class="form-check-label" for="flexRadioDefault1">
													기본이미지로 변경 </label>
											</div>
											<br>
											<div class="form-check">
												<input class="form-check-input" type="radio" name="photo"
													id="flexRadioDefault2" value="new"> <label
													class="form-check-label" for="flexRadioDefault2">
													사진 불러오기(jpg,png) </label>
											</div>
										</div>
										<div class="input-group mb-3">
											<input type="file" class="form-control" id="inputGroupFile02"
												disabled name="filePath"> <label
												class="input-group-text" for="inputGroupFile02">Upload</label>
										</div>
									</div>
									<div class="modal-footer"></div>
								</form>
							</div>
						</div>
					</div>
				</div> -->
				
				<!-- 뒷 배경을 가리는 투명한 레이어 -->
				<div class="modal-backdrop show" id="backdrop" style="display: none;"></div>
				
				<!-- 차단 리스트 페이지 이동 -->
				<nav class="nav">
					<c:if test="${not empty block}">
  						<a class="nav-link active" aria-current="page" href="blocklist.action" style="margin-left: 50px">차단 리스트 보기</a>
  					</c:if>
  				</nav>
				
				<!-- 차단 계정 목록 -->
				<a class="nav-link" href="#" style="float: right"></a>
				<div class="dropdown">
					<button class="btn btn-light dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false"
						style="width: 300px;">차단목록</button>
					<br>
					<ul class="dropdown-menu" style="width: 300px">
						<c:forEach var="dto" items="${block}">
							<li>
								<div>
									<img src="${dto.photo }" style="height: 50px; width: 50px; margin: 10px">${dto.nikname }
									<input type="hidden" id="blockedId" name="blockedId" value="${dto.idNum }">
									<button type="button" class="btn btn-primary blockCle" style="float: right">차단취소</button>
								</div>
							</li>
						</c:forEach>
					</ul>
				</div>
			</div>


			<div class="col-sm-8 col-md-8 col-lg-8" style="padding-top: 10px">
				<div class="row">
					<div class="col-6">
						<span class="myTrip">참여중인 방 목록 <i class="bi bi-people-fill"></i></span> 
						<br><br>
						<div class="listbox row p-3 pt-1" style="border-color: #87BDC7">
							<c:forEach var="dto" items="${joinroom }">
								<div class="card p-10 x-10 m-2"
									style="width: 350px; height: 130px; border-width: 5px; border-color: #48AFB4">
									<div class="card-body p-0">
										<i class="bi bi-people-fill float-start"
											style="color: #48AFB4"></i>
										<div class="float-start m-2" style="font-size: 10px">
											<c:if test="${dto.plan_onoff=='계획공유' }">[계획공유방]</c:if>
											<c:if test="${dto.plan_onoff=='계획전달' }">[계획전달방]</c:if>
										</div>
										<span class="float-end m-2" style="font-size: 8px">
											참여인원: ${dto.mem_curr} / ${dto.mem_max }</span> <br>
										<h6 class="card-title mt-2">
											<i class="bi bi-house"></i> <strong>방 제목 :
												${dto.room_title }</strong>
										</h6>
										<span class="card-subtitle text-muted" style="font-size: 12px">지역
											: ${dto.region }</span> <span class="p-0" style="font-size: 8px">/
											여행 날짜 : ${dto.trip_start_date } ~ ${dto.trip_end_date }</span> <br>
										<span class="m-1" style="font-size: 8px"> 예산 : <fmt:formatNumber
												groupingUsed="true" value="${dto.budget }" /> 원
										</span>
										<p class="card-text">
											<a href="planner.action?room_num=${dto.room_num }" class="card-link float-end"
												style="text-decoration: none; font-size: 8px"> <i
												class="bi bi-arrow-return-right"></i> 해당 방으로 이동하기
											</a>
										</p>
									</div>
								</div>
							</c:forEach>
						</div>
					</div>

					<div class="col-6">
						<span class="myTrip">완료한 방 목록 <i class="bi bi-person-check" style=""></i></span> 
						<br><br>
						 <div class="listbox" style="border-color: #87BDC7">
							<div class="row p-3 pt-1">
								<c:forEach var="dto" items="${finroom }">
									<div class="card p-10 x-10 m-2"
										style="width: 350px; height: 130px; border-width: 5px; border-color: #4E9492">
										<div class="card-body p-0">
											<i class="bi bi-person-check float-start" style="color: #4E9492"></i>
											<div class="float-start m-2" style="font-size: 10px">
												<c:if test="${dto.plan_onoff=='계획공유' }">[계획공유방]</c:if>
												<c:if test="${dto.plan_onoff=='계획전달' }">[계획전달방]</c:if>
											</div>
											<span class="float-end m-2" style="font-size: 8px">
												</span><br>
											<h6 class="card-title mt-2">
												<i class="bi bi-house"></i> 
												<strong>방 제목 : ${dto.room_title }</strong>
											</h6>
											<span class="card-subtitle text-muted" style="font-size: 12px"> 지역 : ${dto.region } </span>
											 <span class="p-0" style="font-size: 8px">/ 여행 날짜 :
												${dto.trip_start_date } ~ ${dto.trip_end_date }</span><br>
											<span class="m-1" style="font-size: 8px">예산 : <fmt:formatNumber
													groupingUsed="true" value="${dto.budget }" /> 원
											</span>
											<p class="card-text">
												<a href="planner.action?room_num=${dto.room_num }" class="card-link float-end" style="text-decoration: none; font-size: 8px">
													<i class="bi bi-arrow-return-right"></i> 해당 방으로 이동하기
												</a>
											</p>
										</div>
									</div>
								</c:forEach>
							</div>
						</div>
					</div>
				</div>
				<hr>
				<br> 
				<span class="myTrip" style="float: left">내 여행 통계 <i class="bi bi-clipboard-data"></i></span> 
				<br>
				<div class="moon">
					<div class="row">
						<div class="col-6">
							통계 분류 
							<select class="form-select" style="width: 150px"id="statistics">
								<!-- 사용자 가입 년도 부터 생성됨 -->
								<option value="1">여행 횟수</option>
								<option value="2">여행 지역</option>
								<option value="3">여행 스타일</option>
							</select>
						</div>
						<div class="col-6">
							여행 스타일 
							<select class="form-select" style="width: 150px" id="styleSelect" disabled>
								<!-- 사용자 가입 년도 부터 생성됨 -->
								<option value="0" selected>==선택==</option>
								<option value="1">계획</option>
								<option value="2">경비</option>
								<option value="3">숙소 형태</option>
								<option value="4">교통</option>
								<option value="5">수면 패턴</option>
								<option value="6">속도</option>
								<option value="7">여행지</option>
								<option value="8">할 것</option>
								<option value="9">볼 것</option>
								<option value="10">음식점 선정</option>
								<option value="11">식사 빈도</option>
								<option value="12">물품 준비</option>
								<option value="13">사진 촬영</option>
							</select>
						</div>
					</div>
				</div>

					<!-- 통계 -->
					<div id="columnchart_material" style="width: 800px; height: 300px;"></div>
					<input type="hidden" id="staticticsStr" name="staticticsStr" value='${statisticStr }'> 
					<input type="hidden" id="option" name="option" value="${option }"> 
					<input type="hidden" id="style" name="style" value="${style }">
					
					
					<hr>
					<br> 
					<span class="myTrip" style="float: left">내 북마크 목록 
						<i class="bi bi-bookmark-star-fill"></i>
					</span>
					<br><br>
					<div class="listbox" style="width: 760px;">
						<div class="row p-3 pt-1">
							<c:forEach var="dto" items="${bookmark }">
								<div class="card p-10 x-10 m-2" style="width: 350px; height: 130px; border-width: 5px; border-color: #FBC066">
									<div class="card-body p-0">
										<i class="bi bi-bookmark-star-fill float-start" style="color: #FBC066"></i>
										<div class="float-start m-2" style="font-size: 10px">
											<c:if test="${dto.plan_onoff=='계획공유' }">[계획공유방]</c:if>
											<c:if test="${dto.plan_onoff=='계획전달' }">[계획전달방]</c:if>
										</div>
										<span class="float-end m-2" style="font-size: 8px">
											참여인원: ${dto.mem_curr} / ${dto.mem_max }</span><Br>
										<h6 class="card-title mt-2">
											<i class="bi bi-house"></i> 
											<strong>방 제목 : ${dto.room_title }</strong>
										</h6>
										<span class="card-subtitle text-muted" style="font-size: 12px">
											지역 : ${dto.region } 
										</span> 
										<span class="p-0" style="font-size: 8px">
										/여행 날짜 : ${dto.trip_start_date } ~ ${dto.trip_end_date }</span><br>
										<span class="m-1" style="font-size: 8px">
											예산 : <fmt:formatNumber groupingUsed="true" value="${dto.budget }" /> 원
										</span>
										<p class="card-text">
											<a href="planner.action?room_num=${dto.room_num }" class="card-link float-end" style="text-decoration: none; font-size: 8px">
												<i class="bi bi-arrow-return-right"></i>
												방으로 이동하기
											</a>
										</p>
									</div>
								</div>
							</c:forEach>
						</div>
					</div>
				<br><br><br>
				
			</div>
		</div>
	</div>

</body>
<script type="text/javascript">
	// 구글 차트 API
	
	var option = document.getElementById("option").value;
	var subtitleStr = "";
	
	// 지역별 그래프 제목
	if(option ==2)
	{
		subtitleStr = '나의 여행지(연도별)';
	}
	// 횟수별 그래프 제목
	else
	{
		subtitleStr = '나의 여행 횟수(월별 / 연도별)';
	}
	
	
	// 여행 스타일 그래프(원) 그리기
	if(option ==3)
	{
		google.charts.load('current', {'packages':['corechart']});
	}
	// 지역, 횟수별 그래프(막대) 그리기
	else
	{
		google.charts.load('current', {'packages':['corechart', 'bar']});
	}
	google.charts.setOnLoadCallback(drawChart);
	 
	function drawChart() 
	{
		// 통계 JSON 문자열 받아오기
		var str = document.getElementById("staticticsStr").value;
		
		// JSON 문자열 파싱
		var obj = JSON.parse(str);
		
		var data = google.visualization.arrayToDataTable(obj);
		
	    // Set the viewWindow max value to 10
	    var options = {
	        chart: 
	        {
	            title: 'My Trip Statistics',
	            subtitle: subtitleStr
	        }
	    };
		
	    // 여행스타일 그래프
	    if(option ==3)
		{
	    	var chart = new google.visualization.PieChart(document.getElementById('columnchart_material'));
		}
	    // 횟수, 지역별 그래프
	    else
	    {
	   	 	var chart = new google.charts.Bar(document.getElementById('columnchart_material'));
	    }
	    
	    chart.draw(data, options);
	}
</script>
</html>