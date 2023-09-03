<%@page import="com.final1.logic.RoomMemberDTO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.final1.util.DBConn"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%

	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	HttpSession session1 = request.getSession();
	String id = (String)session1.getAttribute("id");
	
	Connection conn = DBConn.getConnection();
	
	String sql = "SELECT NIKNAME,PHOTO FROM MEMBER WHERE ID_NUM = (SELECT ID_NUM FROM MEM_REGI WHERE ID =?)";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, id);
	
	ResultSet rs =  pstmt.executeQuery();
	RoomMemberDTO dto = new RoomMemberDTO();
	while(rs.next())
	{
		dto.setNickname(rs.getString(1));
		dto.setPhoto(rs.getString(2));
	}
	String nikname = dto.getNickname();
	String photo = dto.getPhoto();
	
	//rs.close();
	//pstmt.close();
	//conn.close();
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>User_roomListPage.jsp</title>

<!-- jQuery  -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>

<!-- bootstrap 소스 넣기 (bootstrap v5.0 버전)  --> <!-- i clude 된 곳에서 끌어다쓰고 있다.  -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>


<!-- icon 부트스트랩 신버전 소스  -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">

<!-- 모달창 스크립트  -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.1/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>


<style type="text/css">
	
	#background_img { 
		background-image: url("images/korea.jpg");
		background-position: center top;	
	}
	
	h1 { 
		color: white;
	 }
	 
	.search {
	  position: relative;
	  width: 800px;
	  
	}
	
	.search_box {
	  width: 100%;
	  border: none; 
	  border-radius: 45px;
	  padding: 10px 12px;
	  font-size: 14px;
	  height: 60px;
	  text-align: center;
	  overflow: auto;
	}
	
	#trip_search {
		border-radius: 45px;
		color : black; 		
	}
	
	#btn_title {
		position: absolute;
		margin: 0;
		background-color: #FF9966;
		top : 10px;
		left: 25px;
		width: 80px;
		height: 40px;
		border-radius: 45px;
	}
	
	#btn_make {
		border-radius: 45px;
		font-weight: bold;
		width : 150px; 
		height: 40px;
		border: solid 2px #E5E5E5;
		background-color: white;
	}
	
	.bi-funnel-fill:hover {
		color: #49AFB4;
	}
	
	#btn_make:hover {
		font-weight: bold;
		width: 152px;
		height: 43px;
		background-color: #FBBF66;
	}
	
	#btn_div_make {
		top: 0;
		right : 50px;
	}
	
	#regionBtn:hover {
		font-weight: bold;
		width: 60px;
		height: 40px;
	}
	
	#budget:hover {
		font-weight: bold;
		width: 60px;
		height: 40px;
	}
	
	.bi-search {
	  position : absolute;
	  width: 17px;
	  top: 5px;
	  right: 50px;
	  margin: 0;
	  color: #B4B4B4;
	  font-size: 30px;
	}
	
	.bi-funnel-fill {
	  color: #B4B4B4;
	  font-size: 30px;
	}
	
	.bi-search:hover {
  		 color : #FF9966;
  	}
  	
  	.search_box:focus {outline: 2px solid #FFB895;}
	
	/* 부트스트랩 리스트 스타일 */
	
      .bd-placeholder-img {
        font-size: 1.125rem;
        text-anchor: middle;
        -webkit-user-select: none;
        -moz-user-select: none;
        user-select: none;
      }

      @media (min-width: 768px) {
        .bd-placeholder-img-lg {
          font-size: 3.5rem;
        }
      }

      .b-example-divider {
        height: 3rem;
        background-color: rgba(0, 0, 0, .1);
        border: solid rgba(0, 0, 0, .15);
        border-width: 1px 0;
        box-shadow: inset 0 .5em 1.5em rgba(0, 0, 0, .1), inset 0 .125em .5em rgba(0, 0, 0, .15);
      }

      .b-example-vr {
        flex-shrink: 0;
        width: 1.5rem;
        height: 100vh;
      }

      .bi {
        vertical-align: -.125em;
        fill: currentColor;
      }

      .nav-scroller {
        position: relative;
        z-index: 2;
        height: 2.75rem;
        overflow-y: hidden;
      }

      .nav-scroller .nav {
        display: flex;
        flex-wrap: nowrap;
        padding-bottom: 1rem;
        margin-top: -1px;
        overflow-x: auto;
        text-align: center;
        white-space: nowrap;
        -webkit-overflow-scrolling: touch;
      }
	
	.city
	{
	   margin-top: 5px;
	   vertical-align: center;
	}
	
	.roomList:hover
	{	
		color : #FF9966;
	}
	.roomList
	{
		color :white;
	}
	.pagination-container 
	{
  		text-align: center;
	}

	.pagination .page-item.active .page-link 
	{
	  	background-color: #e5e5e5;
	  	border-color: #e5e5e5; 
	}
	
	#roomListPage
	{
		overflow-y: scroll; 
		height: 800px;
		width: 1000px;
	}
	
</style>

<script type="text/javascript">
	
	//비공개 방 비밀번호 체크하는 함수
	function pwCheck(pwCode)
	{	
		
		var pwCodeArray = pwCode.id.split("/");
		//pwCodeArray[0]; // yes, no (비공개 여부)
		//pwCodeArray[1]; // 방 번호 
	
		// 사용자가 입력한 비밀번호 변수 
		var pw = 0;
		// 입력창 초기
		$("#pwCode_modal").val("");
		
		// 비공개방 일 경우 
		if (pwCodeArray[0] == 'YES')
		{
			
			// 사용자가 입력한 비번과 해당 방의 비밀번호가 같은지 비교하는 변수 
			var pwRoom = 0;
			
			// pwModal 창 열기
			$('#pwModal').modal("show");
			
			
			// ajax 중복요청왔을때 계속 ajax success 코드실행을
			// 방지하기 위해 지금 들어온 요청의 카운트 저장 
			var ajax_last_num = 0; // 마지막 요청 카운트 저장. 전역변수 
			
			// ajax 요청 시작 전 ajax 요청이 들어있는 함수의 지역변수 
			var current_ajax_num = ajax_last_num; 
			
			
			// pwModal 창에서 확인버튼을 눌렀을 경우 
			$("#pwModal_Check").click(function() {
				
				// 사용자가 입력한 비밀번호 값을 담는다. 
				pw = $("#pwCode_modal").val();
				console.log("비밀번호 : " + pw);
				$("#pwModal").modal("hide");
				
				$.ajax(
						{
							type:"GET"
							,url: "pw_check.action"
							,async: false   					// 비동기 속성 false 처리 
							,beforeSend:function(request){ // ajax 처리하기 전, ajax 가 실행될때마다 중복 실행되는지 확인하는 누적
								ajax_last_num = ajax_last_num + 1; 
							}
							,data: 
							{
								room_num : pwCodeArray[1]
							   ,pw : pw
							}
							,success:function(data)
							{
								// ajax 처리가 한번만 됐을 경우 실행
								if (current_ajax_num == ajax_last_num - 1) { 
									
									pwRoom = data;
									console.log("pwRoom :" + data);
									
									// 사용자 비번과 해당 방 비번 같을 경우 
									if (pwRoom == 1)
									{
										console.log("비밀번호 맞았을 경우 1");
										//alert("비밀번호가 맞습니다.");
										
										// 해당 방으로 페이지 이동하는 코드 작성하기
										$(location).attr("href","planner.action?page=1&room_num="+pwCodeArray[1]);
									}
									else if(pwRoom == 0)
									{
										console.log("비밀번호 틀렸을 경우 0");
										alert("비밀번호가 틀렸습니다.");
									}	
									
								}
								
							}
							, error:function(e)
							{
								console.log(e.responseText);
							}
						});
				
			})
			
		}
		else
		{
			$(location).attr("href","planner.action?page=1&room_num="+pwCodeArray[1]);
		}
	}
	
	// 예산 선택 시 범위 조정하는 함수 
	function select(obj)
	{
	   var budgetMinValue = obj.value;
	   //alert(budgetMinValue);
	   var budgetMax = document.getElementById("budgetMax");
	   var budgetOption = budgetMin.value;
	   
	   budgetMax.innerHTML = "";
	   
	   for (var i = parseInt(budgetMinValue); i <= 10; i++)
	   {
	      var option = document.createElement("option");
	      option.value = i;
	      option.text = (i*100000).toLocaleString('ko-KR');
	      budgetMax.add(option);
	   }
	   
	}
	
	// 지역 입력하지 않은 채 검색 버튼 누를경우 (ajax 로 요청보내기전 확인하는 함수) 
	function showRequest()
	{
		if (!$.trim($("#trip_search").val()))  
		{
			alert("지역을 입력해주세요.");
			$("#trip_search").focus();
			
			return false; 
		}
		
		return true;
	}
	
	
	// 페이지가 로드될 때 캘린더 기존옵션 설정
	function searchDate()
	{	
		// 현재 날짜
		var today = new Date();
		
		// 현재 날짜를 startDate 에 넣는 구문
		//document.getElementById("search_startDate").valueAsDate = today;
		startDate = document.getElementById("search_startDate");
		// 여행시작일 최소 날짜 제한 		
		startDate.setAttribute("min", startDate.value);
		
		// 여행종료일 기본옵션 
		//document.getElementById("search_endDate").value = startDate.value;
		
		// 처음 로드 될때 여행 종료일이 여행시작일로 최소 날짜 제한
		endDate = document.getElementById("search_endDate");
		endDate.setAttribute("min", startDate.value);
		
		
		var startDateVal = new Date(startDate.value);
		var maxEndDate = new Date(endDate.value);
		//alert("날짜지정중 : " + maxEndDate);
		var maxMax = maxEndDate.setDate(startDateVal.getDate() + 30);
		//alert("최대날짜제한중 : " + maxMax);    //  1693958400000
		var timeOffMax = new Date(endDate.value).getTimezoneOffset()*60000;  // -32400000
		//alert("최대시간과의 차이를 분 단위로 반환 : " + timeOffMax);
		if (startDate.value != "")
		{
			var max = new Date(maxMax-timeOffMax).toISOString().substring(0, 10);
		}
		//alert("최대날짜 구하기1 : " + max); // 2023-09-06 
		
		// 여행 종료일에 최대 범위 구한 값 넣어주기
		endDate.setAttribute("max", max);
		
	}
	
	// 여행 시작일 일정이 change 버튼눌렸을 경우 
	function startChange()
	{	
		
		// 여행종료일 변수설정
		var endFirstDate = document.getElementById("search_endDate").value
		
		// 여행종료일이 여행시작일보다 작거나 같을 경우	
		if (endFirstDate <= startDate.value)
		{	
			// 여행종료일 최소값에 여행시작일의 value 값을 넣어준다.
			endFirstDate = startDate.value;
			endDate.setAttribute("min", endFirstDate);
			
			
			var startDateVal = new Date(startDate.value);
			var maxEndDate = new Date(endDate.value);
			//alert("날짜지정중 : " + maxEndDate);
			var maxMax = maxEndDate.setDate(startDateVal.getDate() + 30);
			//alert("최대날짜제한중 : " + maxMax);    //  1693958400000
			var timeOffMax = new Date(endDate.value).getTimezoneOffset()*60000;  // -32400000
			//alert("최대시간과의 차이를 분 단위로 반환 : " + timeOffMax);
			var max = new Date(maxMax-timeOffMax).toISOString().substring(0, 10);
			
			//alert("여행종료일 최대 범위2 : " + max);
			endDate.setAttribute("max", max);
			
		}
		else
		{
			// 여행 시작일에 맞춰 최소범위 조절
			endDate.setAttribute("min", startDate.value);
			
			var startDateVal = new Date(startDate.value);
			var maxEndDate = new Date(endDate.value);
			//alert("날짜지정중 : " + maxEndDate);
			var maxMax = maxEndDate.setDate(startDateVal.getDate()+30);
			//alert("최대날짜제한중 : " + maxMax);    //  1693958400000
			var timeOffMax = new Date(endDate.value).getTimezoneOffset()*60000;  // -32400000
			//alert("최대시간과의 차이를 분 단위로 반환 : " + timeOffMax);
			var max = new Date(maxMax-timeOffMax).toISOString().substring(0, 10);
			
			//alert("여행종료일 최대 범위3 : " + max);
			endDate.setAttribute("max", max);
		}
		
	}
	
	
	
	function bookmark(btn)
	{
		var bookmark_fill = "<i class='bi bi-bookmark-fill'></i>" 
		var bookmark_fillNot = "<i class='bi bi-bookmark'></i>" 
			
	        $.ajax(
	    			{
	    				type:"POST" 					
	    				, url: "selectmark.action" 		
	    				, data: 
	    				{
	    				 	roomNum : btn.id,
	    				 	//idNum : "ID-00005"
	    				 	
	    				}
	    				, success:function(datas) 
	    				{	
	    					var data = datas;
	    					
	    					if (data != 1)
							{
	    					  btn.innerHTML = bookmark_fill; 
	    						 
							}
	    					else
	    					{
	    						 btn.innerHTML = bookmark_fillNot; 
	    					}
	    				}
	    				, error:function(e)
	    				{
	    					console.log(e.responseText); // 소량의 데이터	
	    				}			
	    		    });
	}
	
	
	
</script>



<script type="text/javascript">
	

	$(function()
	{	
		// 툴팁 
		$('[data-toggle="tooltip"]').tooltip();
		
	    
	    /* 예산 글자 범위에 대해서 글자 조정을 위한 CSS 기능 */
	    $('#budgetApply').click(function()
        {
	         if($("#budgetMin").val()=='0' && $("#budgetMax").val()=='0')
	         {
	            //$("#budget").text((parseInt($("#budgetMin").val())*10)+"~"+(parseInt($("#budgetMax").val())*10));
	            $("#budget").text("예산");
	         }
	         else if($("#budgetMin").val()=='0' && $("#budgetMax").val()!='0')
	         {
	            $("#budget").text((parseInt($("#budgetMin").val())*10)+"~"+(parseInt($("#budgetMax").val())*10)+"만");
	         }
	         else
	         {
	            $("#budget").text((parseInt($("#budgetMin").val())*10)+"만~"+(parseInt($("#budgetMax").val())*10)+"만");
	         }
        });
	         
	    
	    /* 지역내 기초자치단체 검색 되는 기능 구현  */
	    $('#InRegionSearch').click(function()
		{
			//  검색창에 입력한 value값 확인하기 
			var region = $.trim($("#trip_search").val());

			$.ajax(
	    			{
	    				type:"GET" 					
	    				, url: "regionsearch.action" 		
	    				, data: 
	    				{
	    				 	tripSearch: region,
	    				}
	    				, success:function(response)
	    				{	
	    					console.log(response);
	    					$("#regionResult").html(response);
	    					//$("label[for='result1']").text(response);
	    					
	    					$("#trip_search").val("");
	    					$("#trip_search").focus();
	    					
	    				}  // check~!!! 
	    				, beforeSend:showRequest // showRequest() 로 쓰는 것과 헷갈리지말기 → true / false
	    				, error:function(e)
	    				{
	    					console.log(e.responseText); // 소량의 데이터	
	    				}			
	    			});
			
		});
	    
	    
	    // 지역검색 내의 선택버튼을 눌렀을 때의 기능 구현 
	    $('#regionSelect').click(function()
   		{
   	    	// 자신이 검색하거나, 추천지로 있는 지역 버튼을 누른 것의 지역텍스트를 가져옴
   	    	result = $(':radio[name=options-outlined]:checked').next().text();
   			
   			// 확인
   			//alert(result);
   			// 지역 버튼을 누르지않고 선택버튼을 눌렀을 경우 
   			if (result == "")
   			{
   				alert("지역을 선택해주세요.");
   			}
   			else // 그게 아니라면, 
   			{	
   				// 모달창 닫기 
   				$('#regionSearch').modal("hide");
   				// 지역검색 버튼을 사용자가 선택한 지역으로 변경
   				$('#regionBtn').text(result);
   				
   			}
   			
   		});
	    
	    
	    // 방 개설일, 여행시작일 순 정렬을 위한 기능 구현
		$("#sort").change(function()
		{
			var sort = ($("#sort").val());
			// 확인 
			//alert(sort);
			
			// 새로고침하는 방향으로 시도
			$(location).attr("href","roomlist.action?sort="+sort);
			
		});
	    
	    // 여행 스타일 검색 에서 모드 조회 기능 구현 
	    $("#tripMode").on('change',function()
		{
			var param = { mode_name : $("#tripMode").val()}
			
			
			if (($("#tripMode").val() != '기본'))
			{
				$.ajax(
						{
							type:"GET" 					
			    				, url: "mode_select.action" 	
			    				, dataType: "text"
			    				, data: param 
			    				, success: function(args)
								{
									if(args=="1")
									{
										alert("저장된 여행스타일 모드가 없습니다.");
										return;
									}
									else
									{
			    					
										console.log(args);
										
										nameOption = $(args).find("name").text();
										planOption = $(args).find("plan").text();
										payOption = $(args).find("money").text();
										stayOption = $(args).find("stay").text();
										trafficOption = $(args).find("traffic").text();
										cycleOption = $(args).find("cycle").text();
										paceOption = $(args).find("pace").text();
										destiOption = $(args).find("desti").text();
										doOption = $(args).find("do").text();
										seeOption = $(args).find("see").text();
										foodOption = $(args).find("food").text();
										mealOption = $(args).find("meal").text();
										supplyOption = $(args).find("supply").text();
										photoOption = $(args).find("photo").text();
										
										$(":radio[name=planRadio][value=" + planOption + "]").prop('checked', true);
										$(":radio[name=payRadio][value=" + payOption + "]").prop('checked', true);
										$(":radio[name=stayRadio][value=" + stayOption + "]").prop('checked', true);
										$(":radio[name=trafficRadio][value=" + trafficOption + "]").prop('checked', true);
										$(":radio[name=cycleRadio][value=" + cycleOption + "]").prop('checked', true);
										$(":radio[name=faceRadio][value=" + paceOption + "]").prop('checked', true);
										$(":radio[name=tripLocRadio][value=" + destiOption + "]").prop('checked', true);
										$(":radio[name=toDoRadio][value=" + doOption + "]").prop('checked', true);
										$(":radio[name=toSeeRadio][value=" + seeOption + "]").prop('checked', true);
										$(":radio[name=foodRadio][value=" + foodOption + "]").prop('checked', true);
										$(":radio[name=mealCountRadio][value=" + mealOption + "]").prop('checked', true);
										$(":radio[name=supplyRadio][value=" + supplyOption + "]").prop('checked', true);
										$(":radio[name=photoRadio][value=" + photoOption + "]").prop('checked', true);
									}
								}
			    				, error: function(request, status, error) 
			    				{
		    	                   console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		    	                }	
						});
			}
			
		});
	    
	    
		// 여행 스타일 모드 내에서 모드 조회 기능 구현 
	    $("#tripMode1").on('change',function()
		{
			var param = { mode_name : $("#tripMode1").val()}
			
			
			if (($("#tripMode1").val() != '기본'))
			{
				$.ajax(
						{
							type:"GET" 					
			    				, url: "mode_select.action" 	
			    				, dataType: "text"
			    				, data: param 
			    				, success: function(args)
								{
									console.log(args);
									

									if(args=="1")
									{
										alert("저장된 여행스타일 모드가 없습니다.");
										return;
									}
									else
									{
									
										nameOption = $(args).find("name").text();
										planOption = $(args).find("plan").text();
										payOption = $(args).find("money").text();
										stayOption = $(args).find("stay").text();
										trafficOption = $(args).find("traffic").text();
										cycleOption = $(args).find("cycle").text();
										paceOption = $(args).find("pace").text();
										destiOption = $(args).find("desti").text();
										doOption = $(args).find("do").text();
										seeOption = $(args).find("see").text();
										foodOption = $(args).find("food").text();
										mealOption = $(args).find("meal").text();
										supplyOption = $(args).find("supply").text();
										photoOption = $(args).find("photo").text();
										
										$(":radio[name=planRadio1][value=" + planOption + "]").prop('checked', true);
										$(":radio[name=payRadio1][value=" + payOption + "]").prop('checked', true);
										$(":radio[name=stayRadio1][value=" + stayOption + "]").prop('checked', true);
										$(":radio[name=trafficRadio1][value=" + trafficOption + "]").prop('checked', true);
										$(":radio[name=cycleRadio1][value=" + cycleOption + "]").prop('checked', true);
										$(":radio[name=faceRadio1][value=" + paceOption + "]").prop('checked', true);
										$(":radio[name=tripLocRadio1][value=" + destiOption + "]").prop('checked', true);
										$(":radio[name=toDoRadio1][value=" + doOption + "]").prop('checked', true);
										$(":radio[name=toSeeRadio1][value=" + seeOption + "]").prop('checked', true);
										$(":radio[name=foodRadio1][value=" + foodOption + "]").prop('checked', true);
										$(":radio[name=mealCountRadio1][value=" + mealOption + "]").prop('checked', true);
										$(":radio[name=supplyRadio1][value=" + supplyOption + "]").prop('checked', true);
										$(":radio[name=photoRadio1][value=" + photoOption + "]").prop('checked', true);
									}
								}
			    				, error: function(request, status, error) 
			    				{
		    	                   console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		    	                }	
						});
			}
		});
	    
	    
	    // 여행 스타일 모드 저장 및 수정 기능 구현
	    $("#saveBtn").click(function()
		{
			var tripModeOption = $("#tripMode1").val();
			var planOption = $("input[name=planRadio1]:checked").val();
			var payOption = $("input[name=payRadio1]:checked").val();
			var stayOption = $("input[name=stayRadio1]:checked").val();
			var trafficOption = $("input[name=trafficRadio1]:checked").val();
			var cycleOption = $("input[name=cycleRadio1]:checked").val();
			var faceOption = $("input[name=faceRadio1]:checked").val();
			var tripLocOption = $("input[name=tripLocRadio1]:checked").val();
			var toDoOption = $("input[name=toDoRadio1]:checked").val();
			var toSeeOption = $("input[name=toSeeRadio1]:checked").val();
			var foodOption = $("input[name=foodRadio1]:checked").val();
			var mealCountOption = $("input[name=mealCountRadio1]:checked").val();
			var supplyOption = $("input[name=supplyRadio1]:checked").val();
			var photoOption = $("input[name=photoRadio1]:checked").val();
			
			var dtoData = 
			{
					plan_num : planOption,
					money_option_num : payOption,
					stay_type_num : stayOption,
					traffic_num : trafficOption,
					cycle_num : cycleOption,
					pace_num : faceOption,
					desti_type_num : tripLocOption,
					to_do_num : toDoOption,
					to_see_num : toSeeOption,
					food_num : foodOption,
					meal_count_num : mealCountOption,
					supply_num : supplyOption,
					photo_num : photoOption,
					mode_name : tripModeOption
			};
			
			$.ajax(
	    			{
	    				type:"GET" 					
	    				, url: "mode_save.action" 	
	    				, dataType: "text"
	    				, data: dtoData 
	    				, error: function(request, status, error) 
	    				{
    	                   console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
    	                }			
	    			});
			
			
			alert(tripModeOption + "이(가) 저장되었습니다.");
			
		});
	    
	    
	    // 여행스타일 검색버튼을 눌렀을 때
	    $("#styleSearch").click(function()
		{	
	    	// 여행 스타일 옵션 value 값 가져오기 
			var plan = $("input[name=planRadio]:checked").val();
			var pay = $("input[name=payRadio]:checked").val();
			var stay = $("input[name=stayRadio]:checked").val();
			var tfc = $("input[name=trafficRadio]:checked").val();
			var cycle = $("input[name=cycleRadio]:checked").val();
			var face = $("input[name=faceRadio]:checked").val();
			var trip = $("input[name=tripLocRadio]:checked").val();
			var toDo = $("input[name=toDoRadio]:checked").val();
			var toSee= $("input[name=toSeeRadio]:checked").val();
			var food = $("input[name=foodRadio]:checked").val();
			var meal = $("input[name=mealCountRadio]:checked").val();
			var supply = $("input[name=supplyRadio]:checked").val();
			var photo = $("input[name=photoRadio]:checked").val();
			
			// 여행 스타일 개수 세기 위한 변수설정
			var i = 1;
			var sum = 0;
			
			
			// 각 항목마다 무관이 아닐때만 누적 
			if (plan != 4)
				sum += i;
			if (pay != 4)
				sum += i;
			if (stay != 5)
				sum += i;
			if (tfc != 4)
				sum += i;
			if (cycle != 3)
				sum += i;
			if (face != 3)
				sum += i;
			if (trip != 5)
				sum += i;
			if (toDo != 7)
				sum += i;
			if (toSee != 5)
				sum += i;
			if (food != 5)
				sum += i;
			if (meal != 4)
				sum += i;
			if (supply != 4)
				sum += i;
			if (photo != 4)
				sum += i;
			
			// html 단에 출력
			$("#filterCount").html(sum);
			
			// 모달창 닫기 
			$('#tripStyleSearch').modal("hide");
			
		});
	    
	    
		// 총 검색	 
	    $(".bi-search").click(function()
		{	
	    	
	    	// 제목 검색창 텍스트 
	    	var title = $("#titleSearch").val();
	    	
			// 지역검색 - 지역 번호 
			var regionNum = $(":radio[name=options-outlined]:checked").attr("id");
			if (regionNum == undefined)
				regionNum = 0;		
						
			// 예산검색 - 예약 옵션 번호 양쪽
			var budgetMin = ($("#budgetMin").val()) * 100000;
			var budgetMax = ($("#budgetMax").val()) * 100000;
			
			// 성별검색
			var gender = $("#genderOnOff").val();
			
			// 연령검색
			var age = $("#ageOnOff").val();
			
			// 방 공개 여부 검색 
			var roomOnOff = $("#roomOnOff").val();    // YES, NO --> pw_code 와 비교 
			
			// 계획 참여여부 검색
			var planOnOff = $("#planOnOff").val();
			
			// 일정 검색
			var startDate = $("#search_startDate").val();
			
			var endDate = $("#search_endDate").val();
			
			// 여행 스타일 검색 - 사용자가 선택한 옵션 
			var plan = $("input[name=planRadio]:checked").val();
			var pay = $("input[name=payRadio]:checked").val();
			var stay = $("input[name=stayRadio]:checked").val();
			var tfc = $("input[name=trafficRadio]:checked").val();
			var cycle = $("input[name=cycleRadio]:checked").val();
			var face = $("input[name=faceRadio]:checked").val();
			var trip = $("input[name=tripLocRadio]:checked").val();
			var toDo = $("input[name=toDoRadio]:checked").val();
			var toSee= $("input[name=toSeeRadio]:checked").val();
			var food = $("input[name=foodRadio]:checked").val();
			var meal = $("input[name=mealCountRadio]:checked").val();
			var supply = $("input[name=supplyRadio]:checked").val();
			var photo = $("input[name=photoRadio]:checked").val();
			
			$(location).attr("href","roomlist.action?room_title="+title+
							"&region_num="+regionNum+"&budget_min="+budgetMin+"&budget_max="+budgetMax+
							"&gender_limit_num="+gender+"&age_limit_num="+age+"&trip_start_date="+startDate+
							"&trip_end_date="+endDate+"&plan_onoff_num="+planOnOff+"&room_onoff_name="+roomOnOff+
							"&plan_num="+plan+"&money_option_num="+pay+"&stay_type_num="+stay+"&traffic_num="+tfc+
							"&cycle_num="+cycle+"&pace_num="+face+"&desti_type_num="+trip+"&to_do_num="+toDo+
							"&to_see_num="+toSee+"&food_num="+food+"&meal_count_num="+meal+"&supply_num="+supply+"&photo_num="+photo);
	    	
		});
		
		// 추가 ★
	    $('.toast').toast('show');
		
		 // 알림 읽음 버튼 누를 때 추가 ★
		$(".alarmDel").click(function() 
		{
			var params = "num=" + $(this).attr("id").split("/")[0] 
			+"&title="+$(this).attr("id").split("/")[1];
			alert(params);
			
			$.ajax(
			{
				type:"GET"								
				, url:"alarmRead.action"				
				, data:params							
				, success:function(args)
				{
					alert(arg);
				}											
				, error:function(e)
				{
					alert(e.responseText);
				}
			});
			
			
		});
	});
	


</script>

 <!-- Custom styles for this template -->
<link href="css/list-groups.css" rel="stylesheet">

</head>
<body onload="searchDate()">
	<!-- 메뉴바 include  -->
	<nav
		class="navbar navbar-expand-lg navbar-light bg-light fixed-top bg-light">
		<div class="container-fluid">
			<!-- Brand and toggle get grouped for better mobile display -->
			<div class="navbar-header">
				<!-- 브랜드로고 이미지 및 메이트립 표시 -->
				<a class="navbar-brand" href="#"> <img alt="Brand"
					src="images/trip_logo.png" alt="" width="30" height="30"
					style="border-radius: 100%;"> <span
					style="font-weight: bold;">MateTrip</span>
				</a>
			</div>

			<!-- Collect the nav links, forms, and other content for toggling -->
			<div class="collapse navbar-collapse" id="RoomList">
				<!-- 룸리스트 메뉴 구성  -->
				<ul class="nav navbar-nav">
					<li class="nav-item"><a class="nav-link" href="#"> <span
							style="font-weight: bold;">Room List</span>
					</a></li>
				</ul>
			</div>
			<!-- /.navbar-collapse -->

			<div class="d-flex gap-5 justify-content-center">
				<ul class="nav navbar-nav navbar-right justify-content-end"
					id="rightMenu">
					<!-- 알림 아이콘  -->
					<!-- <li class="nav-item"> -->
					<li class="nav-item dropdown dropstart">
						<div
							class="collapse navbar-collapse justify-content-end px-3 py-2">
							<ul class="nav navbar-nav">
								<li class="nav-item dropdown dropstart ">
									<a class="nav-link dropdown-toggle  position-relative" href="#"
										id="navbarDropdownMenuLink1" role="button" data-bs-toggle="dropdown" data-bs-auto-close="false"
										aria-expanded="false"> 
											<svg width="20" height="22" viewBox="0 0 20 22" fill="none" xmlns="http://www.w3.org/2000/svg">
			                  					<path fill-rule="evenodd" clip-rule="evenodd"
												d="M5.05033 2.05025C6.36309 0.737498 8.14356 0 10.0001 0C11.8566 0 13.6371 0.737498 14.9498 2.05025C16.2626 3.36301 17.0001 5.14349 17.0001 7C17.0001 10.3527 17.7171 12.4346 18.378 13.6461C18.7098 14.2544 19.0329 14.6535 19.2573 14.8904C19.3698 15.0091 19.4581 15.0878 19.5114 15.1322C19.538 15.1544 19.5558 15.168 19.5635 15.1737C19.5647 15.1746 19.5657 15.1753 19.5664 15.1758C19.9249 15.4221 20.0835 15.8725 19.9572 16.2898C19.8295 16.7115 19.4407 17 19.0001 17H1.00008C0.559411 17 0.170684 16.7115 0.0429858 16.2898C-0.0833568 15.8725 0.0752824 15.4221 0.433767 15.1758C0.434469 15.1753 0.435424 15.1746 0.436625 15.1737C0.444325 15.168 0.462178 15.1544 0.4888 15.1322C0.542016 15.0878 0.6304 15.0091 0.742875 14.8904C0.967304 14.6535 1.29039 14.2544 1.62218 13.6461C2.28301 12.4346 3.00008 10.3527 3.00008 7C3.00008 5.14348 3.73758 3.36301 5.05033 2.05025ZM0.443875 15.169C0.443954 15.1689 0.444033 15.1688 0.444112 15.1688C0.444107 15.1688 0.444103 15.1688 0.444099 15.1688L0.443875 15.169ZM3.1494 15H16.8508C16.7747 14.8753 16.6983 14.7434 16.6222 14.6039C15.783 13.0654 15.0001 10.6473 15.0001 7C15.0001 5.67392 14.4733 4.40215 13.5356 3.46447C12.5979 2.52678 11.3262 2 10.0001 2C8.674 2 7.40223 2.52678 6.46454 3.46447C5.52686 4.40215 5.00008 5.67392 5.00008 7C5.00008 10.6473 4.21715 13.0654 3.37797 14.6039C3.30188 14.7434 3.22549 14.8753 3.1494 15ZM7.76831 19.135C8.24603 18.8579 8.85796 19.0205 9.13508 19.4982C9.22298 19.6498 9.34916 19.7756 9.50097 19.863C9.65277 19.9504 9.82489 19.9965 10.0001 19.9965C10.1753 19.9965 10.3474 19.9504 10.4992 19.863C10.651 19.7756 10.7772 19.6498 10.8651 19.4982C11.1422 19.0205 11.7541 18.8579 12.2318 19.135C12.7096 19.4121 12.8722 20.024 12.5951 20.5018C12.3314 20.9564 11.9528 21.3337 11.4974 21.5961C11.042 21.8584 10.5256 21.9965 10.0001 21.9965C9.47451 21.9965 8.95816 21.8584 8.50274 21.5961C8.04731 21.3337 7.66879 20.9564 7.40508 20.5018C7.12796 20.024 7.29058 19.4121 7.76831 19.135Z"
												fill="#101828" />
			               					</svg> 
			               				<span class="position-absolute top-10 start-80 translate-middle badge rounded-pill bg-danger">
											${alarmCount } <span class="visually-hidden">????</span>
										</span>
								</a>
									<ul class="dropdown-menu align-items-stretch  rounded-3 shadow-lg w-600px"
										aria-labelledby="navbarDropdownMenuLink1"
										style="overflow-y: scroll; height: 300px;">
										<c:forEach var="alarm" items="${alarmList }">
											<li>
												<div class=" rounded-2 d-flex p-2" style="text-decoration: none;">
													<div class="toast " role="alert" aria-atomic="true"
														aria-live="assertive" data-bs-autohide="false">
														<div class="toast-header">
															<c:if test="${fn:contains(alarm.title, '신고')}">
																<svg xmlns="http://www.w3.org/2000/svg" width="16"
																	height="16" viewBox="0 0 16 16" fill="none">
																  <g clip-path="url(#clip0_280_5777)">
																    <path d="M7.9987 5.33398V8.00065M7.9987 10.6673H8.00536M14.6654 8.00065C14.6654 11.6826 11.6806 14.6673 7.9987 14.6673C4.3168 14.6673 1.33203 11.6826 1.33203 8.00065C1.33203 4.31875 4.3168 1.33398 7.9987 1.33398C11.6806 1.33398 14.6654 4.31875 14.6654 8.00065Z"
																	stroke="#B22729" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" />
																  </g>
																  <defs>
																    <clipPath id="clip0_280_5777">
																      <rect width="16" height="16" fill="white" />
																    </clipPath>
																  </defs>
																</svg>
															</c:if>
															<c:if test="${not fn:contains(alarm.title, '신고')}">
																<i class="bi bi-info-circle"
																	style="color: #48AFB4; font-size: 20px;"></i>
															</c:if>

															<!-- 아이콘 -->
															<span class="me-auto" style="font-weight: bold;
															${fn:contains(alarm.title, '신고') ? 'color:red':''}"
															>&nbsp;&nbsp;${alarm.title }</span>
															<!-- 방 제목  -->
															<small class="text-muted">${alarm.alarmDate }</small>
															<!-- 알림이 언제왔는지. -->
															<button type="button" class="btn-close alarmDel"
																id="${alarm.num }/${alarm.title }"
																data-bs-dismiss="toast" aria-label="Close"></button>
														</div>
														<div class="toast-body">
															<c:if test="${alarm.roomTitle !=' '}">
																<div style="font-weight: bold">
																	<i class="bi bi-house-fill"></i> ${alarm.roomTitle }
																</div>
															</c:if>

															<span id="alarmContext" style="font-size: 15px"> <i
																class="bi bi-arrow-return-right"></i>
																${alarm.alarmContent }
															</span>
														</div>
													</div>
												</div></li>
										</c:forEach>
									</ul></li>
							</ul>
						</div>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#"
						id="navbarDropdownMenuLink" role="button"
						data-bs-toggle="dropdown" aria-expanded="false"> <img
							alt="User_profile" src="<%=photo%>" width="30" height="30"
							style="border-radius: 100%"> <span
							style="font-weight: bold;"><%=nikname%></span>
					</a>
						<ul class="dropdown-menu gap-1 p-2 rounded-3 mx-0 shadow w-220px"
							aria-labelledby="navbarDropdownMenuLink">
							<li><a class="dropdown-item rounded-2" href="mypage1.action">마이페이지</a></li>
							<li><hr class="dropdown-divider"></li>
							<!-- 분할 줄 -->
							<li><a class="dropdown-item rounded-2" href="logout.action">Logout</a></li>
						</ul></li>
				</ul>
			</div>
		</div>
		<!-- /.container-fluid -->
	</nav>

	<!-- <form action="room_search.action" method="get"> -->
	<div class="position-relative">
		<div class="position-relative overflow-hidden p-3 p-md-5 m-md-3 text-center bg-light shadow" id="background_img">
	    <div class="col-md-5 p-lg-5 mx-auto my-5">
	    
	    <!-- 페이지 명 -->
	      <h1 class="display-4 fw-normal">
	      	<a class="roomList" href="roomlist.action" style="text-decoration-line: none; font-weight: bold;">ROOM LIST</a>
	      </h1>
	    </div>
	    <div class="product-device shadow-sm d-none d-md-block"></div>
	    <div class="product-device product-de vice-2 shadow-sm d-none d-md-block"></div>
	  </div>
	    
	    <!-- 방 개설  -->
	    <div class="position-absolute top-100 end-0 translate-middle" id="btn_div_make">
	    	<button type="button" class="btn btn-md shadow" 
	    	onclick="window.location.href='room_make.action';" id="btn_make">
	    		<span style="color: #535353;">방 만들기</span>
	    	</button>
	    </div>
	    
	    
	  <!-- 검색창  -->
	   <div class="position-absolute top-100 start-50 translate-middle">
		    <div class="search">
			  <input type="text" class="search_box shadow" id="titleSearch">	
			  <button type="button" class="btn btn-md shadow" id="btn_title">
			  	<span style="color: white;">제목</span>
			  </button>
			  <button type="submit" class="bi bi-search" style="background-color:transparent; border: none;"></button>
			</div>
	    </div>
	 </div>
	
	
	
	<!-- 지역검색부터 여행스타일 필터  -->
	<div class="d-flex justify-content-center" id="filter">
		
		<div class="row gap-3">
		
		<div class="col-md-1 mt-4" style="margin-left:0px; padding: 0;">
	           <!-- 지역검색 -->
				<button type="button" class="btn w-auto shadow-sm" style="background-color: #FF9966; color: white; border-radius: 45px;" 
				data-toggle="modal" data-target="#regionSearch" id="regionBtn">
					지역검색
				</button>


	           <!-- 지역검색 모달창 -->
					<div class="modal" id="regionSearch" tabindex="-1" role="dialog">
					  <div class="modal-dialog modal-dialog-centered" role="document">
					    <div class="modal-content">
					      <div class="modal-body">
					      <div class="input-group">
					         <input type="text" name="search" class="form-control" placeholder="어디로 여행을 떠나시나요?" id="trip_search">
					      <div class="input-group-append">
					              <input type="button" class="btn btn-default" id="InRegionSearch" value="검색">
					      </div>
					   	  </div><!-- .input-group  -->
					   <br>
					   <span>인기 여행지</span><br>
					   
						   <input type="radio" class="btn-check" name="options-outlined" id="2" autocomplete="off" >
						   <label class="btn btn-outline-success" for="2">부산광역시</label>
						     <input type="radio" class="btn-check" name="options-outlined" id="169" autocomplete="off" >
						   <label class="btn btn-outline-success" for="169">제주특별자치도</label>
						     <input type="radio" class="btn-check" name="options-outlined" id="129" autocomplete="off" >
						   <label class="btn btn-outline-success" for="129">경주시</label>
						     <input type="radio" class="btn-check" name="options-outlined" id="151" autocomplete="off" >
						   <label class="btn btn-outline-success" for="151">양양군</label>
						     <input type="radio" class="btn-check" name="options-outlined" id="163" autocomplete="off" >
						   <label class="btn btn-outline-success" for="163">속초시</label>
						     <input type="radio" class="btn-check" name="options-outlined" id="166" autocomplete="off" >
						   <label class="btn btn-outline-success" for="166">강릉시</label>
						       <br><br>
						    <span>검색 결과</span><br>
						     <div id = "regionResult"></div> 
						      
							    <div class="modal-footer">
							      <button type="button" class="btn btn-primary" id="regionSelect" data-dismiss="modal">선택</button>
					      		</div>
					    	</div><!--.modal-body  -->
						  </div><!--.modal-content  -->
						</div><!-- .modal-dialog  -->
					</div><!--.modal  -->
	         </div><!-- region div  -->
		
		
		
			 <!-- 예산 검색 -->		
	         <div class="col-md-1 mt-4 d-flex justify-content-center" >
             <ul style="padding: 0" >
            
               <button type="button" class="btn w-5 h-5 " style="background-color: #FF9966; color: white; 
               border-radius: 45px;" data-bs-toggle="dropdown" aria-expanded="false" id="budget">
               예산
               </button>
                 <ul class="dropdown-menu align-items-stretch rounded-3 w-200px budgetMenu">
                    <li class="nav-item d-flex">
                       <a class="dropdown-item rounded-2 d-flex" href="#" >
                       <div class="row">
                          <div class="col-md-5 text-center" style="padding: 0">
                             최소 금액
                             <select class="form-select d-block shadow-sm text-end w-auto" id="budgetMin" onchange="select(this)">
                                <c:forEach var="i" step="1" begin="0" end="10">
                                   <option value="${i }"><fmt:formatNumber value="${i*100000 }" /></option>
                                </c:forEach>
                            </select>
                          </div>
                          <div class="col-md-2">
                          ~
                          </div>
                          <div class="col-md-5 text-center" style="padding: 0">
                              최대 금액
                            <select class="form-select d-block shadow-sm text-end w-auto" id="budgetMax">
                                <c:forEach var="i" step="100000" begin="0" end="1000000">
                                   <option value="${i }"><fmt:formatNumber value="${i }" /></option>
                                </c:forEach>
                            </select>
                       	  </div>
                      </div>
                     </a>
                    </li>
                    <li class="d-inline-flex">
                       <a class="dropdown-item rounded-2 d-inline-flex float-end mt-3" href="#" >
                          <button type="button" class="btn float-end" id="budgetApply" 
                          style="background-color: #FF9966; color: white; border-radius: 45px">
                          적용
                          </button>
                       </a>
                    </li>
              	</ul>
              </ul>
            </div>
	         
			<div class="col-md-1 mt-4">
	           <select class="form-select d-block w-auto shadow-sm" id="genderOnOff" 
	           style="border-radius: 45px;">
	               <option value="0">성별검색</option>
	               <option value="1">동일성별</option>
	               <option value="2">성별무관</option>
	             </select>
	         </div>
	
	         <div class="col-md-1 mt-4" style="margin-right: 20px;">
	           <select class="form-select d-block w-auto shadow-sm" id="ageOnOff"
	           style="border-radius: 45px;">
	               <option value="0">연령검색</option>
	               <option value="1">유사연령대</option>
	               <option value="2">연령무관</option>
	           </select>
	         </div>
	         
	         
	         
	         <!-- 방 공개여부  -->
	         <div class="col-md-1 mt-4" style="margin-right: 20px;">
	           <select class="form-select d-block w-auto shadow-sm" id="roomOnOff"
	           style="border-radius: 45px;">
	               <option value="0">방 공개여부</option>
	               <option value="YES">비공개방</option>
	               <option value="NO">공개방</option>
	           </select>
	         </div>
	         
	         <!-- 계획참여여부  -->
	         <div class="col-md-1 mt-4" style="margin-right: 20px;">
	           <select class="form-select d-block w-auto shadow-sm" id="planOnOff"
	           style="border-radius: 45px;">
	               <option value="0">계획 참여여부</option>
	               <option value="1">계획공유방</option>
	               <option value="2">계획전달방</option>
	           </select>
	         </div>
	         
	         <!-- 일정 -->
	         <div class="col-md-1 mt-4 ms-3 w-auto">
		          <div class="row">
			           <div class="col-md-6">
				           <input type="date" class="form-control shadow-sm" data-toggle="tooltip" title="여행시작일" 
				           id="search_startDate" aria-required="true" 
				           value="" onChange="startChange()" style="width: 150px; height: 40px;">
			           </div> 
			           
			           <div class="col-md-6">
			           <input type="date" class="form-control shadow-sm" data-toggle="tooltip" title="여행종료일" 
			           id="search_endDate" aria-required="true" 
			           value="" onChange="" style="width: 150px; height: 40px;">
			         </div>            
			           </div>   
	         </div>
	        
	       <!--  </form>    -->
	         
			<!-- 여행 필터 -->
			<div class="col-md-1 mt-4 w-auto">
				<a class="btn" data-bs-toggle="modal" href="#tripStyleSearch" role="button">
					<div class="position-relative">
						<i class="bi bi-funnel-fill "></i>
						 <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill"
						 style="background-color: #FF9966;">
						 	<!--  여행스타일 옵션 선택 개수 출력 코드  -->
						     <span id="filterCount">0</span>
						  </span>
					</div>
				</a>
			</div>
		
		</div>
	</div>
	
		 
	<!-- 첫번째 모달창 -->
	<div class="modal fade" id="tripStyleSearch" aria-hidden="true" aria-labelledby="tripStyleSearch_Label" tabindex="-1">
	  <div class="modal-dialog modal-dialog-scrollable modal-lg">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h1 class="modal-title fs-3" id="tripStyleSearch_Label" style="color: black; font-weight: bold;" data-dismiss= "modal">여행스타일 검색</h1>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        <div class="col-4">
				<select class="form-select form-select-lg mb-3 shadow-sm" name="tripMode" id="tripMode" 
				aria-label=".form-select-lg example">
				  <option selected style="font-weight: bold;" value="기본">기본</option> 
				   <option value="모드1">Mode 1</option>
	               <option value="모드2">Mode 2</option>
	               <option value="모드3">Mode 3</option>
				</select>
			</div>
				<hr>
				<!-- 계획 -->
				<div>
					<div class="plan">
						<h5 style="font-weight: bold;">계획</h5>
					</div>
					
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="planRadio" id="perfectPlan" value="1">
					  <label class="form-check-label" for="perfectPlan">완벽한 계획</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="planRadio" id="roughPlan" value="2">
					  <label class="form-check-label" for="roughPlan">대략적인 계획</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="planRadio" id="noPlan" value="3">
					  <label class="form-check-label" for="noPlan">계획 없음</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="planRadio" id="unPlan" value="4" checked="checked">
					  <label class="form-check-label" for="unPlan">무관</label>
					</div>
				</div>	
				
				<br>
				<!-- 경비 -->
				
				<div>
					<div class="pay">
						<h5 style="font-weight: bold;">경비</h5>
					</div>
					
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="payRadio" id="dutchPay" value="1">
					  <label class="form-check-label" for="dutchPay">N분의 1</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="payRadio" id="eachPay" value="2">
					  <label class="form-check-label" for="eachPay">각자 계산</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="payRadio" id="afterPay" value="3">
					  <label class="form-check-label" for="afterPay">후청구</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="payRadio" id="unPay" value="4" checked="checked">
					  <label class="form-check-label" for="unPay">무관</label>
					</div>
				</div>	
				
				
				<br>
				<!-- 숙소형태  -->
				
				<div>
					<div class="stay">
						<h5 style="font-weight: bold;">숙소형태</h5>
					</div>
					
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="stayRadio" id="resortStay" value="1">
					  <label class="form-check-label" for="resortStay">리조트</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="stayRadio" id="hotelStay" value="2">
					  <label class="form-check-label" for="hotelStay">호텔</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="stayRadio" id="youthStay" value="3">
					  <label class="form-check-label" for="youthStay">호스텔 </label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="stayRadio" id="homeStay" value="4">
					  <label class="form-check-label" for="homeStay">민박</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="stayRadio" id="unStay" value="5" checked="checked">
					  <label class="form-check-label" for="unStay">무관</label>
					</div>
				</div>	
				
				<br>
				<!-- 교통 -->
				
				<div>
					<div class="traffic">
						<h5 style="font-weight: bold;">교통</h5>
					</div>
					
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="trafficRadio" id="rentTraffic" value="1">
					  <label class="form-check-label" for="rentTraffic">렌트</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="trafficRadio" id="walkTraffic" value="2">
					  <label class="form-check-label" for="walkTraffic">뚜벅이 선호</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="trafficRadio" id="publicTraffic" value="3">
					  <label class="form-check-label" for="publicTraffic">대중교통(택시포함)</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="trafficRadio" id="unTraffic" value="4" checked="checked">
					  <label class="form-check-label" for="unTraffic">무관</label>
					</div>
				</div>	
				
				<br>
				<!-- 사이클  -->
				<div>
					<div class="cycle">
						<h5 style="font-weight: bold;">사이클</h5>
					</div>
					
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="cycleRadio" id="lateCycle" value="1">
					  <label class="form-check-label" for="lazyCycle">늦은취침,늦은기상</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="cycleRadio" id="earlyCycle" value="2">
					  <label class="form-check-label" for="fastCycle">이른취침,이른기상</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="cycleRadio" id="unCycle" value="3" checked="checked">
					  <label class="form-check-label" for="unCycle">무관</label>
					</div>
				</div>	
				
				<br>
				<!--속도  -->
				<div>
					<div class="face">
						<h5 style="font-weight: bold;">속도</h5>
					</div>
					
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="faceRadio" id="slowFace" value="1">
					  <label class="form-check-label" for="slowFace">느긋함 선호</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="faceRadio" id="tightFace" value="2">
					  <label class="form-check-label" for="tightFace">촘촘한 일정 선호</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="faceRadio" id="unFace" value="3" checked="checked">
					  <label class="form-check-label" for="unFace">무관</label>
					</div>
				</div>	
				
				<br>
				<!-- 여행지 -->
				<div>
					<div class="tripLoc">
						<h5 style="font-weight: bold;">여행지</h5>
					</div>
					
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="tripLocRadio" id="natureTripLoc" value="1">
					  <label class="form-check-label" for="natureTripLoc">자연</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="tripLocRadio" id="cityTripLoc" value="2">
					  <label class="form-check-label" for="cityTripLoc">도시</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="tripLocRadio" id="restTripLoc" value="3">
					  <label class="form-check-label" for="restTripLoc">휴양지</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="tripLocRadio" id="historyTripLoc" value="4">
					  <label class="form-check-label" for="historyTripLoc">역사유적지</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="tripLocRadio" id="unTripLoc" value="5" checked="checked">
					  <label class="form-check-label" for="unTripLoc">무관</label>
					</div>
				</div>	
				
				
				<br>
				<!-- 할것  -->
				<div>
					<div class="toDo">
						<h5 style="font-weight: bold;">할 것</h5>
					</div>
					
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="toDoRadio" id="restToDo" value="1">
					  <label class="form-check-label" for="restToDo">휴식</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="toDoRadio" id="shoppingToDo" value="2">
					  <label class="form-check-label" for="shoppingToDo">쇼핑</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="toDoRadio" id="activityToDo" value="3">
					  <label class="form-check-label" for="activityToDo">액티비티</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="toDoRadio" id="movieToDo" value="4">
					  <label class="form-check-label" for="movieToDo">여행영상 촬영</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="toDoRadio" id="foodToDo" value="5">
					  <label class="form-check-label" for="foodToDo">맛집 탐방</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="toDoRadio" id="friendToDo" value="6">
					  <label class="form-check-label" for="friendToDo">새친구 만들기</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="toDoRadio" id="unToDo" value="7" checked="checked">
					  <label class="form-check-label" for="unToDo">무관</label>
					</div>
				</div>	
				
				<br>
				<!-- 볼것  -->
				<div>
					<div class="toSee">
						<h5 style="font-weight: bold;">볼 것</h5>
					</div>
					
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="toSeeRadio" id="historyToSee" value="1">
					  <label class="form-check-label" for="historyToSee">역사</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="toSeeRadio" id="artToSee" value="2">
					  <label class="form-check-label" for="artToSee">예술</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="toSeeRadio" id="cultureToSee" value="3">
					  <label class="form-check-label" for="cultureToSee">문화</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="toSeeRadio" id="naturalToSee" value="4">
					  <label class="form-check-label" for="naturalToSee">자연경관</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="toSeeRadio" id="unToSee" value="5" checked="checked">
					  <label class="form-check-label" for="unToSee">무관</label>
					</div>
				</div>	
				
				<br>
				<!-- 음식 -->
				<div>
					<div class="food">
						<h5 style="font-weight: bold;">음식점 선정기준</h5>
					</div>
					
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="foodRadio" id="koreaFood" value="1">
					  <label class="form-check-label" for="koreaFood">SNS맛집</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="foodRadio" id="localFood" value="2">
					  <label class="form-check-label" for="localFood">현지인맛집</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="foodRadio" id="regionFood" value="3">
					  <label class="form-check-label" for="regionFood">지역특산물위주</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="foodRadio" id="actFood" value="4">
					  <label class="form-check-label" for="actFood">즉흥적으로</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="foodRadio" id="unFood" value="5" checked="checked">
					  <label class="form-check-label" for="unFood">무관</label>
					</div>
				</div>	
				
				<br>
				<!-- 식사횟수  -->
				<div>
					<div class="mealCount">
						<h5 style="font-weight: bold;">식사 횟수</h5>
					</div>
					
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="mealCountRadio" id="oftenFoodCount" value="1">
					  <label class="form-check-label" for="oftenFoodCount">자주, 적게</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="mealCountRadio" id="onceFoodCount" value="2">
					  <label class="form-check-label" for="onceFoodCount">한번에 많이</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="mealCountRadio" id="dietFoodCount" value="3">
					  <label class="form-check-label" for="dietFoodCount">다이어트</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="mealCountRadio" id="unFoodCount" value="4" checked="checked">
					  <label class="form-check-label" for="unFoodCount">무관</label>
					</div>
				</div>
				
				
				<br>
				<!-- 준비물  -->	
				<div>
					<div class="supply">
						<h5 style="font-weight: bold;">준비물</h5>
					</div>
					
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="supplyRadio" id="allSupply" value="1">
					  <label class="form-check-label" for="allSupply">모두 챙김</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="supplyRadio" id="halfSupply" value="2">
					  <label class="form-check-label" for="halfSupply">반반</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="supplyRadio" id="localSupply" value="3">
					  <label class="form-check-label" for="localSupply">현지조달</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="supplyRadio" id="unSupply" value="4" checked="checked">
					  <label class="form-check-label" for="unSupply">무관</label>
					</div>
				</div>	
				
				<br>
				<!-- 사진 -->
				<div>
					<div class="photo">
						<h5 style="font-weight: bold;">사진</h5>
					</div>
					
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="photoRadio" id="lifePhoto" value="1">
					  <label class="form-check-label" for="lifePhoto">인생샷을 위해</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="photoRadio" id="roughPhoto" value="2">
					  <label class="form-check-label" for="roughPhoto">대충 흔적만</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="photoRadio" id="viewPhoto" value="3">
					  <label class="form-check-label" for="viewPhoto">풍경 위주</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="photoRadio" id="unPhoto" value="4" checked="checked">
					  <label class="form-check-label" for="unPhoto">무관</label>
					</div>
				</div>	
				
			</div><!-- .modal-body  -->
	      <div class="modal-footer">
	        <button class="btn btn-primary btn-lg shadow-sm" id="styleSearch">여행스타일 검색</button>
	        <button class="btn btn-warning btn-lg shadow-sm" style="color: #535353; font-weight: bold;"
	         data-bs-target="#tripStyleMode" data-bs-toggle="modal">여행스타일모드 수정</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	<!-- 두번째 모달창 -->
	<div class="modal fade" id="tripStyleMode" aria-hidden="true" aria-labelledby="tripStyleMode_Label" tabindex="-1">
	  <div class="modal-dialog modal-dialog-scrollable modal-lg">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h1 class="modal-title fs-3" id="tripStyleMode_Label" style="color: black; font-weight: bold;">여행스타일 모드 저장</h1>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        <div class="col-4">
				<select class="form-select form-select-lg mb-3 shadow-sm" name="tripMode1" id="tripMode1" 
				aria-label=".form-select-lg example">
				   <option selected style="font-weight: bold;" value="기본">모드를 선택해주세요</option>
				   <option value="모드1">Mode 1</option>
	               <option value="모드2">Mode 2</option>
	               <option value="모드3">Mode 3</option>
				</select>
			</div>
				<hr>
				
				<!-- 계획 -->
				<div>
					<div class="plan1">
						<h5 style="font-weight: bold;">계획</h5>
					</div>
					
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="planRadio1" id="perfectPlan1" value="1">
					  <label class="form-check-label" for="perfectPlan1">완벽한 계획</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="planRadio1" id="roughPlan1" value="2">
					  <label class="form-check-label" for="roughPlan1">대략적인 계획</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="planRadio1" id="noPlan1" value="3">
					  <label class="form-check-label" for="noPlan1">계획 없음</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="planRadio1" id="unPlan1" value="4" checked="checked">
					  <label class="form-check-label" for="unPlan1">무관</label>
					</div>
				</div>	
				
				<br>
				<!-- 경비 -->
				
				<div>
					<div class="pay1">
						<h5 style="font-weight: bold;">경비</h5>
					</div>
					
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="payRadio1" id="dutchPay1" value="1">
					  <label class="form-check-label" for="dutchPay1">N분의 1</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="payRadio1" id="eachPay1" value="2">
					  <label class="form-check-label" for="eachPay1">각자 계산</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="payRadio1" id="afterPay1" value="3">
					  <label class="form-check-label" for="afterPay1">후청구</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="payRadio1" id="unPay1" value="4" checked="checked">
					  <label class="form-check-label" for="unPay1">무관</label>
					</div>
				</div>	
				
				<br>
				<!-- 숙소형태  -->
				
				<div>
					<div class="stay1">
						<h5 style="font-weight: bold;">숙소형태</h5>
					</div>
					
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="stayRadio1" id="resortStay1" value="1">
					  <label class="form-check-label" for="resortStay1">리조트</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="stayRadio1" id="hotelStay1" value="2">
					  <label class="form-check-label" for="hotelStay1">호텔</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="stayRadio1" id="youthStay1" value="3">
					  <label class="form-check-label" for="youthStay1">호스텔 </label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="stayRadio1" id="homeStay1" value="4">
					  <label class="form-check-label" for="homeStay1">민박</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="stayRadio1" id="unStay1" value="5" checked="checked">
					  <label class="form-check-label" for="unStay1">무관</label>
					</div>
				</div>	
				
				<br>
				<!-- 교통 -->
				
				<div>
					<div class="traffic1">
						<h5 style="font-weight: bold;">교통</h5>
					</div>
					
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="trafficRadio1" id="rentTraffic1" value="1">
					  <label class="form-check-label" for="rentTraffic1">렌트</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="trafficRadio1" id="walkTraffic1" value="2">
					  <label class="form-check-label" for="walkTraffic1">뚜벅이 선호</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="trafficRadio1" id="publicTraffic1" value="3">
					  <label class="form-check-label" for="publicTraffic1">대중교통(택시포함)</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="trafficRadio1" id="unTraffic1" value="4" checked="checked">
					  <label class="form-check-label" for="unTraffic1">무관</label>
					</div>
				</div>	
				
				<br>
				<!-- 사이클  -->
				<div>
					<div class="cycle1">
						<h5 style="font-weight: bold;">사이클</h5>
					</div>
					
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="cycleRadio1" id="lateCycle1" value="1">
					  <label class="form-check-label" for="lazyCycle1">늦은취침,늦은기상</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="cycleRadio1" id="earlyCycle1" value="2">
					  <label class="form-check-label" for="fastCycle1">이른취침,이른기상</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="cycleRadio1" id="unCycle1" value="3" checked="checked">
					  <label class="form-check-label" for="unCycle1">무관</label>
					</div>
				</div>	
				
				<br>
				<!--속도  -->
				<div>
					<div class="face1">
						<h5 style="font-weight: bold;">속도</h5>
					</div>
					
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="faceRadio1" id="slowFace1" value="1">
					  <label class="form-check-label" for="slowFace1">느긋함 선호</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="faceRadio1" id="tightFace1" value="2">
					  <label class="form-check-label" for="tightFace1">촘촘한 일정 선호</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="faceRadio1" id="unFace1" value="3" checked="checked">
					  <label class="form-check-label" for="unFace1">무관</label>
					</div>
				</div>	
				
				<br>
				<!-- 여행지 -->
				<div>
					<div class="tripLoc1">
						<h5 style="font-weight: bold;">여행지</h5>
					</div>
					
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="tripLocRadio1" id="natureTripLoc1" value="1">
					  <label class="form-check-label" for="natureTripLoc1">자연</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="tripLocRadio1" id="cityTripLoc1" value="2">
					  <label class="form-check-label" for="cityTripLoc1">도시</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="tripLocRadio1" id="restTripLoc1" value="3">
					  <label class="form-check-label" for="restTripLoc1">휴양지</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="tripLocRadio1" id="historyTripLoc1" value="4">
					  <label class="form-check-label" for="historyTripLoc1">역사유적지</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="tripLocRadio1" id="unTripLoc1" value="5" checked="checked">
					  <label class="form-check-label" for="unTripLoc1">무관</label>
					</div>
				</div>	
				
				
				<br>
				<!-- 할것  -->
				<div>
					<div class="toDo1">
						<h5 style="font-weight: bold;">할 것</h5>
					</div>
					
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="toDoRadio1" id="restToDo1" value="1">
					  <label class="form-check-label" for="restToDo1">휴식</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="toDoRadio1" id="shoppingToDo1" value="2">
					  <label class="form-check-label" for="shoppingToDo1">쇼핑</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="toDoRadio1" id="activityToDo1" value="3">
					  <label class="form-check-label" for="activityToDo1">액티비티</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="toDoRadio" id="movieToDo1" value="4">
					  <label class="form-check-label" for="movieToDo1">여행영상 촬영</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="toDoRadio1" id="foodToDo1" value="5">
					  <label class="form-check-label" for="foodToDo1">맛집 탐방</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="toDoRadio1" id="friendToDo1" value="6">
					  <label class="form-check-label" for="friendToDo1">새친구 만들기</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="toDoRadio1" id="unToDo1" value="7" checked="checked">
					  <label class="form-check-label" for="unToDo1">무관</label>
					</div>
				</div>	
				
				<br>
				<!-- 볼것  -->
				<div>
					<div class="toSee1">
						<h5 style="font-weight: bold;">볼 것</h5>
					</div>
					
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="toSeeRadio1" id="historyToSee1" value="1">
					  <label class="form-check-label" for="historyToSee1">역사</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="toSeeRadio1" id="artToSee1" value="2">
					  <label class="form-check-label" for="artToSee1">예술</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="toSeeRadio1" id="cultureToSee1" value="3">
					  <label class="form-check-label" for="cultureToSee1">문화</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="toSeeRadio1" id="naturalToSee1" value="4">
					  <label class="form-check-label" for="naturalToSee1">자연경관</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="toSeeRadio1" id="unToSee1" value="5" checked="checked">
					  <label class="form-check-label" for="unToSee1">무관</label>
					</div>
				</div>	
				
				<br>
				<!-- 음식 -->
				<div>
					<div class="food1">
						<h5 style="font-weight: bold;">음식점 선정기준</h5>
					</div>
					
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="foodRadio1" id="koreaFood1" value="1">
					  <label class="form-check-label" for="koreaFood1">SNS맛집</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="foodRadio1" id="localFood1" value="2">
					  <label class="form-check-label" for="localFood1">현지인맛집</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="foodRadio1" id="regionFood1" value="3">
					  <label class="form-check-label" for="regionFood1">지역특산물위주</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="foodRadio1" id="actFood1" value="4">
					  <label class="form-check-label" for="actFood1">즉흥적으로</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="foodRadio1" id="unFood1" value="5" checked="checked">
					  <label class="form-check-label" for="unFood1">무관</label>
					</div>
				</div>	
				
				<br>
				<!-- 식사횟수  -->
				<div>
					<div class="mealCount1">
						<h5 style="font-weight: bold;">식사 횟수</h5>
					</div>
					
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="mealCountRadio1" id="oftenFoodCount1" value="1">
					  <label class="form-check-label" for="oftenFoodCount1">자주, 적게</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="mealCountRadio1" id="onceFoodCount1" value="2">
					  <label class="form-check-label" for="onceFoodCount1">한번에 많이</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="mealCountRadio1" id="dietFoodCount1" value="3">
					  <label class="form-check-label" for="dietFoodCount1">다이어트</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="mealCountRadio1" id="unFoodCount1" value="4" checked="checked">
					  <label class="form-check-label" for="unFoodCount1">무관</label>
					</div>
				</div>
				
				
				<br>
				<!-- 준비물  -->	
				<div>
					<div class="supply1">
						<h5 style="font-weight: bold;">준비물</h5>
					</div>
					
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="supplyRadio1" id="allSupply1" value="1">
					  <label class="form-check-label" for="allSupply1">모두 챙김</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="supplyRadio1" id="halfSupply1" value="2">
					  <label class="form-check-label" for="halfSupply1">반반</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="supplyRadio1" id="localSupply1" value="3">
					  <label class="form-check-label" for="localSupply1">현지조달</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="supplyRadio1" id="unSupply1" value="4" checked="checked">
					  <label class="form-check-label" for="unSupply1">무관</label>
					</div>
				</div>	
				
				<br>
				<!-- 사진 -->
				<div>
					<div class="photo1">
						<h5 style="font-weight: bold;">사진</h5>
					</div>
					
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="photoRadio1" id="lifePhoto1" value="1">
					  <label class="form-check-label" for="lifePhoto1">인생샷을 위해</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="photoRadio1" id="roughPhoto1" value="2">
					  <label class="form-check-label" for="roughPhoto1">대충 흔적만</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="photoRadio1" id="viewPhoto1" value="3">
					  <label class="form-check-label" for="viewPhoto1">풍경 위주</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="photoRadio1" id="unPhoto1" value="4" checked="checked">
					  <label class="form-check-label" for="unPhoto1">무관</label>
					</div>
				</div>
	      </div>
	      <div class="modal-footer">
	        <button class="btn btn-primary btn-lg shadow-sm" id="saveBtn">저장</button>
	        <button class="btn btn-dark btn-lg shadow-sm" data-bs-target="#tripStyleMode" data-bs-toggle="modal">돌아가기</button>
	      </div><!-- .modal-footer -->
	    </div> <!-- .modal-content -->
	  </div>
	</div>
	
	
	<br><br> 
	
		<div class="container-">
			<div class="list-group w-auto d-grid gap-5 border-0 position-relative mt-0">
				
				<!-- 정렬순  -->
				<div class="row">
					<div class="d-flex justify-content-start">
						<select class="form-select form-select-lg mb-3 col-md-3 w-auto shadow-sm" 
						id="sort"  name="sort" aria-label=".form-select-lg example">
						  <option ${sortList == null || sortList == 1 ? "selected" : "" } value="1">방 개설일</option>
						  <option ${sortList == 2 ? "selected" : "" } value="2">여행 시작일</option>
						</select>
					</div>
				</div>
				
				
				<!-- 리스트 출력 -->
				<!-- 룸 리스트 데이터 삽입  -->
				<div id="roomListPage">
				<c:forEach var="roomDTO" items="${searchList }">
				<div class="position-relative" style="margin-top: 4vh;">
					  <c:if test="${roomDTO.ongoing=='YES'}">
					  <div class="list-group-item list-group-item-action d-flex gap-4 py-4 pe-5 border-5 shadow " 
					  aria-current="true" id="${roomDTO.pw_code }/${roomDTO.room_num}"  style="border-color: #FBBF66;"
					  onclick="pwCheck(this)">
							<!-- <div class="position-absolute top-0 start-0 translate-middle" style="padding: 10px;"> -->
							<!-- <p style="color: #FBBF66; margin-bottom: 40px; margin-left: 50px;">참여 중</p> -->
							
								<div class="position-absolute top-0 start-0 translate-middle" style="padding: 10px;">
								 <p style="color: #FBBF66; margin-bottom: 40px; margin-left: 50px;">참여 중</p>
								</div>
					  </c:if>
					  <c:if test="${roomDTO.ongoing=='NO' }">
					  <div class="list-group-item list-group-item-action d-flex gap-4 py-4 pe-5 border-5 shadow" 
					  aria-current="true" id="${roomDTO.pw_code }/${roomDTO.room_num}"
					  onclick="pwCheck(this)">
					  </c:if>
					  
					  
					    <!-- <img src="images/User_PF_1.png" alt="User_PF_1" width="60" height="60" class="rounded-circle flex-shrink-0"> -->
					    <img src="${roomDTO.profile_photo }" alt="User_PF_1" width="60" height="60" class="rounded-circle flex-shrink-0">
					    <div class="d-flex gap-1 w-100 justify-content-between">
					    
					      <!-- 여행 방의 정보(닉네임,공유여부, 제목, 인원수)  -->
					      <div class="position-absolute bottom-0 start-0 mt-2">
					      	<!-- <p id="nickName">그로밋</p> -->
					      	<p id="nickName">${roomDTO.nikname }</p>
					      </div>
					      <div>
					        <!-- <h6 class="mb-0">[계획공유방]</h6> -->
					        <h6 class="mb-0">
							<c:if test="${roomDTO.plan_onoff=='계획공유' }">계획공유방</c:if>
							<c:if test="${roomDTO.plan_onoff=='계획전달' }">계획전달방</c:if>
							</h6>
					        <!-- <p class="mb-0 opacity-75" id="title">벚꽃여행 가요!</p> -->
					        <p class="mb-0 opacity-75" id="title">${roomDTO.room_title }</p>
					      </div>
					      	<!-- <input id="BMroom_num" type="hidden" value="${roomDTO.room_num }"> -->
					      <ul>
					      	<li>
					      	<button type="button" id="${roomDTO.room_num }" style="border: 0; outline: 0; background-color: #fff;"
					      	 class="bookmarkBtn" onclick="bookmark(this)" >
						     <c:if test="${roomDTO.bookmark == 'YES'}"><i class="bi bi-bookmark-fill" id="bookmark"></i></c:if>
						     <c:if test="${roomDTO.bookmark != 'YES'}"><i class="bi bi-bookmark" id="bookmark"></i></c:if>
					      	</button>
					      	</li>
					      	<li>
						      <!-- <p class="opacity-50 text-nowrap">1/2</p> -->
						      <p class="opacity-50 text-nowrap">${roomDTO.mem_curr} / ${roomDTO.mem_max }</p>
					      	</li>
					      </ul>
					      <div class="position-absolute top-0 end-0 mt-2">
					      	<!-- <i class="bi bi-unlock"></i> -->
					      	<c:if test="${roomDTO.pw_code =='YES' }"><i class="bi bi-lock"></i></c:if>
					      	<c:if test="${roomDTO.pw_code =='NO' }"><i class="bi bi-unlock"></i></c:if>
					      </div>
					      
					      <!-- 여행 방의 조건(여행기간,성별,연령,지역,예산) -->
					      <div class="position-absolute bottom-0 mb-1">
					      	<ul>
					        	<li>
					       			 <span class="d-block" style="color:#4E9492;">
								       <!-- <i class="bi bi-calendar2-event"></i> 08/18 ~ 08/19 -->
								       <i class="bi bi-calendar2-event"></i>&nbsp;${roomDTO.trip_start_date } ~ ${roomDTO.trip_end_date }
								     </span> 	
					        	</li>
					        	<li>
					       			 <span class="d-block" style="font-weight: bold; color: #8C5B3A;">
								       <!-- 동일성별 -->
								       <c:if test="${roomDTO.gender_limit =='동성' }">동일성별</c:if>
								       <c:if test="${roomDTO.gender_limit =='무관' }">성별무관</c:if>
								     </span> 	
					        	</li>
					        	<li>
					       			 <span class="d-block" style="font-weight: bold; color: #8C5B3A;">
								       <!-- 유사연령 -->
								       <c:if test="${roomDTO.age_limit == '유사연령대'}">유사연령</c:if>
								       <c:if test="${roomDTO.age_limit == '무관'}">연령무관</c:if>
								     </span>
					        	</li>
					        	<li>
					       			 <span class="d-block" style="font-weight: bold; color: #8C5B3A;">
								       <!-- 서울 -->
								       ${roomDTO. region}
								     </span> 	
					        	</li>
					        	<li>
					       			 <span class="d-block" style="font-weight: bold; color: #8C5B3A;">
								       <!-- 300,000 -->
								       ${roomDTO.budget }
								     </span> 	
					        	</li>
					        </ul>
					      </div>
					      
					      
					      <!-- 모달창버튼 -->
					      <div class="position-absolute bottom-0 end-0">
					      	<button type="button" class="btn" id="btnStyle"
					      	data-toggle="modal" data-target="#modal${roomDTO.room_num}">   <!--data-target="#${roomDTO.room_num}  -->
				 					 Style
							</button>
						  </div>
					    </div>
					  </div>
						
					  <!-- 비회원 : confirm 창... 룸리스트 클릭시  => 스타일 다 보여짐
					  회원 : prompt 창.. 비공개 공개 상관 x / 세션 아이디 들어감 --> 
					  <!-- 모달창 --><!--id="${roomDTO.room_num}  -->
						<div class="modal" id="modal${roomDTO.room_num}" tabindex="-1" role="dialog"> <!-- id="myModal" -->
						  <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable" role="document">
						    <div class="modal-content">
						      <div class="modal-header">
						        <h4 class="modal-title"  style="font-weight: bold; color:#15232E;">${roomDTO.nikname }님의 여행스타일</h4>
						        <button type="button" class="btn-close" data-dismiss="modal" aria-label="Close" id="fix_modal">
						        </button>
						      </div>
						      <div class="modal-body">
						      	<div id="content">
									<div class="row">
										<div class="ML1_plan col-5">
											<h5 style="font-weight: bold;">계획</h5>
										</div>
										<div class="col-7">
											<!-- <span>완벽한 계획</span> -->
											 <span>${roomDTO.plan }</span> 
										</div>
									</div>
									<div class="row">
										<div class="ML1_pay col-5">
											<h5 style="font-weight: bold;">경비</h5>
										</div>
										<div class="col-7">
											<!-- <span>N분의 1</span> -->
											<span>${roomDTO.money_option }</span>
										</div>
									</div>
									<div class="row">
										<div class="ML1_stay col-5">
											<h5 style="font-weight: bold;">숙소형태</h5>
										</div>
										<div class="col-7">
											<!-- <span>호텔</span> -->
											<span>${roomDTO.stay_type }</span>
										</div>
									</div>
									<div class="row">
										<div class="ML1_traffic col-5">
											<h5 style="font-weight: bold;">교통</h5>
										</div>
										<div class="col-7">
											<!-- <span>뚜벅이 선호</span> -->
											<span>${roomDTO.traffic }</span>
										</div>
									</div>
									<div class="row">
										<div class="ML1_cycle col-5">
											<h5 style="font-weight: bold;">사이클</h5>
										</div>
										<div class="col-7">
											<!-- <span>무관</span> -->
											<span>${roomDTO.cycle }</span>
										</div>
									</div>
									<div class="row">
										<div class="ML1_face col-5">
											<h5 style="font-weight: bold;">속도</h5>
										</div>
										<div class="col-7">
											<!-- <span>느긋함 선호</span> -->
											<span>${roomDTO.pace }</span> 
										</div>
									</div>
									<div class="row">
										<div class="ML1_tripLoc col-5">
											<h5 style="font-weight: bold;">여행지</h5>
										</div>
										<div class="col-7">
											<!-- <span>도시</span> -->
											<span>${roomDTO.desti_type }</span>
										</div>
									</div>
									<div class="row">
										<div class="ML1_toDo col-5">
											<h5 style="font-weight: bold;">할 것</h5>
										</div>
										<div class="col-7">
											<!-- <span>쇼핑</span> -->
											<span>${roomDTO.to_do }</span>
										</div>
									</div>
									<div class="row">
										<div class="ML1_toSee col-5">
											<h5 style="font-weight: bold;">볼 것</h5>
										</div>
										<div class="col-7">
											<!-- <span>문화</span> -->
											<span>${roomDTO.to_see }</span>
										</div>
									</div>
									<div class="row">
										<div class="ML1_food col-5">
											<h5 style="font-weight: bold;">음식점 선정기준</h5>
										</div>
										<div class="col-7">
											<!-- <span>SNS맛집</span> -->
											<span>${roomDTO.food }</span>
										</div>
									</div>
									<div class="row">
										<div class="ML1_foodCount col-5">
											<h5 style="font-weight: bold;">식사횟수</h5>
										</div>
										<div class="col-7">
											<!-- <span>무관</span> -->
											<span>${roomDTO.meal_count }</span>
										</div>
									</div>
									<div class="row">
										<div class="ML1_supply col-5">
											<h5 style="font-weight: bold;">준비물</h5>
										</div>
										<div class="col-7">
											<!-- <span>현지조달</span> -->
											<span>${roomDTO.supply }</span>
										</div>
									</div>
									<div class="row">
										<div class="ML1_photo col-5">
											<h5 style="font-weight: bold;">사진</h5>
										</div>
										<div class="col-7">
											<!-- <span>인생샷을 위해</span> -->
											<span>${roomDTO.photo }</span> 
										</div>
									</div>
						      	</div>
						      </div>
						    </div>
						  </div>
						</div>
						</div>
					
			  </c:forEach>
			  </div>
			  <br><br><br><br>


			  <!-- 비밀번호 모달창  -->
				<div class="modal fade" id="pwModal" tabindex="-1" aria-labelledby="pwModalLabel" aria-hidden="true">
				  <div class="modal-dialog">
				    <div class="modal-content">
				      <div class="modal-header">
				        <h1 class="modal-title fs-5" id="pwModalLabel">비공개 방</h1>
				        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				      </div>
				      <div class="modal-body">
				        <p>비밀번호를 입력하세요.<p>
				        <input type="password" id="pwCode_modal">
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
				        <button type="button" class="btn btn-primary" id="pwModal_Check" data-bs-dismiss="modal">확인</button>
				      </div>
				    </div>
				  </div>
				</div>


			  <!-- 뒷 배경을 가리는 투명한 레이어 -->
               <div class="modal-backdrop show" id="backdrop"
                  style="display: none;"></div>
			  
			
				
			</div>
		</div>
	</main>
	
	
</body>
</html>


