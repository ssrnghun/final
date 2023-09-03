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
<title>MemberList.jsp</title>
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
		
		var searchKey = '<c:out value="${searchKey}"/>';
		
		if (searchKey == "")
			$("#searchKey").val("idNum");
		else
			$("#searchKey").val(searchKey);
		
	});
	
	function movePersonalPage(btn)
	{
		alert(btn.value);
		$(location).attr("href", "personalpage.action?etiId=" + btn.value); 
	}
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
					회원 목록 출력
				</span>
				<form action="memberlist.action" method="post">
					<div class="input-group">
						<div class="input-container">
							<select id="searchKey" name="searchKey" class="form-control">
								<option value="idNum">아이디번호</option>
								<option value="id">아이디</option>
								<option value="name">이름</option>
								<option value="memStatus">회원상태</option>
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
				전체 회원 수 <span class="bedge">${count } 명</span>
			</div>
			
			<div class="panel-body">
				<table class="table table-hover table-striped">
					<thead>
						<tr class="trTitle">
							<th>번호</th>
							<th>아이디번호</th>
							<th>아이디</th>
							<th>이름</th>
							<th>주민등록번호</th>
							<th>회원상태</th>
							<th>비고</th>
						</tr>
					</thead>
					
					<tbody>
						<c:forEach var="list" items="${list }">
						<tr>
							<td>${list.num }</td>
							<td>${list.idNum }</td>
							<td>${list.id }</td>
							<td>${list.name }</td>
							<td>${list.ssn }</td>
							<td>${list.memStatus }</td>
							<td>
							<c:choose>
								<c:when test="${list.memStatus eq '탈퇴회원(재가입 가능)' or list.memStatus eq '탈퇴회원(재가입 불가)'}">
									<!-- 
                    				<button type="button" class="btn btn-success" disabled>상태수정</button>
                    				<button type="button" class="btn btn-danger" disabled>마이페이지이동</button>
                    				-->
                				</c:when>
                			<c:otherwise>
                    			<%-- <button type="button" id="btnModify" class="btn btn-success" value="${list.idNum }">상태수정</button> --%>
                    			<button type="button" id="movePage" class="btn btn-primary" value="${list.id }" onclick="movePersonalPage(this)">개인페이지</button>
                			</c:otherwise>
            				</c:choose>
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