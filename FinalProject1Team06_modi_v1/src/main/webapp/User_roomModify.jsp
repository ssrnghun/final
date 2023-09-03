<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
	String StartSelect = request.getParameter("StartSelect");
	if(StartSelect == null)
		StartSelect = "";
%>
<!DOCTYPE html>
<html lang="ko">

<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>User_roomModify.jsp</title>
	
  <!-- jQuery  -->
  <script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
	
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" 
  integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
  
  
  <!-- 기능구현  -->  	
  <script type="text/javascript">
	function select(obj)
	{	
	   var budgetMinValue = obj.value;
	   alert(budgetMinValue);
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
	
	// 지역 검색의 값이 비어있을 경우 유효성 검사를 하는 함수
	function region_submit(){
	      //값 비어있으면
	      if($("#region").val() == "")
	      {
	          // is-invalid 클래스를 붙여줘서 빨간 경고문구 붙여준다
	          $("#region").addClass("is-invalid");
	          // 폼 제출을 반환(제출 안되게 리턴)
	          return;
	      }
	      
	}
	
  
  </script>
  <script type="text/javascript">
  	
  
     var result = $(':radio[name=options-outlined]:checked').next().text();
  
	$(function()
	{
		
		/* 비밀번호 창 잠금여닫는 익명함수 비활성화 구현  */
		
		$("input:radio[name=OpenCloseRadio]").click(function()
		{
			if($("input[name=OpenCloseRadio]:checked").val() == 1)
			{	
				$("input:password[name=pwd]").attr("disabled",true);
			}
			else if($("input[name=OpenCloseRadio]:checked").val() == 2)
			{
				$("input:password[name=pwd]").attr("disabled",false);
			}
		});
		
		
		/* 장소선택 클릭시 페이지 요청 */
		$("#selectPositionBtn").click(function()
		{	
			var region = $("#region").val();
			$(location).attr("href","StartSelect.jsp?region="+region);
			
		});
		
		
	    
	    /* 예산이 처음에 선택한 값보다 뒤의 값이 작은 값을 선택하지 못하도록 설정하는 기능 */
	    $('#budgetApply').click(function()
        {
	         if($("#budgetMin").val()=='0' && $("#budgetMax").val()=='0')
	         {
	            $("#budget").text((parseInt($("#budgetMin").val())*10)+"~"+(parseInt($("#budgetMax").val())*10));
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
	    
	    
	    $('#regionSelect').click(function()
		{
	    	
	    	result = $(':radio[name=options-outlined]:checked').next().text();
			
			// 확인
			//alert(result);
			if (result == "")
			{
				alert("지역을 선택해주세요.");
			}
			else 
			{
				$("#regionSearch").modal("hide");    /* 모달창이 닫힘*/
				$('#region').attr('value',result);
			}
			
		  //$('#region').css('display','none'); /* 모달창을 닫아도 뒷 배경이 활성화되어 있음  */
			
		     $("#region").removeClass("is-invalid");
			 $("#region").addClass("is-valid");
			
		});
	    
		
	});
	
	

  </script>
  
  
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.1/dist/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	
  <style>
    body {
      min-height: 100vh;

      background: -webkit-gradient(linear, left bottom, right top, from(#4E9492), to(#FF9A66));
      background: -webkit-linear-gradient(bottom left, #4E9492 0%, #FF9A66 100%);
      background: -moz-linear-gradient(bottom left, #4E9492 0%, #FF9A66 100%);
      background: -o-linear-gradient(bottom left, #4E9492 0%, #FF9A66 100%);
      background: linear-gradient(to top right, #4E9492 0%, #FF9A66 100%);
    }

    .input-form {
      max-width: 680px;

      margin-top: 80px;
      padding: 32px;

      background: #fff;
      -webkit-border-radius: 10px;
      -moz-border-radius: 10px;
      border-radius: 10px;
      -webkit-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
      -moz-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
      box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15)
    }
    
    select 
    {
    	padding: 0.375rem 2.25rem 0.375rem 0.75rem;
    }
    
    label
    {
    	font-weight: bold;
    	font-size: 18px;
    }
    
    h4
    {
    	font-weight: bold;
    }
    
  </style>
</head>

<body>
  <div class="container">
    <div class="input-form-backgroud row">
      <div class="input-form col-md-12 mx-auto">
        <h4 class="mb-3">여행 계획 방 수정하기</h4>
        <form class="validation-form" novalidate>
          <div class="row">
            <div class="mb-3">
              <label for="title">제목</label>
              <input type="text" class="form-control shadow-sm" id="title" placeholder="" value="" required>
              <div class="invalid-feedback">
                제목을 입력해주세요.
              </div>
            </div>
            
           <div class="mb-3">
	           <!-- 지역검색 -->
	            <label for="region">지역</label>
	            <div class="row">
		            <div class="col-md-6 mb-3">
						<input type="text" class="form-control shadow-sm" id="region" placeholder="" value="" required readonly>
						<br>
						<button type="button" class="btn btn-dark w-auto shadow-sm" id="resultSearch" 
						data-toggle="modal" data-target="#regionSearch">
							지역검색
						</button>
						<div class="invalid-feedback">
		                지역을 선택해주세요.
		                </div>
					</div>
	            </div>
				


	           <!-- 지역검색 모달창 -->
					<div class="modal" id=regionSearch tabindex="-1" role="dialog">
					  <div class="modal-dialog modal-dialog-centered" role="document">
					    <div class="modal-content">
					      <div class="modal-body">
					      <div class="input-group">
					         <input type="text" name="search" class="form-control" placeholder="어디로 여행을 떠나시나요?" id="trip_search">
					      <div class="input-group-append">
					              <input type="button" class="btn btn-default" value="검색">
					      </div>
					   	  </div><!-- .input-group  -->
					   <br>
					   <span>추천 여행지</span><br>
					   
						   <input type="radio" class="btn-check" name="options-outlined" id="success-outlined1" autocomplete="off">
						   <label class="btn btn-outline-success" for="success-outlined1">부산</label>
						     <input type="radio" class="btn-check" name="options-outlined" id="success-outlined2" autocomplete="off" >
						   <label class="btn btn-outline-success" for="success-outlined2">제주도</label>
						     <input type="radio" class="btn-check" name="options-outlined" id="success-outlined3" autocomplete="off" >
						   <label class="btn btn-outline-success" for="success-outlined3">경주</label>
						     <input type="radio" class="btn-check" name="options-outlined" id="success-outlined4" autocomplete="off" >
						   <label class="btn btn-outline-success" for="success-outlined4">양양</label>
						     <input type="radio" class="btn-check" name="options-outlined" id="success-outlined5" autocomplete="off" >
						   <label class="btn btn-outline-success" for="success-outlined5">속초</label>
						     <input type="radio" class="btn-check" name="options-outlined" id="success-outlined6" autocomplete="off" >
						   <label class="btn btn-outline-success" for="success-outlined6">강릉</label>
						       <br><br>
						    <span>검색 결과</span><br>
						      <input type="radio" class="btn-check" name="options-outlined" id="result1" autocomplete="off" >
						      <label class="btn btn-outline-success" for="result1">양양</label>
						      <input type="radio" class="btn-check" name="options-outlined" id="result2" autocomplete="off" >
						      <label class="btn btn-outline-success" for="result2">대구</label>
						      <input type="radio" class="btn-check" name="options-outlined" id="result3" autocomplete="off" >
						      <label class="btn btn-outline-success" for="result3">부산</label>
							    <div class="modal-footer">
							      <button type="button" class="btn btn-dark" id="regionSelect" data-dismiss="modal">선택</button>
					      		</div>
					    	</div><!--.modal-body  -->
						  </div><!--.modal-content  -->
						</div><!-- .modal-dialog  -->
					</div><!--.modal  -->
	         </div><!-- region div  -->
		 
            
            
            
          </div>

          <div class="mb-3">
            <label for="calendar">일정</label>
          <div class="row">
           <div class="col-md-6">
           여행시작일
           <input type="date" class="form-control shadow-sm" required aria-required="true" value="2023-08-01"onChange="" 
           style="width: 200px" readonly="readonly">
           </div> 
           
           <div class="col-md-6">
           여행 종료일  
           <input type="date" class="form-control shadow-sm" required aria-required="true" value="2023-08-15" onChange="" style="width: 200px" readonly="readonly">
         </div>            
           </div>   
          </div>
          
          
           <div class="mb-3">
            <label for="plan">계획 여부</label>
            <select class="form-select d-block w-100 shadow-sm" id="plan" required disabled>
                <option value="">여부 선택</option>
                <option selected>계획 공유방</option>
                <option>계획 전달방</option>
              </select>
            <div class="invalid-feedback">
              계획여부를 선택해주세요.
            </div>
          </div>

		<div class="row">
          <div class="col-md-4 mb-3">
            <label for="memberCount">정원</label>
            <select class="form-select d-block w-100 shadow-sm" id="memberCount" required disabled> 
                <option value="">최대인원수</option>
                <option value="1">1명</option>
                <option value="2">2명</option>
                <option value="3" selected>3명</option>
                <option value="4">4명</option>
                <option value="5">5명</option>
                <option value="6">6명</option>
                <option value="7">7명</option>
                <option value="8">8명</option>
                <option value="9">9명</option>
              </select>
            <div class="invalid-feedback">
              정원을 선택해주세요.
            </div>
          </div>
		
          <div class="col-md-4 mb-3">
            <label for="gender">성별</label>
            <select class="form-select d-block w-100 shadow-sm" id="gender" required disabled>
                <option value="">성별선택</option>
                <option selected>성별무관</option>
                <option>동일성별</option>
              </select>
            <div class="invalid-feedback">
              성별을 선택해주세요.
            </div>
          </div>

          <div class="col-md-4 mb-3">
            <label for="age">연령</label>
            <select class="form-select d-block w-100 shadow-sm" id="age" required disabled>
                <option value="">연령선택</option>
                <option selected>연령무관</option>
                <option>유사연령대</option>
              </select>
            <div class="invalid-feedback">
              연령을 선택해주세요.
            </div>
          </div>
		</div>
          
          
          <div class="row">
	          <label for="tripStyle">여행스타일(선택)</label><br>
	          <div class="mb-3">
	            <button type="button" name="tripStyle" class="btn btn-dark btn-md btn-block shadow-sm" 
	            id="tripStyle" data-toggle="modal" data-target="#myModal">
	            여행스타일 선택
	            </button>
	          </div>
	            
	          <br>
          </div> 
          
			
			<!-- 모달창 -->
			<div class="modal" id="myModal" tabindex="-1" role="dialog">
			  <div class="modal-dialog modal-dialog-scrollable modal-lg" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h3 class="modal-title">여행스타일 창</h3>
			        <button type="button" class="btn-close" data-dismiss="modal" aria-label="Close">
			        </button>
			      </div>
			      <div class="modal-body">
				
				<div class="col-4">
						<select class="form-select form-select-lg mb-3 shadow-sm" name="tripMode" id="tripMode" 
						aria-label=".form-select-lg example">
						  <option selected style="font-weight: bold;">여행모드 기본</option>
						   <option value="1">Mode 1</option>
			               <option value="2">Mode 2</option>
			               <option value="3">Mode 3</option>
						</select>
				</div>
				
				
				<hr>
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
					  <input class="form-check-input" type="radio" name="stayRadio" id="homeStay" value="3">
					  <label class="form-check-label" for="homeStay">민박</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="stayRadio" id="unStay" value="4" checked="checked">
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
					  <input class="form-check-input" type="radio" name="toDoRadio" id="foodToDo" value="4">
					  <label class="form-check-label" for="foodToDo">맛집 탐방</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="toDoRadio" id="friendToDo" value="5">
					  <label class="form-check-label" for="friendToDo">새친구 만들기</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="toDoRadio" id="unToDo" value="6" checked="checked">
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
					  <input class="form-check-input" type="radio" name="foodRadio" id="localFood" value="2">
					  <label class="form-check-label" for="regionFood">지역특산물위주</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="foodRadio" id="localFood" value="2">
					  <label class="form-check-label" for="actFood">즉흥적으로</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="foodRadio" id="unFood" value="3" checked="checked">
					  <label class="form-check-label" for="unFood">무관</label>
					</div>
				</div>	
				
				<br>
				<!-- 식사횟수  -->
				<div>
					<div class="foodCount">
						<h5 style="font-weight: bold;">식사 횟수</h5>
					</div>
					
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="foodCountRadio" id="oftenFoodCount" value="1">
					  <label class="form-check-label" for="oftenFoodCount">자주, 적게</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="foodCountRadio" id="onceFoodCount" value="2">
					  <label class="form-check-label" for="onceFoodCount">한번에 많이</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="foodCountRadio" id="dietFoodCount" value="3">
					  <label class="form-check-label" for="dietFoodCount">다이어트</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="foodCountRadio" id="unFoodCount" value="4" checked="checked">
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
				
			      </div>
			      
			      <div class="modal-footer">
			        <button type="button" class="btn btn-secondary btn-lg shadow-sm" data-dismiss="modal">닫기</button>
			        <button type="button" class="btn btn-primary btn-lg shadow-sm">저장</button>
			      </div>
			    </div> <!-- .modal-content -->
			  </div>
			</div>
			
          
          <div class="row">
	          <label for="startPosition">출발지(선택)</label><br>
	          <div class="col-md-6 mb-3">
	          	<input type="text" class="form-control shadow-sm" value="<%= StartSelect %>" id="startPosition" readonly="readonly">
	          </div>
	          <div class="col-md-6 mb-3">
	          	<button type="button" class="btn btn-dark btn-md btn-block shadow-sm" id="selectPositionBtn">장소선택</button>
	          </div>
          </div> 
          
          
           <div class="col-md-6 mb-3">
            <label for="age">출발시간(선택)</label>
            	<p>
            		<input class="form-select" type="time" value="xxx" min="yyy" max="zzz"> 
            	</p>
            	<!-- 
            	value : 선택 항목으로, 기본 날짜를 정한다.
				min : 선택 항목으로, 입력 가능한 가장 빠른 날짜이다.
				max : 선택 항목으로, 입력 가능한 가장 늦은 날짜이다.
            	 -->
          </div>
          
          <!-- 예산 검색 -->		
	         <div class="col-md-6"  >
             <ul style="padding: 0" >
             <label for="form-label">예산</label><br>
               <button type="button" class="btn btn-dark w-5 h-3" id="budget" 
               data-bs-toggle="dropdown" aria-expanded="false">
               예산
               </button>
                 <ul class="dropdown-menu rounded-3 budgetMenu px-3 py-2"
                  style="background-color: #E5E5E5;">
                    <li class="">
                       <a class="dropdown-item rounded-2 d-flex" href="#" >
                       <div class="row">
                          <div class="col-md-5 text-center">
                             <span style="font-weight: bold;">최소 금액</span>
                             <select class="form-select d-block shadow-sm text-end w-auto" id="budgetMin" onchange="select(this)">
                                <c:forEach var="i" step="1" begin="0" end="10">
                                   <option value="${i }"><fmt:formatNumber value="${i*100000 }" /></option>
                                </c:forEach>
                            </select>
                          </div>
                          <div class="col-md-2">
                           <span style="font-weight: bold;"> ~ </span>
                          </div>
                          <div class="col-md-5 text-center">
                            <span style="font-weight: bold;">최대 금액</span>
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
                       <a class="dropdown-item rounded-2 d-inline-flex mt-3" href="#" >
                          <button type="button" class="btn btn-warning" id="budgetApply"
                           style="color : white;">
                          적용
                          </button>
                       </a>
                    </li>
              	</ul>
              </ul>
            </div>
          
          
          
		  <div class="form-check form-check-inline">
  			<input class="form-check-input" type="radio" name="OpenCloseRadio" id="OpenRadio1" value="1" disabled>
  			<label class="form-check-label" for="OpenRadio1">공개</label>
		  </div>
		  <div class="form-check form-check-inline">
  			<input class="form-check-input" type="radio" name="OpenCloseRadio" id="CloseRadio2" value="2" checked="checked" disabled>
  			<label class="form-check-label" for="CloseRadio2">비공개</label>
		  </div>
          	&nbsp;&nbsp;&nbsp;비밀번호 <input type="password" name="pwd" id="pwd" value="1234" disabled="disabled"/>
          
          <br /><br />
          <div class="row">
          
	          <div class="col-md-6 mb-4">
		          <button class="btn btn-primary btn-md btn-block shadow" 
		          style="width: 100%;" type="submit" onclick="region_submit()">개설</button>
	          </div>
	          <div class="col-md-6 mb-4">
		          <button class="btn btn-dark btn-md btn-block shadow" 
		          style="width: 100%;" type="reset">취소</button>
	          </div>
          </div>
          
        </form>
      </div>
    </div>
    <footer class="my-3 text-center text-small">
      <p class="mb-1" style="color: white; font-weight: bold;">&copy; 2023 MateTrip</p>
    </footer>
  </div>
  <script>
   window.addEventListener('load', () => {
      const forms = document.getElementsByClassName('validation-form');

      Array.prototype.filter.call(forms, (form) => {
        form.addEventListener('submit', function (event) {
          if (form.checkValidity() === false) {
            event.preventDefault();
            event.stopPropagation();
          }

          form.classList.add('was-validated');
        }, false);
      });
    }, false); 
  </script>
</body>

</html>