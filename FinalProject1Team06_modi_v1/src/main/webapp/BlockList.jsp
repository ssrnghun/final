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
<title>BlockList.jsp</title>

<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
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
	.panel-default
	{
		margin-top: 30px;
	}
</style>


</head>
<body>
	<nav>
		<jsp:include page="/WEB-INF/view/User_menuBar.jsp"></jsp:include>
	</nav>

	<div class="container">
		<div class="panel-group">
			<div class="panel panel-default">

				<div class="panel-heading row">
					<span style="font-size: 17pt; font-weight: bold;" class="col-md-3">
						차단 목록 </span>
				</div>

				<div class="panel-body">
					전체 인원 수 <span class="bedge">${count }명</span>
				</div>

				<div class="panel-body">
					<table class="table table-hover table-striped text-center">
						<thead>
							<tr>
								<th>번호</th>
								<th>닉네임</th>
								<th>차단일자</th>
								<th>차단사유</th>
							</tr>
						</thead>
						<c:forEach var="dto" items="${list }">
							<tr>
								<td>${dto.num}</td>
								<td>${dto.nikName}</td>
								<td>${dto.blockDate}</td>
								<td>${dto.reason }</td>
							</tr>
						</c:forEach>
						</tbody>
					</table>
				</div>

				<div class="pagination-container">
					<nav aria-label="Page navigation example">
						<ul class="pagination">
							<li class="page-item"><a class="page-link" href="#"
								aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
							</a></li>
							<li class="page-item"><a class="page-link" href="#">1</a></li>
							<li class="page-item"><a class="page-link" href="#"
								aria-label="Next"> <span aria-hidden="true">&raquo;</span>
							</a></li>
						</ul>
					</nav>
				</div>
				
				
				
			</div>
		</div>
	</div>
</body>
</html>