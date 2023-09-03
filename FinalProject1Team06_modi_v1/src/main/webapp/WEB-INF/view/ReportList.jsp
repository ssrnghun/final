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
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>ReportList.jsp</title>
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/memberList.css">
<style type="text/css">
	th {text-align: center;}
	td {text-align: center;}
	
	.pagination-container 
	{
  		text-align: center;
	}

	.pagination .page-item.active .page-link 
	{
	  	background-color: #e5e5e5;
	  	border-color: #e5e5e5; 
	}
</style>

<script type="text/javascript">

	$(function()
	{
		$(".btn-danger").click(function()
		{
			$(location).attr("href", "reportprocess.action?num=" + $(this).val());
		});
		
		var searchKey = '<c:out value="${searchKey}"/>';
		
		if (searchKey == "")
			$("#searchKey").val("reporterId");
		else
			$("#searchKey").val(searchKey);	
		
	});

</script>

</head>
<body>

<!-- 메인 메뉴 영역 -->
<header class="p-3 text-bg-dark">
	<div class="container">
		<div class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start">
			<ul class="nav col-12 col-lg-auto me-lg-auto mb-2 justify-content-center mb-md-0">
          		<li><a href="memberlist.action" class="nav-link  text-white">회원 관리</a></li>
          		<li><a href="penaltylist.action" class="nav-link text-white">패널티 관리</a></li>
          		<li><a href="reportlist.action" class="nav-link text-white">신고 관리</a></li>
          		<li><a href="adminloginform.action" class="nav-link  text-white">로그아웃</a></li>
        	</ul>
      	</div>
	</div>
</header>

<br>
<div class="container">
	<div class="panel-group">
		<div class="panel panel-default">
		
			<div class="panel-heading row">
				<span style="font-size: 17pt; font-weight: bold;" class="col-md-3">
					신고 이력 현황
				</span>
				<form action="reportlist.action" method="post">
					<div class="input-group">
						<div class="input-container">
							<select id="searchKey" name="searchKey" class="form-control">
								<option value="reporterId">신고자 아이디</option>
								<option value="reportedId">피신고자 아이디</option>
							</select>
						</div>
						<div class="input-container">
							<input type="text" id="searchValue" name="searchValue" class="form-control" value="${searchValue }">
							<input type="submit" class="btn btn-secondary" value="검색">
						</div>
					</div>
				</form>
			</div>
			
			<div class="panel-body">
				전체 신고 내역 <span class="bedge">${count } 건</span>
			</div>
			
			<div class="panel-body">
				<table class="table table-hover table-striped">
					<thead>
						<tr>
							<th>번호</th>
							<th>신고자아이디</th>
							<th>피신고자아이디</th>
							<th>신고사유</th>
							<th>신고내용</th>
							<th>신고일자</th>
							<th>신고처리</th>
						</tr>
					</thead>
					
					<tbody>
						<c:forEach var="list" items="${list }">
						<tr>
							<td>${list.num }</td>
							<td>${list.reporterId }</td>
							<td>${list.reportedId }</td>
							<td>${list.reason }</td>
							<td>${list.content }</td>
							<td>${list.reportDate }</td>
							<td>
							<c:if test="${list.result eq '대기' }">
								<button type="button" id="num" name="num" class="btn btn-danger" value="${list.num }">처리</button>
							</c:if>
							<c:if test="${list.result eq '완료' }">
								<button type="button" class="btn btn-dark" disabled="disabled">완료</button>
							</c:if>
							</td>
						</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div class="pagination-container ">
				<nav aria-label="Page navigation example">
					<ul class="pagination justify-content-center">
						<c:if test="${count != 0}">
							${pageIndexList }
						</c:if>
					</ul>
				</nav>
			</div>
		</div>
	</div>
</div>

</body>
</html>