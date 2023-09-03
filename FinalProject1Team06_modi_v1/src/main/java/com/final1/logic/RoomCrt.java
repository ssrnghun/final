/*=====================================
	RoomListCrt.java
	- mybatis 객체 활용(Controller)
=====================================*/

package com.final1.logic;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class RoomCrt
{
	@Autowired
	private SqlSession sqlSession;
	
	/*
	@RequestMapping(value = "/roomlist.action", method = RequestMethod.GET)
	public String hello(Model model)
	{
		model.addAttribute("message", "mybatis 환경 체크");
		
		return "/room.jsp";
	}
	*/
	
	@RequestMapping(value = "/planner.action", method = RequestMethod.GET)
	//public String roomList(Model model, String room_num, String my_id)
	//public String roomList(Model model)
	public String roomList(Model model, HttpSession session, String room_num, String page)
	{
		String result = "";
		if (room_num == null)
		{
			room_num = (String)session.getAttribute("room_num");
			
		}
		if (page == null)
			page = "1";
		
		IRoomDAO dao = sqlSession.getMapper(IRoomDAO.class);
		
		String my_real_id= (String)session.getAttribute("id");
		//String my_real_id = "moon1010";
		//String room_num = "ROOM-00001";
		String my_id = dao.findIdNum(my_real_id);
		String my_join_num = dao.findJoinNum(my_id, room_num);
		
		session.setAttribute("room_num", room_num);
		session.setAttribute("myId", my_id);
		session.setAttribute("my_real_id", my_real_id);
		session.setAttribute("my_join_num", my_join_num);
		session.setAttribute("page", page);
		
		String memMax = dao.planner(my_id, room_num).getMem_max();
		String memCurr = dao.planner(my_id, room_num).getMem_curr();
		String allReady = dao.allReady(room_num);
		ArrayList<PlannerLocMemoDTO> plannerLocMemo = dao.plannerLocMemo(room_num);
		ArrayList<PlannerLocMemoDTO> collectionList = dao.collectionList(room_num);
		ArrayList<PlannerLocMemoDTO> myCollectionList = dao.myCollectionList(my_id, room_num);
		ArrayList<CollectionDTO> myCheckList = dao.myCheckList(my_id, room_num);
		
		if (allReady == null)
		{
			allReady = "0";
		}
		
		String canGo = "";
		
		// 픽스 갯수 추가 ★
		int fixCount = dao.fixCount(room_num);
		int day = dao.dayCal(room_num);
		
		if (Integer.parseInt(memMax) == Integer.parseInt(memCurr) && Integer.parseInt(allReady) + 1 >= Integer.parseInt(memCurr)
				&& day == fixCount)
			canGo = "OK";
		System.out.println(memCurr);
		System.out.println(memMax);
		
		System.out.println(allReady); 
		
		System.out.println(fixCount);
		System.out.println(day);
		
		model.addAttribute("planner", dao.planner(my_id, room_num));
		
		//int res = (int)(dao.planner(my_id, room_num).getTrip_end_date())-(int)(dao.planner(my_id, room_num).getTrip_start_date())+1;
		
		model.addAttribute("roomMembers", dao.roomMembers(room_num));
		//model.addAttribute("myId", my_id);
		model.addAttribute("canGo", canGo);
		model.addAttribute("plannerLocMemo", plannerLocMemo);
		model.addAttribute("collectionList", collectionList);
		model.addAttribute("myCollectionList", myCollectionList);
		
		// 추가 ★
		model.addAttribute("hostPassList", dao.hostpassList(room_num));
		model.addAttribute("memPassList", dao.memPassList(room_num, my_id));
		model.addAttribute("barInfo", dao.menuBarInfo(my_id));
		model.addAttribute("myCheckList",myCheckList);
		
		IFeedDAO dao2 = sqlSession.getMapper(IFeedDAO.class);
		model.addAttribute("feedList", dao2.feedList(room_num));
		
		FeedDTO dto = new FeedDTO();
		dto.setId(my_real_id);
		dto.setRoomNum(room_num);
		
		model.addAttribute("feedDto", dao2.searchId(dto));
		
		if(dao.voteslist(room_num).isEmpty())
		{
			model.addAttribute("voteList","개설된 투표가 없습니다.");
		}
		else
		{
			model.addAttribute("voteList",dao.voteslist(room_num));
		}
		
		// ★ 추가 ★
		IAlarmDAO dao3 = sqlSession.getMapper(IAlarmDAO.class);
		
		model.addAttribute("alarmList", dao3.alarmList(my_id));
		model.addAttribute("alarmCount", dao3.alarmCount(my_id));
		model.addAttribute("tripScoreMate", dao.tripScoreMate(room_num, my_id));
		model.addAttribute("tripScoreMate", dao.tripScoreMate(room_num, my_id));
		model.addAttribute("finMemCount", dao.finMemCount(my_id, room_num));
		model.addAttribute("tsCount", dao.tsCount(my_id, room_num));
		
		
		if (page.equals("1"))
			result = "/scheduleList.jsp";
		else if (page.equals("-1"))
			result = "/collectionList.jsp";
		else
			result = "/WEB-INF/view/Feed.jsp";
		
		return result;
	}
	
	@RequestMapping(value = "/ready.action", method = RequestMethod.GET)
	public String ready(Model model, String room_num, String my_id)
	{
		String result = "";
		//System.out.println("room="+room_num+"/id="+my_id);
		
		IRoomDAO dao = sqlSession.getMapper(IRoomDAO.class);
		
		String choice = "";
		
		if (dao.isReady(my_id, room_num).getReady().equals("0"))
			choice = "SYSDATE";
		else
			choice = "NULL";
		
		int res=  dao.ready(choice, my_id, room_num);
		
		// 추가 ★
		// 올픽스 올레디 상태일 때 
		if(dao.allReady(room_num).equals("1") && dao.allFix(room_num) ==1)
		{
			// 방장 출발 알림 보내기(insert)
			dao.goAlarm(room_num);
		}
		
		System.out.println(res);
		model.addAttribute("choice", choice);
		
		result = "/ready.jsp";
		
		return result;		
	}
	 // 출발 버튼 누를 때 
	@RequestMapping(value = "/go.action", method = RequestMethod.GET)
	public String go(Model model, String room_num, String my_id)
	{
		String result = "";
		
		IRoomDAO dao = sqlSession.getMapper(IRoomDAO.class);
		
		dao.go(room_num);
		dao.ready("SYSDATE", my_id, room_num);
		dao.readyAlarm(my_id, room_num);
		
		// 추가 
		// 북마크 목록에서 해당 방 삭제
		dao.bookmarkDel(room_num);
		
		// 추가
		// 완료된 방에 insert 
		for(String mem_join_num : dao.ogMemJoin(room_num))
		{
			dao.finAdd(mem_join_num);
		}
		
		String choice = "SYSDATE";
		
		model.addAttribute("choice", choice);
		
		result = "/ready.jsp";
				
		return result;
	}
	
	@RequestMapping(value = "/searchbookmark.action", method = RequestMethod.GET)
	public String searchBookmark(Model model, String room_num, String my_id)
	{
		String result = "";
		
		IRoomDAO dao = sqlSession.getMapper(IRoomDAO.class);

		String bookmark = dao.searchBookmark(my_id, room_num);
		
		if (bookmark == null)
		{
			dao.addBookmark(my_id, room_num);
			bookmark = dao.searchBookmark(my_id, room_num);
			//System.out.println(bookmark);
			model.addAttribute("bookmark", bookmark);
		}
		else
		{
			dao.removeBookmark(my_id, room_num);
			bookmark = dao.searchBookmark(my_id, room_num);
			//System.out.println(bookmark);
			model.addAttribute("bookmark", bookmark);
		}
		
		result = "/bookmark.jsp";
		
		return result;
	}
	
	@RequestMapping(value = "/memberplus.action", method = RequestMethod.GET)
	public String memberPlus(Model model, String my_id, String room_num)
	{
		String result = "";
		
		IRoomDAO dao = sqlSession.getMapper(IRoomDAO.class);
		
		dao.memberPlus(room_num);
		dao.changeReady(room_num);
		
		result = "redirect:planner.action";
		
		return result;
	}

	@RequestMapping(value = "/memberminus.action", method = RequestMethod.GET)
	public String memberMinus(Model model, String my_id, String room_num)
	{
		String result = "";
		
		IRoomDAO dao = sqlSession.getMapper(IRoomDAO.class);
		
		dao.memberMinus(room_num);
		dao.changeReady(room_num);

		result = "redirect:planner.action";
		
		return result;
	}
	
	@RequestMapping(value = "/gocheck.action", method = RequestMethod.GET)
	public String goCheck(Model model, String room_num)
	{
		String result = "";
		
		IRoomDAO dao = sqlSession.getMapper(IRoomDAO.class);

		String goCheck = dao.goCheck(room_num);
		
		model.addAttribute("goCheck", goCheck);
		
		result = "/goCheck.jsp";
		
		return result;
	}
	// 수정 
	@RequestMapping(value = "/removemember.action", method = RequestMethod.GET)
	public String removeMember(Model model, String room_num, String idNum, int reason, FeedDTO dto)
	{
		//System.out.println("메소드 실행");
		//System.out.println(room_num +"/"+idNum);
		String result = "";
		String my_id = idNum;
		
		IRoomDAO dao = sqlSession.getMapper(IRoomDAO.class);
		IFeedDAO dao2 = sqlSession.getMapper(IFeedDAO.class);
		
		dto.setRoomNum(room_num);
		dto.setIdNum(idNum);
		
		dao2.addContentExit(dto);
		dao.insertExitMember(idNum, room_num, reason);
		dao.removeMember(idNum, room_num);
		dao.changeReady(room_num);
		
		//추가 ★
		RoomDTO room = dao.planner(my_id, room_num);
		
		// 최대 인원에서 한명 줄었을 때
		if(Integer.parseInt(room.getMem_max())-1 == Integer.parseInt(room.getMem_curr()))
		{
			//해당 방을 북마크한 리스트 가져오기
			for(BookMarkDTO mark : dao.bookMarkList(room_num))
			{
				// 북마크 알람 추가
				dao.bookMarkAlarm(mark.getBookMarkNum());
			}
		}
		
		result = "redirect:planner.action";
		
		return result;
	}
	
	@RequestMapping(value = "/map.action", method = RequestMethod.GET)
	public String map(String room_num, HttpSession session, int day)
	{
		String result = "";
		
		IRoomDAO dao = sqlSession.getMapper(IRoomDAO.class);
		
		String my_id = (String)session.getAttribute("myId");
		
		ArrayList<PlannerLocMemoDTO> plannerLocMemoDay = dao.plannerLocMemoDay(room_num, day);
		ArrayList<PlannerLocMemoDTO> collectionList = dao.collectionList(room_num);
		ArrayList<PlannerLocMemoDTO> myCollectionList = dao.myCollectionList(my_id, room_num);
		
		if (day == -1)
			session.setAttribute("plannerLocMemoDay", collectionList);
		else if (day == -2)
			session.setAttribute("plannerLocMemoDay", myCollectionList);
		else
			session.setAttribute("plannerLocMemoDay", plannerLocMemoDay);
		
		result = "/positions.jsp";
		
		return result;
	}
	
	// 수정 ★★★★★
	@RequestMapping(value = "/findjoinroom.action", method = RequestMethod.GET)
	public String findJoinRoom(Model model, HttpSession session, String startDate, String endDate, String room_num)
	{
		String result = "";
		
		String my_real_id = (String)session.getAttribute("my_real_id");
		IRoomDAO dao = sqlSession.getMapper(IRoomDAO.class);
		String compareDate = dao.compareDate(startDate, endDate, my_real_id);
		
		
		String id_num = dao.findIdNum(my_real_id);
		int exitCount = dao.exitCount(id_num, room_num);
		
		String str = "";
		if(!compareDate.equals("0"))
		{
			str = "이미 참여 중인 여행과 기간이 겹칩니다.";
		}
		else // 여행 기간이 안겹칠 때 
		{
			// 강제퇴장 된 방일 때
			if(exitCount != 0)
			{
				str = "방장으로부터 강제퇴장 처리된 방으로 참여가 불가능합니다.";
			}
			else // 강제퇴장 된 적 없을 때
			{
				str = "0";
			}
		}
		
		
		model.addAttribute("str", str);
		
		result = "/compareDate.jsp";
		return result;
	}
	
	@RequestMapping(value = "/joinroom.action", method = RequestMethod.GET)
	public String joinRoom(HttpSession session, String startDate, String endDate)
	{	
		String result = "";
		
		String my_real_id = (String)session.getAttribute("my_real_id");
		String room_num = (String)session.getAttribute("room_num");
		String id_num = (String)session.getAttribute("myId");
		
		//System.out.println(my_real_id);
		//System.out.println(id_num);
		//System.out.println(room_num);
		
		IRoomDAO dao = sqlSession.getMapper(IRoomDAO.class);
		IFeedDAO dao2 = sqlSession.getMapper(IFeedDAO.class);
		
		FeedDTO dto = new FeedDTO();
		
		dto.setId(my_real_id);
		dto.setIdNum(id_num);
		dto.setRoomNum(room_num);
		
		String compareDate = dao.compareDate(startDate, endDate, my_real_id );
		
		System.out.println(compareDate);
		if (compareDate != null)
		{
			if (Integer.parseInt(compareDate) == 0)
			{
				//System.out.println("testnotnull");
				dao.memJoin(id_num, room_num);
				dao.ongoing(id_num, room_num);
				dao.changeReady(room_num);
			}
		}
		else
		{
			//System.out.println("testnull");
			dao.memJoin(id_num, room_num);
			dao.ongoing(id_num, room_num);
			dao.changeReady(room_num);
		}

		// 피드에 참여하였습니다 추가
		dao2.addContentInto(dto);
		
		result = "redirect:planner.action?room_num="+room_num;
		
		return result;
	}
	
	@RequestMapping(value = "/addmemo.action", method = RequestMethod.GET)
	public String addMemo(String memo, HttpSession session, String day, Model model)
	{
		String result = "";
		
		//System.out.println(memo);
		
		IRoomDAO dao = sqlSession.getMapper(IRoomDAO.class);
		
		System.out.println(memo);
		System.out.println((String)session.getAttribute("room_num"));
		System.out.println(day);
		dao.addMemo(memo, (String)session.getAttribute("room_num"), day);
		
		model.addAttribute("memoResult", day);
		
		result = "/addMemo.jsp";
		
		return result;
	}
	
	@RequestMapping(value = "/addplan.action", method = RequestMethod.GET)
	public String addPlan(String title, String lat, String lng, HttpSession session, String day, Model model)
	{
		//System.out.println("addplan");
		String result = "";
		//System.out.println(title);
		IRoomDAO dao = sqlSession.getMapper(IRoomDAO.class);
		
		String room_num = (String)session.getAttribute("room_num");
		
		dao.addPlan(title, lat, lng, room_num, day);
		dao.changeReady(room_num);
		
		// 추가 ★ -> 방장 패스 제거
		dao.removeHostPass(room_num, Integer.parseInt(day));
		
		//model.addAttribute("planResult", day);
		
		result = "/addMemo.jsp";
		
		return result;
	}
	
	@RequestMapping(value = "/removeplan.action", method = RequestMethod.GET)
	public String removePlan(String loc_memo_num, String room_num)
	{
		String result = "";

		IRoomDAO dao = sqlSession.getMapper(IRoomDAO.class);
		
		int removePlanResult = dao.removePlan(loc_memo_num);
		if (removePlanResult != 0)
			dao.changeReady(room_num);
		
		dao.removeMemo(loc_memo_num);
		
		result = "redirect:planner.action";
		
		return result;
	}
	
	// 수정 ★★★★★
	@RequestMapping(value = "/hostpass.action", method = RequestMethod.GET)
	public void hostPass(String room_num, String day, Model model, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		IRoomDAO dao = sqlSession.getMapper(IRoomDAO.class);
		
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		
		String id_num = dao.findIdNum(id);
		
		int isHostPassResult = dao.isHostPassDay(room_num, Integer.parseInt(day));
		
		if (isHostPassResult == 0) // 방장 패스를 안누른 상태일 때 
		{
			dao.addHostPass(room_num, Integer.parseInt(day)); // 패스 요청
			
			 // 해당 방에 있는 사람들 방장패스알림테이블에 모두 insert  추가★
			for(String mem_join_num : dao.ogMemJoin(room_num))
			{
				dao.hostPassAlarmAdd(mem_join_num, room_num);
			}
		}
		else // 방장 패스를 누른 상태일 때 
		{
			dao.removeHostPass(room_num, Integer.parseInt(day)); // 패스 요청 취소
		}
		
		String html = generateHTML.passCheck(dao.hostpassList(room_num));
		
		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(html);
	}
	
	// 추가 ★★★★★
	@RequestMapping(value = "/mempass.action", method = RequestMethod.GET)
	public void memPass(String room_num, String day, Model model, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		
		IRoomDAO dao = sqlSession.getMapper(IRoomDAO.class);
		
		String my_real_id = (String)request.getSession().getAttribute("id");
		
		String my_id = dao.findIdNum(my_real_id);
		
		int isMemPass = dao.isMemPass(room_num, my_id, Integer.parseInt(day));
		
		
		if (isMemPass == 0) // 특정일자에 패스를 안누른 상태일 때 
		{
			System.out.println("패스");
			dao.addMemPass(room_num, my_id, Integer.parseInt(day)); // 패스 요청
			
			// 현재 참여중인 인원이 해당 일자에 모두 패스를 눌렀을 때 FIX 반환
			if(dao.isFix(room_num, Integer.parseInt(day)).equals("FIX"))
			{
				// FIX 테이블에 INSERT
				if(dao.addFix(room_num, Integer.parseInt(day))>0)
				{
					// 레디 풀기
					dao.changeReady(room_num);
				}
			}
		}
		else // 패스를 누른 상태일 때 
		{
			System.out.println("취소");
			dao.removeMemPass(room_num, my_id,Integer.parseInt(day)); // 패스 요청 취소
		}
		
		String html = generateHTML.passMemCheck(dao.memPassList(room_num, my_id));
		
		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(html);
	}
	

	
	/*
	@RequestMapping(value = "/ishostpass.action", method = RequestMethod.GET)
	public String isHostPass(String room_num, String day, Model model)
	{
		String result = "";
		
		IRoomDAO dao = sqlSession.getMapper(IRoomDAO.class);
		
		//String isHostPassResult = dao.isHostPassDay(room_num, Integer.parseInt(day));
		
		//model.addAttribute("isHostPassResult", isHostPassResult);
		
		result = "/hostPass.jsp";
		
		return result;
	}
	*/
	
	@RequestMapping(value = "/passlist.action", method = RequestMethod.GET)
	public void passList(String room_num, String day, Model model, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		IRoomDAO dao = sqlSession.getMapper(IRoomDAO.class);
		
		RoomMemberDTO hostDto = dao.hostPassCheck(room_num);
		ArrayList<RoomMemberDTO> memList = dao.memPassCheck(room_num, Integer.parseInt(day));
		
		String html = generateHTML.dayPassList(hostDto, memList, day);
		
		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(html);
	}
	
	@RequestMapping(value = "/roomdel.action", method = RequestMethod.GET)
	public String roomdel(String room_num)
	{
		String result = "";
		IRoomDAO dao = sqlSession.getMapper(IRoomDAO.class);
		
		// 방 삭제일 update 
		dao.roomDel(room_num);
		
		for(String mem_join_num : dao.ongoingMemCheck(room_num))
		{
			// 퇴장 테이블에 insert 
			dao.roomDelExit(mem_join_num);
		}
		
		// onging 테이블 내 멤버 삭제
		dao.ongoingDel(room_num);
		
		// bookmark 삭제
		dao.bookmarkDel(room_num);
		
		// 룸리스트로 이동
		result = "roomlist.action";
		
		return result;
	}
	
	@RequestMapping(value = "/modiplace.action", method = RequestMethod.GET)
	public String modiPlace(PlannerLocMemoDTO dto)
	{
		String result = "";
		IRoomDAO dao = sqlSession.getMapper(IRoomDAO.class);
		int res = dao.modiPlace(dto);
		// 레디 풀리게 함
		dao.changeReady(dto.getRoom_num());
		
		
		// 룸리스트로 이동
		result = "redirect:planner.action?page=1&room_num="+dto.getRoom_num();
		System.out.println(result);
		
		return result;
	}
	
	@RequestMapping(value = "/memomodi.action", method = RequestMethod.GET)
	public String modiMemo(PlannerLocMemoDTO dto)
	{
		String result = "";
		IRoomDAO dao = sqlSession.getMapper(IRoomDAO.class);
		
		int res = dao.modiMemo(dto);
		
		System.out.println(dto.getRoom_num());
		// 룸리스트로 이동
		result = "redirect:planner.action?room_num="+dto.getRoom_num();
		
		return result;
	}
	
	@RequestMapping(value = "updateroomform.action")
	public String updateFormRoom(Model model, String room_num)
	{
		IRoomDAO dao = sqlSession.getMapper(IRoomDAO.class);
		
		System.out.println(room_num);
		
		model.addAttribute("dto", dao.searchRoom(room_num));
		
		return "/WEB-INF/view/UpdateRoomForm.jsp";
	}
	
	// 방 수정
	@RequestMapping(value = "updateroom.action")
	public String updateRoom(RoomDTO dto)
	{
		String result = "";
		
		IRoomDAO dao = sqlSession.getMapper(IRoomDAO.class);

		dao.modifyRoom(dto);
		
		result = "redirect:planner.action?=" + dto.getRoom_num();
		
		return result;
	}
	
	@RequestMapping(value = "/addcollection.action", method = RequestMethod.GET)
	public String addCollection(String title, String lat, String lng, HttpSession session, String day, Model model)
	{
		String result = "";
		IRoomDAO dao = sqlSession.getMapper(IRoomDAO.class);
		
		String room_num = (String)session.getAttribute("room_num");
		
		dao.addCollection(title, lat, lng, room_num, (String)session.getAttribute("myId"));
		
		result = "/addMemo.jsp";
		
		return result;
	}
	
	@RequestMapping(value = "/addmemocollection.action", method = RequestMethod.GET)
	public String addMemoCollection(String memo, HttpSession session, Model model)
	{
		String result = "";
		
		//System.out.println(memo);
		
		IRoomDAO dao = sqlSession.getMapper(IRoomDAO.class);
		
		int addResult = dao.addMemoCollection(memo, (String)session.getAttribute("room_num"), (String)session.getAttribute("myId"));
		
		model.addAttribute("memoResult", addResult);
		
		result = "/addMemo.jsp";
		
		return result;
	}
	
	// 컬렉션 장소 및 메모 수정 추가 ★★★★★★★★★★★
	@RequestMapping(value = "collectionmodiplace.action")
	public String modifyCollection(PlannerLocMemoDTO dto)
	{
		String result = "";
		
		IRoomDAO dao = sqlSession.getMapper(IRoomDAO.class);
		
		dao.modifyCollection(dto);
		
		result = "redirect:planner.action?room_num=" + dto.getRoom_num() + "&page=-1";
		
		return result;
	}
	
	// 컬렉션 장소 및 메모 수정 추가 ★★★★★★★★★★★
	@RequestMapping(value = "collectionmemomodi.action")
	public String modifyCollectionMemo(PlannerLocMemoDTO dto)
	{
		String result = "";
		
		IRoomDAO dao = sqlSession.getMapper(IRoomDAO.class);
		
		dao.modifyCollectionMemo(dto);
		System.out.println(dto.getRoom_num());
		result = "redirect:planner.action?room_num=" + dto.getRoom_num() + "&page=-1";
		
		return result;
	}
	
	// 컬렉션 장소 및 메모 삭제 추가
	@RequestMapping(value = "removecollection.action")
	public String removeCollection(String loc_memo_num, String room_num)
	{
		String result = "";
		
		IRoomDAO dao = sqlSession.getMapper(IRoomDAO.class);
		dao.removeCollection(loc_memo_num);
		dao.removeCollectionMemo(loc_memo_num);
		
		result = "redirect:planner.action?room_num=" + room_num + "&page=-1";
		
		return result;
	}
	
	// 체크리스트 출력 
	@RequestMapping(value = "/mychecklist.action", method = RequestMethod.GET)
	public String myCheckList(String my_id, String room_num, Model model)
	{
		String result = "";
		
		IRoomDAO dao = sqlSession.getMapper(IRoomDAO.class);
		
	    ArrayList<CollectionDTO> checklistResult = dao.myCheckList(my_id, room_num);
	
		model.addAttribute("checklistResult", checklistResult);
		
		result = "/mychecklist.jsp";
		
		return result;
	}	
		// 체크리스트 삭제
		@RequestMapping(value = "/deletechecklist.action", method = RequestMethod.GET)
		public void deleteCheckList(HttpSession session, String chklist_num, HttpServletResponse response) throws IOException
		{
			String result = "";

			IRoomDAO dao = sqlSession.getMapper(IRoomDAO.class);
			
			String my_id= (String)session.getAttribute("myId");
			String room_num = (String)session.getAttribute("room_num");
			
			dao.deleteCheckList(my_id, room_num, chklist_num);
			
			ArrayList<CollectionDTO> checklistResult = dao.myCheckList(my_id,room_num);
			
			String html = generateHTML.checkListHTML(checklistResult);
			
			response.setContentType("text/html");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(html);
		}
		
		// 체크리스트 입력
		@RequestMapping(value = "/insertchecklist.action", method = RequestMethod.GET)//mem_join_num/chklist_cnt 수신
		public void insertCheckList(HttpSession session,String chklist_cnt, HttpServletResponse response) throws IOException
		{
			//String result = "";

			IRoomDAO dao = sqlSession.getMapper(IRoomDAO.class);
			
			String my_id= (String)session.getAttribute("myId");
			String room_num = (String)session.getAttribute("room_num");
			//dao insert 
			dao.insertCheckList(my_id,room_num, chklist_cnt);
			//리스트를 모두 출력
			ArrayList<CollectionDTO> checklistResult = dao.myCheckList(my_id, room_num);
			System.out.println(checklistResult.get(0).getChklist_cnt());
			
			//ajax 해줌
			String html = generateHTML.checkListHTML(checklistResult);
			
			response.setContentType("text/html");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(html);
		}	
	
	
		// 투표 출력 
		@RequestMapping(value = "/voteslist.action", method = RequestMethod.GET) //방 번호 수신(3번방)
		public String voteslist(String room_num, Model model, String vote_num)
		{
			String result = "";
			
			IRoomDAO dao = sqlSession.getMapper(IRoomDAO.class);
			
			ArrayList<VotesDTO> votesList= dao.voteslist(room_num);
			System.out.println();

			String voteList = "";
			voteList += "<table class=\"table table-hover\" >";
			voteList += "<thead>";
			voteList += "  <tr>";
			voteList += "	<th scope=\"col\">주제</th>";
			voteList += "	<th scope=\"col\">투표 개설일</th>";
			voteList += "   <th scope=\"col\">투표 종료일</th>";
			voteList += "  </tr>";
			voteList += "<tbody>";
			
			for(VotesDTO Onevote:votesList)
			{
				voteList += "<tr>";
				voteList += "<td>"+"<a href='voteform.action?vote_num="+Onevote.getVote_num()+"'>"+Onevote.getTitle()+"</td>";
				voteList += "<td>"+Onevote.getStart_date()+"</td>";
				voteList += "<td>"+Onevote.getEnd_date()+"</td>";
				voteList += " </tr>";
			}
			voteList += "</tbody>";
			voteList += "</table>";
			
			model.addAttribute("voteList",voteList);
			
			result = "/votesList.jsp";
			
			return result;
		}		
		
	// 투표 목록 클릭 시 투표 본문 보기
		
		@RequestMapping(value = "/voteform.action", method = RequestMethod.GET)
		public String votecatelist(String vote_num, Model model)
		{
			String result = "";
			
			
			IRoomDAO dao = sqlSession.getMapper(IRoomDAO.class);
			
			ArrayList<VoteCateDTO> voteform =  dao.votecatelist(vote_num);
			String voteFormList = "테스트";
			/*
			for(VoteCateDTO OnevoteForm:voteform)
			{
				voteFormList += "		            <ul class='shadow p-1 mb-2 bg-body rounded list-group list-group-horizontal rounded-0 bg-white'>";
				voteFormList += "		              <li>";
				voteFormList += "		                class='list-group-item d-flex align-items-center  py-1 rounded-0 border-0 bg-transparent'>";
				voteFormList += "		                <div class='form-check'>";
				voteFormList += "		                  <input class='form-check-input me-0' type='checkbox' value='' id='flexCheckChecked2'";
				voteFormList += "		                    aria-label='...' />";
				voteFormList += "		                </div>";
				voteFormList += "		               </li>";
				voteFormList += "		              <li>";
				voteFormList += "		                class='list-group-item px-3 py-1 d-flex align-items-center flex-grow-1 border-0 bg-transparent'>";
				voteFormList += "		                <p class='lead fw-normal mb-0'></p>";
				voteFormList += "		              </li>";
				voteFormList += "		              <li class='list-group-item ps-3 pe-3 py-1 rounded-0 border-0 bg-transparent row justify-content-center'>";
				voteFormList += "		              	<div class='showCount px-1'>표</div>";
				voteFormList += "		              </li>";
				voteFormList += "		            </ul> ";
			
			}		
			*/
			model.addAttribute("voteFormList", voteFormList);
			
			
			result = "/voteContent.jsp";
			
			return result;		
		}
		
	// 추가 ★
	// 알림 읽음 기능
	@RequestMapping(value = "/alarmRead.action", method = RequestMethod.GET)
	public String alarmRead(String num, Model model, String title)
	{
		IAlarmDAO dao = sqlSession.getMapper(IAlarmDAO.class);
		
		if(title.contains("퇴장") || title.contains("삭제"))
		{
			dao.alarmReadExit(num);
		}
		else if(title.contains("패스"))
		{
			dao.alarmReadHP(num);
		}
		else if(title.contains("북마크"))
		{
			dao.alarmReadMark(num);
		}
		else if(title.contains("출발 가능"))
		{
			dao.alarmReadGoAlarm(num);
		}
		else if(title.contains("출발"))
		{
			dao.alarmReadMFG(num);
		}
		else if(title.contains("여행 점수"))
		{
			dao.alarmReadMF(num);
		}
		else if(title.contains("피드 신고 패널티"))
		{
			dao.alarmReadFRP(num);
		}
		else if(title.contains("컬렉션 메모 신고 패널티"))
		{
			dao.alarmReadCRP(num);
		}
		else if(title.contains("플래너 메모 신고 패널티"))
		{
			dao.alarmReadPMRP(num);
		}
		else if(title.contains("방 신고 패널티"))
		{
			dao.alarmReadRPP(num);
		}
		else if(title.contains("프로필 신고 패널티"))
		{
			dao.alarmReadPFRP(num);
		}
		else if(title.contains("불참 신고 패널티"))
		{
			dao.alarmReadNJRP(num);
		}
		else if(title.contains("피드 신고"))
		{
			dao.alarmReadFRR(num);
		}
		else if(title.contains("컬렉션 메모 신고"))
		{
			dao.alarmReadCRR(num);
		}
		else if(title.contains("플래너 메모 신고"))
		{
			dao.alarmReadPMRR(num);
		}
		else if(title.contains("방 신고"))
		{
			dao.alarmReadRRR(num);
		}
		else if(title.contains("프로필 신고"))
		{
			dao.alarmReadPFRR(num);
		}
		
		model.addAttribute("alarm", "dd");
		
		return "Alarm.jsp";
		
	}

	// 픽스 여부 확인
	@RequestMapping(value = "/dayisfix.action", method = RequestMethod.GET)
	public String dayIsFix(String day, Model model, String room_num)
	{
		IRoomDAO dao = sqlSession.getMapper(IRoomDAO.class);
		
		String result = dao.isFix(room_num, Integer.parseInt(day));
		
		model.addAttribute("result", result);
		
		return "IsFix.jsp";
		
	}	
	
	// 여행 점수 부여
	@RequestMapping(value = "/triprate.action", method = RequestMethod.GET)
	public String tripRate(String mem_finish_num, Model model, String score, HttpSession session, String room_num)
	{
		IRoomDAO dao = sqlSession.getMapper(IRoomDAO.class);
		
		String id = (String)session.getAttribute("id");
		String my_id = dao.findIdNum(id);
		String give_mem_join_num = dao.findJoinNum(my_id, room_num);
		
		System.out.println(give_mem_join_num);
		System.out.println(mem_finish_num);
		System.out.println(score);
		
		dao.tripScoreAdd(give_mem_join_num, mem_finish_num, score);
		
		return "redirect:roomlist.action";
		
	}	  
	
	// 플래너 순서 변경
	@RequestMapping(value = "/ordermove.action", method = RequestMethod.GET)
	public String orderMove(String num, String p,String day,Model model, HttpSession session)
	{
		IRoomDAO dao = sqlSession.getMapper(IRoomDAO.class);
		
		String room_num = (String)session.getAttribute("room_num");
		String result = "";
		
		RoomMemberDTO dto = null;
		for(RoomMemberDTO order : dao.plannerLocMemoSel(num, room_num,day))
		{
			if(order.getLoc_memo_num().equals(num))
			{
				dto = order;
			}
		}
		
		String loc_memo_num = num;
		
		int order = Integer.parseInt(dto.getSequence());
		
		String preNum = dto.getPrenum();
		String nextNum = dto.getNextnum();
		int preOrder = 0;
		int nextOrder = 0;
		
		result = "planner.action?page=1&room_num="+room_num;
		
		// up
		if(p.equals("u"))
		{
			if(preNum == null)
			{
				return result;
			}
			else
			{
				preOrder = Integer.parseInt(dto.getPreorder());
				
				if(loc_memo_num.substring(5,6).equals("L"))
				{
					dao.plannerLocUpdate(preOrder, loc_memo_num);
				}
				else
				{
					dao.plannerMemoUpdate(preOrder, loc_memo_num);
				}
				
				
				if(preNum.substring(5,6).equals("L"))
				{
					dao.plannerLocUpdate(order, preNum);
				}
				else
				{
					dao.plannerMemoUpdate(order, preNum);
				}
			}
		}
		// down
		else if(p.equals("d"))
		{
			if(dto.getNextnum() == null)
			{
				return result;
			}
			else
			{
				nextOrder = Integer.parseInt(dto.getNextorder());
				
				if(loc_memo_num.substring(5,6).equals("L"))
				{
					dao.plannerLocUpdate(nextOrder, loc_memo_num);
				}
				else
				{
					dao.plannerMemoUpdate(nextOrder, loc_memo_num);
				}
				
				
				if(nextNum.substring(5,6).equals("L"))
				{
					dao.plannerLocUpdate(order, nextNum);
				}
				else
				{
					dao.plannerMemoUpdate(order, nextNum);
				}
				
			}
		}
		
		return result;
		
	}	  
	
	
	
}
