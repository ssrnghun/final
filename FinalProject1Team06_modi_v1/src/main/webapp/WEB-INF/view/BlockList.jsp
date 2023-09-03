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

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">

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

	<button class="float-start p-2"
		style="border: none; background-color: white; color: #48AFB4; font-family: Merriweather; font-size: 20px;" onclick="history.back()">
		<i class="bi bi-arrow-bar-left"></i> BACK
	</button>
	<br>

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
				
			</div>
		</div>
	</div>
</body>
</html>