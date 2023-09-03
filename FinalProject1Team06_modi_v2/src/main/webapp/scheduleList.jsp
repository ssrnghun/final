<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
<!-- <link rel="stylesheet" type="text/css" href="css/main.css"> -->



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
		page = 1;
		
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
		
		showMarker(1);
		
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
					addMarkers(latlng[j], title[j]);
					centerLat = Number(centerLat) + Number(lat[j]);
					centerLng = Number(centerLng) + Number(lng[j]);
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
					$("#day").val(0);
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
	/*		
	function clickMemo()
	{
		$(".accordion-button").trigger("click");
		
	}
	*/
	
	 $(function()
	{
		 $(".accordion-button").click(function()
		{
			 document.getElementById("inputMemoFormBox").focus();
		});
	});
	
	function addMemo()
	{
		// 추가 ★★★★★
		if(document.getElementById("day").value == 0)
		{
			alert("메모 추가할 일차를 선택해주세요.");
			return;
		}
		
		$.ajax(
		{
			type:"GET"								
			, url:"addmemo.action"				
			, data:$("#memoForm").serialize()
			, success:function(args)
			{
				$(location).attr("href","planner.action");
			}											
			, error:function(e)
			{
				alert(e.responseText);
			}
		});
		
	}
	
	// 수정 ★★★★★★
	function placeSelect()
	{
		if($("#go").val()=='go')
		{
			alert("해당 방은 출발하여 장소를 추가할 수 없습니다.");
			return;
		}
		
		if(document.getElementById("day").value == 0)
		{
			alert("장소 추가할 일차를 선택해주세요.");
			return;
		}
		
		var params = "day=" + document.getElementById("day").value + "&room_num=" + "<c:out value='${planner.room_num}'/>";
		
		$.ajax(
		{
			type:"GET"								
			, url:"dayisfix.action"				
			, data:params
			, success:function(args)
			{
				if(args == "FIX")
				{
					alert("해당 일정은 픽스되어 장소를 추가할 수 없습니다.");
				}
				else
				{
					$(location).attr("href","PlaceSelect.jsp?mySelectDay="
					+document.getElementById("day").value+"&page=1&region="+"<c:out value='${planner.region}'/>");
				}
			}											
			, error:function(e)
			{
				alert(e.responseText);
			}
		});
		
	}

	function removePlan(val)
	{
		if($("#go").val()=='go')
		{
			alert("해당 방은 출발하여 장소를 삭제할 수 없습니다.");
			return;
		}
		if($("#go").val()=='go')
		{
			alert("해당 방은 출발하여 장소를 추가할 수 없습니다.");
			return;
		}
		if (confirm("정말 삭제하시겠습니까?"))
			$(location).attr("href", "removeplan.action?loc_memo_num="+val+"&room_num=" + $("#hidden_room_num").val());
	}
	
	
	function hostPass(btn)
	{
		var res = btn.id.split("/");
		
		if(res[1] =="cancle")
		{
			alert(res[0]+"일자 패스 취소하였습니다.");
		}
		else if(res[1]=="pass")
		{
			alert(res[0]+"일자 메이트에게 패스 요청하였습니다.");
		}
		
		var params = "day=" + res[0] + "&room_num=" + "<c:out value='${planner.room_num}'/>";
		
		$.ajax(
		{
			type:"GET"								
			, url:"hostpass.action"				
			, data:params
			, success:function(args)
			{
				$(".passModal").html(args);
			}											
			, error:function(e)
			{
				alert(e.responseText);
			}
		});
		
	}
	
	function memPass(btn)
	{
		var res = btn.id.split("/");
		
		if(res[1] =="cancle")
		{
			alert(res[0]+"일자 패스 취소하였습니다.");
		}
		else if(res[1]=="pass")
		{
			alert(res[0]+"일자 패스하였습니다.");
		}
		var params = "day=" + res[0] + "&room_num=" + "<c:out value='${planner.room_num}'/>";
		
		$.ajax(
		{
			type:"GET"								
			, url:"mempass.action"				
			, data:params
			, success:function(args)
			{
				$(".passModal").html(args);
			}											
			, error:function(e)
			{
				alert(e.responseText);
			}
		});
		
	}
	
	function passList(btn)
	{
		var params = "day=" + btn.id + "&room_num=" + "<c:out value='${planner.room_num}'/>";
		
		$.ajax(
		{
			type:"GET"								
			, url:"passlist.action"				
			, data:params
			, success:function(args)
			{
				$("#dayPassList").html(args);
			}											
			, error:function(e)
			{
				alert(e.responseText);
			}
		});
	}
	
		function placemodify(obj)
		{
			if($("#go").val()=='go')
			{
				alert("해당 방은 출발하여 장소를 수정할 수 없습니다.");
				return;
			}
			var arr = obj.id.split("/");
			var place = arr[0];
			var region = arr[1];
			var num = obj.value;
			$(location).attr("href", "PlaceModify.jsp?num="+num+"&room_num=" + "<c:out value='${planner.room_num}'/>"+"&region="+region);
		}
		
		function memomodify(obj)
		{
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
			
			$(location).attr("href", "memomodi.action?loc_memo_num="+num+"&loc_content=" +txt+"&room_num=" + "<c:out value='${planner.room_num}'/>");
		}
		
		function modicancel(obj)
		{
			var place = obj.id.split('/')[1];
			
			$('#'+obj.value).html('<p class="lead fw-normal mb-0">'+place+'</p>');
			$('#btn'+obj.value).html('<button type="submit" class="btn btn-primary modifyBtn m-1" id="'+place+'" style="background-color: #32a852; border:none;"'
			+'onclick="memomodify(this)" value="'+obj.value+'">수정</button><button type="submit" class="btn btn-danger" style="background-color: #FF8C00; border:none;'
			+'value="'+obj.value+'" onclick="removePlan(this.value)">삭제</button>');
		}
</script>
<script type="text/javascript">
	// 추가 ★★★★★
	$(function() 
	{
		$('#passModal').modal({backdrop: 'static'});
		$('#TripScore').modal({backdrop: 'static'});
		
		$('.closePassModal').click(function()
		{
			$('#passModal').modal('hide');
			$('#TripScore').modal('hide');
		});
		
		var today = new Date();   

		var endDate = "<c:out value='${planner.trip_end_date}'/>";
		
		var tripEnd = new Date(endDate);   
		var start = addDays(tripEnd, 1); 
		var end = addDays(tripEnd, 13); 
		
		function addDays(date, days) 
		{
			var clone = new Date(date);
		    clone.setDate(date.getDate() + days)
		    return clone;
		}
		
		var finMemCount = "<c:out value='${finMemCount}'/>";
		var tsCount = "<c:out value='${tsCount}'/>";
		
		if(today>=start && today<=end && finMemCount != tsCount)
		{
			$("#TripScore").modal("show");
		}
		
		// 별 클릭했을 때
		$(".label_star").click(function()
		{
			 $("#score").text($(this).find('span').text());
		});
		
		// 사람 선택 바꿨을 때
		$(".mateSel").change(function() 
		{
			$("#score").text("별을 클릭해주세요.");
			$('input:radio[name="starpoint"]').prop("checked", false);
		});
		
		// 평가하기 클릭
		 $(".rate").click(function()
		{
	    	// 점수
	        var score = $("#score").text();
			var option = $(".mateSel").val();
			
			var mem_finish_num = $(".mateSel").val().split("/")[0];
			var nik = $(".mateSel").val().split("/")[1];
			
			if(option =='0')
			{
				alert("메이트를 선택해주세요.");
				return;
			}
			if(!score.includes("점"))
			{
				alert("점수를 선택해주세요.");
				return;
			}
			if(confirm("'"+nik+"'님에게 여행 점수' "+score+" '을 부여하시겠습니까?"))
			{
				var params = "score="+score.substring(0,1)+"&mem_finish_num="+mem_finish_num+"&room_num=" + "<c:out value='${planner.room_num}'/>"; 
				
				alert("여행점수가 부여되었습니다. 감사합니다.");
				
				$(location).attr("href","triprate.action?"+params);
				
			}
		});
		
		
	});
	
</script>
<style type="text/css">

	.noClick:hover
	{
		cursor: default!important;
	}
	.passBtn:active 
	{
	    box-shadow: inset -.3rem -.1rem 1.4rem  #FBFBFB, inset .3rem .4rem .8rem #BEC5D0; 
	    cursor: pointer;
	}
	.passBtn
	{
		box-shadow:.8rem .5rem 1.4rem  #BEC5D0, -.3rem -.4rem .8rem #FBFBFB;
	}
 	.passMem
 	{
 		width: 8rem; height: 8rem; flex-direction: row;
 	}
 	.passNik
 	{
 		font-weight: bold;
 	}
 	.passImg
 	{
 		width:60px; height:60px; border-radius: 50%;
 	}
 	.nopass
 	{
 		font-family: Merriweather; font-size: 22px; font-weight: bold; color: gray;
 	}
 	.yespass
 	{
 		font-size: 22px; font-weight: bold; color: orange;
 	}
 	 .passList
    {
    	font-size: 8px; color: gray; border: none; background-color: transparent;
    }

.starpoint_wrap{display:inline-block;}
.starpoint_box{position:relative;background:url(https://ido-archive.github.io/svc/etc/element/img/sp_star.png) 0 0 no-repeat;font-size:0;}
.starpoint_box .starpoint_bg{display:block;position:absolute;top:0;left:0;height:18px;background:url(https://ido-archive.github.io/svc/etc/element/img/sp_star.png) 0 -20px no-repeat;pointer-events:none;}
.starpoint_box .label_star{display:inline-block;width:20px;height:18px;box-sizing:border-box;}
.starpoint_box .star_radio{opacity:0;width:0;height:0;position:absolute;}
.starpoint_box .star_radio:nth-of-type(1):hover ~ .starpoint_bg,
.starpoint_box .star_radio:nth-of-type(1):checked ~ .starpoint_bg{width:20%;}
.starpoint_box .star_radio:nth-of-type(2):hover ~ .starpoint_bg,
.starpoint_box .star_radio:nth-of-type(2):checked ~ .starpoint_bg{width:40%;}
.starpoint_box .star_radio:nth-of-type(3):hover ~ .starpoint_bg,
.starpoint_box .star_radio:nth-of-type(3):checked ~ .starpoint_bg{width:60%;}
.starpoint_box .star_radio:nth-of-type(4):hover ~ .starpoint_bg,
.starpoint_box .star_radio:nth-of-type(4):checked ~ .starpoint_bg{width:80%;}
.starpoint_box .star_radio:nth-of-type(5):hover ~ .starpoint_bg,
.starpoint_box .star_radio:nth-of-type(5):checked ~ .starpoint_bg{width:100%;}
.blind{position:absolute;clip:rect(0 0 0 0);margin:-1px;width:1px;height: 1px;overflow:hidden;}

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
								<div class="dropdown me-2">
									<a class="btn btn-secondary dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
						    		<span class="daySpan">전체 일자</span>
						  			</a>
						
									<ul class="dropdown-menu">
										<li><a class="dropdown-item" href="#1" onclick="whatDays(0)">전체일차</a></li>
										<!-- 드롭다운 마지막 일차까지 돌리는 forEach 구문 -->
										<c:forEach var="n" begin="1" end="${planner.days }" step="1">
											<li><a class="dropdown-item" href="#${n}" onclick="whatDays(${n})">${n }일차</a></li>
										</c:forEach>
						
						  			</ul>
								</div> <!-- dropdown 끝 -->
								<c:if test="${page == 1 and planner.id_num == myId }">
								<button type="button" class="btn btn-light me-2" onclick="placeSelect()">
		 							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="orange" class="bi bi-pin-map-fill" viewBox="0 0 16 16">
							  			<path fill-rule="evenodd" d="M3.1 11.2a.5.5 0 0 1 .4-.2H6a.5.5 0 0 1 0 1H3.75L1.5 15h13l-2.25-3H10a.5.5 0 0 1 0-1h2.5a.5.5 0 0 1 .4.2l3 4a.5.5 0 0 1-.4.8H.5a.5.5 0 0 1-.4-.8l3-4z"/>
							  			<path fill-rule="evenodd" d="M4 4a4 4 0 1 1 4.5 3.969V13.5a.5.5 0 0 1-1 0V7.97A4 4 0 0 1 4 3.999z"/>
									</svg>
		 							장소 추가
		 						</button>
		 						</c:if>
		 						<!-- <button type="button" class="btn btn-light" onclick="clickMemo()">
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="orange" class="bi bi-pencil-square" viewBox="0 0 16 16">
							 			<path d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z"/>
							  			<path fill-rule="evenodd" d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5v11z"/>
									</svg>
		 							메모 추가
		 						</button> -->
		 						<button type="button" class="btn btn-light" data-bs-toggle="modal" data-bs-target="#passModal">
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="orange" class="bi bi-person-check" viewBox="0 0 16 16">
									  <path d="M12.5 16a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7Zm1.679-4.493-1.335 2.226a.75.75 0 0 1-1.174.144l-.774-.773a.5.5 0 0 1 .708-.708l.547.548 1.17-1.951a.5.5 0 1 1 .858.514ZM11 5a3 3 0 1 1-6 0 3 3 0 0 1 6 0ZM8 7a2 2 0 1 0 0-4 2 2 0 0 0 0 4Z"/>
									  <path d="M8.256 14a4.474 4.474 0 0 1-.229-1.004H3c.001-.246.154-.986.832-1.664C4.484 10.68 5.711 10 8 10c.26 0 .507.009.74.025.226-.341.496-.65.804-.918C9.077 9.038 8.564 9 8 9c-5 0-6 3-6 4s1 1 1 1h5.256Z"/>
									</svg>
		 							패스 현황
		 						</button>
	            			</div>
	           				<hr />
	            		<div class="card-body px-4 px-md-5" style="overflow: auto; height: 50vh;">
	   			 		<!-- 일차마다 몇 일차인지 제목 달기 (책갈피 역할) ---------------------------------------------------------------------------------- -->
	          			
	          			<c:forEach var="m" begin="1" end="${planner.days }" step="1">
	            			<ul class="p-2 bg-body rounded list-group list-group-horizontal rounded-0 bg-transparent" style="padding-left: 0;">
	            				<li class="list-group-item py-1 d-flex align-items-center flex-grow-1 border-0 bg-transparent" style="padding-left: 0;">
	                				<p class="lead fw-normal mb-0">
	                					<a name="${m }" class="dateBtn"><!-- 책갈피 -->
			                				<button type="button" class="btn btn-light me-2 shadow noClick">
					 							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-calendar-check" viewBox="0 0 16 16" style="color: orange;">
												  <path d="M10.854 7.146a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708 0l-1.5-1.5a.5.5 0 1 1 .708-.708L7.5 9.793l2.646-2.647a.5.5 0 0 1 .708 0z"/>
												  <path d="M3.5 0a.5.5 0 0 1 .5.5V1h8V.5a.5.5 0 0 1 1 0V1h1a2 2 0 0 1 2 2v11a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V3a2 2 0 0 1 2-2h1V.5a.5.5 0 0 1 .5-.5zM1 4v10a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V4H1z"/>
												</svg>
		                						<span style="font-weight: bold;">
		                							&nbsp;${m }일차
		                						</span>
				 							</button>
	                					</a>
	                				</p>
	              				</li>
	            			</ul>
	            			
            				<c:set var="sequence" value="0"></c:set>
	            			<c:forEach var="oneplan" items="${plannerLocMemo }"  varStatus="plannerStatus">
	            				<c:if test="${oneplan.day == m }">
	            					<c:if test="${fn:substring(oneplan.loc_memo_num, 5, 6)=='L'}">
	            						<c:set var="sequence" value="${sequence + 1 }"></c:set>
			            			</c:if>
			            			<!-- 일정 불러와서 for문 돌리기 --------------------------------------------- -->	            
			            			<!-- 일정 한줄 -->
		            				<ul class="shadow p-2 mb-3 bg-body rounded list-group list-group-horizontal rounded-0 bg-white">
				            			<!-- 공백 -->
				             			<!-- 동그라미 한줄 -->
			              				<li class="list-group-item ps-3 pe-0 py-1 rounded-0 border-0 bg-transparent"> <!-- ps: padding-left pe:padding-right py:padding-right -->
							      			<span class="d-inline-flex align-items-center justify-content-center  rounded-circle m-1 me-2" 
							      			style="background-color:${(fn:substring(oneplan.loc_memo_num, 5, 6)=='L') ? 'orange' : 'green' }; width: 20px; height: 20px;">
											<c:if test="${fn:substring(oneplan.loc_memo_num, 5, 6)=='L'}">
												${sequence }
			            					</c:if>
							     			</span>
				              			</li>
				              			<!-- 장소 한줄 -->
				              			<li class="list-group-item px-3 py-1 d-flex align-items-center flex-grow-1 border-0 bg-transparent position-relative" id="${oneplan.loc_memo_num }" style="width: 60%;">
				                			<p class="lead fw-normal mb-0" >${oneplan.loc_content }</p>
				                			
				              			</li>
				              			<!-- 버튼 한줄 -->
				              				<li class="list-group-item ps-3 pe-10 py-2 px-0 rounded-0 border-0 bg-transparent float-end justify-content-center" id="btn${oneplan.loc_memo_num }" >
				              				
				              				<!--  fix 된 일자는 수정 버튼 disabled -->
									    	<c:if test="${oneplan.checkfix =='1'}">
					              				<button type="submit" class="btn btn-primary modifyBtn" id="${oneplan.loc_content }" style="background-color: 	#32a852; border:none;
					              				display: ${planner.id_num == myId ? 'inline' : 'none'};" disabled value="${oneplan.loc_memo_num }">수정</button>
				              				</c:if>
				              			 	<c:if test="${oneplan.checkfix =='0'}">
					              				<c:if test="${fn:substring(oneplan.loc_memo_num, 5, 6)=='L'}">
					              				<button type="submit" class="btn btn-primary modifyBtn" id="${oneplan.loc_content }/${planner.region}" style="background-color: #32a852; border:none;
					              				display: ${planner.id_num == myId ? 'inline' : 'none'};" onclick="placemodify(this)" value="${oneplan.loc_memo_num }">수정</button>
						              			</c:if>
						              			<c:if test="${fn:substring(oneplan.loc_memo_num, 5, 6)!='L'}">
						              			<button type="submit" class="btn btn-primary modifyBtn" id="${oneplan.loc_content }" style="background-color: 	#32a852; border:none;
						              			display: ${planner.id_num == myId ? 'inline' : 'none'};" onclick="memomodify(this)" value="${oneplan.loc_memo_num }">수정</button>
						              			</c:if>
				              				</c:if>
				              				</li>
				              				<li class="list-group-item ps-3 pe-10  px-0 py-2 rounded-0 border-0">
				              				<!-- fix된 일자는 삭제 불가  disabled 추가 ★--> 
				              				<c:if test="${oneplan.checkfix =='1'}">
						            			<button type="submit" class="btn btn-danger" 
						            			style="background-color: 	#FF8C00; border:none; display: ${planner.id_num == myId ? 'inline' : 'none'};" 
						            			value="${oneplan.loc_memo_num }" disabled onclick="removePlan(this.value)">삭제</button>
						            		</c:if>
						            		<c:if test="${oneplan.checkfix =='0'}">
						            			<button type="submit" class="btn btn-danger" 
						            			style="background-color: 	#FF8C00; border:none; display: ${planner.id_num == myId ? 'inline' : 'none'};" 
						            			value="${oneplan.loc_memo_num }" onclick="removePlan(this.value)">삭제</button>
						            		</c:if>
						            		</li >
						            		<li class="list-group-item ps-3 pe-10 px-0 py-1 rounded-0 border-0">
						            		<div class="text-end">
				                			<a href="#" style="text-decoration: none">▲</a><br><a href="#" style="text-decoration: none">▼</a>
				                			</div>
				                			</li>
			            			</ul> <!-- 일정 1개 끝 -->
			            		</c:if>
		            		</c:forEach>
		            	</c:forEach>
		            		<!-- --------------------------------------------- 일정 불러와서 for문 돌리기 -->
		            		<br>
				
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
			                  								<input type="text" class="form-control" id="whatDays" style="width: 15%; margin-right: 2%" 
			                  								readonly="readonly" value="1일차">
			                  								
			                  								<!-- 수정 ★★★★★ -->
			                  								<input type="hidden" id="day" value="0" name="day">
				                   			 				<input type="text" class="form-control form-control-lg" id="inputMemoFormBox" name="memo"
				                      						placeholder="남기고 싶은 메모를 입력하세요" style="margin-right: 2%">
				                    						<!-- <a href="#!" data-mdb-toggle="tooltip" title="Set due date"><i
				                        					class="fas fa-calendar-alt fa-lg me-3"></i></a> -->
		                    								<div>
		                      									<button type="button" class="btn btn-primary" style="background-color: #32a852" ${planner.id_num == myId ? 'onclick="addMemo()"' : 'disabled="disabled"'}>
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
      <div class="modal-body passModal">
		<div id="passCheck" class="justify-content-center row ">
		<!-- 방장일 때 -->
		<c:if test="${planner.id_num == myId}">
	        <c:forEach var="pass" items="${hostPassList }">
	        	<div class="col-2" style="${pass.day%10!= 0 ? 'float:left;' : '' } margin: 4px;" >&nbsp;${pass.day }일차
					<br>
						<c:if test="${pass.hostCount == 0 }">
							<button type="button" class="btn btn-light shadow passBtn" onclick="hostPass(this)"
							id="${pass.day }/pass" style="border-radius: 1rem; border: 2px solid #ffef85;  width: 110px; height: 65px;
							background-color: white;">
								<span style="font-weight: bold; font-size: smaller; color: orange;">PASS 하기</span>
							</button>
						</c:if>
						<c:if test="${pass.hostCount == 1 && pass.checkFix == '0' && pass.passdelcheck =='CANDEL' }">
							<button type="button" class="btn btn-light shadow passBtn" onclick="hostPass(this)" 
							id="${pass.day }/cancle" style="border-radius: 1rem; border: 2px solid #ffef85;  width: 110px; height: 65px;
							background-color: orange;">
								<span style="font-weight: bold; font-size: smaller; color: white;">PASS 취소</span>
							</button><br>
							<button class="mx-2 passList" id=${pass.day } onclick="passList(this)"><i class="bi bi-arrow-right"></i>패스현황보기</button>
						</c:if>
						<c:if test="${pass.hostCount == 1 && pass.checkFix == '0' && pass.passdelcheck =='CANNOTDEL' }">
							<button type="button" class="btn btn-light shadow passBtn" onclick="hostPass(this)" 
							id="${pass.day }/cancle" style="border-radius: 1rem; border: 2px solid #909090;  width: 110px; height: 65px;
							background-color: gray;" disabled>
								<span style="font-weight: bold; font-size: smaller; " >PASS <br>취소 불가</span>
							</button><br>
							<button class="mx-2 passList" id=${pass.day } onclick="passList(this)"><i class="bi bi-arrow-right"></i>패스현황보기</button>
						</c:if>
						<c:if test="${pass.hostCount == 1 && pass.checkFix == '1'}">
							<button type="button" class="btn btn-light shadow" 
								id="${pass.day }" style="border-radius: 1rem;  background-color: #C6C6C6; width: 110px; height: 65px;" disabled>
									<span style="font-weight: bold; font-size: 15px; color: red; ">FIX</span>
								</button>
						</c:if> 
						</div>
	        </c:forEach>
	      </c:if>
	      
	      <!-- 메이트일 때 -->
	      <c:if test="${planner.id_num != myId}">
	        <c:forEach var="pass" items="${memPassList }">
	        	<div class="col-2" style="${pass.day%10!= 0 ? 'float:left;' : '' } margin: 4px;" >&nbsp;${pass.day }일차
					<br>
						<!--  방장 패스 요청이 없을 때 → PASS 요청 없음 버튼 -->
						<c:if test="${pass.hostCount == 0 }">
							<button type="button" class="btn btn-light shadow "
							id="${pass.day }" style="border-radius: 1rem; border: 3px solid #909090; width: 110px; height: 65px;
							background-color: white;" disabled>
								<span style="font-weight: bold; font-size: smaller; color:  #909090;">PASS</span><br>
								<span style="font-weight: bold; font-size: smaller; color:  #909090;">요청 없음</span>
							</button>
						</c:if>
						<!-- 방장 패스 요청 있을 때 -->
						<c:if test="${pass.hostCount == 1 }">
							<!--  멤버 패스 버튼 안눌렀을 때 → 방장 PASS 요청 !  -->
							<c:if test="${pass.memCount == 0 && pass.checkFix == '0' }">
								<button type="button" class="btn btn-light shadow passBtn" onclick="memPass(this)" 
								id="${pass.day }/pass" style="border-radius: 1rem; border: 3px solid #ffef85; background-color: white;  width: 110px; height: 65px;">
									<span style="font-weight: bold; font-size: 15px; color: orange;">PASS 하기</span>
									<br><span style="font-size: 5px; color: red">방장PASS요청!</span>
								</button><br>
								<button class="mx-2 passList" id="${pass.day }" onclick="passList(this)"><i class="bi bi-arrow-right"></i>패스현황보기</button>
							</c:if>
							<!-- 멤버 패스 버튼 눌렀을 때 → PASS 완료   -->
							<c:if test="${pass.memCount == 1 && pass.checkFix == '0'}">
								<button type="button" class="btn btn-light shadow passBtn" onclick="memPass(this)" 
								id="${pass.day }/cancle" style="border-radius: 1rem; border: 2px solid #ffef85; background-color: orange; width: 110px; height: 65px;">
									<span style="font-weight: bold; font-size: 15px; color: white; ">PASS 취소</span>
								</button><br>
									<button class="mx-2 passList" id="${pass.day }" onclick="passList(this)"><i class="bi bi-arrow-right"></i>패스현황보기</button>
							</c:if>
							<c:if test="${ pass.checkFix != '0'}">
								<button type="button" class="btn btn-light shadow" 
								id="${pass.day }" style="border-radius: 1rem;  background-color: #C6C6C6; width: 110px; height: 65px;" disabled>
									<span style="font-weight: bold; font-size: 15px; color: red; ">FIX</span>
								</button>
							</c:if>
						</c:if>
				</div>
				<c:if test="${pass.day % 6 == 0 }">
					<br><br><br><br>
				</c:if>
	        </c:forEach>
	      </c:if>
		</div>
      <!--  패스 현황 눌렀을 때 -->
      <div id="dayPassList">
   		</div>
   		</div>

      <div class="modal-footer">
        <button type="button" class="btn btn-secondary closePassModal" data-dismiss="modal"  aria-label="Close">닫기</button>
      </div>
    </div>
  </div>
</div>		


<div class="modal fade" id="TripScore" tabindex="-1" role="dialog">
  <div class="modal-dialog  modal-dialog-centered" role="document" style="width: 350px"> 
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">여행 점수 부여</h5>
      </div>
      <div class="modal-body text-center">
      
      <select class="form-select mateSel mx-3" aria-label="Default select example" style="width: 280px">
		  <option selected value="0">==메이트 선택==</option>
		  <c:forEach var="member" items="${tripScoreMate }">
			  <option value="${member.mem_finish_num }/${member.nickname }">${member.nickname }</option>
		  </c:forEach>
	  </select>
      <br><br>
		<div class="starpoint_wrap">
			<div class="starpoint_box">
				<label for="starpoint_1" class="label_star" title="1">
					<span class="blind">1점</span>
				</label> 
				<label for="starpoint_2" class="label_star" title="2">
					<span class="blind">2점</span>
				</label>
				<label for="starpoint_3" class="label_star" title="3">
					<span class="blind">3점</span>
				</label> 
				<label for="starpoint_4" class="label_star" title="4">
					<span class="blind">4점</span>
				</label>
				<label for="starpoint_5" class="label_star" title="5">
					<span class="blind">5점</span>
				</label> 
				<input type="radio" name="starpoint" id="starpoint_1" class="star_radio">
				<input type="radio" name="starpoint" id="starpoint_2" class="star_radio"> 
				<input type="radio" name="starpoint" id="starpoint_3" class="star_radio">
				<input type="radio" name="starpoint" id="starpoint_4" class="star_radio">
				<input type="radio" name="starpoint" id="starpoint_5" class="star_radio">
				<span class="starpoint_bg etiScore"></span>
			</div>
		</div>
		<br> <br>
		<span id="score" style="color: red">별을 클릭해주세요.</span>
	</div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary rate" data-dismiss="modal" >평가하기</button>
         <button type="button" class="btn btn-secondary closePassModal" data-dismiss="modal"  aria-label="Close">닫기</button>
    </div>
    </div>
    </div>
    </div>	
    
</body>
</html>