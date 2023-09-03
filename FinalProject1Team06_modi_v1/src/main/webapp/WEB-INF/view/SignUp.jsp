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
<title>SignUp.jsp</title>
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
		integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
		
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
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<style>

	body 
	{
		min-height: 100vh;
		
		background: -webkit-gradient(linear, left bottom, right top, from(#97C1FF), to(#0D6EFD));
		background: -webkit-linear-gradient(bottom left, #97C1FF 0%, #0D6EFD 100%);
		background: -moz-linear-gradient(bottom left, #97C1FF 0%, #0D6EFD 100%);
		background: -o-linear-gradient(bottom left, #97C1FF 0%, #0D6EFD 100%);
		background: linear-gradient(to top right, #97C1FF 0%, #0D6EFD 100%);
	}
	
	.input-form 
	{
		max-width: 680px;
		
		margin-top: 80px;
		padding: 32px;
		
		background: #fff;
		-webkit-border-radius: 10px;
		-moz-border-radius: 10px;
		border-radius: 10px;
		-webkit-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
		-moz-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
		box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
	}
	.test
	{
		display: flex;
		justify-content: space-evenly;
		
	}
	.test2
	{
		display: flex;
		flex-direction: column;
		margin-top: 0.5vh;
	}
	.mg
	{
		margin: 1vh;
	}
	.test3
	{
		margin-bottom: 1vh;
		
	}
	label
	{
		margin-bottom: 0rem;
	}
	img
	{
		width: 150px;
		height: 150px;
		border-radius: 50%;
	}
	

</style>
<script type="text/javascript" src="<%=cp%>/js/ajax.js"></script>
<script type="text/javascript">

	function idCheck()
	{
		var id = document.getElementById("id").value;
		
		if (id == "")
		{
			alert("아이디를 입력해주세요.");
			document.getElementById("id").focus();
			return;
		}
		
		var idReg = /^[A-Za-z]{1}[A-Za-z0-9]{5,19}$/;
		if ( !idReg.test( id ) ) 
		{
            alert("아이디는 영문자로 시작하는 6~20자 영문자 또는 숫자이어야 합니다.");
            document.getElementById("id").value = "";
            document.getElementById("id").focus();         
            return;
        }
		
		var url = "idcheck.action?id=" + id;
		
		ajax = createAjax();
		
		ajax.open("GET", url, true);
		
		//ajax.onreadystatechange = 기능;
		ajax.onreadystatechange = function()
		{
			if (ajax.readyState==4 && ajax.status==200)
			{
				// 업무 처리(업무 수행) → 외부로 추출 → 함수 정의 → 정의된 함수 호출
				callBack();
			}
		};
		
		ajax.send("");
		
		document.getElementById("checked_id").value = 'y';
		
		
	}
	
	function callBack()
	{
		// responseText / responseXML
		
		var data = ajax.responseText;
		
		data = parseInt(data);
		
		if (data == 0)
		{
			document.getElementById("err1").innerText = "사용 가능한 아이디입니다.";
			document.getElementById("err1").style.color = "green";
		}
		else
		{
			document.getElementById("err1").innerText = "이미 사용중인 아이디입니다.";
			document.getElementById("err1").style.color = "red";
		}
	}
	
	function checkNick()
	{
		var nickName = document.getElementById("nickName").value;
		
		var nickReg = /^[가-힣]{2,16}$/;
        if (!nickReg.test(nickName))
        {
            alert("닉네임은 2자 이상 16자 이하, 한글로 구성해야합니다.");
            document.getElementById("nickName").value = "";
            document.getElementById("nickName").focus();
            return;
        } 
		
		if (nickName == "")
		{
			alert("닉네임을 입력해주세요.");
			document.getElementById("nickName").focus();
			return;
		}
		
		var url = "checknickname.action?nickName=" + nickName;
		
		ajax = createAjax();
		
		ajax.open("GET", url, true);
		
		//ajax.onreadystatechange = 기능;
		ajax.onreadystatechange = function()
		{
			if (ajax.readyState==4 && ajax.status==200)
			{
				// 업무 처리(업무 수행) → 외부로 추출 → 함수 정의 → 정의된 함수 호출
				callBack2();
			}
		};
		
		ajax.send("");
		
		document.getElementById("check_nick").value = 'y';
		
		
	}
	
	function callBack2()
	{
		// responseText / responseXML
		
		var data = ajax.responseText;
		
		data = parseInt(data);
		
		if (data == 0)
		{
			document.getElementById("err2").innerText = "사용 가능한 닉네임입니다.";
			document.getElementById("err2").style.color = "green";
		}
		else
		{
			document.getElementById("err2").innerText = "이미 사용중인 닉네임입니다.";
			document.getElementById("err2").style.color = "red";
		}
	}
</script>

<script type="text/javascript">

	$(function()
	{
		if ($("#ssnCheck").val() >= 1)
		{
			alert("이미 가입한 이력이 있습니다.");
		}
		
		$("#label2").click(function()
		{
			$("#file1").attr("disabled",false);
		});
	
			    
		$("#label1").click(function()
		{
			$("#file1").attr("disabled",true);
		});
		
		// 회원가입 버튼 클릭 시
		$("#btnSign").click(function()
		{
			if ($("#id").val()=="" || $("#password").val()=="" || $("#name").val()=="" || $("#nickName").val()=="" || $("#ssn").val()=="")
			{
				alert("필수 항목을 입력해주셔야 합니다.");
				event.preventDefault();
				return false;
			}
			
			// 주민등록번호 형식 검사 (정규표현식)
			var registNoRule = /\d{6}\-[1-4]\d{6}/;
			
			if(!registNoRule.test($("#ssn").val())) 
			{
		        alert("올바른 주민등록번호 형식이 아닙니다.");
		        event.preventDefault();
		        return false;
		    }
			
			// 주민등록번호 유효성 검사
			var ssn = $("#ssn").val();
			
			var arr = ssn.split("-");
			
			var ssn1 = [];
			var ssn2 = [];
			
			for (var i=0; i<6; i++)
				ssn1[i] = parseInt(arr[0].substring(i, i+1));
			
			for (var j=0; j<7; j++)
				ssn2[j] = parseInt(arr[1].substring(j, j+1));
			
			var tempSum = 0;
			
			for (var i=0; i<ssn1.length; i++)
			{
				tempSum += ssn1[i] * (2+i);
			}
			
			for (var i=0; i<ssn2.length-1; i++)
			{
				if (i>=2)
					tempSum += ssn2[i] * i;
				else
					tempSum += ssn2[i] * (8+i);
			}
			
			if ((11-(tempSum%11))%10 != ssn2[6])
			{
				alert("올바른 주민등록번호 형식이 아닙니다.");
				event.preventDefault();
				return false;
			}
			
			// ○ 20세 미만 가입 불가 로직
			// 주민등록번호에서 앞 두자리 추출
			var birthYear = parseInt(ssn.substring(0, 2));
			
			// 현재 날짜 기준으로 연도 가져오기
			var currentDate = new Date();
			var currentYear = currentDate.getFullYear();
			var currentYear2 = currentYear % 100;
			
			// 앞 두자리를 바탕으로 실제 생년월일 구하기
			var fullBirthYear = (birthYear >= currentYear2) ? birthYear + 1900 : birthYear + 2000;
			
			// 생년월일을 바탕으로 나이 계산
			var age = currentYear - fullBirthYear;
			
			// 20세 미만인 경우 가입을 막음
			if (age < 20)
			{
				alert("20세 미만은 가입이 불가합니다.");
				event.preventDefault();
				return false;
			}
			/* 
			if ($("#ssnCheck").val() == 1)
			{
				alert("이미 가입한 이력이 있습니다.");
				event.preventDefault();
				return false;
			}
			 */
			
			var regExp = /^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{8,16}$/;
	        if( !regExp.test( $("#password").val() ) ) 
	        {
	            alert("비밀번호는 8 ~ 16자 영문, 숫자, 특수문자를 최소 한가지씩 조합해야 합니다.");
	            $("#password").attr("value", "");
	            $("#password").focus();
	            event.preventDefault();
	            return false;
	        }
			
			// 아이디 및 닉네임의 중복확인 여부 확인
			if ($("#checked_id").val() == "" || $("#check_nick").val() == "")
			{
				alert("아이디 및 닉네임의 중복확인이 되지 않았습니다.");
				event.preventDefault();
				return false;
			}
		});
		
	});
	


</script>






</head>
<body>

<div class="container">
	<div class="input-form-backgroud row">
		<div class="input-form col-md-12 mx-auto">
			<h4 class="mb-3">회원가입</h4>
			<form action="signupprocess.action" method="post" id="myForm" class="validation-form" novalidate>
   				<div class="row">
           			<div class="col-md-6 mb-3">
        				<label for="id">아이디</label>
        				<div class="input-group">
            				<input type="text" class="form-control" name="id" id="id" placeholder="ID" value="" required style="width: 200px;">
            				<%-- <input type="hidden" name="count" id="count" value="${count }"> --%>
            				<input type="hidden" id="checked_id" name="checked_id" value="">
            				<div class="input-group-append">
                				<button type="button" class="btn btn-primary" id="btnCheckId" onclick="idCheck()">중복확인</button>
            				</div>
            				<div class="invalid-feedback">
            					아이디를 입력해주세요.
        					</div>
        					<div>
        						<span id="err1" style="font-size: small;"></span>
        					</div>
        				</div>
    				</div>
           			<div class="col-md-6 mb-3">
             			<label for="password">비밀번호</label>
             			<input type="password" class="form-control" id="password" name="pw"placeholder="8 ~ 16자 영문, 숫자, 특수문자 조합" value="" required>
             			<div class="invalid-feedback">
               				비밀번호를 입력해주세요.
             			</div>
           			</div>
           	
           			<div class="col-md-6 mb-3">
						<label for="name">이름</label>
						<input type="text" class="form-control" id="name" name="name" placeholder="Name" value="" required>
						<div class="invalid-feedback">
  							이름을 입력해주세요.
						</div>
					</div>
					
					<div class="col-md-6 mb-3">
						<label for="nickname">닉네임</label>
						<div class="input-group">
							<input type="text" class="form-control" name="nickName" id="nickName" placeholder="Nickname" value="" required>
							<input type="hidden" name="check_nick" id="check_nick" value="">
							<div class="input-group-append">
                				<button type="button" class="btn btn-primary" id="btnCheckNickName" onclick="checkNick()">중복확인</button>
            				</div>
            				
            				<div class="invalid-feedback">
  								닉네임을 입력해주세요.
							</div>
						</div>
						<div>
       						<span id="err2" style="font-size: small;"></span>
       					</div>
					</div>
				
					<div class="col-md-6 mb-3">
            			<label for="ssn">주민등록번호</label>
            			<input type="text" class="form-control" id="ssn" name="ssn" placeholder="ex)123456-1234567" required>
            			<!-- <input type="password" class="form-control" id="ssn2" required="required"> -->
            			<div class="invalid-feedback">
              				주민등록번호를 입력해주세요.
            			</div>
            		</div>
            		          	
         		</div>	

         		<div class="mb-3">
           			<label for="introduce">자기소개란</label>
           			<textarea rows="5" cols="5" id="introduce" name="introduce" class="form-control"></textarea>
         		</div>
         
				<hr class="mb-4">
				<div class="custom-control custom-checkbox">
					<input type="checkbox" class="custom-control-input" id="aggrement" required>
      				<label class="custom-control-label" for="aggrement">개인정보 수집 및 이용에 동의합니다.</label>
				</div>
   				<div class="mb-4"></div>
   				<button class="btn btn-primary btn-lg btn-block" type="submit" id="btnSign">회원가입</button>
   				<button class="btn btn-danger btn-lg btn-block" type="reset">다시작성</button>
   				
   			</form>
   			<br>
   			<button class="btn btn-secondary btn-lg btn-block" type="button" onclick="location.href='loginform.action'">돌아가기</button>
   		</div>
	</div><!-- close .input-form-backgroud row -->
	<footer class="my-3 text-center text-small">
    	<p class="mb-1" style="color: white; font-weight: bold;">&copy; 2023 MateTrip</p>
	</footer>
</div><!-- close .container -->

<input type="hidden" id="ssnCheck" name="ssnCheck" value="${ssnCheck }">

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