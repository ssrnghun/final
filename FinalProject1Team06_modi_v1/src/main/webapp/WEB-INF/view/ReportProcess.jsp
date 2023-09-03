<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>ReportProcess.jsp</title>

<!-- jquery -->
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script type="text/javascript">

	$(function()
	{
		$("#btnCheck").click(function()
		{
			if ($("#selectPenalty").val() == "0")
			{
				alert("필수 항목을 선택해주세요.");
				return false;
			}
			
		});
	});

</script>

<style type="text/css">
	#basic-addon1
	{
		width: 130px;
		text-align: right;
	}
	#basic-addon2
	{
		width: 130px;
		text-align: right;
	}
	#basic-addon3
	{
		width: 130px;
		text-align: right;
	}
</style>

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
<div class="container">
	<div class="panel-group">
		<div class="panel panel-default">
		
			<div class="panel-heading row">
				<span style="font-size: 17pt; font-weight: bold;" class="col-md-3">
					신고 처리
				</span>
			</div>
			
			<div class="panel-body">
			
				<form action="reportupdate.action" method="post" id="myForm">
					<table class="table table-striped">
					
						<tr>
							<td>
								<div class="input-group" role="group">
									<span class="input-group-addon" id="basic-addon1">
										번호
									</span>
									<input type="text" id="num" name="num" class="form-control" maxlength="30" value="${dto.num }" readonly="readonly">
									<span class="input-group-addon"></span>
								</div>
							</td>
						</tr>
						
						<tr style="height: 10px;">
						</tr>
						
						<tr>
							<td>
								<div class="input-group" role="group">
									<span class="input-group-addon" id="basic-addon2">
										신고자 아이디
									</span>
									<input type="text" id="reporterId" name="reporterId" class="form-control" value="${dto.reporterId }" readonly="readonly">
									<span class="input-group-addon"></span>
								</div>
							</td>
						</tr>
						
						<tr style="height: 10px;">
						</tr>
						
						<tr>
							<td>
								<div class="input-group" role="group">
									<span class="input-group-addon" id="basic-addon3">
										피신고자 아이디
									</span>
									<input type="text" id="reportedId" name="reportedId" class="form-control" value="${dto.reportedId }" readonly="readonly">
									<span class="input-group-addon"></span>
								</div>
							</td>
						</tr>
						
						<tr style="height: 10px;">
						</tr>
						
						<tr>
							<td>
								<div class="input-group" role="group">
									<span class="input-group-addon" id="basic-addon3">
										신고사유
									</span>
									<input type="text" id="reason" name="reason" class="form-control" value="${dto.reason }" readonly="readonly">
									<span class="input-group-addon"></span>
								</div>
							</td>
						</tr>
						
						<tr style="height: 10px;">
						</tr>
						
						<tr>
							<td>
								<div class="input-group" role="group">
									<span class="input-group-addon" id="basic-addon3">
										신고내용
									</span>
									<input type="text" id="content" name="content" class="form-control" value="${dto.content }" readonly="readonly">
									<span class="input-group-addon"></span>
								</div>
							</td>
						</tr>
						
						<tr style="height: 10px;">
						</tr>
						
						<tr>
							<td>
								<div class="input-group" role="group">
									<span class="input-group-addon" id="basic-addon3">
										신고일자
									</span>
									<input type="text" id="reportDate" name="reportDate" class="form-control" value="${dto.reportDate }" readonly="readonly">
									<span class="input-group-addon"></span>
								</div>
							</td>
						</tr>
						
						<tr style="height: 10px;">
						</tr>
						
						<tr>
							<td>
								<div class="input-group" role="group">
									<span class="input-group-addon" id="basic-addon3">
										신고처리상태
									</span>
									<input type="text" id="result" name="result" class="form-control" value="${dto.result }" readonly="readonly">
									<span class="input-group-addon"></span>
								</div>
							</td>
						</tr>
						
						<tr style="height: 10px;">
						</tr>
						
						<tr>
							<td>
								<div class="input-group" role="group">
									<span class="input-group-addon" id="basic-addon3">
										<sup style="color: red;">※</sup>신고처리
									</span>
    										
									<c:if test="${dto.receiptNum eq 'ROOM' }">
										<select class="form-control" id="selectPenalty" name="selectPenalty">
											<option value="0" selected="selected">선택</option>
   											<option value="1">1. 블라인드 해제</option>
	    									<option value="2">2. 블라인드 해제 + 신고자 계정정지 3일</option>
	    									<option value="3">3. 방 삭제</option>
	    									<option value="4">4. 방 삭제 + 피신고자 방 개설 금지 3일</option>
	    									<option value="5">5. 방 삭제 + 피신고자 방 개설 금지 5일</option>
	    									<option value="6">6. 방 삭제 + 피신고자 방 개설 금지 7일</option>
	    									<option value="7">7. 방 삭제 + 피신고자 계정정지 14일</option>
	    								</select>
									</c:if>
									<c:if test="${dto.receiptNum eq 'COLLECTION' }">
										<select class="form-control" id="selectPenalty" name="selectPenalty">
											<option value="0" selected="selected">선택</option>
											<option value="1">1. 블라인드 해제</option>
		   									<option value="2">2. 블라인드 해제 + 신고자 계정정지 3일</option>
		   									<option value="3">3. 글 삭제</option>
		   									<option value="4">4. 글 삭제 + 피신고자 방 개설 금지 3일</option>
		   									<option value="5">5. 글 삭제 + 피신고자 방 개설 금지 5일</option>
		   									<option value="6">6. 글 삭제 + 피신고자 방 개설 금지 7일</option>
		   									<option value="7">7. 글 삭제 + 피신고자 계정정지 14일</option>
	   									</select>
									</c:if>
									<c:if test="${dto.receiptNum eq 'PLANMEMO' }">
										<select class="form-control" id="selectPenalty" name="selectPenalty">
											<option value="0" selected="selected">선택</option>
 											<option value="1">1. 블라인드 해제</option>
		   									<option value="2">2. 블라인드 해제 + 신고자 계정정지 3일</option>
		   									<option value="3">3. 글 삭제</option>
		   									<option value="4">4. 글 삭제 + 피신고자 방 개설 금지 3일</option>
		   									<option value="5">5. 글 삭제 + 피신고자 방 개설 금지 5일</option>
		   									<option value="6">6. 글 삭제 + 피신고자 방 개설 금지 7일</option>
		   									<option value="7">7. 글 삭제 + 피신고자 계정정지 14일</option>
	   									</select>
									</c:if>
									<c:if test="${dto.receiptNum eq 'PROFILE' }">
										<select class="form-control" id="selectPenalty" name="selectPenalty">
											<option value="0" selected="selected">선택</option>
 											<option value="1">1. 블라인드 해제</option>
		   									<option value="2">2. 블라인드 해제 + 신고자 계정정지 3일</option>
		   									<option value="3">3. 부적절한 프로필 표시 3일</option>
		   									<option value="4">4. 부적절한 프로필 표시 5일</option>
		   									<option value="5">5. 부적절한 프로필 표시 7일</option>
		   									<option value="6">6. 피신고자 계정정지 14일</option>
	   									</select>
									</c:if>
									<c:if test="${dto.receiptNum eq 'FEED' }">
										<select class="form-control" id="selectPenalty" name="selectPenalty">
											<option value="0" selected="selected">선택</option>
 											<option value="1">1. 블라인드 해제</option>
		   									<option value="2">2. 블라인드 해제 + 신고자 계정정지 3일</option>
		   									<option value="3">3. 글 삭제</option>
		   									<option value="4">4. 글 삭제 + 피신고자 방 개설 금지 3일</option>
		   									<option value="5">5. 글 삭제 + 피신고자 방 개설 금지 5일</option>
		   									<option value="6">6. 글 삭제 + 피신고자 방 개설 금지 7일</option>
		   									<option value="7">7. 글 삭제 + 피신고자 계정정지 14일</option>
	   									</select>
									</c:if>
									<span class="input-group-addon"></span>
								</div>
							</td>
						</tr>
						
						<tr style="height: 20px;">
						</tr>
						
						<tr>
							<td colspan="2" style="text-align: center;">
								<button type="submit" class="btn btn-success" id="btnCheck">저장</button>
								<button type="button" class="btn btn-default" onclick="location.href='reportlist.action'">취소</button>
								<br>
								
								<span style="font-size: small;">(※)는 필수입력 사항입니다.</span>
								<span id="errMsg"
								style="font-size: small; color: red; display: none;">
									필수입력 사항을 입력해주세요.
								</span>
							</td>
						</tr>
					
					</table>
					<input type="hidden" id="reportReceiptNum" name="reportReceiptNum" value="${dto.reportReceiptNum }">
					<input type="hidden" id="receiptNum" name="receiptNum" value="${dto.receiptNum }">
				</form>
			
			</div>
		
		</div>
	</div>
</div>

</body>
</html>