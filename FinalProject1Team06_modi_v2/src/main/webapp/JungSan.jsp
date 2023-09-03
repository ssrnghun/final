<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
<title>비용정산</title>

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

<style>
body 
{
	min-height: 100vh;
	
	background: -webkit-gradient(linear, left bottom, right top, from(#48AFB4), to(#FBC066));
      background: -webkit-linear-gradient(bottom left, #48AFB4 0%, #FBC066 100%);
      background: -moz-linear-gradient(bottom left, #48AFB4 0%, #FBC066 100%);
      background: -o-linear-gradient(bottom left, #48AFB4 0%, #FBC066 100%);
      background: linear-gradient(to top right, #48AFB4 0%, #FBC066 100%);
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
/* #btnCheck
{
	margin-left: 69%;
	margin-bottom: 20%;
} */
/*
.test1
{
	display: flex;
	justify-content: flex-start;

}

.test
{
	display: flex;
	justify-content: space-between;
	
}
.test2
{
	display: flex;
	flex-direction: column;
	align-items: center;
	padding-top: 5vh;
}

.mg
{
	margin: 1vw;
}
.form-control
{
	height: 100%;
}
*/

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

.person
{
	color: #000;
	font-family: Merriweather;
	font-size: 20px;
	font-style: normal;
	font-weight: 300;
	line-height: 0px; 
	
	display: flex;
	width: 260px;
	height: 20px;
	flex-direction: column;
	justify-content: center;
	flex-shrink: 0;
	vertical-align: middle;
	margin-top: 5px;
}
.personBtn
{
	display: flex;
	height:50px;
	flex-direction: column;
	justify-content: center;
	flex-shrink: 0;
	vertical-align: middle;
	
}
#checkboxNoLabel
{
	float: right
}
img
{
	margin-bottom: 10px;
	padding-right: 0;
	float: right;
	height: 25px; 
	width: 25px;"
}
.head
{
	font-weight: bold;
}
.money
{
	float: right;
}
</style>
</head>

<body>


<button class="float-start p-2"
		style="border: none;  background-color: transparent;  color: white; font-family: Merriweather; font-size: 20px;" 
		onclick="location.href='accountlist.action?page=2&room_num=<c:out value='${room_num}'/>'">
		<i class="bi bi-arrow-bar-left"></i> 가계부 내역
</button>
<div class="container">
	<div class="input-form-backgroud row">
		<div class="input-form col-md-12 mx-auto">
			<h4 class="mb-3 head"> 여행 비용 정산</h4> 
			<hr>
         		<strong>개인별 지출 내역</strong>
         		<hr>
         		<c:forEach var="dto" items="${sumCost }">
         		<div class="people">
         		<div class="row">
	         		<div class="col-md-1 photo"><img src="${dto.photo }" ></div>
	         		<div class="col-md-4 person">${dto.nikname }</div>
	         		<div class="col-md-6 ">
	         			<span class="money">
	         			<fmt:formatNumber groupingUsed="true" value="${dto.docost}">
	         			</fmt:formatNumber> 원</span>
	         		</div>
	         		<div class="col-md-6 ">
	         		</div>
	         		<div class="col-md-6 ">
	         			<span class="money" >
	         			(결제 : 
	         			<fmt:formatNumber groupingUsed="true" value="${dto.paycost}">
	         			</fmt:formatNumber> 원)
	         			</span>
	         		</div>
					</div>
	         	</div><hr>
	         	</c:forEach>
	         	
         			<strong>받아야 하는 금액</strong><hr>
         			<div class="people">
		         			<div class="row">
			         		<div class="col-md-1 photo"><img src="images/Ellipse 20.svg" ></div>
			         		<div class="col-md-5 person">군기반장으로부터</div>
			         		<div class="col-md-4 ">
			         			<span class="money">20,000,000 원</span>
							</div>
			         		<div class="col-md-2 ">
							  <button class="btn btn-primary money" type="button">받음</button>
							</div>
	         			</div><br>
	         		</div>
         			<strong>보내야 하는 금액</strong><hr>
         			<div class="people">
		         			<div class="row">
			         		<div class="col-md-1 photo"><img src="images/Ellipse 20.svg" ></div>
			         		<div class="col-md-5 person">왕호랭이에게</div>
			         		<div class="col-md-4 ">
			         			<span class="money">20,000,000 원</span>
							</div>
			         		<div class="col-md-2 ">
							  <button class="btn btn-primary money" type="button">보냄</button>
							</div>
	         			</div><br>
	         		</div>
         		</div>
         		</div>
   		</div>
   		<br><br><Br>
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