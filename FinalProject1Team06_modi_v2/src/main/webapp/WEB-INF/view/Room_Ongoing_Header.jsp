<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Room_Ongoing_Header.jsp</title>
<!-- 사용자 정의 css -->
<link rel="stylesheet" type="text/css" href="css/main.css">

<!-- jquery 소스 넣기 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<!-- bootstrap 소스 넣기 (bootstrap v5.0 버전)  -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>

<!-- icon 부트스트랩 아이콘 신버전 소스  -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">

<script type="text/javascript">

	$(function()
	{
		
		var goCheck = "<c:out value='${planner.final_go_date}'/>";
		//alert(goCheck);
		
		if (goCheck != "")
		{
			$(".mateBtn").attr("disabled", true);
			$(".leaderBtn").attr("disabled", true);
			$(".before").attr("disabled", true);
			$(".ing").attr("disabled", true);
			$(".leader").attr("disabled", true);
			
		}
		
		$(".mateBtn").click(function()
		{
			//alert("테스트");
			
			var thisBtn = $(this);
			
			var params = "my_id="+ $(this).val() +"&room_num=" + $("#hidden_room_num").val();
			
			var readyCheck = "<svg width='24' height='24' viewBox='0 0 24 24' fill='none' xmlns='http://www.w3.org/2000/svg'><path d='M22 11.0801V12.0001C21.9988 14.1565 21.3005 16.2548 20.0093 17.9819C18.7182 19.7091 16.9033 20.9726 14.8354 21.584C12.7674 22.1954 10.5573 22.122 8.53447 21.3747C6.51168 20.6274 4.78465 19.2462 3.61096 17.4372C2.43727 15.6281 1.87979 13.4882 2.02168 11.3364C2.16356 9.18467 2.99721 7.13643 4.39828 5.49718C5.79935 3.85793 7.69279 2.71549 9.79619 2.24025C11.8996 1.76502 14.1003 1.98245 16.07 2.86011M22 4.00011L12 14.0101L9.00001 11.0101' stroke='#101828' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'/></svg>";
			
			//alert(params);
			
			$.ajax(
			{
				
				type:"GET"								
				, url:"ready.action"				
				, data:params							
				, success:function(args)
				{
					//alert(args);
					
					if (args == "SYSDATE")
					{
						if (thisBtn.hasClass("bg-danger") == 1)
							thisBtn.removeClass("bg-danger")
						if (thisBtn.hasClass("bg-warning") == 0)
							thisBtn.addClass("bg-warning")
						thisBtn.html(readyCheck);
					}
					else if (args == "NULL")
					{
						if (thisBtn.hasClass("bg-warning") == 1)
							thisBtn.removeClass("bg-warning")
						if (thisBtn.hasClass("bg-danger") == 0)
							thisBtn.addClass("bg-danger")
						thisBtn.html("Ready");
					}
				}											
				, error:function(e)
				{
					alert(e.responseText);
				}
			});
			
			
		});
		
		
		$(".leaderBtn").click(function()
		{
			var thisBtn = $(this);
			
			var params = "my_id="+ $(this).val() +"&room_num=" + $("#hidden_room_num").val();
		
			var readyCheck = "<svg width='24' height='24' viewBox='0 0 24 24' fill='none' xmlns='http://www.w3.org/2000/svg'><path d='M22 11.0801V12.0001C21.9988 14.1565 21.3005 16.2548 20.0093 17.9819C18.7182 19.7091 16.9033 20.9726 14.8354 21.584C12.7674 22.1954 10.5573 22.122 8.53447 21.3747C6.51168 20.6274 4.78465 19.2462 3.61096 17.4372C2.43727 15.6281 1.87979 13.4882 2.02168 11.3364C2.16356 9.18467 2.99721 7.13643 4.39828 5.49718C5.79935 3.85793 7.69279 2.71549 9.79619 2.24025C11.8996 1.76502 14.1003 1.98245 16.07 2.86011M22 4.00011L12 14.0101L9.00001 11.0101' stroke='#101828' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'/></svg>";
			
			$.ajax(
			{
				type:"GET"								
				, url:"go.action"				
				, data:params							
				, success:function(args)
				{
					if (args == "SYSDATE")
					{
						alert("여행이 확정되었습니다. 즐거운 여행되십시오.");
						if (thisBtn.hasClass("bg-danger") == 1)
							thisBtn.removeClass("bg-danger")
						if (thisBtn.hasClass("bg-warning") == 0)
							thisBtn.addClass("bg-warning")
						thisBtn.html(readyCheck);
						$(".mateBtn").attr("disabled", true);
						$(".leaderBtn").attr("disabled", true);
						$(".before").attr("disabled", true);
						$(".ing").attr("disabled", true);
						$(".leader").attr("disabled", true);
						
						// 추가 ★
						$("#go").val("go");
					}
					else
					{
						alert("오류입니다.");
					}
				}											
				, error:function(e)
				{
					alert(e.responseText);
				}
			});
				
	
		});
		
		$("#updateRoom").click(function()
		{
			$(location).attr("href", "updateroomform.action?room_num=" + $(this).val());
		});
				
		
		$("#bookmarkPlace").click(function()    
		{			
			var params = "my_id="+ "<c:out value='${myId}'/>" +"&room_num=" + $("#hidden_room_num").val();
			
			var bookmark_check = "<svg xmlns='http://www.w3.org/2000/svg' width='30' height='30' fill='white' class='bi bi-bookmark-check-fill bookmarkIcon' viewBox='0 0 16 16'><path fill-rule='evenodd' d='M2 15.5V2a2 2 0 0 1 2-2h8a2 2 0 0 1 2 2v13.5a.5.5 0 0 1-.74.439L8 13.069l-5.26 2.87A.5.5 0 0 1 2 15.5zm8.854-9.646a.5.5 0 0 0-.708-.708L7.5 7.793 6.354 6.646a.5.5 0 1 0-.708.708l1.5 1.5a.5.5 0 0 0 .708 0l3-3z'/></svg>";
			var bookmark_plus = "<svg xmlns='http://www.w3.org/2000/svg' width='30' height='30' fill='white' class='bi bi-bookmark-plus bookmarkIcon' viewBox='0 0 16 16'><path d='M2 2a2 2 0 0 1 2-2h8a2 2 0 0 1 2 2v13.5a.5.5 0 0 1-.777.416L8 13.101l-5.223 2.815A.5.5 0 0 1 2 15.5V2zm2-1a1 1 0 0 0-1 1v12.566l4.723-2.482a.5.5 0 0 1 .554 0L13 14.566V2a1 1 0 0 0-1-1H4z'/><path d='M8 4a.5.5 0 0 1 .5.5V6H10a.5.5 0 0 1 0 1H8.5v1.5a.5.5 0 0 1-1 0V7H6a.5.5 0 0 1 0-1h1.5V4.5A.5.5 0 0 1 8 4z'/></svg>";
			
			$.ajax(
			{
				type:"GET"								
				, url:"searchbookmark.action"				
				, data:params							
				, success:function(args)
				{
					var bookmark = args;
					
					if(bookmark != "")
					{
						$("#bookmarkPlace").html(bookmark_check);
					}
					else
					{
						$("#bookmarkPlace").html(bookmark_plus);
					}
					
				}											
				, error:function(e)
				{
					alert(e.responseText);
				}
			});
			
			
		});
	
		$(".memberPlus").click(function()
		{
			
			var params = "room_num=" + $("#hidden_room_num").val();
			
			$.ajax(
			{
				type:"GET"								
				, url:"gocheck.action"				
				, data:params							
				, success:function(args)
				{
					if (args == "")
					{
						var params2 = "my_id="+ "<c:out value='${myId}'/>" +"&room_num=" + $("#hidden_room_num").val();
						$(location).attr("href", "memberplus.action?" + params2);						
					}
					else
						alert("출발 이후 최대정원 변경이 불가능합니다.")
				}											
				, error:function(e)
				{
					alert(e.responseText);
				}
			});
			
			
		});
		
		$(".memberMinus").click(function()
		{
			var params = "room_num=" + $("#hidden_room_num").val();
			
			$.ajax(
			{
				type:"GET"								
				, url:"gocheck.action"				
				, data:params							
				, success:function(args)
				{
					if (args == "")
					{
						var params2 = "my_id="+ "<c:out value='${myId}'/>" +"&room_num=" + $("#hidden_room_num").val();
						$(location).attr("href", "memberminus.action?" + params2);						
					}
					else
						alert("출발 이후 최대정원 변경이 불가능합니다.")
				}											
				, error:function(e)
				{
					alert(e.responseText);
				}
			});

		});
		
		
		$(".memberExit").click(function()
		{	
			
			$(".removeSpan").click();
			
			removeMemberId = $(this).val();
		});
		
		$('#roomDel').click(function()
		{
			var params = "room_num=" + $("#hidden_room_num").val();
			
			$(location).attr("href", "roomdel.action?" + params);		
		})
		
			 // 추가 ★
		     // 토스트 보여주기
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

	function removeExecute(num)
	{
		//alert(removeMemberId);
		if (Number(num)==2)
			var idNum = removeMemberId;
		else if (Number(num)==1)
			var idNum = "<c:out value='${myId}'/>";

		var params = "room_num=" + $("#hidden_room_num").val();

		$.ajax(
		{
			type:"GET"								
			, url:"gocheck.action"				
			, data:params							
			, success:function(args)
			{
				if (args == "")
				{
					//alert("퇴장");
					var params2 = "idNum=" + idNum + "&room_num=" + $("#hidden_room_num").val() + "&reason=" + Number(num);
					//alert(params2);
					$(location).attr("href", "removemember.action?" + params2);						
				}
				else
				{
					if (Number(num)==2)
						alert("출발 이후 메이트 강제 퇴장이 불가능합니다.");
					else if (Number(num)==1)
						alert("출발 이후 참여취소가 불가능합니다.");
						
				}
			}											
			, error:function(e)
			{
				alert(e.responseText);
			}
		});			
	}
	
	// 수정 ★★★★
	function joinroom()
	{
		//alert("테스트");
		
		var startDate = "<c:out value='${planner.trip_start_date}'/>";
		var endDate =  "<c:out value='${planner.trip_end_date}'/>";
		
		//alert(startDate);
		//alert(endDate);
		
		var params = "startDate=" + startDate + "&endDate=" + endDate+"&room_num=" + $("#hidden_room_num").val();
		
		$.ajax(
		{
			type:"GET"
			, url: "findjoinroom.action"
			, data:params
			, success:function(args)
			{
				if (args == '0')
					$(location).attr("href","joinroom.action?startDate=" + startDate + "&endDate=" + endDate);
				else
					alert(args);
				
			}
			, error:function(e)
			{
				alert(e.responseText);
			}
		});
		
	}
	
	function moveToCollection()
	{
		$(location).attr("href","planner.action?room_num="+$("#hidden_room_num").val()+"&page=-1");
	}

	function moveToPlanner()
	{
		$(location).attr("href","planner.action?room_num="+$("#hidden_room_num").val()+"&page=1");
	}
	
	function moveToFeed()
	{
		$(location).attr("href","planner.action?room_num="+$("#hidden_room_num").val()+"&page=0");
	}

	function insertCheckList()
	{
		//alert("체크리스트 입력");
		var content = document.getElementById("exampleFormControlInput1").value;
		var params="chklist_cnt="+content; //전송//임의로 지정
		
		
		$.ajax(
				{
					type:"GET"								
					, url:"insertchecklist.action"				
					, data:params							
					, success:function(args)
					{
						//alert(args);
				       	$("#checklists").html(args);	
					}											
					, error:function(e)
					{
						alert(e.responseText);
					}
				});	
		
	}
	function deleteCheckList(val)
	{
		//alert("체크리스트 삭제");		
		//alert(val);
		//CHK-ADD-00007
	
		
		var params = "chklist_num="+val;
		//FinalProject1Team_heejeong/deletechecklist.action?chklist_num=CHK-ADD-00007
		
		$.ajax(
				{
					type:"GET"								
					, url:"deletechecklist.action"				
					, data:params							
					, success:function(args)
					{
				       	$("#checklists").html(args);	
					}											
					, error:function(e)
					{
						alert(e.responseText);
					}
				});		
	}
	
	function votesList()
	{
		//alert("투표리스트");
		var params="room_num=ROOM-00003"+"&vote_num=VOTE-00003"; //전송. 임의로 지정
		//var params="chklist_cnt="+content+"&mem_join_num=MEM-JOIN-00010"; //전송//임의로 지정
		$.ajax(
				{
					type:"GET"								
					, url:"voteslist.action"				
					, data:params							
					, success:function(args)
					{
				
				       	$("#votes").html(args);	
					}											
					, error:function(e)
					{
						alert(e.responseText);
					}
				});			
	}
	

</script>

</head>

<style type="text/css">
	
	.before:disabled, .ing:disabled, .leader:disabled
	{
		opacity: 1;
		color: #595959;
	}
	
	.bookmarkIcon:hover, .memberMinus:hover, .memberPlus:hover
	{
		cursor: pointer;
	}

	.modal-backdrop {
	     z-index: 5; 
	}

	body
	{
		height: 100vh;
	}

	#background_img { 
		background-image: url("images/Rectangle 31.png");
		background-position: center top;
		/* width: 100%; */
		background-size: cover
		
	}
	
	
	h1 { 
		color: white;
	 }
	 
	.search {
	  position: relative;
	  width: 800px;
	  
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
	
	.btn_make {
		padding: 8px;
		border-radius: 45px;
		height: 25px;
		line-height: 0px;
		border: none;
		font-weight: bold;	
		background-color: rgba(252, 189, 78, 1);
		color:white;
	}
	
	.btn_made
	{
		padding: 8px;
		border-radius: 45px;
		height: 25px;
		line-height: 0px;
		border: none;
		font-weight: bold;
		background-color: rgba(252, 189, 78, 1);
		color:white;	
	}
	
	#btn_div_make {
		top: 0;
		right : 50px;
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

      @media (min-width: 768px) 
      {
        .bd-placeholder-img-lg 
        {
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

     /*  .bi {
        vertical-align: -.125em;
        
      } */

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
      
      
 .buttonWrap {
        display: flex;
        flex-direction: row;
        gap: 10px; /* 버튼들 사이의 간격 설정, 원하는 만큼 조정 가능 */
        text-align: center;
        display: inline-block;
        margin-top: 1vh;
    }
    
    .buttonWrap .button {
        flex-grow: 0;
    }
	

	/* 멤버박스 */
	.membersDiv
	{
		position: sticky;
		left:0;
		bottom:0;
		background-color: white;
	 	z-index: 1;
	 	background-color: rgba(255,255,255,0.7);
	}
	

	.membersDivContent
	{
		display: flex;
	}
	

	   
	 .1user
	 {
	 	width: 100px; 
	 	height: 115px; 
	 }


	 #btn_exit
	 {
	 	border-radius: 45px;
		width : 150px; 
		height: 40px;
		border: solid 2px #E5E5E5;
		background-color: white;
		font-weight: bold;
		
	 }
	 
	.btn
	{
		font-weight: bold;
	}
</style>

<body>

<nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top bg-light" style="width: 80%; margin: auto; ">
  	<div class="container-fluid">
    	<!-- Brand and toggle get grouped for better mobile display -->
    	<div class="navbar-header">
      		<!-- 브랜드로고 이미지 및 메이트립 표시 -->
      		<a class="navbar-brand" href="#">
				<img alt="Brand" src="images/trip_logo.png" alt="" width="30" height="30" style="border-radius: 100%;">
    			<span style="font-weight: bold;">MateTrip</span>
     		</a>
    	</div>
		<input type="hidden" id="go" name="go" value="dd">
    	<!-- Collect the nav links, forms, and other content for toggling -->
    	<div class="collapse navbar-collapse" id="RoomList">
      		<!-- 룸리스트 메뉴 구성  -->
      		<ul class="nav navbar-nav">
         		<li class="nav-item">
         			<a class="nav-link" href="#">
         				<span style="font-weight: bold; ${page == 1 || (planner.plan_onoff == '계획전달' && page == -1) ? 'color: #FF6666;' : ''}"
         				${(page == 0 || (planner.plan_onoff != '계획전달' && page == -1 ))  ? 'onclick="moveToPlanner()"' : '' }
         				>플래너</span>
         			</a>
         		</li>
         		<c:if test="${planner.plan_onoff != '계획전달' }">
         		<li class="nav-item">
         			<a class="nav-link" href="#">
         				<span style="font-weight: bold; ${page == -1 ? 'color: #FF6666;' : ''}"
         				${page != -1 ? 'onclick="moveToCollection()"' : '' }
         				>컬렉션</span>
         			</a>
         		</li>
         		</c:if>
         		<li class="nav-item">
         			<a class="nav-link" href="#">
         				<span style="font-weight: bold;  ${page == 0 ? 'color: #FF6666;' : ''}"
         				${page != 0 ? 'onclick="moveToFeed()"' : '' }>피드</span>
         			</a>
         		</li>
         		<li class="nav-item">
         			<a class="nav-link" href="accountlist.action?room_num=${planner.room_num }&page=2">
         				<span style="font-weight: bold;">가계부</span>
         			</a>
         		</li>
         		<li class="nav-item">
         			<a class="nav-link" href="roomlist.action">
         				<span style="font-weight: bold;">룸 리스트</span>
         			</a>
         		</li>
         		</ul>
         		</div>
         		<!-- 알림 수정 ★ -->
				<div class="collapse navbar-collapse justify-content-end px-3 py-2" >
					<ul class="nav navbar-nav">
						<li class="nav-item dropdown dropstart ">
						<a class="nav-link dropdown-toggle  position-relative" href="#"
							id="navbarDropdownMenuLink1" role="button"
							data-bs-toggle="dropdown" data-bs-auto-close="false"
							aria-expanded="false">
							<svg width="20" height="22" viewBox="0 0 20 22" fill="none" xmlns="http://www.w3.org/2000/svg">
			                  <path fill-ruQle="evenodd" clip-rule="evenodd" d="M5.05033 2.05025C6.36309 0.737498 8.14356 0 10.0001 0C11.8566 0 13.6371 0.737498 14.9498 2.05025C16.2626 3.36301 17.0001 5.14349 17.0001 7C17.0001 10.3527 17.7171 12.4346 18.378 13.6461C18.7098 14.2544 19.0329 14.6535 19.2573 14.8904C19.3698 15.0091 19.4581 15.0878 19.5114 15.1322C19.538 15.1544 19.5558 15.168 19.5635 15.1737C19.5647 15.1746 19.5657 15.1753 19.5664 15.1758C19.9249 15.4221 20.0835 15.8725 19.9572 16.2898C19.8295 16.7115 19.4407 17 19.0001 17H1.00008C0.559411 17 0.170684 16.7115 0.0429858 16.2898C-0.0833568 15.8725 0.0752824 15.4221 0.433767 15.1758C0.434469 15.1753 0.435424 15.1746 0.436625 15.1737C0.444325 15.168 0.462178 15.1544 0.4888 15.1322C0.542016 15.0878 0.6304 15.0091 0.742875 14.8904C0.967304 14.6535 1.29039 14.2544 1.62218 13.6461C2.28301 12.4346 3.00008 10.3527 3.00008 7C3.00008 5.14348 3.73758 3.36301 5.05033 2.05025ZM0.443875 15.169C0.443954 15.1689 0.444033 15.1688 0.444112 15.1688C0.444107 15.1688 0.444103 15.1688 0.444099 15.1688L0.443875 15.169ZM3.1494 15H16.8508C16.7747 14.8753 16.6983 14.7434 16.6222 14.6039C15.783 13.0654 15.0001 10.6473 15.0001 7C15.0001 5.67392 14.4733 4.40215 13.5356 3.46447C12.5979 2.52678 11.3262 2 10.0001 2C8.674 2 7.40223 2.52678 6.46454 3.46447C5.52686 4.40215 5.00008 5.67392 5.00008 7C5.00008 10.6473 4.21715 13.0654 3.37797 14.6039C3.30188 14.7434 3.22549 14.8753 3.1494 15ZM7.76831 19.135C8.24603 18.8579 8.85796 19.0205 9.13508 19.4982C9.22298 19.6498 9.34916 19.7756 9.50097 19.863C9.65277 19.9504 9.82489 19.9965 10.0001 19.9965C10.1753 19.9965 10.3474 19.9504 10.4992 19.863C10.651 19.7756 10.7772 19.6498 10.8651 19.4982C11.1422 19.0205 11.7541 18.8579 12.2318 19.135C12.7096 19.4121 12.8722 20.024 12.5951 20.5018C12.3314 20.9564 11.9528 21.3337 11.4974 21.5961C11.042 21.8584 10.5256 21.9965 10.0001 21.9965C9.47451 21.9965 8.95816 21.8584 8.50274 21.5961C8.04731 21.3337 7.66879 20.9564 7.40508 20.5018C7.12796 20.024 7.29058 19.4121 7.76831 19.135Z" fill="#101828"/>
			               </svg>
			                <span class="position-absolute top-10 start-80 translate-middle badge rounded-pill bg-danger">
							    ${alarmCount }
						    <span class="visually-hidden">????</span>
						  </span>
						</a>
							<ul class="dropdown-menu align-items-stretch  rounded-3 shadow-lg"
								aria-labelledby="navbarDropdownMenuLink1" style="overflow-y: scroll; height: 300px; width: 430px">
								<c:forEach var="alarm" items="${alarmList }">
								<li><div class=" rounded-2 d-flex p-2"  style="text-decoration: none; ">
										<div class="toast " role="alert" aria-atomic="true"
											aria-live="assertive" data-bs-autohide="false" style="width: 390px">
											<div class="toast-header">
												<c:if test = "${fn:contains(alarm.title, '신고')}">
													<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16" fill="none">
													  <g clip-path="url(#clip0_280_5777)">
													    <path d="M7.9987 5.33398V8.00065M7.9987 10.6673H8.00536M14.6654 8.00065C14.6654 11.6826 11.6806 14.6673 7.9987 14.6673C4.3168 14.6673 1.33203 11.6826 1.33203 8.00065C1.33203 4.31875 4.3168 1.33398 7.9987 1.33398C11.6806 1.33398 14.6654 4.31875 14.6654 8.00065Z" stroke="#B22729" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
													  </g>
													  <defs>
													    <clipPath id="clip0_280_5777">
													      <rect width="16" height="16" fill="white"/>
													    </clipPath>
													  </defs>
													</svg>
												</c:if> 
											<c:if test = "${not fn:contains(alarm.title, '신고')}">
												<i class="bi bi-info-circle"style="color: #48AFB4; font-size: 20px;"></i>
											</c:if> 
													
												<!-- 아이콘 -->
												<span class="me-auto" style="font-weight: bold; ${fn:contains(alarm.title, '신고') ? 'color:red':''}" >&nbsp;&nbsp;${alarm.title }</span>
												<!-- 방 제목  -->
												<small class="text-muted">${alarm.alarmDate }</small>
												<!-- 알림이 언제왔는지. -->
												<button type="button" class="btn-close alarmDel" id="${alarm.num }/${alarm.title }"
													data-bs-dismiss="toast" aria-label="Close" ></button>
											</div>
											<div class="toast-body">
											<c:if test="${alarm.roomTitle !=' '}">
												 <div style="font-weight: bold"> <i class="bi bi-house-fill"></i> ${alarm.roomTitle }</div>
											</c:if>
											
												<span id="alarmContext" style="font-size: 15px"> <i class="bi bi-arrow-return-right"></i> ${alarm.alarmContent }
												</span>
											</div>
										</div>
								</div>
								</li>
								</c:forEach>
							</ul>
							</li>
					</ul>
				</div>

			<!-- /.navbar-collapse -->
  
  		<div class="d-flex gap-5 justify-content-center">
  			<ul class="nav navbar-nav navbar-right justify-content-end" id="rightMenu">
  				<!-- 알림 아이콘  -->

         		<!-- 로그아웃 / 참여 중 계획목록 드롭다운 -->
         		<li class="nav-item dropdown">
          			<a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-bs-toggle="dropdown" aria-expanded="false">
          				<img alt="User_profile" src="${barInfo.photo }" width="30" height="30" style="border-radius: 100%" >
      					<span style="font-weight: bold;">${barInfo.nickname }</span>
          			</a>
	  				<ul class="dropdown-menu gap-1 p-2 rounded-3 mx-0 shadow w-220px" aria-labelledby="navbarDropdownMenuLink">
	    				<li><a class="dropdown-item rounded-2" href="mypage1.action">마이페이지</a></li>
	   	   	 			<li><hr class="dropdown-divider"></li> <!-- 분할 줄 -->
	        			<li><a class="dropdown-item rounded-2" href="logout.action">Logout</a></li>
	  				</ul>
  				</li>
  			</ul>
  		</div>
      
  	</div><!-- /.container-fluid -->
</nav>

<main>
    
	<div class="" id="headerSection">
		<div class="overflow-hidden p-2 text-center bg-light shadow" id="background_img">
	    	<div class="p-lg-5 p-4 mx-auto my-5 position-relative" id="headerWrap">
	    		<!-- 뒤로가기 버튼 -->
	    		<div class="position-absolute top-0 start-0 pt-3 ps-2">
					<svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" fill="black" class="bi bi-arrow-left" viewBox="0 0 16 16">
					  <path fill-rule="evenodd" d="M15 8a.5.5 0 0 0-.5-.5H2.707l3.147-3.146a.5.5 0 1 0-.708-.708l-4 4a.5.5 0 0 0 0 .708l4 4a.5.5 0 0 0 .708-.708L2.707 8.5H14.5A.5.5 0 0 0 15 8z"/>
					</svg>
	    		</div>
	    		<div>
	      			<h2 class="display-4 fw-normal" style="color: white">${planner.room_title }</h2>
	      			<input type="hidden" id="hidden_room_num" value="${planner.room_num }">
	      		</div>
	      		<div class="buttonWrap w-50">
		    		<button type="button" class="btn_make" disabled="disabled">${planner.gender_limit }</button>
		    		<button type="button" class="btn_make" disabled="disabled">${planner.age_limit }</button>
		    		<button type="button" class="btn_make" disabled="disabled">${planner.region }</button>
		    		<button type="button" class="btn_make" disabled="disabled">${planner.budget }</button>
		    		<button type="button" class="btn_make" disabled="disabled"
		    		>${planner.trip_start_date }~${planner.trip_end_date }</button>
		    		<button type="button" class="btn_make" disabled="disabled"
		    		>${planner.pw_code == "YES" ? "공개" : "비공개" }</button>
		    		<button type="button" class="btn_make" disabled="disabled">${planner.plan_onoff }</button>
		    		
	    			<button type="button" class="btn_made" disabled="disabled">${planner.plan }</button>
	    			<button type="button" class="btn_made" disabled="disabled">${planner.money_option }</button>
	    			<button type="button" class="btn_made" disabled="disabled">${planner.stay_type }</button>
	    			<button type="button" class="btn_made" disabled="disabled">${planner.cycle }</button>
	    			<button type="button" class="btn_made" disabled="disabled">${planner.desti_type }</button>
	    			<button type="button" class="btn_made" disabled="disabled">${planner.to_do }</button>
	    			<button type="button" class="btn_made" disabled="disabled">${planner.to_see }</button>
	    			<button type="button" class="btn_made" disabled="disabled">${planner.food }</button>
	    			<button type="button" class="btn_made" disabled="disabled">${planner.meal_count }</button>
	    			<button type="button" class="btn_made" disabled="disabled">${planner.supply }</button>
	    			<button type="button" class="btn_made" disabled="disabled">${planner.photo }</button>
	    		</div>
			   <!--북마크 아이콘/ 투표버튼/ 체크리스트 버튼-->
		 	   <div class="position-absolute start-0 bg-transparent rounded p-3" id="icons">
		 	   		<!-- 북마크 -->
		 	   		<span id="bookmarkPlace">
			 	   		<c:if test="${planner.bookmark == 'YES'}">
							<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="white" class="bi bi-bookmark-check-fill bookmarkIcon" viewBox="0 0 16 16">
							  <path fill-rule="evenodd" d="M2 15.5V2a2 2 0 0 1 2-2h8a2 2 0 0 1 2 2v13.5a.5.5 0 0 1-.74.439L8 13.069l-5.26 2.87A.5.5 0 0 1 2 15.5zm8.854-9.646a.5.5 0 0 0-.708-.708L7.5 7.793 6.354 6.646a.5.5 0 1 0-.708.708l1.5 1.5a.5.5 0 0 0 .708 0l3-3z"/>
							</svg>
						</c:if>
						<c:if test="${planner.bookmark != 'YES'}">
							<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="white" class="bi bi-bookmark-plus bookmarkIcon" viewBox="0 0 16 16">
							  <path d="M2 2a2 2 0 0 1 2-2h8a2 2 0 0 1 2 2v13.5a.5.5 0 0 1-.777.416L8 13.101l-5.223 2.815A.5.5 0 0 1 2 15.5V2zm2-1a1 1 0 0 0-1 1v12.566l4.723-2.482a.5.5 0 0 1 .554 0L13 14.566V2a1 1 0 0 0-1-1H4z"/>
							  <path d="M8 4a.5.5 0 0 1 .5.5V6H10a.5.5 0 0 1 0 1H8.5v1.5a.5.5 0 0 1-1 0V7H6a.5.5 0 0 1 0-1h1.5V4.5A.5.5 0 0 1 8 4z"/>
							</svg>
						</c:if>
					</span>
					
					<!-- 투표 버튼(투표목록으로 넘어감). 연결은 바디 태그 위에-->
					<!-- <button type="button" class="btn btn-light" data-bs-toggle="modal" data-bs-target="#voteListModal">투표</button> -->	
					
					<!-- 체크리스트 버튼 -->			
					<!-- <button type="button" class="btn btn-light" data-bs-toggle="modal" data-bs-target="#checkList">나의 체크리스트</button> -->	
					<!-- 체크리스트 모달-->
					<c:if test="${page == '-1' || (page == '1' && planner.plan_onoff == '계획전달') }">
						<!-- 투표 버튼(투표목록으로 넘어감). 연결은 바디 태그 위에-->
						<button type="button" class="btn btn-light" data-bs-toggle="modal" data-bs-target="#voteListModal" onclick="votesList()">투표</button>	
					
						<!-- 체크리스트 버튼 -->			
						<button type="button" class="btn btn-light" data-bs-toggle="modal" data-bs-target="#checkList">나의 체크리스트</button>
					</c:if>	
					<!-- 체크리스트 모달-->
					<div class="modal fade" id="checkList" tabindex="-1" aria-labelledby="chlModalLabel" aria-hidden="true">                                                                                  
						  <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-lg">                                                                                                                    
						    <div class="modal-content">                                                                                                                                                               
						      <div class="modal-header">                                                                                                                                                              
						        <h1 class="modal-title fs-5" id="chlModalLabel"><span style="color: black;">체크리스트</span></h1>                                                                                                                        
						        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>                                                                                          
						      </div>                                                                                                                                                                                  
						      <div class="modal-body">                                                                                                                                                                
						        <!-- 내부 체크리스트-->                                                                                                                                                                      
								<section>                                                                                                                                                                             
								  <div class="container">                                                                                                                                                        
								    <div class="row d-flex justify-content-center align-items-center h-100">                                                                                                          
								      <div class="col">                                                                                                                                                               
								        <div class="card" id="list1" style="border-radius: .75rem; background-color: #eff1f2;">                                                                                       
								          <div class="card-body"> 
								             <div id ="checklists">
								            <c:forEach var="OneCheckList" items="${myCheckList}">
									            <ul class="shadow bg-body p-2 rounded list-group list-group-horizontal rounded bg-white">

									              <li                                                                                                                                                                     
									                class="list-group-item d-flex align-items-center rounded-0 border-0 bg-transparent">                                                                       
									                <div class="form-check">                                                                                                                                              
									                  <input class="form-check-input me-0" type="checkbox" value="" id="flexCheckChecked2"                                                                                
									                    aria-label="..." />                                                                                                                                               
									                </div>                                                                                                                                                                
									               </li>
									             
									              <li
									                class="list-group-item d-flex align-items-center flex-grow-1 border-0 bg-transparent">
									                <p class="lead fw-normal mb-0">${OneCheckList.chklist_cnt}</p>
									              </li>
									           
									              <li class="list-group-item ps-3 pe-10 py-1 rounded-0 border-0 bg-transparent">
									              <c:if test="${OneCheckList.checking == '1' }">
								            		<button type="submit" class="btn btn-danger" style="border:none;"
								            		value="${OneCheckList.chklist_num }"  onclick="deleteCheckList(this.value)">삭제</button>
								            	  </c:if>
									              </li>
									            </ul>  
									            
								
								            	</c:forEach> 
								             </div>                                                                                                                                                                                                                                        
								            <!-- 폼 접기 -->		                                                                                                                                                      
											<div class="accordion" id="accordionExample">                                                                                                                             
											  <div class="accordion-item">                                                                                                                                            
											    <h2 class="accordion-header" id="headingOne">			                                                                                                              
											      <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">            
											      </button>                                                                                                                                                           
											    </h2>                                                                                                                                                                 
											    <div id="collapseOne" class="accordion-collapse collapse show" aria-labelledby="headingOne" data-bs-parent="#accordionExample">                                       
											      <!-- 접기 -->                                                                                                                                                         
											      <div class="accordion-body">                                                                                                                                        
											      <!-- 내부 입력 폼 -->                                                                                                                                                    
										            <div class="pt-2 pb-2">                                                                                                                                           
										              <div class="card">                                                                                                                                              
										                <div class="card-body">                                                                                                                                       
										                  <div class="d-flex flex-row align-items-center">                                                                                                            
										                    <input type="text" class="form-control form-control-lg" id="exampleFormControlInput1"                                                                     
										                      placeholder="준비물 입력" value="${OneCheckList.chklist_cnt }">                                                                                                                                   
										                    <a href="#!" data-mdb-toggle="tooltip" title="Set due date"><i                                                                                            
										                        class="fas fa-calendar-alt fa-lg me-3"></i></a>                                                                                                       
										                    <div>                                                                                                                                                     
										                      <button type="button" class="btn btn-primary" style="background-color: #32a852" onclick="insertCheckList()">                                                                        
																<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-plus" viewBox="0 0 16 16">                            
																  <path d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4z"/>                                   
																</svg>                                                                                                                                                
										                      </button>                                                                                                                                               
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
								  </div>                                                                                                                                                                              
								</section>                                                                                                                                                                            
						      </div>                                                                                                                                                                                  
						                                                                                                                                                                                              
						      <div class="modal-footer">                                                                                                                                                              
						        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">저장</button>                                                                                                   
						        <button type="button" class="btn btn-primary">닫기</button>                                                                                                                             
						      </div>                                                                                                                                                                                  
						    </div>                                                                                                                                                                                    
						  </div>                                                                                                                                                                                      
						</div> <!-- 체크리스트 모달 끝 -->  

		 	   </div><!-- 버튼상자 끝 -->	
		 	
		 	
			   <!--방 버튼 상자 -->
		 	   <div class="position-absolute end-0 pt-1" id="RoomBtns">
		 	       <!-- 로그인 전 before 클래스 -->
		 	       	<c:if test="${myId == '' }">
			 	  		<button type="button" class="btn btn-light fw-bold before">
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="orange" class="bi bi-airplane" viewBox="0 0 16 16">
							  <path d="M6.428 1.151C6.708.591 7.213 0 8 0s1.292.592 1.572 1.151C9.861 1.73 10 2.431 10 3v3.691l5.17 2.585a1.5 1.5 0 0 1 .83 1.342V12a.5.5 0 0 1-.582.493l-5.507-.918-.375 2.253 1.318 1.318A.5.5 0 0 1 10.5 16h-5a.5.5 0 0 1-.354-.854l1.319-1.318-.376-2.253-5.507.918A.5.5 0 0 1 0 12v-1.382a1.5 1.5 0 0 1 .83-1.342L6 6.691V3c0-.568.14-1.271.428-1.849Zm.894.448C7.111 2.02 7 2.569 7 3v4a.5.5 0 0 1-.276.447l-5.448 2.724a.5.5 0 0 0-.276.447v.792l5.418-.903a.5.5 0 0 1 .575.41l.5 3a.5.5 0 0 1-.14.437L6.708 15h2.586l-.647-.646a.5.5 0 0 1-.14-.436l.5-3a.5.5 0 0 1 .576-.411L15 11.41v-.792a.5.5 0 0 0-.276-.447L9.276 7.447A.5.5 0 0 1 9 7V3c0-.432-.11-.979-.322-1.401C8.458 1.159 8.213 1 8 1c-.213 0-.458.158-.678.599Z"/>
							</svg>
			 	  		참여하기
			 	  		</button>
		 	  		</c:if>
		 	  		
		 	  		<!-- 참여중인지 체크 -->
					<c:set var="doneloop" value="false"></c:set>
					<c:set var="joinOrNot" value="0"></c:set>
		 	  		<c:forEach var="member" items="${roomMembers}">
			 	  		<c:if test="${not doneloop }">
							<c:if test="${member.id_num == myId }">
								<c:set var="joinOrNot" value="1"></c:set>		 	  		
			 	  				<c:set var="doneloop" value="true"></c:set>
							</c:if>
							<c:if test="${member.id_num != myId }">
								<c:set var="joinOrNot" value="0"></c:set>
							</c:if>			 	  		
			 	  		</c:if>
		 	  		</c:forEach>


		 	       <!-- 참여전 before 클래스 -->
		 	  		<c:if test="${joinOrNot eq 0}">
			 	  		<button type="button" class="btn btn-light fw-bold before" onclick="joinroom()">
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="orange" class="bi bi-airplane" viewBox="0 0 16 16">
							  <path d="M6.428 1.151C6.708.591 7.213 0 8 0s1.292.592 1.572 1.151C9.861 1.73 10 2.431 10 3v3.691l5.17 2.585a1.5 1.5 0 0 1 .83 1.342V12a.5.5 0 0 1-.582.493l-5.507-.918-.375 2.253 1.318 1.318A.5.5 0 0 1 10.5 16h-5a.5.5 0 0 1-.354-.854l1.319-1.318-.376-2.253-5.507.918A.5.5 0 0 1 0 12v-1.382a1.5 1.5 0 0 1 .83-1.342L6 6.691V3c0-.568.14-1.271.428-1.849Zm.894.448C7.111 2.02 7 2.569 7 3v4a.5.5 0 0 1-.276.447l-5.448 2.724a.5.5 0 0 0-.276.447v.792l5.418-.903a.5.5 0 0 1 .575.41l.5 3a.5.5 0 0 1-.14.437L6.708 15h2.586l-.647-.646a.5.5 0 0 1-.14-.436l.5-3a.5.5 0 0 1 .576-.411L15 11.41v-.792a.5.5 0 0 0-.276-.447L9.276 7.447A.5.5 0 0 1 9 7V3c0-.432-.11-.979-.322-1.401C8.458 1.159 8.213 1 8 1c-.213 0-.458.158-.678.599Z"/>
							</svg>
			 	  		참여하기
			 	  		</button>
			 	  	</c:if>
			 	  	
					<!-- 참여취소 모달 --> <!-- 참여중 ing -->
		 	  		<c:if test="${joinOrNot != 0 and planner.id_num != myId}">
						<button type="button" class="btn btn-light fw-bold ing" data-bs-toggle="modal" data-bs-target="#cancelModal">
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="orange" class="bi bi-airplane" viewBox="0 0 16 16">
							  <path d="M6.428 1.151C6.708.591 7.213 0 8 0s1.292.592 1.572 1.151C9.861 1.73 10 2.431 10 3v3.691l5.17 2.585a1.5 1.5 0 0 1 .83 1.342V12a.5.5 0 0 1-.582.493l-5.507-.918-.375 2.253 1.318 1.318A.5.5 0 0 1 10.5 16h-5a.5.5 0 0 1-.354-.854l1.319-1.318-.376-2.253-5.507.918A.5.5 0 0 1 0 12v-1.382a1.5 1.5 0 0 1 .83-1.342L6 6.691V3c0-.568.14-1.271.428-1.849Zm.894.448C7.111 2.02 7 2.569 7 3v4a.5.5 0 0 1-.276.447l-5.448 2.724a.5.5 0 0 0-.276.447v.792l5.418-.903a.5.5 0 0 1 .575.41l.5 3a.5.5 0 0 1-.14.437L6.708 15h2.586l-.647-.646a.5.5 0 0 1-.14-.436l.5-3a.5.5 0 0 1 .576-.411L15 11.41v-.792a.5.5 0 0 0-.276-.447L9.276 7.447A.5.5 0 0 1 9 7V3c0-.432-.11-.979-.322-1.401C8.458 1.159 8.213 1 8 1c-.213 0-.458.158-.678.599Z"/>
							</svg>
			 	  			참여취소
						</button>
					</c:if>
					
					<!-- 참여취소 Modal -->
					<div class="modal fade" id="cancelModal" tabindex="-1" aria-labelledby="cancelModalLabel" aria-hidden="true">
					  <div class="modal-dialog">
					    <div class="modal-content">
					      <div class="modal-header">
					        <h1 class="modal-title fs-5" id="cancelModalLabel" style="color: black;">참여 취소 확인</h1>
					        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					      </div>
					      <div class="modal-body">
							<h5>아직 확정되지 않은 계획입니다</h5><br>
							<h4 style="font-weight: bold;">참여를 취소하시겠습니까?</h4>
					      </div>
					      <div class="modal-footer">
					        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" onclick="removeExecute(1)">예</button>
					        <button type="button" class="btn btn-primary" data-bs-dismiss="modal">아니오</button>
					      </div>
					    </div>
					  </div>
					</div>
					
					
					<c:if test="${planner.id_num == myId }">							 	  		
			 	  		<button type="button" class="btn btn-light fw-bold leader" id="updateRoom" name="updateRoom" value="${planner.room_num }"> <!-- 방장 leader 클래스 -->
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="orange" class="bi bi-airplane" viewBox="0 0 16 16">
							  <path d="M6.428 1.151C6.708.591 7.213 0 8 0s1.292.592 1.572 1.151C9.861 1.73 10 2.431 10 3v3.691l5.17 2.585a1.5 1.5 0 0 1 .83 1.342V12a.5.5 0 0 1-.582.493l-5.507-.918-.375 2.253 1.318 1.318A.5.5 0 0 1 10.5 16h-5a.5.5 0 0 1-.354-.854l1.319-1.318-.376-2.253-5.507.918A.5.5 0 0 1 0 12v-1.382a1.5 1.5 0 0 1 .83-1.342L6 6.691V3c0-.568.14-1.271.428-1.849Zm.894.448C7.111 2.02 7 2.569 7 3v4a.5.5 0 0 1-.276.447l-5.448 2.724a.5.5 0 0 0-.276.447v.792l5.418-.903a.5.5 0 0 1 .575.41l.5 3a.5.5 0 0 1-.14.437L6.708 15h2.586l-.647-.646a.5.5 0 0 1-.14-.436l.5-3a.5.5 0 0 1 .576-.411L15 11.41v-.792a.5.5 0 0 0-.276-.447L9.276 7.447A.5.5 0 0 1 9 7V3c0-.432-.11-.979-.322-1.401C8.458 1.159 8.213 1 8 1c-.213 0-.458.158-.678.599Z"/>
							</svg>
			 	  			방 정보 수정	
			 	  		</button>
		 	  		</c:if>
		 	  		
		 	  		
					<!-- 방 삭제 모달 --> <!-- leader -->
					<c:if test="${planner.id_num == myId }">
						<button type="button" class="btn btn-light fw-bold leader" data-bs-toggle="modal" data-bs-target="#deleteRoom">
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="orange" class="bi bi-airplane" viewBox="0 0 16 16">
							  <path d="M6.428 1.151C6.708.591 7.213 0 8 0s1.292.592 1.572 1.151C9.861 1.73 10 2.431 10 3v3.691l5.17 2.585a1.5 1.5 0 0 1 .83 1.342V12a.5.5 0 0 1-.582.493l-5.507-.918-.375 2.253 1.318 1.318A.5.5 0 0 1 10.5 16h-5a.5.5 0 0 1-.354-.854l1.319-1.318-.376-2.253-5.507.918A.5.5 0 0 1 0 12v-1.382a1.5 1.5 0 0 1 .83-1.342L6 6.691V3c0-.568.14-1.271.428-1.849Zm.894.448C7.111 2.02 7 2.569 7 3v4a.5.5 0 0 1-.276.447l-5.448 2.724a.5.5 0 0 0-.276.447v.792l5.418-.903a.5.5 0 0 1 .575.41l.5 3a.5.5 0 0 1-.14.437L6.708 15h2.586l-.647-.646a.5.5 0 0 1-.14-.436l.5-3a.5.5 0 0 1 .576-.411L15 11.41v-.792a.5.5 0 0 0-.276-.447L9.276 7.447A.5.5 0 0 1 9 7V3c0-.432-.11-.979-.322-1.401C8.458 1.159 8.213 1 8 1c-.213 0-.458.158-.678.599Z"/>
							</svg>
			 	  			방 삭제
						</button>
					</c:if>
					
					<!-- 방 삭제 Modal -->
					<div class="modal fade" id="deleteRoom" tabindex="-1" aria-labelledby="cancelModalLabel" aria-hidden="true">
					  <div class="modal-dialog">
					    <div class="modal-content">
					      <div class="modal-header">
					        <h1 class="modal-title fs-5" id="cancelModalLabel" style="color: black;">방 삭제 확인</h1>
					        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					      </div>
					      <div class="modal-body">
							<h5>아직 완료되지 않은 계획입니다</h5><br>
							<h4 style="font-weight: bold;">모든 계획이 삭제됩니다 <br /> 그래도 삭제하시겠습니까? </h4>
					      </div>
					      <div class="modal-footer">
					        <button type="button" class="btn btn-secondary" id="roomDel" data-bs-dismiss="modal">확인</button>
					        <button type="button" class="btn btn-primary" data-bs-dismiss="modal">취소</button>
					      </div>
					    </div>
					  </div>
					</div>
					
					
		 	   </div><!-- 버튼상자 끝 -->	
	    	</div>
	    
			<div class="totalWrapper position-relative">		
		        <!-- 멤버 카드들 고정 -->
		        <!-- 경우에 수를 클래스에 표시 -->
		        <!-- 1.go: 방장 -->
		        <!-- 2.yetReady: 팀원이 ready 하기를 기다리는 상황 -->
		        <!-- 3.doneReady: 팀원이 ready를 누른 상황 -->
			  	<div class="membersDiv mt-3 row row-cols-1 row-cols-md-3 g-4 justify-content-center position-relative">
					<!-- 방장 -->
					<c:forEach var="member" items="${roomMembers }">
						
						<c:if test="${member.id_num == planner.id_num }">
							<div class="card mx-3 my-3 p-1" style="width: 7rem; height: 11rem;">
							  <div class="card-body p-0 text-center pt-3">
							  
							  <c:if test="${member.id_num == myId }">
							  	<div>
								  <a href="mypage1.action" style="color: black; text-decoration: none">
										<img alt="" src="${member.photo }" style="width: 60px; height: 60px; border-radius: 50%"><br>
										<span style="margin:0; font-size: 13px; color: black">${member.nickname}/${member.age }</span>
								  </a>
								  </div>	
							  </c:if>
							  <c:if test="${member.id_num != myId }">
							  <div>
								  <a href="personalpage.action?etiId=${member.id}&room_num=${planner.room_num }" style="color: black; text-decoration: none">
										<img alt="" src="${member.photo } " style="width: 60px; height: 60px; border-radius: 50%"><br>
										<span style="margin:0; font-size: 13px; color: black">${member.nickname}/${member.age }</span>
								  </a>
								  </div>	
							  </c:if>
							  <div>
						 	        <button type="button" class="${canGo == 'OK' ? (planner.final_go_date != null ? 'bg-warning' :'bg-danger') : 'bg-secondary' }
						 	        leaderBtn btn rounded pt-1 px-2 mt-1"
						 	        ${member.id_num != myId ? "disabled=\"disabled\"" : (canGo == "OK" ? (planner.final_go_date != null ? "disabled=\"disabled\"" : "") : "disabled=\"disabled\"")}
						 	        value="${member.id_num }">
						 	        ${planner.final_go_date == null ? "Go" : "<svg width='24' height='24' viewBox='0 0 24 24' fill='none' 
						 	        xmlns='http://www.w3.org/2000/svg'><path d='M22 11.0801V12.0001C21.9988 14.1565 21.3005 16.2548 20.0093
						 	         17.9819C18.7182 19.7091 16.9033 20.9726 14.8354 21.584C12.7674 22.1954 10.5573 22.122 8.53447 
						 	         21.3747C6.51168 20.6274 4.78465 19.2462 3.61096 17.4372C2.43727 15.6281 1.87979 13.4882 2.02168
						 	          11.3364C2.16356 9.18467 2.99721 7.13643 4.39828 5.49718C5.79935 3.85793 7.69279 2.71549 9.79619
						 	           2.24025C11.8996 1.76502 14.1003 1.98245 16.07 2.86011M22 4.00011L12 14.0101L9.00001 11.0101' 
						 	           stroke='#101828' stroke-width ='2' stroke-linecap='round' stroke-linejoin='round'/></svg>" }
						 	        </button>
						 	        </div>
							  </div>
							</div>
						</c:if>
						<!-- 메이트 -->
						<c:if test="${member.id_num != planner.id_num }">
							<div class="card mx-3 my-3 p-1" style="width: 7rem; height: 11rem;">
							  <div class="card-body p-0 text-center pt-3">
							  <c:if test="${member.id_num == myId }">
								  <a href="mypage1.action" style="color: black; text-decoration: none" >
										<img alt="" src="${member.photo }" style="width: 60px; height: 60px; border-radius: 50%"><br>
										<span style="margin:0; font-size: 13px; color: black">${member.nickname}/${member.age }</span>
								  </a>	
							  </c:if>
							  <c:if test="${member.id_num != myId }">
								  <a href="personalpage.action?etiId=${member.id}&room_num=${planner.room_num }" style="color: black; text-decoration: none">
										<img alt="" src="${member.photo }" style="width: 60px; height: 60px; border-radius: 50%"><br>
										<span style="margin:0; font-size: 13px; color: black">${member.nickname}/${member.age }</span>
								  </a>	
							  </c:if>
						 	        <button type="button" class="${member.ready == null ? 'bg-danger' : 'bg-warning' }
						 	        mateBtn btn rounded pt-1 px-2 mt-1"
						 	        ${member.id_num != myId ? "disabled=\"disabled\"" : ""}
						 	        value="${member.id_num }">
						 	        ${member.ready == null ? "Ready" : "<svg width='24' height='24' viewBox='0 0 24 24' fill='none' xmlns='http://www.w3.org/2000/svg'><path d='M22 11.0801V12.0001C21.9988 14.1565 21.3005 16.2548 20.0093 17.9819C18.7182 19.7091 16.9033 20.9726 14.8354 21.584C12.7674 22.1954 10.5573 22.122 8.53447 21.3747C6.51168 20.6274 4.78465 19.2462 3.61096 17.4372C2.43727 15.6281 1.87979 13.4882 2.02168 11.3364C2.16356 9.18467 2.99721 7.13643 4.39828 5.49718C5.79935 3.85793 7.69279 2.71549 9.79619 2.24025C11.8996 1.76502 14.1003 1.98245 16.07 2.86011M22 4.00011L12 14.0101L9.00001 11.0101' stroke='#101828' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'/></svg>" }
						 	        </button>
							  </div>
							  <!-- x자 뱃지(누르면 강제퇴장 kickModal) -->
							  <c:if test="${myId == planner.id_num}">
								  <button type="button" class="memberExit" value="${member.id_num }"
								  style="height: 0; padding: 0; border: 0;">
									  <span class="position-absolute top-0 start-100 translate-middle bg-light border border-none rounded-circle">
										<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-x" viewBox="0 0 16 16">
										  <path d="M4.646 4.646a.5.5 0 0 1 .708 0L8 7.293l2.646-2.647a.5.5 0 0 1 .708.708L8.707 8l2.647 2.646a.5.5 0 0 1-.708.708L8 8.707l-2.646 2.647a.5.5 0 0 1-.708-.708L7.293 8 4.646 5.354a.5.5 0 0 1 0-.708z"/>
										</svg>
								  	</span>
							  	</button>
							  	<span class="removeSpan" data-bs-toggle="modal" data-bs-target="#kickModal"></span>
							  </c:if>	
							</div>
						</c:if>
					</c:forEach>
						<c:forEach var="n" begin="1" end="${planner.mem_max - planner.mem_curr}" step="1">
								<div class="card mx-3 my-3 p-2" style="width: 7rem; height: 11rem;">
									<div class="card-body" style="margin-left: auto; margin-right: auto; margin-top: 2.5rem; margin-bottom: 2.5rem;">
										<c:if test="${planner.id_num == myId }">
											<span class="memberMinus">
												<svg width="40" height="40" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
													<path d="M8 12H16M22 12C22 17.5228 17.5228 22 12 22C6.47715 22 2 17.5228 2 12C2 6.47715 6.47715 2 12 2C17.5228 2 22 6.47715 22 12Z" stroke="#101828" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
												</svg>
											</span>
										</c:if>
									</div>
								</div>
						</c:forEach>
					<c:if test="${planner.id_num == myId }">
						<c:if test="${planner.mem_max < 10 }">
							<div class="card mx-3 my-3 p-2" style="width: 7rem; height: 11rem; background-color: transparent; border-color: transparent;">
								<div class="card-body" style="margin-left: auto; margin-right: auto; margin-top: 2.5rem; margin-bottom: 2.5rem;">
									<span class="memberPlus">
										<svg width="40" height="40" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
											<path d="M12 8V16M8 12H16M22 12C22 17.5228 17.5228 22 12 22C6.47715 22 2 17.5228 2 12C2 6.47715 6.47715 2 12 2C17.5228 2 22 6.47715 22 12Z" stroke="#101828" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
										</svg>
									</span>
								</div>
							</div>
						</c:if>
					</c:if>
				</div><!-- 카드들 -->
			   </div>
			</div>
	  	</div>		    	
</main>
		
	  <!-- 모달 자리(테스트) -->
		<!-- Modal -->
		<div class="modal fade removeModal" id="kickModal" tabindex="-1" aria-labelledby="kickModalLabel" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h1 class="modal-title fs-5" id="kickModalLabel" style="color: black;">강제 퇴장</h1>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <div class="modal-body">
		        <h5>아직 확정되지 않은 계획입니다</h5><br />
		        <h5>해당 사용자를 강제퇴장 시키시겠습니까?</h5>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" onclick="removeExecute(2)">예</button>
		        <button type="button" class="btn btn-primary" data-bs-dismiss="modal">아니오</button>
		      </div>
		    </div>
		  </div>
		</div>
		<!-- 모달 연결 자리 끝 -->		
			
		<!-- 투표 목록 Modal -->
		<div class="modal fade modal-dialog-scrollable" id="voteListModal" tabindex="-1" aria-labelledby="voteListModalLabel" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
              <div class="modal-body">    
				${voteList }                                                                                 
			  </div>
		      <div class="modal-footer">
				<!-- 투표 만들기 버튼 -->
				<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#modal2">투표 만들기</button>
		        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
		      </div>
		    </div>
		  </div>
		</div><!-- 투표모달 끝 -->
		
		<!-- 두번째 모달 창 -->
		<div class="modal fade" id="modal2" tabindex="-1" role="dialog">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title">두번째 모달 창</h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      <div class="modal-body">
		        <p>모달 내용</p>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
		      </div>
		    </div>
		  </div>
		</div>		
		<!-- 모달 끝 -->		

</body>
</html>