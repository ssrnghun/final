package com.final1.logic;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class FeedController
{
	@Autowired
	private SqlSession sqlSession;
	
	/*
	@RequestMapping(value = "feed.action")
	public String feedList(Model model, HttpServletRequest request)
	{
		String result = "";
		
		IFeedDAO dao = sqlSession.getMapper(IFeedDAO.class);
		
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		//Boolean processed = (Boolean)session.getAttribute("processed");
		
		FeedDTO dto = new FeedDTO();
		dto.setId(id);	
		
		FeedDTO dto2 = dao.searchId(dto);
		
		// 추후 방에 참여할 때 구현되게 수정 → 방 참여 컨트롤러에 구문 추가하고 여기서는 삭제
		// 다른 방에 들어간다면 세션 처리 때문에 구문 실행이 안됨.. 다른 방법 모색
		
		if (processed == null || !processed) 
		{
	        dao.addContentInto(id);
	        session.setAttribute("processed", true);
	    }
	    
		//dao.addContentInto(id);
		
		IRoomDAO dao3 = sqlSession.getMapper(IRoomDAO.class);

		String room_num = "ROOM-00001";
		String my_real_id = "hj002";
		//String my_id = dao.findIdNum(my_real_id);
		String my_id = "ID-00050";
		
		//model.addAttribute("room_num", room_num);
		//model.addAttribute("my_id", my_id);
		
		session.setAttribute("room_num", room_num);
		session.setAttribute("myId", my_id);
		session.setAttribute("my_real_id", my_real_id);
		
		String memMax = dao3.planner(my_id, room_num).getMem_max();
		String memCurr = dao3.planner(my_id, room_num).getMem_curr();
		String allReady = dao3.allReady(room_num);
		ArrayList<PlannerLocMemoDTO> plannerLocMemo = dao3.plannerLocMemo(room_num);
		
		if (allReady == null)
		{
			allReady = "0";
		}
		
		String canGo = "";
		
		if (Integer.parseInt(memMax) == Integer.parseInt(memCurr) && Integer.parseInt(allReady) + 1 >= Integer.parseInt(memCurr))
			canGo = "OK";
		
		model.addAttribute("planner", dao3.planner(my_id, room_num));
		model.addAttribute("roomMembers", dao3.roomMembers(room_num));
		//model.addAttribute("myId", my_id);
		model.addAttribute("canGo", canGo);
		model.addAttribute("plannerLocMemo", plannerLocMemo);
		
		 result = "/scheduleList.jsp"; 
		
		
		model.addAttribute("dto", dto2);
		model.addAttribute("feedList", dao.feedList());
		
		result = "/WEB-INF/view/Feed.jsp";
		
		return result;
	}
	*/
	@RequestMapping(value = "insertcontent.action")
	public void feedAdd(HttpServletRequest request, String content, HttpServletResponse response, String room_num) throws IOException
	{
		IFeedDAO dao = sqlSession.getMapper(IFeedDAO.class);
		IRoomDAO dao2 = sqlSession.getMapper(IRoomDAO.class);
		
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		
		FeedDTO dto = new FeedDTO();
		dto.setId(id);
		dto.setContent(content);
		dto.setIdNum(dao2.findIdNum(id));
		dto.setRoomNum(room_num);
		
		dao.addContent(dto);
		
		String html = FeedContentAjax.addContent(dao.feedList(room_num), id);
	      
		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(html);
		
	}
	
	@RequestMapping(value = "deletefeed.action")
	public String deleteFeed(String feedNum, String room_num)
	{
		String result = "";
		
		IFeedDAO dao = sqlSession.getMapper(IFeedDAO.class);
		
		dao.removeContent(feedNum);
		
		result = "redirect:planner.action?page=0&room_num="+room_num;
		
		return result;
	}
}
