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
<title>Find_ID_Form.jsp</title>

<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript">

	$(function()
	{
		$("#btnFindId").click(function()
		{
			if ($("#name").val() == "" || $("#ssn").val() == "")
			{
				alert("모든 항목을 입력해야 합니다.");
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
			
		});
	});

</script>

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
</head>
<body>

<div class="container">
	<div class="input-form-backgroud row">
		<div class="input-form col-md-12 mx-auto">
			<h4 class="mb-3">아이디찾기</h4>
			
       		<form action="findid.action" method="post" class="validation-form" novalidate>
   				<div class="row">
           			<div class="col-md-6 mb-3">
        				<label for="name">이름</label>
        				<div class="input-group">
            				<input type="text" class="form-control" name="name" id="name" placeholder="name" value="" required style="width: 200px;">
            				<div class="invalid-feedback">
            					이름을 입력해주세요.
        					</div>
        				</div>
    				</div>
           		
           			<div class="col-md-6 mb-3">
             			
           			</div>
           	
           			<div class="col-md-6 mb-3">
						
					</div>
					
					<div class="col-md-6 mb-3">
						
					</div>
				
					<div class="col-md-6 mb-3">
            			<label for="ssn">주민등록번호</label>
            			<input type="text" class="form-control" name="ssn" id="ssn" placeholder="주민등록번호" required>
            			<!-- <input type="password" class="form-control" id="ssn2" required="required"> -->
            			<div class="invalid-feedback">
              				주민등록번호를 입력해주세요.
            			</div>
            		</div>
           	
         		</div>

         		<div class="mb-3">
           			<p><span style="color: red; font-size: small;">${str }</span></p>
         		</div>
         
				<hr class="mb-4">
				<div class="custom-control custom-checkbox">
					
				</div>
   				<div class="mb-4"></div>
   				<button class="btn btn-primary btn-lg btn-block" type="submit" id="btnFindId">아이디 찾기</button>
   				<button class="btn btn-secondary btn-lg btn-block" type="submit" onclick="location.href='loginform.action'">로그인페이지</button>
   				<button class="btn btn-secondary btn-lg btn-block" type="submit" onclick="location.href='adminloginform.action'">관리자로그인페이지</button>
   			</form>
   		</div>
	</div><!-- close .input-form-backgroud row -->
	<footer class="my-3 text-center text-small">
    	<p class="mb-1" style="color: white; font-weight: bold;">&copy; 2023 MateTrip</p>
	</footer>
</div><!-- close .container -->

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