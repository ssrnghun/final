<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>scheduleList.jsp</title>
<!-- 사용자 정의 css -->
<link rel="stylesheet" type="text/css" href="css/main.css">



<!-- jquery 소스 넣기 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<!-- bootstrap 소스 넣기 (bootstrap v5.0 버전)  -->
<!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
 -->
<!-- icon 부트스트랩 신버전 소스  -->
<!-- <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css"> -->

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=1cd979abcb06ec0dc17c31451c2b0cb5"></script>

<script type="text/javascript">
	
	function initialize()
	{
		initCenterLat = "<c:out value='${planner.start_loc_lat}'/>";
		initCenterLng = "<c:out value='${planner.start_loc_lng}'/>";
		page = -1;
		
		// 확인
		//alert("함수 호출 확인");
		mapContainer = document.getElementById("map");		
		
		mapOption =
		{
			center: new kakao.maps.LatLng(Number(initCenterLat), Number(initCenterLng)),
			level: 7,											
		};
		map = new kakao.maps.Map(mapContainer, mapOption);	
		
		// 줌 컨트롤(확대 축소 제어 컨트롤) 생성
		zoomControl = new kakao.maps.ZoomControl();
		
		// 줌 컨트롤을 지도 위에 표시
		map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
		
		showMarker(-1);
			
	}
	
	
	function showMarker(n)
	{		
		markers = [];
		
		var params = "day="+ n +"&room_num=" + $("#hidden_room_num").val();
		
		var title = new Array;
		var lat = new Array;
		var lng = new Array;
		var latlng = new Array;
		var centerLat = 0;
		var centerLng = 0;
		var infoWindow = new Array;
		var sameLatLng = new Array;
		
		$.ajax(
		{
			type:"GET"								
			, url:"map.action"				
			, data:params
			, dataType:"xml"
			, success:function(args)
			{
				var i = 0;
				$(args).find("place").find("title").each(function()
				{
					title[i] = $(this).text();
					i = i + 1;
				});
				i = 0;
				$(args).find("place").find("lat").each(function()
				{
					lat[i] = $(this).text();
					i = i + 1;
				});
				i = 0;
				$(args).find("place").find("lng").each(function()
				{
					lng[i] = $(this).text();
					i = i + 1;
				});
				
				for (var j=0; j<i; j++) // i가 들어가는 것이 맞음 i+1 아님 (이미 증가했음)
				{		
					//alert("마커 추가");
					latlng[j] = new kakao.maps.LatLng(lat[j], lng[j]);
					
					//------------------------------------------------------------------
					sameLatLng[j] = 1;
					for (var k=0; k<j; k++)
					{
						if (latlng[k].equals(latlng[j]))
						{
							sameLatLng[j] = sameLatLng[j] + 1;
							markers[k].setMap(null);
						}
					}
					
					//------------------------------------------------------------------
					
					addMarkers(latlng[j], title[j]);
					centerLat = Number(centerLat) + Number(lat[j]);
					centerLng = Number(centerLng) + Number(lng[j]);
					
					//------------------------------------------------------------------
					
					var iwContent = "<div style='padding:5px;'>"+sameLatLng[j]+"번 선택</div>";
					infoWindow[j] = new kakao.maps.InfoWindow(
					{
						position: latlng[j],
						content: iwContent,
					});
					if (sameLatLng[j] > 0)
					{
						kakao.maps.event.addListener(markers[j], "mouseover", makeOverListener(map, markers[j], infoWindow[j]));
						kakao.maps.event.addListener(markers[j], "mouseout", makeOutListener(infoWindow[j]));
						//infoWindow[j].open(map, markers[j])
					}
					//------------------------------------------------------------------
					
				}
				
				centerLat = centerLat / i;
				centerLng = centerLng / i;
				
				if (!Number.isNaN(centerLat))
					map.setCenter(new kakao.maps.LatLng(centerLat, centerLng));
				else
					map.setCenter(new kakao.maps.LatLng(Number(initCenterLat), Number(initCenterLng)));
					
				
			}											
			, error:function(request,error)
			{
				alert("에러발생"); // 에러 계속 발생했는데 xml 위에 개행 있는 것을 못봐서였음
				//alert(e.responseText);
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
			
		});
	}	
	
	function makeOverListener(map, marker, infowindow)
	{
	    return function()
	    {
	        infowindow.open(map, marker);
	    };
	}
	
	function makeOutListener(infowindow) 
	{
	    return function() 
	    {
	        infowindow.close();
	    };
	}
	
	

	function addMarkers(position, title)
	{
		marker = new kakao.maps.Marker(
		{
			position: position,
			title: title,
		});
		
		marker.setMap(map);
		
		markers.push(marker);
				
	}
	
	function setMarkers(map)
	{
		for (var i=0; i<markers.length; i++)
		{
			markers[i].setMap(map);
		}
	}


	
	function whatDays(n)
	{	
		var params = "";
		
		$.ajax(
		{
			type:"GET"								
			, url:""				
			, data:params						
			, success:function(args)
			{
				//alert("AJAX 성공");
				if (n==0)
				{
					$("#whatDays").val("1 일차");
					$(".daySpan").text("전체 일차");
					$("#day").val(1);
				}
				else
				{
					$("#whatDays").val(n+"일차");
					$(".daySpan").text(n+"일차");
					$("#day").val(n);
				}
			}											
			, error:function(e)
			{
				alert(e.responseText);
			}
		});
		
		setMarkers(null);
		showMarker(n);
	}

	
	$(function()
	{
		$(".accordion-button").click(function()
		{
			 document.getElementById("inputMemoFormBox").focus();
		});
		 
	});
	
	function addMemo()
	{
		$.ajax(
		{
			type:"GET"								
			, url:"addmemo.action"				
			, data:$("#memoForm").serialize()
			, success:function(args)
			{
				$(location).attr("href","planner.action?page=-1");
			}											
			, error:function(e)
			{
				alert(e.responseText);
			}
		});
		
	}
	
	function addMemoCollection()
	{
		$.ajax(
		{
			type:"GET"								
			, url:"addmemocollection.action"				
			, data:$("#memoForm").serialize()
			, success:function(args)
			{
				$(location).attr("href","planner.action?page=-1");
			}											
			, error:function(e)
			{
				alert(e.responseText);
			}
		});
		
	}
	
	// 수정 ★
	function placeSelect()
	{
		var day = document.getElementById("day").value;
		if($("#go").val()=='go')
		{
			alert("해당 방은 출발하여 장소를 추가할 수 없습니다.");
			return;
		}
		//alert("<c:out value='${planner.region}'/>");
		$(location).attr("href","PlaceSelect.jsp?mySelectDay="+document.getElementById("day").value+"&page=-1"+"&region="+"<c:out value='${planner.region}'/>");
	}

	// 수정 ★
	function removePlan(val)
	{
		//alert(val);
		if($("#go").val()=='go')
		{
			alert("해당 방은 출발하여 장소를 삭제할 수 없습니다.");
			return;
		}
		
		if (confirm("정말 삭제하시겠습니까?"))
			$(location).attr("href", "removecollection.action?page=-1"+"&loc_memo_num="+val+"&room_num=" + $("#hidden_room_num").val());
	}
	
	$(function()
	{
		$('#passModal').modal({backdrop: 'static'});
		
		$('.closePassModal').click(function()
		{
			$('#passModal').modal('hide');
		});
		
	});
	
	function hostPass(btn)
	{

		var params = "day=" + btn.id + "&room_num=" + "<c:out value='${planner.room_num}'/>";
		
		$.ajax(
		{
			type:"GET"								
			, url:"hostpass.action"				
			, data:params
			, success:function(args)
			{
				alert("성공");
			}											
			, error:function(e)
			{
				alert(e.responseText);
			}
		});
		
	}
	
	function selectMyCollection()
	{
		setMarkers(null);
		showMarker(-2);
		
		var replaceHtml = "";
		
		replaceHtml += " <c:forEach var='oneplan' items='${myCollectionList }'>";
		replaceHtml += " 	<ul class=\"shadow p-2 mb-3 bg-body rounded list-group list-group-horizontal rounded-0 bg-white\">";
		replaceHtml += "   		<li class=\"list-group-item ps-3 pe-0 py-1 rounded-0 border-0 bg-transparent\">";
		replaceHtml += "       		<span class=\"d-inline-flex align-items-center justify-content-center  rounded-circle m-1 me-2\" ";
		replaceHtml += "       		style=\"background-color:${(fn:substring(oneplan.loc_memo_num, 8, 9)=='L') ? 'orange' : 'green' }; width: 20px; height: 20px;\">";
		replaceHtml += "      		</span>";
		replaceHtml += "   		</li>";
		replaceHtml += "   		<li class=\"list-group-item px-3 py-1 d-flex align-items-center flex-grow-1 border-0 bg-transparent\">";
		replaceHtml += "     		<p class=\"lead fw-normal mb-0\">${oneplan.loc_content }</p>";
		replaceHtml += "   		</li>";
		replaceHtml += "   		<li class=\"list-group-item ps-3 pe-10 py-1 rounded-0 border-0 bg-transparent\">";
		replaceHtml += "   			<button type=\"submit\" class=\"btn btn-primary\" style=\"background-color: 	#32a852; border:none;";
		replaceHtml += "   			display: ${oneplan.mem_join_num == my_join_num ? 'inline' : 'none'};\">수정</button>";
		replaceHtml += "     		<button type=\"submit\" class=\"btn btn-danger\" ";
		replaceHtml += "     		style=\"background-color: 	#FF8C00; border:none; display: ${oneplan.mem_join_num == my_join_num ? 'inline' : 'none'};\" ";
		replaceHtml += "     		value=\"${oneplan.loc_memo_num }\" onclick=\"removePlan(this.value)\">삭제</button>";
		replaceHtml += "   		</li>";
		replaceHtml += " 	</ul>";
		replaceHtml += " </c:forEach>";
		
		$("#collectionListPlace").html(replaceHtml);
		
		var replaceBtn = "";
		
		replaceBtn += "<button type='button' class='btn btn-light' onclick='selectToTalCollection()'>";
		replaceBtn += "		<svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='orange' class='bi bi-person-circle' viewBox='0 0 16 16'>";
		replaceBtn += "			<path d='M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z'/>";
		replaceBtn += "			<path fill-rule='evenodd' d='M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z'/>";
		replaceBtn += "		</svg>";
		replaceBtn += "전체 보기";
		replaceBtn += "</button>";
		
		$("#changeToTalAndMySelection").html(replaceBtn);
		
	}
	
	function selectToTalCollection()
	{
		setMarkers(null);
		showMarker(-1);
		
		var replaceHtml = "";
		
		replaceHtml += " <c:forEach var='oneplan' items='${collectionList }'>";
		replaceHtml += " 	<ul class=\"shadow p-2 mb-3 bg-body rounded list-group list-group-horizontal rounded-0 bg-white\">";
		replaceHtml += "   		<li class=\"list-group-item ps-3 pe-0 py-1 rounded-0 border-0 bg-transparent\">";
		replaceHtml += "       		<span class=\"d-inline-flex align-items-center justify-content-center  rounded-circle m-1 me-2\" ";
		replaceHtml += "       		style=\"background-color:${(fn:substring(oneplan.loc_memo_num, 8, 9)=='L') ? 'orange' : 'green' }; width: 20px; height: 20px;\">";
		replaceHtml += "      		</span>";
		replaceHtml += "   		</li>";
		replaceHtml += "   		<li class=\"list-group-item px-3 py-1 d-flex align-items-center flex-grow-1 border-0 bg-transparent\">";
		replaceHtml += "     		<p class=\"lead fw-normal mb-0\">${oneplan.loc_content }</p>";
		replaceHtml += "   		</li>";
		replaceHtml += "   		<li class=\"list-group-item ps-3 pe-10 py-1 rounded-0 border-0 bg-transparent\">";
		replaceHtml += "   			<button type=\"submit\" class=\"btn btn-primary\" style=\"background-color: 	#32a852; border:none;";
		replaceHtml += "   			display: ${oneplan.mem_join_num == my_join_num ? 'inline' : 'none'};\">수정</button>";
		replaceHtml += "     		<button type=\"submit\" class=\"btn btn-danger\" ";
		replaceHtml += "     		style=\"background-color: 	#FF8C00; border:none; display: ${oneplan.mem_join_num == my_join_num ? 'inline' : 'none'};\" ";
		replaceHtml += "     		value=\"${oneplan.loc_memo_num }\" onclick=\"removePlan(this.value)\">삭제</button>";
		replaceHtml += "   		</li>";
		replaceHtml += " 	</ul>";
		replaceHtml += " </c:forEach>";
		
		$("#collectionListPlace").html(replaceHtml);
		
		var replaceBtn = "";
		
		replaceBtn += "<button type='button' class='btn btn-light' onclick='selectMyCollection()'>";
		replaceBtn += "		<svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='orange' class='bi bi-person-circle' viewBox='0 0 16 16'>";
		replaceBtn += "			<path d='M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z'/>";
		replaceBtn += "			<path fill-rule='evenodd' d='M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z'/>";
		replaceBtn += "		</svg>";
		replaceBtn += "내 의견 모아보기";
		replaceBtn += "</button>";
		
		$("#changeToTalAndMySelection").html(replaceBtn);
		
	}
	

	function placemodify(obj)
	{
		if($("#go").val()=='go')
		{
			alert("해당 방은 출발하여 장소를 수정할 수 없습니다.");
			return;
		}
		var place = obj.id;
		var num = obj.value;
		$(location).attr("href", "CollectionPlaceModify.jsp?num="+num+"&room_num=" + "<c:out value='${planner.room_num}'/>&region=" + "<c:out value='${planner.region}'/>");
	}
	
	function memomodify(obj)
	{
		//alert(obj.id.substr(8,10)); 
		$('#'+obj.value).html("<textarea id='txt"+obj.value+"'rows='1' style='width:90%'>"+obj.id+"</textarea>");
		$('#btn'+obj.value).html('<button type="button" class="btn btn-primary m-1" value="'+obj.id+'" id="com/'+obj.value+'"'
				+'style="background-color:#32a852; border:none;" onclick="memomodi(this)">완료</button>'
				+'<button type="button" class="btn btn-primary " value="'+obj.value+'" id="can/'+obj.id+'"'
				+'style="background-color:#FF8C00; border:none;" onclick="modicancel(this)">취소</button>');
	}
	
	function memomodi(obj)
	{
		var num = obj.id.split('/')[1];
		var str = 'txt'+num;
		var txt = $('#'+str).val();
		
		$(location).attr("href", "collectionmemomodi.action?loc_memo_num="+num+"&loc_content=" +txt+"&room_num=<c:out value='${planner.room_num}'/>");
	}
	
	function modicancel(obj)
	{
		var place = obj.id.split('/')[1];
		
		// 컬렉션 메모 수정 ★★★★★
		$('#'+obj.value).html('<p class="lead fw-normal mb-0">'+place+'</p>');
		$('#btn'+obj.value).html('<button type="submit" class="btn btn-primary modifyBtn m-1" id="'+place+'" style="background-color: #32a852; border:none;"'
		+'onclick="memomodify(this)" value="'+obj.value+'">수정</button><button type="submit" class="btn btn-danger" style="background-color: #FF8C00; border:none;'
		+'value="'+obj.value+'" onclick="removePlan(this.value)">삭제</button>');t
	}
	
	
			

</script>
<style type="text/css">

	.noClick:hover
	{
		cursor: default!important;
	}


</style>


</head>
<!-- 오버플로우 오토는 내용이 길 때 스크롤바 자동 생성하는 스타일 -->
<body onload="initialize()">
<div class="container-fluid" style="width: 80%">
	<div>
		<jsp:include page="/WEB-INF/view/Room_Ongoing_Header.jsp"/>
	</div>
	<div>
		<div class="py-5">
			<div class="row">
				<div class="col" style="margin-top: 0;">	
					<div class="card h-100" id="mapCard" style="border-radius: .75rem; background-color: #eff1f2;">
						<div class="card-body">
							<div id="map" style="height: 100%; width: 100%; border-radius: .75rem;"></div>
						</div>
					</div>
				</div>	
				<div class="col">
					<div class="card h-100" id="list1" style="border-radius: .75rem; background-color: #eff1f2;">
						
							<!-- 아래 아이콘 -->
							<!-- 
							<hr class="mb-2">
					 		-->
							<div class="d-flex justify-content-center align-items-center pt-2">
								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chevron-compact-down" viewBox="0 0 16 16">
									<path fill-rule="evenodd" d="M1.553 6.776a.5.5 0 0 1 .67-.223L8 9.44l5.776-2.888a.5.5 0 1 1 .448.894l-6 3a.5.5 0 0 1-.448 0l-6-3a.5.5 0 0 1-.223-.67z"/>
								</svg>
							</div>
							<hr class="my-3">
							<div class="d-flex justify-content-center align-items-center mb-1 pt-2 pb-2">
								<button type="button" class="btn btn-light me-2" onclick="placeSelect()">
		 							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="orange" class="bi bi-pin-map-fill" viewBox="0 0 16 16">
							  			<path fill-rule="evenodd" d="M3.1 11.2a.5.5 0 0 1 .4-.2H6a.5.5 0 0 1 0 1H3.75L1.5 15h13l-2.25-3H10a.5.5 0 0 1 0-1h2.5a.5.5 0 0 1 .4.2l3 4a.5.5 0 0 1-.4.8H.5a.5.5 0 0 1-.4-.8l3-4z"/>
							  			<path fill-rule="evenodd" d="M4 4a4 4 0 1 1 4.5 3.969V13.5a.5.5 0 0 1-1 0V7.97A4 4 0 0 1 4 3.999z"/>
									</svg>
		 							장소 추가
		 						</button>
			 					<span id="changeToTalAndMySelection">	
		 							<button type="button" class="btn btn-light" onclick="selectMyCollection()">
										<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="orange" class="bi bi-person-circle" viewBox="0 0 16 16">
										  <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
										  <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"/>
										</svg>
			 							내 의견 모아보기
			 						</button>
			 					</span>
	            			</div>
	           				<hr />
	            		<div class="card-body px-4 px-md-5" style="overflow: auto; height: 50vh;">
							<span id="collectionListPlace">
            				<c:forEach var="oneplan" items="${collectionList }">
			            		<!-- 일정 불러와서 for문 돌리기 --------------------------------------------- -->	            
			            		<!-- 일정 한줄 -->
			            		<ul class="shadow p-2 mb-3 bg-body rounded list-group list-group-horizontal rounded-0 bg-white">
				            		<!-- 공백 -->
				             		<!-- 동그라미 한줄 -->
				              		<li class="list-group-item ps-3 pe-0 py-1 rounded-0 border-0 bg-transparent"> <!-- ps: padding-left pe:padding-right py:padding-right -->
							      		<span class="d-inline-flex align-items-center justify-content-center  rounded-circle m-1 me-2" 
							      		style="background-color:${(fn:substring(oneplan.loc_memo_num, 8, 9)=='L') ? 'orange' : 'green' }; width: 20px; height: 20px;">
							     		</span>
				              		</li>
				              		<!-- 장소 한줄 -->
				              		<li class="list-group-item px-3 py-1 d-flex align-items-center flex-grow-1 border-0 bg-transparent" id="${oneplan.loc_memo_num }">
				                		<p class="lead fw-normal mb-0">${oneplan.loc_content }</p>
				              		</li>
				              		<!-- 버튼 한줄 -->
				              		 
				              		<li class="list-group-item ps-3 pe-10 py-1 rounded-0 border-0 bg-transparent" id="btn${oneplan.loc_memo_num }">
				              		<c:if test="${fn:substring(oneplan.loc_memo_num, 8, 9)=='L'}">
				              			<button type="submit" class="btn btn-primary" id="${oneplan.loc_content }" style="background-color: 	#32a852; border:none;
				              			display: ${oneplan.mem_join_num == my_join_num ? 'inline' : 'none'};" onclick="placemodify(this)" value="${oneplan.loc_memo_num }">수정</button>
				              		</c:if>
				              		<c:if test="${fn:substring(oneplan.loc_memo_num, 8, 9)!='L'}">
				              			<button type="submit" class="btn btn-primary modifyBtn" id="${oneplan.loc_content }" style="background-color: 	#32a852; border:none;
				              			display: ${oneplan.mem_join_num == my_join_num ? 'inline' : 'none'};" onclick="memomodify(this)" value="${oneplan.loc_memo_num }">수정</button>
				              		</c:if>
					            		<button type="submit" class="btn btn-danger" 
					            		style="background-color: 	#FF8C00; border:none; display: ${oneplan.mem_join_num == my_join_num ? 'inline' : 'none'};" 
					            		value="${oneplan.loc_memo_num }" onclick="removePlan(this.value)">삭제</button>
				              		</li>
				              		
			            		</ul> <!-- 일정 1개 끝 -->
		            		</c:forEach>
							</span>
	            			<!-- ---------------------------------------------------------------------------------- 일차마다 몇 일차인지 제목 달기 (책갈피 역할) -->  
	
	
	          			</div>
							<div class="accordion p-4" id="accordionExample">
				  				<div class="accordion-item">
				    				<h2 class="accordion-header" id="headingOne">
				      					<button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
				      					
											<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="#4c8afc" class="bi bi-pencil-square" viewBox="0 0 16 16">
							 					<path d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z"/>
							  					<path fill-rule="evenodd" d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5v11z"/>
											</svg>
		 									<span style="color:#4c8afc ">&nbsp;메모 추가</span>
				      					
				      					</button>
				    				</h2>
				   					<div id="collapseOne" class="accordion-collapse collapse show" aria-labelledby="headingOne" data-bs-parent="#accordionExample">
				     				<!-- 접기 -->
				      					<div class="accordion-body">
				      					<!-- 내부 입력 폼 -->
			            					<div class="pt-2 pb-2">
			              						<div class="card">
			                						<div class="card-body">
			                  							<form id="memoForm">
			                  							<div class="d-flex flex-row align-items-center">
			                  								<input type="hidden" id="day" value="1" name="day">
				                   			 				<input type="text" class="form-control form-control-lg" id="inputMemoFormBox" name="memo"
				                      						placeholder="남기고 싶은 메모를 입력하세요" style="margin-right: 2%">
				                    						<!-- <a href="#!" data-mdb-toggle="tooltip" title="Set due date"><i
				                        					class="fas fa-calendar-alt fa-lg me-3"></i></a> -->
		                    								<div>
		                    								
		                      									<button type="button" class="btn btn-primary" style="background-color: #32a852" onclick="addMemoCollection()">
																	<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-check-lg" viewBox="0 0 16 16">
								  										<path d="M12.736 3.97a.733.733 0 0 1 1.047 0c.286.289.29.756.01 1.05L7.88 12.01a.733.733 0 0 1-1.065.02L3.217 8.384a.757.757 0 0 1 0-1.06.733.733 0 0 1 1.047 0l3.052 3.093 5.4-6.425a.247.247 0 0 1 .02-.022Z"/>
																	</svg>
		                      									</button>
			                    							</div>
				                  						</div>
			                    						</form>
				                					</div>
				              					</div>
				            				</div>
					      				</div>
					    			</div>
					  			</div>
							</div>
	        		</div>
	      		</div>
			</div>
		</div>
	</div>
</div>

<!-- 패스현황 모달창 -->
<div class="modal fade" id="passModal" tabindex="-1" role="dialog">
  <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">${planner.id_num == myId ? '패스 요청하기' : '패스 하기'}</h5>
        <!-- <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button> -->
      </div>
      <div class="modal-body">
        <c:forEach var="dayN" begin="1" end="${planner.days }" step="1">
			<div style="${dayN%10!=0 ? 'float:left;' : '' } margin: 4px;" >
				&nbsp;${dayN }일차<br>
				<button type="button" class="btn btn-light shadow" ${planner.id_num == myId ? 'onclick="hostPass(this)"' : '' } 
				id="${dayN }" style="border-radius: 1rem; border: 2px solid #ffef85; 
				background-color: white;">
					<span style="font-weight: normal; font-size: smaller; color: orange;">PASS</span>
				</button>
			</div>
        </c:forEach>        
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary closePassModal" data-dismiss="modal"  aria-label="Close">닫기</button>
      </div>
    </div>
  </div>
</div>		


</body>
</html>