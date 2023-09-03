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
<title>가계부 비용추가</title>

<link rel="stylesheet" type="text/css" href="css/main.css">
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
  <link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="/resources/demos/style.css">
  <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
  <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
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
	font-weight: 400;
	line-height: 0px; 
	
	display: flex;
	width: 340px;
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
.form-check-inline
{
	padding: 10px;
}
</style>
<script>
  $( function() {
    $( "#datepicker" ).datepicker();
    $( "#datepicker" ).datepicker( "option", "dateFormat", 'yy-mm-dd' );
  } );
  </script>
</head>

<body>
<button class="float-start p-2"
		style="border: none; background-color: transparent; color: white; font-family: Merriweather; font-size: 20px;" 
		onclick="location.href='accountlist.action?page=2&room_num=${room_num }'">
		<i class="bi bi-arrow-bar-left"></i> 가계부 내역
</button>

<div class="container">
	<div class="input-form-backgroud row">
		<div class="input-form col-md-12 mx-auto">
			<h4 class="mb-3">DAY ${day } (${date }) 비용추가 </h4> 
			<hr>
			
       		<form class="validation-form" novalidate action="accountinsert.action">
			<input type="hidden" id="room_num" name="room_num" value="${room_num }">
			<input type="hidden" id="day" name="day" value="${day }">
				
   				<div class="row">
					<div class="col-md-6 mb-3">
						<label for="ssn2">금액</label>
            			<input type="text" class="form-control" id="cost" name="cost" placeholder="금액을 입력해주세요" required>
            		</div>
					<div class="col-md-4 mb-3">
						<label for="ssn2">결제 일자</label>
						<input type="text" class="form-control"  id="datepicker" name="paid_date" placeholder="날짜를 선택해주세요">
            		</div>
            	
         		</div>

         		<div class="mb-3">
           			<label for="content">내용</label>
           			<input type="text" class="form-control" id="content" name="content"  placeholder="내용을 입력해주세요" required>
         		</div>
         		
         		<span>카테고리</span><br>
	         		<div class="form-check form-check-inline" required>
					  <input class="form-check-input" type="radio" name="pay_category_num" id="inlineRadio1" value="1" required>
					  <label class="form-check-label" for="inlineRadio1">
					  항공 
					  <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-airplane-fill"viewBox="0 0 16 16">
	 					<path d="M6.428 1.151C6.708.591 7.213 0 8 0s1.292.592 1.572 1.151C9.861 1.73 10 2.431 10 3v3.691l5.17 2.585a1.5 1.5 0 0 1 .83 1.342V12a.5.5 0 0 1-.582.493l-5.507-.918-.375 2.253 1.318 1.318A.5.5 0 0 1 10.5 16h-5a.5.5 0 0 1-.354-.854l1.319-1.318-.376-2.253-5.507.918A.5.5 0 0 1 0 12v-1.382a1.5 1.5 0 0 1 .83-1.342L6 6.691V3c0-.568.14-1.271.428-1.849Z" />
					  </svg>
					  </label>
					</div>
	         		<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="pay_category_num" id="inlineRadio2" value="2" required>
					  <label class="form-check-label" for="inlineRadio2">
					  교통 
					  <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-bus-front-fill" viewBox="0 0 16 16">
					  <path d="M16 7a1 1 0 0 1-1 1v3.5c0 .818-.393 1.544-1 2v2a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1-.5-.5V14H5v1.5a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1-.5-.5v-2a2.496 2.496 0 0 1-1-2V8a1 1 0 0 1-1-1V5a1 1 0 0 1 1-1V2.64C1 1.452 1.845.408 3.064.268A43.608 43.608 0 0 1 8 0c2.1 0 3.792.136 4.936.268C14.155.408 15 1.452 15 2.64V4a1 1 0 0 1 1 1v2ZM3.552 3.22A43.306 43.306 0 0 1 8 3c1.837 0 3.353.107 4.448.22a.5.5 0 0 0 .104-.994A44.304 44.304 0 0 0 8 2c-1.876 0-3.426.109-4.552.226a.5.5 0 1 0 .104.994ZM8 4c-1.876 0-3.426.109-4.552.226A.5.5 0 0 0 3 4.723v3.554a.5.5 0 0 0 .448.497C4.574 8.891 6.124 9 8 9c1.876 0 3.426-.109 4.552-.226A.5.5 0 0 0 13 8.277V4.723a.5.5 0 0 0-.448-.497A44.304 44.304 0 0 0 8 4Zm-3 7a1 1 0 1 0-2 0 1 1 0 0 0 2 0Zm8 0a1 1 0 1 0-2 0 1 1 0 0 0 2 0Zm-7 0a1 1 0 0 0 1 1h2a1 1 0 1 0 0-2H7a1 1 0 0 0-1 1Z"/>
					</svg>
					</i>
					  </label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="pay_category_num" id="inlineRadio3" value="3" required>
					  <label class="form-check-label" for="inlineRadio3">숙소 <i class="bi bi-house-fill"></i></label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="pay_category_num" id="inlineRadio4" value="4" required>
					  <label class="form-check-label" for="inlineRadio4">식비 
					  <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none">
					  <path fill-rule="evenodd" clip-rule="evenodd" d="M6 0C6.55228 0 7 0.447715 7 1V4C7 4.55228 6.55228 5 6 5C5.44772 5 5 4.55228 5 4V1C5 0.447715 5.44772 0 6 0ZM10 0C10.5523 0 11 0.447715 11 1V4C11 4.55228 10.5523 5 10 5C9.44772 5 9 4.55228 9 4V1C9 0.447715 9.44772 0 10 0ZM14 0C14.5523 0 15 0.447715 15 1V4C15 4.55228 14.5523 5 14 5C13.4477 5 13 4.55228 13 4V1C13 0.447715 13.4477 0 14 0ZM1 8C1 7.44772 1.44772 7 2 7H19C20.3261 7 21.5979 7.52678 22.5355 8.46447C23.4732 9.40215 24 10.6739 24 12C24 13.3261 23.4732 14.5979 22.5355 15.5355C21.5979 16.4732 20.3261 17 19 17C19 18.3261 18.4732 19.5979 17.5355 20.5355C16.5979 21.4732 15.3261 22 14 22H6C4.67392 22 3.40215 21.4732 2.46447 20.5355C1.52678 19.5979 1 18.3261 1 17V8ZM19 15C19.7956 15 20.5587 14.6839 21.1213 14.1213C21.6839 13.5587 22 12.7956 22 12C22 11.2044 21.6839 10.4413 21.1213 9.87868C20.5587 9.31607 19.7956 9 19 9V15ZM17 9V17C17 17.7956 16.6839 18.5587 16.1213 19.1213C15.5587 19.6839 14.7956 20 14 20H6C5.20435 20 4.44129 19.6839 3.87868 19.1213C3.31607 18.5587 3 17.7956 3 17V9H17Z" fill="black"/>
					  </svg>
					  </label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="pay_category_num" id="inlineRadio5" value="5" required>
					  <label class="form-check-label" for="inlineRadio5">쇼핑 <i class="bi bi-cart-fill"></i></label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="pay_category_num" id="inlineRadio6" value="6" required>
					  <label class="form-check-label" for="inlineRadio5">기타 <i class="bi bi-three-dots"></i></label>
					</div><br><br>
				<div class="row" >
         		<div class="col-md-8">
         		<strong>함께한 사람</strong>
         		<hr>
         		</div>
         		<div class="col-md-2 text-center">
         			<strong style="text-align: center">함께</strong><hr>
         		</div>
         		<div class="col-md-2 text-center"><strong>결제</strong><hr></div>
				</div> 
         		
         		<c:forEach var="dto" items="${member }">
         		<div class="people">
         		<div class="row">
	         		<div class="col-md-1 photo"><img src="${dto.photo}" ></div>
	         		<div class="col-md-7 person">${dto.nikname }</div>
	         		<div class="col-md-2">
					  <input class="form-check-input float-end" type="checkbox" id="do/${dto.mem_join_num }" name="do" 
					  value="${dto.mem_join_num }">
					</div>
	         		<div class="col-md-2">
					  <input class="form-check-input float-end" type="checkbox" id="pay/${dto.mem_join_num }"  name="pay"  
					   value="${dto.mem_join_num }">
					</div>
	         	</div><br>
	         	</div>
	         	</c:forEach>
   				<div class="mb-4"></div>
   				<button class="btn btn-primary btn-lg btn-block" type="submit" style="float: right">비용 추가</button>
   			</form>
   		</div>
	</div><!-- close .input-form-backgroud row -->
	<footer class="my-3 text-center text-small">
    	<p class="mb-1">&copy; 2021 YD</p>
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