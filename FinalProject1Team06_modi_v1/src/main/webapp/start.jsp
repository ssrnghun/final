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
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
</head>
<body>

<div>
	<form action="planner.action" method="get">
	<!-- <input type="text" name="room_num" value="ROOM-00001"> -->
	<!-- <input type="text" name="my_id" value="ID-00007"> -->
	<button>전송</button>
	</form>
</div>

</body>
</html>