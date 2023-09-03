<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>InfoModify.jsp</title>

<link rel="stylesheet" src="<%=cp %>/css/infoModify.css">
<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">
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
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.1/dist/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=cp%>/js/ajax.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">

<script>
  $(document).ready(function() {
	  
	    // 모달창이 열리고 닫힐 때 뒷 배경을 비활성화/활성화 처리
	    $('#myModal').on('show.bs.modal', function () {
	      $('#backdrop').show();
	    });
	
	    $('#myModal').on('hidden.bs.modal', function () {
	      $('#backdrop').hide();
	     
    	});
	    
	    // 비밀번호 변경 버튼 눌렀을 때
	    $('.pwModify').click(function()
		{
	    	// 현재 비밀번호, 새로운 비밀번호 및 확인 입력칸 초기화
			$('#pwNow').attr("value","");
			$('#newPw').attr("value","");
			$('#newCheck').attr("value","");
		})
	    
	    
	    // 현재 비밀번호 확인 버튼 눌렀을 때
	    $('.pwCheck').click(function() 
	    {
	    	
	    	// 입력값이 없을 경우
	    	if($("#pwNow").val()=="")
	    	{
	    		// 경고 문구 출력
	    		$("#str1").text("비밀번호를 입력해주세요.");
	    		$("#str1").focus();
				return;
	    	}
	    	
	    	// 현재 비밀번호 입력값 받아오기
	    	var params = "pwNow="+ $("#pwNow").val();
	         $.ajax({
	             url: 'pwcheck1.action',	// 데이터를 받아올 서버 URL
	             type: 'GET',
	             data:params, 				// 받아온 데이터 형식 (JSON)
	             success: function(data) {
	                 // 성공적으로 데이터를 받아왔을 때 처리
	                 // 받아온 데이터를 화면에 추가 또는 변경하는 등의 작업 수행
	                 $('#str1').text(data);
	                 
	                 // 입력한 현재 비밀번호가 일치할 경우
	                 if(data != "비밀번호가 일치하지 않습니다.")
	                 {
	                	 // 현재 비밀번호 및 확인 입력칸 활성화
		                 $("#newPw").attr("disabled",false);
		                 $("#newCheck").attr("disabled",false);
	                 }
	                 
	             },
	             error: function(xhr, status, error) {
	                 console.log('Ajax 요청 실패:', error);
	             }
	         });
	     });
	    
	    // 비밀번호 변경 버튼 눌렀을 때
	    $(".newpwCheck").click(function()
		{
	    	// 경고 문구 초기화
	    	$('#str1').text("");
	    	$('#newStr').text("");
	    	
	    	// 새로운 비밀번호 또는 비밀번호 확인 입력칸 값 없을 경우
	    	if($("#newPw").val()=="" || $("#newCheck").val()=="")
	    	{
	    		// 경고 문구 출력
	    		$("#newStr").text("비밀번호를 입력해주세요.");
	    		$("#newPw").focus();
				return;
	    	}
	    	
	    	// 새로운 비밀번호와 비밀번호 확인 입력값 다를 경우
	    	if($("#newPw").val() != $("#newCheck").val())
	    	{
	    		// 경고 문구 출력
	    		$("#newStr").text("비밀번호가 일치하지 않습니다.");
	    		return;
	    	}
	    	
	    	var regExp = /^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{8,16}$/;
            if( !regExp.test( $("#newPw").val() ) ) 
            {
               alert("비밀번호는 8 ~ 16자 영문, 숫자, 특수문자를 최소 한가지씩 조합해야 합니다.");
               $("#newPw").val("");
               $("#newCheck").val("");
               $("#newPw").focus();
               event.preventDefault();
               return false;
            }
	    	
	    	// 새로운 비밀번호 값 담기
	    	var params = "newPw="+$("#newPw").val();
	    	
	         $.ajax({
	             url: 'pwmodify.action',// 데이터를 받아올 서버 URL
	             type: 'GET',
	             data:params, 			// 받아온 데이터 형식 (JSON)
	             success: function(data) {
	            	 
	                 // 성공적으로 데이터를 받아왔을 때 처리
	                 // 받아온 데이터를 화면에 추가 또는 변경하는 등의 작업 수행
	                 
	                 // 변경 결과 출력
	                 $('#newStr').text(data);
	                 // 비밀번호 칸에 새로운 비밀번호 담김
	                 $('#pw').val($("#newPw").val());
	                 
	             },
	             error: function(xhr, status, error) {
	                 console.log('Ajax 요청 실패:', error);
	             }
	         });
		});
	    
	    
	    // 닉네임 중복 확인 버튼 눌렀을 때
	    $('.nikCheck').click(function() {

	    	// 닉네임 입력칸에 값이 없을 때
	    	if($("#nikname").val()=="")
	    	{
	    		// 경고 문구 출력
	    		$("#nikErr").text("닉네임을 입력해주세요.");
	    		$("#nikErr").focus();
				return;
	    	}
	    	
	        var nickReg = /^[가-힣]{2,16}$/;
	          if (!nickReg.test($("#nikname").val()))
	          {
	              alert("닉네임은 2자 이상 16자 이하, 한글로 구성해야합니다.");
	              document.getElementById("nikname").value = "";
	              document.getElementById("nikname").focus();
	              return;
	          } 
	        
	        if ($("#nikname").val() == "")
	        {
	           alert("닉네임을 입력해주세요.");
	           document.getElementById("nikname").focus();
	           return;
	        }
	    	
	    	
	    	// 닉네임 입력 값 담기
	    	var params = "nikname="+ $("#nikname").val();
	         $.ajax({
	             url: 'nikcheck.action',// 데이터를 받아올 서버 URL
	             type: 'GET',
	             data:params, 			// 받아온 데이터 형식 (JSON)
	             success: function(data) {
	                 // 성공적으로 데이터를 받아왔을 때 처리
	                 // 받아온 데이터를 화면에 추가 또는 변경하는 등의 작업 수행
	                 
	                 // 결과 출력
	                 $('#nikErr').text(data);
	                 // 중복확인 여부 hidden input 에 담기 
	                 $("#nikCheck").val("check");
	                 // 경고 문구 초기화
	                 $("#totalErr").text("");
	             },
	             error: function(xhr, status, error) {
	                 console.log('Ajax 요청 실패:', error);
	             }
	         });
	     });
	    
	    // 탈퇴 버튼 눌렀을 때
	    $('.leave').click(function() {
	    	
	    	// 비밀번호 입력 값이 없을 때
	    	if($("#pwSg").val()=="")
	    	{
	    		// 경고 문구 출력
	    		$("#leaveErr").text("비밀번호를 입력해주세요.");
	    		$("#leaveErr").focus();
				return;
	    	}
	    	// 내용숙지 체크 안 눌렀을 때
	    	if (!$("#leave").is(":checked"))
			{
	    		// 경고 문구 출력
				$("#leaveErr").text("탈퇴 처리 내용 숙지란에 체크해주세요.");
				$("#leaveErr").focus();
				return;
			}
	    	
	    	// 비밀번호 값 담기
	    	var params = "pwSg="+ $("#pwSg").val();
	    	
	         $.ajax({
	             url: 'pwcheck2.action',// 데이터를 받아올 서버 URL
	             type: 'GET',
	             data:params, 			// 받아온 데이터 형식 (JSON)
	             success: function(data) {
	                 // 성공적으로 데이터를 받아왔을 때 처리
	                 // 받아온 데이터를 화면에 추가 또는 변경하는 등의 작업 수행
	                 
	                 // 탈퇴 가능 결과 출력
	                 $('#leaveErr').text(data);
	                 
	     	 	    // 탈퇴 가능한 조건일 때 로그인 페이지로 이동 						
	     	 	    if($("#leaveErr").text()== "탈퇴 가능합니다.")
	     	 	    {
	     	 	    	if(confirm("정말로 탈퇴하시겠습니까?"))
	     	 	    	{
	     	 	    		$(location).attr("href","loginform.action");	
	     	 	    	}
	     	 	    }
	                 
	             },
	             error: function(xhr, status, error) {
	                 console.log('Ajax 요청 실패:', error);
	             }
	         });
	         
	     });
	    
	    
	 	// 정보수정 버튼 눌렀을 때
	    $('.totalUpdate').click(function() 
	    {
	    	// 경고 메세지 초기화
	    	$("#totalErr").text("");
	    	$('#nikErr').text("");
	    	
	    	// 기존 닉네임과 다른 닉네임으로 변경했지만 중복확인을 거치지 않은 경우
	    	if(($("#nikname").val() != $("#nikHidden").val()) && $("#nikCheck").val()!= "check")
	    	{
	    		$("#totalErr").text("별명 변경 후에는 중복확인을 거쳐야합니다.");
	    		return;
	    	}
	    	alert("정보수정이 완료되었습니다.");
	    	$('#myForm').submit();
	    	
	    });
	    
	    
	    // 파일 업로드 Ajax 보류 ..........
	    /*
	    $('.pfChange').click(function() 
	    {
	    	var photo =  $('input[name=photo]:checked').val()
	    	if(photo == "now")
	    	{
	    		return;
	    	}
	    	
	    	var filePath = document.getElementById('filePath');
            var file = filePath.files[0]; // 선택한 파일 가져오기
            
			alert(file.name);
            // FormData 객체 생성
           // var formData = new FormData();
           // formData.append('f', file);
           // formData.append("photo",photo);
            
	    	
            $.ajax({
                url:'photoupdate.action', 
                type: 'GET',
                data: {
                    filename: file.name // 다운로드할 파일의 이름을 지정합니다.
                },
                success: function(response) {
                    // 서버에서 반환한 다운로드 URL을 사용하여 파일을 다운로드합니다.
                    window.location.href = response;
                },
                error: function(request, status, error) 
                {
                	//alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
                }
            });
            
	     });
	    */
	    
  });
</script>

</head>



<body>
<button class="float-start p-2"
		style="border: none; background-color: white; color: #48AFB4; font-family: Merriweather; font-size: 20px;" 
		onclick="location.href='mypage1.action'">
		<i class="bi bi-arrow-bar-left"></i> MY PAGE
	</button>

	<div class="container">
		<div class="input-form-backgroud row">
			<div class="input-form col-md-12 mx-auto">
				<h4 class="m-3">회원 정보 수정</h4>
					<div class="row test ">
						<div class="col-6 text-center">
						<div class="test1" >
							<img alt="" src="${info.photo }" id="pf" style="width: 200px; height: 200px;border-radius : 50%">
						</div>
						</div>
						<div class="col-6">
						<div class="test2">
							<div class="test2">
								<label> <input type="radio" name="photo"
									class="mg" value="now" checked> 현재 프로필 이미지 
								</label> <br>
								<label><input type="radio" name="photo" class="mg"
									value="default"> 기본 이미지로 변경
								</label> <br>
								<label> <input type="radio" name="photo"
									class="mg" value="new"> 사진 불러오기(jpg, png)
								</label>
							</div>
							<div class="test3">
								<div class="row">
								<input type="file" class="form-control form-control-sm m-2"
									aria-label="Small file input example" name="filePath" id="filePath" style="width: 400px">
								<button type="button" class="btn btn-secondary float-end m-2 pfChange" style="width: 400px">프로필 사진변경</button>
								</div>
								<br>
								<span id="result"></span>
							</div>
						</div>
						</div>
					</div>

				<form action="infoupdate.action" class="validation-form" novalidate id="myForm">
						<div class="row">
							<div class="col-md-6 mb-3">
								<label for="id">아이디</label>
								<div class="input-group">
									<input type="text" class="form-control" id="id" value="${info.id }"
										readonly="readonly" style="width: 200px;">
									<div class="invalid-feedback">아이디를 입력해주세요.</div>
								</div>
							</div>
	
							<div class="col-md-6 mb-3">
								<label for="password">비밀번호</label>
								<div class="input-group">
									<input type="password" class="form-control" id="pw" name="pw"
										value="*****" readonly="readonly">
									<div class="input-group-append">
										<button type="button" class="btn btn-primary pwModify" id="btnCheck"
											data-toggle="modal" data-target="#myModal">변경</button>
									</div>
									<div class="invalid-feedback">비밀번호를 입력해주세요.</div>
								</div>
							</div>
	
							<div class="col-md-6 mb-3">
								<label for="name">이름</label> <input type="text"
									class="form-control" id="name" name="name" value="${info.name }" required>
								<div class="invalid-feedback">이름을 입력해주세요.</div>
							</div>
	
							<div class="col-md-6 mb-3">
								<label for="nickname">별명</label>
								<div class="input-group">
									<input type="text" class="form-control" id="nikname" name="nikname" value="${info.nikname }"
										required>
									<input type="hidden" class="form-control" id="nikHidden" name="nikHidden" value="${info.nikname }">
									<div class="input-group-append">
										<button type="button" class="btn btn-primary nikCheck" id="btnCheck">중복확인</button>
										<input type="hidden" class="form-control" id="nikCheck" name="nikCheck" value="">
									</div><br>
									<div class="invalid-feedback">별명을 입력해주세요.</div>
									</div>
									<div><span id="nikErr" style="color: red"></span></div>
								
							</div>
	
							<div class="col-md-6 mb-3">
								<label for="ssn">주민등록번호</label> <input type="text"
									class="form-control" id="ssn" readonly="readonly" value="${info.ssn }">
								<!-- <input type="password" class="form-control" id="ssn2" required="required"> -->
								<div class="invalid-feedback">주민등록번호를 입력해주세요.</div>
							</div>
						</div>
	
						<div class="mb-3">
							<label for="introduce">자기소개란</label>
							<textarea rows="5" cols="5" id="introduce" name="introduce" class="form-control">${info.introduce }</textarea>
						</div>
						<span id="totalErr" style="color: red"></span>
						<hr class="mb-4">
						<div class="custom-control custom-checkbox">
							<input type="checkbox" class="custom-control-input" id="aggrement"
								required>
						</div>
						<div class="mb-4"></div>
						<button class="btn btn-primary btn-lg btn-block totalUpdate" type="submit">정보
							수정</button>
						<button type="button" class="btn btn-secondary btn-lg btn-block"
							data-toggle="modal" data-target="#myModal2">회원 탈퇴</button>
					</form>
				
					<!-- 모달창 -->
					<div class="modal" id="myModal" tabindex="-1" role="dialog">
						<div class="modal-dialog modal-dialog-centered" role="document">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title">비밀번호 변경</h5>
									<button type="button" class="close" data-dismiss="modal" data-target ="myModal"
										aria-label="Close">
										<span aria-hidden="true">&times;</span>
									</button>
								</div>
								<div class="modal-body">
									현재 비밀번호 
									<div class="row">
									<div class="col">
									<input type="password" class="form-control"
											id="pwNow" name="pwNow" value="" required style="width: 200px"></div>
									<div class="col">
											<button type="submit" class="btn btn-secondary pwCheck" >확인</button></div>
									<span id="str1" style="color: red; "></span>
									</div>
								<br>
									새 비밀번호 <input type="password" class="form-control"
										id="newPw" name="newPw" value="" required disabled><br>
									 새 비밀번호 확인 <input
										type="password" class="form-control" id="newCheck" name="newCheck" value=""
										required disabled>
										<span id="newStr" style="color: red; "></span>
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-secondary" class="close" aria-label="Close"
									data-dismiss="modal" data-target ="myModal">돌아가기</button>
									<button type="button" class="btn btn-primary newpwCheck" >비밀번호 변경</button>
								</div>
							</div>
						</div>
					</div>

					<!-- 뒷 배경을 가리는 투명한 레이어 -->
					<div class="modal-backdrop show" id="backdrop"
						style="display: none;"></div>


				<!-- 모달창 -->
				<div class="modal" id="myModal2" tabindex="-1" role="dialog">
					<div class="modal-dialog modal-dialog-centered" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title">회원 탈퇴</h5>
								<button type="button" class="close" data-dismiss="modal"
									aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
							</div>
							<div class="modal-body">
							
								<span>탈퇴 진행을 위해 비밀번호를 입력해주세요.</span><br><br>
								<label for="password">비밀번호</label>
								<div class="input-group">
									<input type="password" class="form-control" id="pwSg" name="pwSg"value=""
										required >
									<div class="invalid-feedback">비밀번호를 다시 입력해주세요.</div>
								</div>
								<br><br>
								<div class="accordion" id="accordionExample">
									<div class="accordion-item">
										<h2 class="accordion-header" id="headingOne">
											<button class="accordion-button" type="button"
												data-bs-toggle="collapse" data-bs-target="#collapseOne"
												aria-expanded="true" aria-controls="collapseOne">
												탈퇴 시 사용자 정보 처리 내용보기 </button>

										</h2>
										
										<div id="collapseOne" class="accordion-collapse collapse show"
											aria-labelledby="headingOne"
											data-bs-parent="#accordionExample">
											<div class="accordion-body">
												<p>
													<strong>※탈퇴 시 사용자 정보 처리 내용 ※</strong><br> 1. 탈퇴 후에도
													유지되는 정보<br> 1) 해당 사용자가 직접 개설한 방<br> 2) 해당 사용자가 개설
													및 참여한 방의 피드<br> 3) 해당 사용자가 개설 및 참여한 방의 개인노트<br>
													<br> * 위의 세가지 항목의 정보는 탈퇴 전 사용자가 직접 삭제해야 하며 탈퇴 후에는 삭제
													불가능합니다.<br> * 탈퇴 후에 다른 사용자에게 ‘탈퇴한 사용자’로 보여집니다.<br>
													* 퇴장한 방의 피드와 개인노트는 삭제할 수 없습니다.<br>
													<br> 2. 탈퇴일로부터 1년간 유지되는 정보<br> 1) 사용자 개인 정보<br>
													- 이름, 주민번호<br> 2) 계정 관련 정보<br> - 신고이력, 패널티이력,
													매너점수, 완료된 여행 목록<br> 3) 탈퇴 즉시 삭제되는 정보<br> - 패스워드,
													닉네임, 자기소개란
													
												</p>
											</div>
										</div>
									</div>
								</div>
								<br> 
									<div class="form-check">
										<input class="form-check-input" type="checkbox" value="leave" name="leave"
											id="leave"> <label
											class="form-check-label" for="flexCheckDefault">
											위의 "탈퇴 시 사용자 정보 처리 내용"을 숙지하였으며,<br> 탈퇴를 계속 진행합니다.
										</label>
									</div><br>
								<span id="leaveErr" class="float-start" style="color: red"></span>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-danger leave" name="lCheck" id="lCheck" value="lCheck">탈퇴</button>
							</div>
						</div>
					</div>
				</div>

			</div>
		</div>
	</div>
	<!-- close .container -->
	<script type="text/javascript"
		src="http://code.jquery.com/jquery.min.js"></script>
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