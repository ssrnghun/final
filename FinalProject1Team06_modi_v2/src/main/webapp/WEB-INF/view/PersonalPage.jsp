<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%
	request.setCharacterEncoding("UTF-8");
String cp = request.getContextPath();
String room_num = request.getParameter("room_num");

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PersonalPage.jsp</title>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
	integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"
	integrity="sha384-fbbOQedDUMZZ5KreZpsbe1LCZPVmfTnH7ois6mU1QK+m14rQ1l2bGBq41eYeM/fS"
	crossorigin="anonymous"></script>
	
<link rel="canonical" href="https://getbootstrap.kr/docs/5.2/examples/dashboard/">
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.1/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/j
s/bootstrap.min.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">

<link rel="stylesheet" type="text/css"  href="<%=cp %>/css/mypage.css">
<style type="text/css">
	/* 스크롤바 생성 */
	.listbox {
	  overflow-y: scroll;
	  height: 400px; 
	  width: 800px; 
	  border: 3px solid gray; 
	  border-radius: 15px;
	  ms-overflow-style: none; /* IE and Edge */
      scrollbar-width: none; /* Firefox */
	}
	.listbox::-webkit-scrollbar {
	    display: none; /* Chrome, Safari, Opera*/
	}
</style>

<script type="text/javascript"
	src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function()
	{
		$("#popTrip").popover();
		$("#popEti").popover();
		  
		$(".label_star").click(function()
		{
			 $("#score").text($(this).find('span').text());
		});
		$(".etiRate").click(function()
		{
			$("#score").text("별을 클릭해주세요.");
			
			 $('input:radio[name="starpoint"]').prop("checked", false);
		})
	
	    // 모달창이 열리고 닫힐 때 뒷 배경을 비활성화/활성화 처리
	    $('#myModal').on('show.bs.modal', function () {
	      $('#backdrop').show();
	      
	    });

	    $('#myModal').on('hidden.bs.modal', function () {
	      $('#backdrop').hide();
	    });
	    
	    $('#myModal2').on('show.bs.modal', function () {
	      $('#backdrop').show();
	    });

	    $('#myModal2').on('hidden.bs.modal', function () {
	      $('#backdrop').hide();
	    });
	    $('#myModal3').on('show.bs.modal', function () {
	      $('#backdrop').show();
	    });

	    $('#myModal3').on('hidden.bs.modal', function () {
	      $('#backdrop').hide();
	    });
	    
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
	    
	    var today = new Date();
	    var year = today.getFullYear();
	    var month = ('0' + (today.getMonth() + 1)).slice(-2);
	    var day = ('0' + today.getDate()).slice(-2);
	    
	    str = year+"-"+month+"-"+day;
	    $("#date").text(str); 
	    
	    $(".rate").click(function()
		{
	    	// 점수
	        var score = $("#score").text();
			var nik = $("#name").attr("class");
			// 개인페이지 계정 아이디
			var etiId = '<c:out value="${etiId}"/>';
			
			if(confirm("'"+nik+"'님에게 에티켓 점수'"+score+"'을 부여하시겠습니까?"))
			{
				var params = "score="+score+"&etiId="+etiId; 
				
		         $.ajax({
		             url: 'etirate.action',	// 데이터를 받아올 서버 URL
		             type: 'GET',
		             data:params, 				// 받아온 데이터 형식 (JSON)
		             success: function(data) {
		            	 
		            	 alert(data);
		             },
		             error: function(xhr, status, error) {
		                 console.log('Ajax 요청 실패:', error);
		             }
		         });
			}
		});
	    
	    var str = '<c:out value="${str}"/>';
	    
	    if(str != "")
	    {
	    	alert(str);
	    }
	    
	});
</script>
</head>
 

<body id="body">

	<!-- 플래너로 이동 -->
	<button class="float-start p-2"
		style="border: none; background-color: white; color: #48AFB4; font-family: Merriweather; font-size: 20px;" onclick="location.href='planner.action?room_num=${room_num }'">
		<i class="bi bi-arrow-bar-left"></i> PLANNER
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
              	<!-- 닉네임 성별 -->
               	<div id="name" class="name" >${info.nikname}
               	
               	<c:if test="${info.gender == '여'}">
               		<i class="bi bi-gender-female" style="color:#87BDC7; "></i>
               	</c:if>
               	<c:if test="${info.gender == '남'}">
               		<i class="bi bi-gender-male" style="color:#87BDC7; "></i>
               	</c:if>
               	</div>
				<br><br>
				
				<!-- 자기소개 -->
				<div class="mb-3 d-flex " style="margin-left: 50px">
				  <label for="exampleFormControlTextarea1" class="form-label justify-content-center">자기소개
				  <textarea class="form-control justify-content-center " id="exampleFormControlTextarea1" rows="3" readonly="readonly" 
				  style="width: 300px;">${info.introduce }</textarea>
				  </label>
				</div>

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
				
			<!-- 버튼을 클릭하면 모달창이 열리도록 설정 -->
			<button type="button" class="btn btn-primary etiRate" data-toggle="modal" data-target="#myModal">
			  에티켓 점수 평가하기
			</button>
			
			<!-- 에티켓 점수 모달창 -->
			<div class="modal" id="myModal" tabindex="-1" role="dialog">
			  <div class="modal-dialog modal-dialog-centered" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h5 class="modal-title">에티켓 점수 평가</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true">&times;</span>
			        </button>
			      </div>
			      <div class="modal-body">
			        <p>※ 에티켓 점수는 한 사람에게 하루에 한 번 평가 가능합니다.※</p>
			        <h7 style="float: left" id="date"> 일자 : </h7><br><br>
			        <h4> 나 → ${info.nikname} </h4><br>
					<div class="starpoint_wrap">
						<div class="starpoint_box">
							<label for="starpoint_1" class="label_star" title="1">
								<span class="blind">1점</span>
							</label> 
							<label for="starpoint_2" class="label_star" title="2">
								<span class="blind">2점</span>
							</label>
							<label for="starpoint_3" class="label_star" title="3">
								<span class="blind">3점</span>
							</label> 
							<label for="starpoint_4" class="label_star" title="4">
								<span class="blind">4점</span>
							</label>
							<label for="starpoint_5" class="label_star" title="5">
								<span class="blind">5점</span>
							</label> 
							<input type="radio" name="starpoint" id="starpoint_1" class="star_radio">
							<input type="radio" name="starpoint" id="starpoint_2" class="star_radio"> 
							<input type="radio" name="starpoint" id="starpoint_3" class="star_radio">
							<input type="radio" name="starpoint" id="starpoint_4" class="star_radio">
							<input type="radio" name="starpoint" id="starpoint_5" class="star_radio">
							<span class="starpoint_bg etiScore"></span>
						</div>
					</div>
					<br> <br>
					<span id="score" style="color: red">별을 클릭해주세요.</span>
				</div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-secondary rate" data-dismiss="modal" >평가하기</button>
			    </div>
			    </div>
			    </div>
			    </div>
					    
					<!-- 뒷 배경을 가리는 투명한 레이어 -->
				<div class="modal-backdrop show" id="backdrop" style="display: none;"></div>
				<br><br>
				<button type="button" class="btn btn-light" data-toggle="modal" data-target="#myModal2">프로필 신고하기</button>
				<!-- 신고하기 모달창 -->
				<div class="modal" id="myModal2" tabindex="-1" role="dialog">
					<div class="modal-dialog modal-dialog-centered" role="document">
						<form action="pfreport.action">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title">${info.nikname }님을 신고하시겠습니까?</h5>
									<input type="hidden" id="reportedId" name="reportedId"
										value="${etiId }">
									<button type="button" class="close" data-dismiss="modal"
										aria-label="Close">
										<span aria-hidden="true">&times;</span>
									</button>
								</div>
								<div class="modal-body">
									<span style="color: red; font-size: 14px">허위 신고의 경우
										신고자에게 제재가 가해질 수 있습니다.</span><br>
									<br>
									<div class="row">

										<div class="col-md-3">
											<span class="sinGoTxt align-middle">신고사유</span>
										</div>
										<div class="col-md-9">
											<select class="form-select"
												aria-label="Default select example" style="width: 350px"
												id="report_reason_num" name="report_reason_num">
												<option selected>===========선택===========</option>
												<option value="1">스팸, 홍보, 도배</option>
												<option value="2">욕설 및 선정적인 내용</option>
												<option value="3">도용, 명예훼손 및 비방, 초상권 및 저작권 침해</option>
												<option value="4">범죄</option>
											</select>
										</div>
									</div>
									<br> <span style="float: left">신고상세내용</span><br>
									<textarea rows="3" cols="59" id="content" name="content"></textarea>
								</div>
								<div class="modal-footer">
									<button type="submit" class="btn btn-primary" id="report">신고하기</button>
									<button type="reset" class="btn btn-secondary"
										data-dismiss="modal">취소하기</button>
								</div>
							</div>
						</form>
					</div>
				</div>
				<button type="button" class="btn btn-light" data-toggle="modal" data-target="#myModal3">차단하기</button>
				<br>
				<br>
				
				<!-- 차단하기 모달창 -->
				<div class="modal" id="myModal3" tabindex="-1" role="dialog">
					<div class="modal-dialog modal-dialog-centered" role="document">
						<div class="modal-content">
							<form action="block.action">
								<div class="modal-header">
									<h5 class="modal-title">${info.nikname }님을 차단하시겠습니까?</h5>
									<input type="hidden" id="blockedId" name="blockedId"
										value="${etiId }">
									<button type="button" class="close" data-dismiss="modal"
										aria-label="Close">
										<span aria-hidden="true">&times;</span>
									</button>
								</div>
								<div class="modal-body">
									<p style="color: red; text-align: left;">
										차단 이후에는 회원님과 ${info.nikname }님은 <br>서로의 계정 정보를 확인할 수
										없습니다.<br> 상대방과 주고 받은 여행 점수 및 에티켓 점수는 초기화됩니다.<br> 차단
										사유는 다른 이용자가 볼 수 없으며, <br> 회원님만 차단 목록을 통해 추후에 확인가능합니다.
									</p>
									<br> <span style="float: left;">차단사유</span><br>
									<textarea rows="3" cols="55" id="reason" name="reason"></textarea>
								</div>
								<div class="modal-footer">
									<button type="submit" class="btn btn-secondary" >차단하기</button>
									<input type="hidden" id="room_num" name="room_num" value="<%=room_num%>">
									<button type="reset" class="btn btn-secondary"
										data-dismiss="modal">취소하기</button>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
				<div class="col-sm-8 col-md-8 col-lg-8" style="padding-top: 10px">
						<span class="myTrip float-start" style="font-size: 20px">참여중인 방 목록 <i class="bi bi-people-fill"></i></span>
						<br>
						<br>
						<div class="listbox row p-3 pt-1" style="border-color: #87BDC7">
							<c:forEach var="dto" items="${joinroom }">
								<div class="card p-10 x-10 m-2"
									style="width: 400px; height: 130px; border-width: 5px; border-color: #48AFB4">
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
											<a href="#" class="card-link float-end"
												style="text-decoration: none; font-size: 8px"> <i
												class="bi bi-arrow-return-right"></i> 해당 방으로 이동하기
											</a>
										</p>
									</div>
								</div>
							</c:forEach>
						</div>
			</div>
	</div>



</body>
</html>