<%@page import="java.util.ArrayList"
%><%@page import="com.final1.logic.PlannerLocMemoDTO"
%><%@ page contentType="text/html; charset=UTF-8"
%><?xml version="1.0" encoding="UTF-8"?>
<positions>
	<place>
		<%
		ArrayList<PlannerLocMemoDTO> arrList = (ArrayList)session.getAttribute("plannerLocMemoDay");
		
		for (PlannerLocMemoDTO dto : arrList)
		{ 
			if (dto.getMap_lat() != null)
			{
		%>	
		<title><%=dto.getLoc_content() %></title>
		<lat><%=dto.getMap_lat() %></lat>
		<lng><%=dto.getMap_lng() %></lng>
		<%
			}
		}
		%>
	</place>
</positions>