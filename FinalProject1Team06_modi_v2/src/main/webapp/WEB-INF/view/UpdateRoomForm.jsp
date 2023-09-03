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
  <title>UpdateRoomForm.jsp</title>
	
  <!-- jQuery  -->
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
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
	
	
	// 폼 제출하기 전 지역선택했는지 확인하는 유효성 검사 함수
	function region_submit()
	{
	      //값 비어있으면
	      if($("#region").val() == "")
	      {
	          // is-invalid 클래스를 붙여줘서 빨간 경고문구 붙여준다
	          $("#region").addClass("is-invalid");
	       // 폼 제출을 반환(제출 안되게 리턴)
	          return;
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

	
	// 장소선택페이지로 이동하고 오더라도 값이 유지되게 설정하는 함수
	function selectOptions()
	{
		var regionOption = $("#region").val(); // 장소 선택 페이지에서 선택한 옵션 값을 가져오는 로직이 필요합니다.
		sessionStorage.setItem("regionOption", regionOption);
	}
	
	
	function time(obj)
	{
		obj.value = obj.value.toString();
	}
	</script>
	
	
  <script type="text/javascript">
  	
     var result = $(':radio[name=options-outlined]:checked').next().text();
  
	$(function()
	{
		
		
		
	    
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
	    
	    /* 선택버튼을 클릭했을 때 */
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
				$('#regionSearch').modal("hide");   
				$('#region').attr('value',result);
				
			}
			
			// 선택하는 모달창이 사라져야한다.
		  	//$('#region').css('display','none'); /* 모달창을 닫아도 뒷 배경이 활성화되어 있음  */
			
		     $("#region").removeClass("is-invalid");
			 $("#region").addClass("is-valid");
			
		});
	    
	    
	    $('#selectPositionBtn').click(function()
		{
	    	var region = $("#region").val();
	    	window.open("StartSelect.jsp?region="+region);
	    	
		});
	    
	    // 지역 검색 클릭 시
	    $("#searchRegion").click(function()
		{
			//alert("dd");
			
			var region = $.trim($("#trip_search").val());
			
			//alert(region);
			
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
	    					//$("label[for='result1']").text(response);
	    					
	    					$("#trip_search").val("");
	    					$("#trip_search").focus();
	    					
	    				}  // check~!!! 
	    				//, beforeSend:showRequest // showRequest() 로 쓰는 것과 헷갈리지말기 → true / false
	    				, error:function(e)
	    				{
	    					console.log(e.responseText); // 소량의 데이터	
	    				}			
	    			});
			
			
		});
	    
	 	// 지역검색 내의 선택버튼을 눌렀을 때의 기능 구현 
	    $('#regionSelect').click(function()
   		{
   	    	// 자신이 검색하거나, 추천지로 있는 지역 버튼을 누른 것의 지역텍스트를 가져옴
   	    	result = $(':radio[name=options-outlined]:checked').next().text();
   			
   			// 확인
   			//alert(result);
   			// 지역 버튼을 누르지않고 선택버튼을 눌렀을 경우 
   			if (result == "")
   			{
   				alert("지역을 선택해주세요.");
   			}
   			else // 그게 아니라면, 
   			{	
   				// 모달창 닫기 
   				$('#regionSearch').modal("hide");
   				// 지역검색 버튼을 사용자가 선택한 지역으로 변경
   				$('#regionBtn').text(result);
   				
   			}
   			
   		});
	 	
	 
	    // 여행 스타일 선택 에서 모드 조회 기능 구현
	    $("#tripMode").on('change',function()
		{
			var params = { mode_name : $("#tripMode").val()}
			
			if (($("#tripMode").val() != '기본'))
			{
				$.ajax(
						{
							type:"GET" 					
			    				, url: "mode_select.action" 	
			    				, dataType: "text"
			    				, data: params 
			    				, success: function(args)
								{
			    					
									console.log(args);
									
									if(args=="1")
									{
										alert("저장된 여행스타일 모드가 없습니다.");
										return;
									}
									else
									{
									
										nameOption = $(args).find("name").text();
										planOption = $(args).find("plan").text();
										payOption = $(args).find("money").text();
										stayOption = $(args).find("stay").text();
										trafficOption = $(args).find("traffic").text();
										cycleOption = $(args).find("cycle").text();
										paceOption = $(args).find("pace").text();
										destiOption = $(args).find("desti").text();
										doOption = $(args).find("do").text();
										seeOption = $(args).find("see").text();
										foodOption = $(args).find("food").text();
										mealOption = $(args).find("meal").text();
										supplyOption = $(args).find("supply").text();
										photoOption = $(args).find("photo").text();
										
										$(":radio[name=plan_num][value=" + planOption + "]").prop('checked', true);
										$(":radio[name=money_option_num][value=" + payOption + "]").prop('checked', true);
										$(":radio[name=stay_type_num][value=" + stayOption + "]").prop('checked', true);
										$(":radio[name=traffic_num][value=" + trafficOption + "]").prop('checked', true);
										$(":radio[name=cycle_num][value=" + cycleOption + "]").prop('checked', true);
										$(":radio[name=pace_num][value=" + paceOption + "]").prop('checked', true);
										$(":radio[name=desti_type_num][value=" + destiOption + "]").prop('checked', true);
										$(":radio[name=to_do_num][value=" + doOption + "]").prop('checked', true);
										$(":radio[name=to_see_num][value=" + seeOption + "]").prop('checked', true);
										$(":radio[name=food_num][value=" + foodOption + "]").prop('checked', true);
										$(":radio[name=meal_count_num][value=" + mealOption + "]").prop('checked', true);
										$(":radio[name=supply_num][value=" + supplyOption + "]").prop('checked', true);
										$(":radio[name=photo_num][value=" + photoOption + "]").prop('checked', true);
									}
								}
			    				, error: function(request, status, error) 
			    				{
		    	                   console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		    	                }	
						});
			}
			
			// 기본일 때 라디오버튼이 초기화 되는 기능 보류 
			/*
			else if(($("#tripMode").val() == '기본'))
			{
				$(":radio[name=planRadio]").prop('checked', true);
				
			}
			*/
			
		});
	    
	    
	    // 여행 스타일 적용 버튼 클릭 시
	    $("#styleSearch").click(function()
		{
	    	var selectedOptionText = $("#tripMode option:selected").text();
	    	
	    	//alert(selectedOptionText);
	    	
	    	$("#tripStyleInput").val(selectedOptionText);
			
		});
	 
		
	    
		
	});
	
	

  </script>
  
  
	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.1/dist/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	
  <style>
    body {
      min-height: 100vh;

      background: -webkit-gradient(linear, left bottom, right top, from(#48AFB4), to(#FBC066));
      background: -webkit-linear-gradient(bottom left, #48AFB4 0%, #FBC066 100%);
      background: -moz-linear-gradient(bottom left, #48AFB4 0%, #FBC066 100%);
      background: -o-linear-gradient(bottom left, #48AFB4 0%, #FBC066 100%);
      background: linear-gradient(to top right, #48AFB4 0%, #FBC066 100%);
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
        <form action="updateroom.action" method="post" class="validation-form" novalidate>
          <div class="row">
            <div class="mb-3">
              <label for="title">제목</label>
              <input type="text" class="form-control shadow-sm" name="room_title" id="title" placeholder="" value="${dto.room_title }" required>
              <div class="invalid-feedback">
                제목을 입력해주세요.
              </div>
            </div>
            
           <div class="mb-3">
	           <!-- 지역검색 -->
	            <label for="region">지역</label>
	            <div class="row">
		            <div class="col-md-6 mb-3">
						<input type="text" class="form-control shadow-sm" name="region_num" id="region" value="${dto.region }" placeholder="" required readonly>
						<div class="invalid-feedback">
		                지역을 선택해주세요.
		                </div>
					</div>
					<button type="button" class="btn btn-dark w-auto shadow-sm" id="resultSearch" 
						data-toggle="modal" data-target="#regionSearch" style="height: 40px;">
							지역검색
					</button>
					
	            </div>
				


	           <!-- 지역검색 모달창 -->
					<div class="modal" id=regionSearch tabindex="-1" role="dialog">
					  <div class="modal-dialog modal-dialog-centered" role="document">
					    <div class="modal-content">
					      <div class="modal-body">
					      <div class="input-group">
					         <input type="text" name="search" class="form-control" placeholder="어디로 여행을 떠나시나요?" id="trip_search">
					      <div class="input-group-append">
					              <input type="button" class="btn btn-default" id="searchRegion" value="검색">
					      </div>
					   	  </div><!-- .input-group  -->
					   <br>
					   <span>추천 여행지</span><br>
					   
						   <input type="radio" class="btn-check" name="options-outlined" id="success-outlined1" autocomplete="off">
						   <label class="btn btn-outline-success" for="success-outlined1">부산광역시</label>
						     <input type="radio" class="btn-check" name="options-outlined" id="success-outlined2" autocomplete="off" >
						   <label class="btn btn-outline-success" for="success-outlined2">제주시</label>
						     <input type="radio" class="btn-check" name="options-outlined" id="success-outlined3" autocomplete="off" >
						   <label class="btn btn-outline-success" for="success-outlined3">경주시</label>
						     <input type="radio" class="btn-check" name="options-outlined" id="success-outlined4" autocomplete="off" >
						   <label class="btn btn-outline-success" for="success-outlined4">양양군</label>
						     <input type="radio" class="btn-check" name="options-outlined" id="success-outlined5" autocomplete="off" >
						   <label class="btn btn-outline-success" for="success-outlined5">속초시</label>
						       <br><br>
						    <span>검색 결과</span><br>
						      <div id = "regionResult"></div>
						      
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
           여행 시작일
           <input type="text" class="form-control shadow-sm" id="trip_start_date" name="trip_start_date"
           value="${dto.trip_start_date }" style="width: 200px; height: 40px;" readonly="readonly">
				           
           </div> 
           
           <div class="col-md-6">
           여행 종료일  
           <input type="text" class="form-control shadow-sm" id="trip_end_date" name="trip_end_date"
           value="${dto.trip_end_date }" onChange="" style="width: 200px; height: 40px;" readonly="readonly">
         </div>            
           </div>   
          </div>
          
          
           <div class="mb-3">
            <label for="plan">계획 여부</label>
            <input type="text" class="form-control d-block w-100 shadow-sm" id="plan" name="plan_onoff_num" value="${dto.plan }" readonly="readonly">
            <!-- 
            <select class="form-select d-block w-100 shadow-sm" id="plan" name="plan_onoff_num" required>
                <option value="">여부 선택</option>
                <option value="1">계획 공유방</option>
                <option value="2">계획 전달방</option>
              </select>
               -->
          </div>

		<div class="row">
          <div class="col-md-4 mb-3">
            <label for="memberCount">정원</label>
            <input type="text" class="form-control d-block w-100 shadow-sm" id="mem_max" name="mem_max" value="${dto.mem_max } 명" readonly="readonly">
            
          </div>
		
          <div class="col-md-4 mb-3">
            <label for="gender">성별</label>
            <input type="text" class="form-control d-block w-100 shadow-sm" id="gender_limit" name="gender_limit_num"
            value="${dto.gender_limit }" readonly="readonly">
           
          </div>

          <div class="col-md-4 mb-3">
            <label for="age">연령</label>
            <input type="text" class="form-control d-block w-100 shadow-sm" id="age_limit" name="age_limit_num"
            value="${dto.age_limit }" readonly="readonly">
          </div>
		</div>
         
          
         	
	          <label for="tripStyle">여행스타일(선택)</label><br>
	          <div class="col-md-4 mb-3">
	           
	            <button type="button" name="tripStyle" class="btn btn-dark btn-md btn-block shadow-sm" 
	            id="tripStyle" data-toggle="modal" data-target="#tripStyleSearch">
	            여행스타일 선택
	            </button>
	          
	            
          	</div> 
          
			
			<!-- 첫번째 모달창 -->
	<div class="modal fade" id="tripStyleSearch" aria-hidden="true" aria-labelledby="tripStyleSearch_Label" tabindex="-1">
	  <div class="modal-dialog modal-dialog-scrollable modal-lg">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h1 class="modal-title fs-3" id="tripStyleSearch_Label" style="color: black; font-weight: bold;" >여행스타일 선택</h1>
	        <button type="button" class="btn-close" data-dismiss="modal" aria-label="Close" ></button>
	      </div>
	      <div class="modal-body">
	        <div class="col-4">
				<select class="form-select form-select-lg mb-3 shadow-sm" name="tripMode" id="tripMode" 
				aria-label=".form-select-lg example">
				  <option selected style="font-weight: bold;" value="기본">기본</option> 
				   <option value="모드1">Mode 1</option>
	               <option value="모드2">Mode 2</option>
	               <option value="모드3">Mode 3</option>
				</select>
			</div>
				<hr>
				<!-- 계획 -->
				<div>
					<div class="plan">
						<h5 style="font-weight: bold;">계획</h5>
					</div>
					
					<div class="form-check form-check-inline">
	    				<input class="form-check-input" type="radio" name="plan_num" id="perfectPlan" value="1"
	    				<c:if test="${dto.plan_num == 1}">checked</c:if>>
	    				<label class="form-check-label" for="perfectPlan">완벽한 계획</label>
					</div>
					<div class="form-check form-check-inline">
					    <input class="form-check-input" type="radio" name="plan_num" id="roughPlan" value="2"
					    <c:if test="${dto.plan_num == 2}">checked</c:if>>
					    <label class="form-check-label" for="roughPlan">대략적인 계획</label>
					</div>
					<div class="form-check form-check-inline">
					    <input class="form-check-input" type="radio" name="plan_num" id="noPlan" value="3"
					    <c:if test="${dto.plan_num == 3}">checked</c:if>>
					    <label class="form-check-label" for="noPlan">계획 없음</label>
					</div>
					<div class="form-check form-check-inline">
					    <input class="form-check-input" type="radio" name="plan_num" id="unPlan" value="4"
					    <c:if test="${dto.plan_num == 4}">checked</c:if>>
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
					  <input class="form-check-input" type="radio" name="money_option_num" id="dutchPay" value="1"
					  <c:if test="${dto.money_option_num == 1}">checked</c:if>>
					  <label class="form-check-label" for="dutchPay">N분의 1</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="money_option_num" id="eachPay" value="2"
					  <c:if test="${dto.money_option_num == 2}">checked</c:if>>
					  <label class="form-check-label" for="eachPay">각자 계산</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="money_option_num" id="afterPay" value="3"
					  <c:if test="${dto.money_option_num == 3}">checked</c:if>>
					  <label class="form-check-label" for="afterPay">후청구</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="money_option_num" id="unPay" value="4"
					  <c:if test="${dto.money_option_num == 4}">checked</c:if>>
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
					  <input class="form-check-input" type="radio" name="stay_type_num" id="resortStay" value="1"
					  <c:if test="${dto.stay_type_num == 1}">checked</c:if>>
					  <label class="form-check-label" for="resortStay">리조트</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="stay_type_num" id="hotelStay" value="2"
					  <c:if test="${dto.stay_type_num == 2}">checked</c:if>>
					  <label class="form-check-label" for="hotelStay">호텔</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="stay_type_num" id="youthStay" value="3"
					  <c:if test="${dto.stay_type_num == 3}">checked</c:if>>
					  <label class="form-check-label" for="youthStay">호스텔 </label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="stay_type_num" id="homeStay" value="4"
					  <c:if test="${dto.stay_type_num == 4}">checked</c:if>>
					  <label class="form-check-label" for="homeStay">민박</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="stay_type_num" id="unStay" value="5"
					  <c:if test="${dto.stay_type_num == 5}">checked</c:if>>
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
					  <input class="form-check-input" type="radio" name="traffic_num" id="rentTraffic" value="1"
					  <c:if test="${dto.traffic_num == 1}">checked</c:if>>
					  <label class="form-check-label" for="rentTraffic">렌트</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="traffic_num" id="walkTraffic" value="2"
					  <c:if test="${dto.traffic_num == 2}">checked</c:if>>
					  <label class="form-check-label" for="walkTraffic">뚜벅이 선호</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="traffic_num" id="publicTraffic" value="3"
					  <c:if test="${dto.traffic_num == 3}">checked</c:if>>
					  <label class="form-check-label" for="publicTraffic">대중교통(택시포함)</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="traffic_num" id="unTraffic" value="4"
					  <c:if test="${dto.traffic_num == 4}">checked</c:if>>
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
					  <input class="form-check-input" type="radio" name="cycle_num" id="lateCycle" value="1"
					  <c:if test="${dto.cycle_num == 1}">checked</c:if>>
					  <label class="form-check-label" for="lazyCycle">늦은취침,늦은기상</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="cycle_num" id="earlyCycle" value="2"
					  <c:if test="${dto.cycle_num == 2}">checked</c:if>>
					  <label class="form-check-label" for="fastCycle">이른취침,이른기상</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="cycle_num" id="unCycle" value="3"
					  <c:if test="${dto.cycle_num == 3}">checked</c:if>>
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
					  <input class="form-check-input" type="radio" name="pace_num" id="slowFace" value="1"
					  <c:if test="${dto.pace_num == 1}">checked</c:if>>
					  <label class="form-check-label" for="slowFace">느긋함 선호</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="pace_num" id="tightFace" value="2"
					  <c:if test="${dto.pace_num == 2}">checked</c:if>>
					  <label class="form-check-label" for="tightFace">촘촘한 일정 선호</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="pace_num" id="unFace" value="3"
					  <c:if test="${dto.pace_num == 3}">checked</c:if>>
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
					  <input class="form-check-input" type="radio" name="desti_type_num" id="natureTripLoc" value="1"
					  <c:if test="${dto.desti_type_num == 1}">checked</c:if>>
					  <label class="form-check-label" for="natureTripLoc">자연</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="desti_type_num" id="cityTripLoc" value="2"
					  <c:if test="${dto.desti_type_num == 2}">checked</c:if>>
					  <label class="form-check-label" for="cityTripLoc">도시</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="desti_type_num" id="restTripLoc" value="3"
					  <c:if test="${dto.desti_type_num == 3}">checked</c:if>>
					  <label class="form-check-label" for="restTripLoc">휴양지</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="desti_type_num" id="historyTripLoc" value="4"
					  <c:if test="${dto.desti_type_num == 4}">checked</c:if>>
					  <label class="form-check-label" for="historyTripLoc">역사유적지</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="desti_type_num" id="unTripLoc" value="5"
					  <c:if test="${dto.desti_type_num == 5}">checked</c:if>>
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
					  <input class="form-check-input" type="radio" name="to_do_num" id="restToDo" value="1"
					  <c:if test="${dto.to_do_num == 1}">checked</c:if>>
					  <label class="form-check-label" for="restToDo">휴식</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="to_do_num" id="shoppingToDo" value="2"
					  <c:if test="${dto.to_do_num == 2}">checked</c:if>>
					  <label class="form-check-label" for="shoppingToDo">쇼핑</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="to_do_num" id="activityToDo" value="3"
					  <c:if test="${dto.to_do_num == 3}">checked</c:if>>
					  <label class="form-check-label" for="activityToDo">액티비티</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="to_do_num" id="movieToDo" value="4"
					  <c:if test="${dto.to_do_num == 4}">checked</c:if>>
					  <label class="form-check-label" for="movieToDo">여행영상 촬영</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="to_do_num" id="foodToDo" value="5"
					  <c:if test="${dto.to_do_num == 5}">checked</c:if>>
					  <label class="form-check-label" for="foodToDo">맛집 탐방</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="to_do_num" id="friendToDo" value="6"
					  <c:if test="${dto.to_do_num == 6}">checked</c:if>>
					  <label class="form-check-label" for="friendToDo">새친구 만들기</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="to_do_num" id="unToDo" value="7"
					  <c:if test="${dto.to_do_num == 7}">checked</c:if>>
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
					  <input class="form-check-input" type="radio" name="to_see_num" id="historyToSee" value="1"
					  <c:if test="${dto.to_see_num == 1}">checked</c:if>>
					  <label class="form-check-label" for="historyToSee">역사</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="to_see_num" id="artToSee" value="2"
					  <c:if test="${dto.to_see_num == 2}">checked</c:if>>
					  <label class="form-check-label" for="artToSee">예술</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="to_see_num" id="cultureToSee" value="3"
					  <c:if test="${dto.to_see_num == 3}">checked</c:if>>
					  <label class="form-check-label" for="cultureToSee">문화</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="to_see_num" id="naturalToSee" value="4"
					  <c:if test="${dto.to_see_num == 4}">checked</c:if>>
					  <label class="form-check-label" for="naturalToSee">자연경관</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="to_see_num" id="unToSee" value="5"
					  <c:if test="${dto.to_see_num == 5}">checked</c:if>>
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
					  <input class="form-check-input" type="radio" name="food_num" id="koreaFood" value="1"
					  <c:if test="${dto.food_num == 1}">checked</c:if>>
					  <label class="form-check-label" for="koreaFood">SNS맛집</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="food_num" id="localFood" value="2"
					  <c:if test="${dto.food_num == 2}">checked</c:if>>
					  <label class="form-check-label" for="localFood">현지인맛집</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="food_num" id="regionFood" value="3"
					  <c:if test="${dto.food_num == 3}">checked</c:if>>
					  <label class="form-check-label" for="regionFood">지역특산물위주</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="food_num" id="actFood" value="4"
					  <c:if test="${dto.food_num == 4}">checked</c:if>>
					  <label class="form-check-label" for="actFood">즉흥적으로</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="food_num" id="unFood" value="5"
					  <c:if test="${dto.food_num == 5}">checked</c:if>>
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
					  <input class="form-check-input" type="radio" name="meal_count_num" id="oftenFoodCount" value="1"
					  <c:if test="${dto.meal_count_num == 1}">checked</c:if>>
					  <label class="form-check-label" for="oftenFoodCount">자주, 적게</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="meal_count_num" id="onceFoodCount" value="2"
					  <c:if test="${dto.meal_count_num == 2}">checked</c:if>>
					  <label class="form-check-label" for="onceFoodCount">한번에 많이</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="meal_count_num" id="dietFoodCount" value="3"
					  <c:if test="${dto.meal_count_num == 3}">checked</c:if>>
					  <label class="form-check-label" for="dietFoodCount">다이어트</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="meal_count_num" id="unFoodCount" value="4"
					  <c:if test="${dto.meal_count_num == 4}">checked</c:if>>
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
					  <input class="form-check-input" type="radio" name="supply_num" id="allSupply" value="1"
					  <c:if test="${dto.supply_num == 1}">checked</c:if>>
					  <label class="form-check-label" for="allSupply">모두 챙김</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="supply_num" id="halfSupply" value="2"
					  <c:if test="${dto.supply_num == 2}">checked</c:if>>
					  <label class="form-check-label" for="halfSupply">반반</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="supply_num" id="localSupply" value="3"
					  <c:if test="${dto.supply_num == 3}">checked</c:if>>
					  <label class="form-check-label" for="localSupply">현지조달</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="supply_num" id="unSupply" value="4"
					  <c:if test="${dto.supply_num == 4}">checked</c:if>>
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
					  <input class="form-check-input" type="radio" name="photo_num" id="lifePhoto" value="1"
					  <c:if test="${dto.photo_num == 1}">checked</c:if>>
					  <label class="form-check-label" for="lifePhoto">인생샷을 위해</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="photo_num" id="roughPhoto" value="2"
					  <c:if test="${dto.photo_num == 2}">checked</c:if>>
					  <label class="form-check-label" for="roughPhoto">대충 흔적만</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="photo_num" id="viewPhoto" value="3"
					  <c:if test="${dto.photo_num == 3}">checked</c:if>>
					  <label class="form-check-label" for="viewPhoto">풍경 위주</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="photo_num" id="unPhoto" value="4"
					  <c:if test="${dto.photo_num == 4}">checked</c:if>>
					  <label class="form-check-label" for="unPhoto">무관</label>
					</div>
				</div>	
				
			</div><!-- .modal-body  -->
	      <div class="modal-footer">
	        <button type="button" class="btn btn-primary btn-lg shadow-sm " id="styleSearch" data-dismiss="modal">여행스타일 적용</button>
	        
	      </div>
	    </div>
	  </div>
	</div>
			
          
          <div class="row">
	          <label for="startPosition">출발지(선택)</label><br>
	          <div class="col-md-6 mb-3">
	          	<input type="text" class="form-control shadow-sm" name="start_loc_name" value="${dto.start_loc_name }" id="StartSelect" readonly="readonly">
	          	<input type="hidden" id="lat" name="start_loc_lat" value="">
	          	<input type="hidden" id="lng" name="start_loc_lng" value="">
	          </div>
	          <div class="col-md-6 mb-3">
	          	<button type="button" class="btn btn-dark btn-md btn-block shadow-sm" id="selectPositionBtn">장소선택</button>
	          </div>
          </div> 
          
          
           <div class="col-md-6 mb-3">
            <label for="age">출발시간(선택)</label>
            	<p>
            		<input class="form-select" onchange="time(this)" type="time" value="${dto.start_loc_date }" min="yyy" max="zzz" name="start_loc_date"> 
            	</p>
            	<!-- 
            	value : 선택 항목으로, 기본 날짜를 정한다.
				min : 선택 항목으로, 입력 가능한 가장 빠른 날짜이다.
				max : 선택 항목으로, 입력 가능한 가장 늦은 날짜이다.
            	 -->
          </div>
          
          <%-- 
          <!-- 예산 검색 -->		
	         <div class="col-md-6"  >
             <ul style="padding: 0" >
             <label for="form-label">예산</label><br>
               <button type="button" class="btn btn-dark w-5 h-3" id="budget" 
               data-bs-toggle="dropdown" aria-expanded="false">
               예산
               </button>
                 <ul class="dropdown-menu budgetMenu px-3 py-2"
                  style="background-color: #E5E5E5;">
                    <li class="d-flex">
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
	          --%>
          <div class="mb-3">
            <label for="budget">예산</label>
            <select class="form-select d-block w-100 shadow-sm" id="budget" name="budget" required>
				<option value="">예산 선택</option>
				<option value="100000" <c:if test="${dto.budget == 100000}">selected</c:if>>100,000원 이하</option>
				<option value="200000" <c:if test="${dto.budget == 200000}">selected</c:if>>200,000원</option>
				<option value="300000" <c:if test="${dto.budget == 300000}">selected</c:if>>300,000원</option>
				<option value="400000" <c:if test="${dto.budget == 400000}">selected</c:if>>400,000원</option>
				<option value="500000" <c:if test="${dto.budget == 500000}">selected</c:if>>500,000원</option>
				<option value="600000" <c:if test="${dto.budget == 600000}">selected</c:if>>600,000원</option>
				<option value="700000" <c:if test="${dto.budget == 700000}">selected</c:if>>700,000원</option>
				<option value="800000" <c:if test="${dto.budget == 800000}">selected</c:if>>800,000원</option>
				<option value="900000" <c:if test="${dto.budget == 900000}">selected</c:if>>900,000원</option>
				<option value="1000000" <c:if test="${dto.budget == 1000000}">selected</c:if>>1,000,000원</option>
			</select>
            <div class="invalid-feedback">
              예산을 선택해주세요.
            </div>
          </div>
          
          
		  
          
          <br /><br />
          <div class="row">
          
	          <div class="col-md-6 mb-4">
		          <button class="btn btn-primary btn-md btn-block shadow" 
		          style="width: 100%;" type="submit" onclick="region_submit()">수정</button>
	          </div>
	          <div class="col-md-6 mb-4">
		          <button id="cancel" class="btn btn-dark btn-md btn-block shadow" onclick="location.href='planner.action'" style="width: 100%;" type="button">취소</button>
	          </div>
          </div>
          <input type="hidden" id="room_num" name="room_num" value="${dto.room_num }">
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

</html>>