<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.Date, java.text.SimpleDateFormat, java.util.Calendar" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가계부</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
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

<link rel="canonical"
	href="https://getbootstrap.kr/docs/5.2/examples/dashboard/">
<script
	src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.1/dist/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">

<style type="text/css">
.day {
	color: #535353;
	font-family: Merriweather;
	font-size: 30px;
	font-style: normal;
	font-weight: 700;
	line-height: 0px; /* 0% */
	float: right;
	position: relative;
	right: 20px;
	top: 15px;
}

.card {
	width: 800px;
	float: left;
}
.add-cost
{
	position: relative;
	top: 20px;
}
.total-cost
{
	float: right;
	width: 300px;
	text-align: center;
}

</style>
<script type="text/javascript">

	function whatDays(num) 
	{
		//alert(num);
		// 전체 일자 선택했을 때
		if(num == 0)
		{
			$(location).attr("href", "accountlist.action?page=2&room_num=" 
					+ "<c:out value='${planner.room_num}'/>");
		}
		else
		{
			$(location).attr("href", "accountlist.action?page=2&day="
			+num+"&room_num=" + "<c:out value='${planner.room_num}'/>");
		}
	}
	

</script>

</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top bg-light" style="width: 100%; margin: auto; ">
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
         			<a class="nav-link" href="planner.action?room_num=${planner.room_num}&page=1">
         				<span style="font-weight: bold; 
         				${page == 1 || (planner.plan_onoff == '계획전달' && page == -1) ? 'color: #FF6666;' : ''}"
         				>플래너</span>
         			</a>
         		</li>
         		<c:if test="${planner.plan_onoff != '계획전달' }">
         		<li class="nav-item">
         			<a class="nav-link" href="planner.action?room_num=${planner.room_num}&page=-1">
         				<span style="font-weight: bold; ${page == -1 ? 'color: #FF6666;' : ''}"
         				>컬렉션</span>
         			</a>
         		</li>
         		</c:if>
         		<li class="nav-item">
         			<a class="nav-link" href="planner.action?room_num=${planner.room_num}&page=0">
         				<span style="font-weight: bold;  ${page == 0 ? 'color: #FF6666;' : ''}"
         				>피드</span>
         			</a>
         		</li>
         		<li class="nav-item">
         			<a class="nav-link" href="accountlist.action?room_num=${planner.room_num }&page=2">
         				<span style="font-weight: bold;  ${page == 2 ? 'color: #FF6666;' : ''}"
         				>가계부</span>
         			</a>
         		</li>
         		<li class="nav-item">
         			<a class="nav-link" href="roomlist.action">
         				<span style="font-weight: bold;">룸 리스트</span>
         			</a>
         		</li>
      		</ul>
    	</div>
    	</nav>
    	<br><br><br>

	<div class="container py-4">
		<button type="button" class="btn btn-light" 
		onclick="location.href='accountcal.action?room_num=${planner.room_num }'">정산하기</button>
		<a class="btn btn-secondary dropdown-toggle" href="#" role="button"
			data-bs-toggle="dropdown" aria-expanded="false">일자 선택</a>
		<ul class="dropdown-menu">
			<li><a class="dropdown-item" href="#1" onclick="whatDays(0)">전체일자</a></li>
			<!-- 드롭다운 마지막 일차까지 돌리는 forEach 구문 -->
				
				<!-- Calendar 객체 -->
				<c:set var="calendar" value="<%= Calendar.getInstance() %>" />
				<fmt:parseDate var="startDate" value="${planner.trip_start_date }" pattern="yyyy-MM-dd" />
				
			<c:forEach var="n" begin="1" end="${planner.days }" step="1">
				<c:set target="${calendar}" property="time" value="${startDate}" />
				
				<c:set var="daysToAdd" value="${n }" />
				<c:set target="${calendar}" property="timeInMillis" value="${calendar.timeInMillis + (daysToAdd-1) * 24 * 60 * 60 * 1000}" />
				
				<fmt:formatDate value="${calendar.time}" pattern="yyyy-MM-dd" var="newDate"  />
				
				<!-- 일자 선택 -->
				<li><a class="dropdown-item" href="#${n}" onclick="whatDays(${n})"> DAY ${n } | 
				<c:out value="${newDate }"/>
				</a></li>
			</c:forEach>
		</ul>
		
		<div class="card total-cost">
		  <div class="card-body">
			총 ￦<fmt:formatNumber groupingUsed="true"
			value="${cost}"></fmt:formatNumber> 원 지출
		  </div>
		</div>
		<br><br>
		<br>
		<br>
		
		<input type="hidden" id="dayFlag" name="dayFlag" value=${dayFlag }> 
		<!-- 1일차 가계부 -->
		
		<!-- 일자 선택했을 때 -->
		<c:if test="${dayFlag != ''}">
			<div>
				<div class="row">
					<div class="col-2">
						 <span class="day">  DAY ${dayFlag }</span><br>
						<br>
						
						<!-- 캘린더 객체 -->
						<c:set var="calendar2" value="<%= Calendar.getInstance() %>" />
						<fmt:parseDate var="startDate2"
							value="${planner.trip_start_date }" pattern="yyyy-MM-dd" />
						<c:set target="${calendar2}" property="time" value="${startDate2}" />

						<c:set var="daysToAdd2" value="${dayFlag }" />
						<c:set target="${calendar2}" property="timeInMillis"
							value="${calendar2.timeInMillis + (daysToAdd2-1) * 24 * 60 * 60 * 1000}" />

						<fmt:formatDate value="${calendar2.time}" pattern="yyyy-MM-dd"
							var="newDate2" />

						<span class="day" style="font-size: 20px"><c:out
								value="${newDate2 }" /></span>
						
						
						<span class="day" style="font-size: 20px">
						${account.nalza }</span>
					</div>
					<div class="col-11">
						<!-- 가계부 내역 출력 -->
						<c:forEach var="account" items="${accountListSel}">
						<div class="card">
							<div class="card-body">
								<div class="row">
									<div class="col-md-1"> ${account.pccontent}</div>
									<div class="col-md-3">
										<span> <i class="bi bi-clipboard2-check-fill"></i>
											${account.content}
										</span>
									</div>
									<div class="col-md-2">
										<span class="float-end">￦<fmt:formatNumber groupingUsed="true"
												value="${account.cost}"></fmt:formatNumber></span>
									</div>
									<div class="col-md-4">
										<span class="float-end"><i class="bi bi-people-fill"></i>
											${account.nikname }</span>
									</div>
								<div class="col-md-2">
								<button type="button" class="btn btn-primary float-end"
								onclick="location.href='accountdel.action?pay_num=
								${account.pay_num }&room_num=${planner.room_num }'"
								${planner.id_num != id_num ? "disabled='disabled'":"" }>삭제</button>
								</div>
								</div>
							</div>
						</div>
					</c:forEach>
					</div>
				</div>
				<div style="text-align: center">
					<button type="button" class="btn btn-secondary add-cost"
					onclick="location.href='accountadd.action?day=${dayFlag }&date=${newDate2 }
							 &room_num=${planner.room_num }'"
							 ${planner.id_num != id_num ? "disabled='disabled'":"" }>비용추가</button>
				</div>
			</div>
			<br>
			<br>
			<hr>
		</c:if>
		
		<c:if test="${dayFlag == ''}">
		<c:forEach var="m" begin="1" end="${planner.days }" step="1">
			<div>
				<div class="row">
					<div class="col-2">
						<span class="day">DAY ${m}</span><br>
						<br>

						<!-- 캘린더 객체 -->
						<c:set var="calendar1" value="<%= Calendar.getInstance() %>" />
						<fmt:parseDate var="startDate1"
							value="${planner.trip_start_date }" pattern="yyyy-MM-dd" />
						<c:set target="${calendar1}" property="time" value="${startDate1}" />

						<c:set var="daysToAdd1" value="${m }" />
						<c:set target="${calendar1}" property="timeInMillis"
							value="${calendar1.timeInMillis + (daysToAdd1-1) * 24 * 60 * 60 * 1000}" />

						<fmt:formatDate value="${calendar1.time}" pattern="yyyy-MM-dd"
							var="newDate1" />

						<span class="day" style="font-size: 20px"><c:out
								value="${newDate1 }" /></span>
					</div>
					<div class="col-10">
						<!-- 가계부 내역 출력 -->
						<c:forEach var="account" items="${accountList}">
							<c:choose>
								<c:when test="${m == account.day}">
									<div class="card" style="width: 1000px">
										<div class="card-body">
											<div class="row">
												<div class="col-md-1">${account.pccontent}</div>
												<div class="col-md-3">
													<span> <i class="bi bi-clipboard2-check-fill"></i>
														${account.content}
													</span>
												</div>
												<div class="col-md-2">
													<span class="float-end">￦<fmt:formatNumber groupingUsed="true"
															value="${account.cost}"></fmt:formatNumber></span>
												</div>
												<div class="col-md-4">
													<span class="float-end" ><i class="bi bi-people-fill"></i>
														${account.nikname }</span>
												</div>
												<div class="col-md-2">
												<button type="button" class="btn btn btn-outline-secondary float-end"
												onclick="location.href='accountdel.action?pay_num=${account.pay_num }&room_num=${planner.room_num }'"
												${planner.id_num != id_num ? "disabled='disabled'":'' }>삭제</button>
												</div>
											</div>
										</div>
									</div>
								</c:when>
							</c:choose>
							
						</c:forEach>
					</div>
				</div>
				<div style="text-align: center">
					<button type="button" class="btn btn-secondary add-cost"
					onclick="location.href='accountadd.action?day=${m}&date=${newDate1 }&room_num=${planner.room_num }'"
					${planner.id_num != id_num ? "disabled='disabled'":'' }>비용추가</button>
				</div>
			</div>
			<br>
			<br>
			<hr>
		</c:forEach>
		</c:if>
		<!-- 1일차 가계부 끝 -->
		
		
</div>		
</body>
</html>