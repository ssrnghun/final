package com.final1.logic;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class PersonalPageController
{
	@Autowired
	private SqlSession sqlSession;
	
	// 개인페이지 요청 
	// 수정 ★★★★★
	@RequestMapping(value = "personalpage.action", method = RequestMethod.GET)
	public String memberList(Model model, String etiId, String str, HttpSession session)
	{
		String result = "";
		
		IMyPageDAO dao1 = sqlSession.getMapper(IMyPageDAO.class);
		
		// 계정 닉네임, 사진, 성별 정보 
		model.addAttribute("info", dao1.info(etiId));
		// 계정 에티켓 점수
		model.addAttribute("etiScore",dao1.etiScore(etiId));
		// 계정 여행 점수
		model.addAttribute("tripScore", dao1.tripScore(etiId));
		
		// 참여중인 방 리스트
		model.addAttribute("joinroom",dao1.joinRooms(etiId));
		
		// 개인페이지 계정 아이디
		model.addAttribute("etiId", etiId);
		
		model.addAttribute("str", str);
		
		// 추가 ★
		model.addAttribute("room_num", session.getAttribute("room_num"));
		
		result = "/WEB-INF/view/PersonalPage.jsp";
		
		return result;
	}
	
	// 에티켓 점수 부여 
	@RequestMapping(value = "etirate.action", method = RequestMethod.GET)
	public String etiRate(Model model, HttpServletRequest request, String etiId, String score)
	{
		String result = "";
		
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		
		MyPageDTO dto = new MyPageDTO();
		
		int scoreInt=0;
		scoreInt = Integer.parseInt(score.substring(0, 1));
		
		dto.setEtiId(etiId);
		dto.setId(id);
		dto.setScore(scoreInt);
		
		
		System.out.println(etiId);
		System.out.println(id);
		System.out.println(scoreInt);
		IPersonalPageDAO dao = sqlSession.getMapper(IPersonalPageDAO.class);
		
		String str = "";
		if(dao.etiCount(dto) != 0)
		{
			str = "오늘 이미 점수를 부여하였습니다.";
		}
		else
		{
			int res = dao.etiScore(dto);
			if(res >0)
				str = "점수를 부여하였습니다.";
		}
		
		model.addAttribute("str", str);
		
		result = "EtiScore.jsp";
		return result;
	}
	
	// 프로필 신고 접수
	@RequestMapping(value = "pfreport.action", method = RequestMethod.GET)
	public String pfReport(Model model, HttpServletRequest request, ReportDTO dto)
	{
		String result ="";
		HttpSession session = request.getSession();
		String reporterId = (String)session.getAttribute("id");
		
		//dto.setReporterId(reporterId);
		dto.setReporterId(reporterId);	// 임의의 값
		String id = dto.getReportedId();
		
		IPersonalPageDAO dao = sqlSession.getMapper(IPersonalPageDAO.class);
		
		int res = dao.pfReport1(dto);
		System.out.println(res);
		
		String str="";
		if(res==1)
		{
			str = "신고 접수가 완료되었습니다.";
		}
		model.addAttribute("str", str);
		
		result = "redirect:personalpage.action?etiId="+id;
		return result;
	}
	
	// 차단
	// 수정 ★★★★
	@RequestMapping(value = "block.action", method = RequestMethod.GET)
	public String blcok(Model model, HttpServletRequest request, blockDTO dto)
	{
		String result ="";
		HttpSession session = request.getSession();
		String blockerId = (String)session.getAttribute("id");
		
		IRoomDAO dao2 = sqlSession.getMapper(IRoomDAO.class);
		
		//dto.setBlockerId(blockerId);
		
		dto.setBlockerId(blockerId);	// 임의의 값 ★
		
		String blockerIdNum = dao2.findIdNum(blockerId);
		String blockedIdNum = dao2.findIdNum(dto.getBlockedId());
		
		IPersonalPageDAO dao = sqlSession.getMapper(IPersonalPageDAO.class);
		int check = dao.blockCheck(blockedIdNum, blockerIdNum);
		
		// 참여중인 방이 겹치는것이 없을 때
		if(check == 0)
		{
			int res1 = dao.block(dto);
			
			if(res1>0)
			{
				int res2 = dao.etiDel(dto);
				int res3 = dao.tripDel(dto);
			}
			result = "redirect:planner.action?room_num="+dto.getRoom_num(); 
		}
		else 
		{
			model.addAttribute("str", "함께 참여중인 방이 있으므로 차단할 수 없습니다.");
			result = "redirect:personalpage.action?etiId="+dto.getBlockedId();
		}
		
		return result;
	}
	
	
	
}