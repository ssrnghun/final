package com.final1.logic;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.final1.util.MyUtil;


@Controller
public class AdminController
{
	@Autowired
	private SqlSession sqlSession;
	
	// 회원 리스트 출력
	@RequestMapping(value = "memberlist.action")
	public String memberList(Model model, HttpServletRequest request,@Param("pageNum") String pageNum
			, @Param("searchKey")String searchKey, @Param("searchValue")String searchValue) 
					throws UnsupportedEncodingException
	{
		String result = "";
		
		IAdminDAO dao = sqlSession.getMapper(IAdminDAO.class);
		
		int dataCount = 0;
		// 이전 페이지(?)로부터 넘어온 페이지 번호 수신
		int currentPage = 1;
		if(pageNum != null)
			currentPage = Integer.parseInt(pageNum);
		
		
		if(searchValue != null)			
		{
			if(request.getMethod().equalsIgnoreCase("GET"))  
			{
				searchValue = URLDecoder.decode(searchValue, "UTF-8");		
			}
			dataCount = dao.searchMemberCount(searchKey, searchValue);			
		}
		else
		{
			dataCount = dao.count();
		}
		model.addAttribute("count", dataCount);
		
		MyUtil myUtil = new MyUtil();
		
		int numPerPage = 10;				
		int totalPage = myUtil.getPageCount(numPerPage, dataCount);
		
		if(currentPage > totalPage)
			currentPage = totalPage;
		
		int start = (currentPage-1) * numPerPage + 1;
		int end = currentPage * numPerPage;
		
		String param = "";
		
		if(searchValue == null)			
		{
			model.addAttribute("list", dao.memberList(start, end));
		}
		else
		{
			model.addAttribute("list", dao.searchMemberList(searchKey, searchValue, start, end));
			param += "?searchKey=" + searchKey;
			param += "&searchValue=" + searchValue;
		}
		
		String listUrl = "memberlist.action" + param;
		String pageIndexList = myUtil.pageIndexList(currentPage, totalPage, listUrl);
		
		model.addAttribute("pageIndexList", pageIndexList);
		model.addAttribute("searchKey", searchKey);
		model.addAttribute("searchValue", searchValue);
		
		
		result = "/WEB-INF/view/MemberList.jsp";
		
		return result;
	}
	
	// 전체 패널티 현황 출력
	@RequestMapping(value = "penaltylist.action")
	public String penaltyList(Model model, @Param("pageNum") String pageNum
			, @Param("searchKey")String searchKey, @Param("searchValue")String searchValue
			, HttpServletRequest request)
					throws UnsupportedEncodingException
	{
		
		IAdminDAO dao = sqlSession.getMapper(IAdminDAO.class);
		
		int dataCount = 0;
		// 이전 페이지(?)로부터 넘어온 페이지 번호 수신
		int currentPage = 1;
		if(pageNum != null)
			currentPage = Integer.parseInt(pageNum);
		
		
		if(searchValue != null)			
		{
			if(request.getMethod().equalsIgnoreCase("GET")) 
			{
				searchValue = URLDecoder.decode(searchValue, "UTF-8");		
			}
			
			dataCount = dao.searchPenaltyCount(searchKey, searchValue);		
		}
		else
		{
			dataCount = dao.penaltyCount();
		}
		model.addAttribute("count", dataCount);
		
		MyUtil myUtil = new MyUtil();
		
		int numPerPage = 10;				
		int totalPage = myUtil.getPageCount(numPerPage, dataCount);
		
		if(currentPage > totalPage)
			currentPage = totalPage;
		
		int start = (currentPage-1) * numPerPage + 1;
		int end = currentPage * numPerPage;
		
		// 페이징 처리
		String param = "";
		
		// 실제 리스트 가져오기
		if(searchValue == null)			
		{
			model.addAttribute("list", dao.penaltyList(start, end));
		}
		else
		{
			model.addAttribute("list", dao.searchPenaltyList(searchKey, searchValue, start, end));
			System.out.println( dao.searchPenaltyList(searchKey, searchValue, start, end).isEmpty());
			param += "?searchKey=" + searchKey;
			param += "&searchValue=" + searchValue;
			System.out.println(searchKey + searchValue);
			model.addAttribute("searchKey", searchKey);
			model.addAttribute("searchValue", searchValue);
		}
		
		
		String listUrl = "penaltylist.action" + param;
		String pageIndexList = myUtil.pageIndexList(currentPage, totalPage, listUrl);
		
		model.addAttribute("pageIndexList", pageIndexList);
		
		return "/WEB-INF/view/PenaltyList.jsp";
	}
	
	// 전체 신고 현황 출력
	@RequestMapping(value = "reportlist.action")
	public String reportList(Model model, @Param("pageNum") String pageNum
			, @Param("searchKey")String searchKey, @Param("searchValue")String searchValue
			, HttpServletRequest request)
					throws UnsupportedEncodingException
	{
		
		IAdminDAO dao = sqlSession.getMapper(IAdminDAO.class);
		
		int dataCount = 0;

		int currentPage = 1;
		if(pageNum != null)
			currentPage = Integer.parseInt(pageNum);
		
		
		if(searchValue != null)			
		{
			if(request.getMethod().equalsIgnoreCase("GET"))  
			{
				searchValue = URLDecoder.decode(searchValue, "UTF-8");	
			}
			
			dataCount = dao.searchReportCount(searchKey, searchValue);		
		}
		else
		{
			dataCount = dao.reportCount();
		}
		model.addAttribute("count", dataCount);
		
		MyUtil myUtil = new MyUtil();
		
		// 전체 데이터 갯수 구하기
		int numPerPage = 10;				
		int totalPage = myUtil.getPageCount(numPerPage, dataCount);
		if(currentPage > totalPage)
			currentPage = totalPage;
		
		// 데이터베이스에서 가져올 시작과 끝 위치
		int start = (currentPage-1) * numPerPage + 1;
		int end = currentPage * numPerPage;
		
		// 페이징 처리
		String param = "";
		
		if(searchValue == null)			
		{
			model.addAttribute("list", dao.reportList(start, end));
		}
		else
		{
			model.addAttribute("list", dao.searchReportList(searchKey, searchValue, start, end));
			param += "?searchKey=" + searchKey;
			param += "&searchValue=" + searchValue;
		}
		
		String listUrl = "reportlist.action" + param;
		String pageIndexList = myUtil.pageIndexList(currentPage, totalPage, listUrl);
		
		model.addAttribute("pageIndexList", pageIndexList);
		model.addAttribute("searchKey", searchKey);
		model.addAttribute("searchValue", searchValue);
		
		return "/WEB-INF/view/ReportList.jsp";
	}
	
	// 특정 인원의 신고 세부 현황
	@RequestMapping(value = "reportprocess.action")
	public String reportProcess(int num, Model model)
	{
		IAdminDAO dao = sqlSession.getMapper(IAdminDAO.class);
		
		ReportListDTO dto = dao.searchId(num);
		
		model.addAttribute("dto", dto);
		
		return "/WEB-INF/view/ReportProcess.jsp";
	}
	
	// 신고 처리
	@RequestMapping(value = "reportupdate.action")
	public String reportUpdate(ReportListDTO dto, HttpServletRequest request)
	{
		String result = "";
		
		IAdminDAO dao = sqlSession.getMapper(IAdminDAO.class);
		
		HttpSession session = request.getSession();
		String adminId = (String)session.getAttribute("adminId");
		
		String receiptNum = dto.getReceiptNum();
		int selectPenalty =	dto.getSelectPenalty();
		 
		// 신고처리하기전에..... 해당 신고 항목에 따라 해당 계정의 계정정지 여부 확인 
		// 계정정지 되어있으면 계정정지 끝나는날짜 확인 -> 패널티 시작일 : 계정정지 끝나는날짜 +1
		// 신고 처리 insert -> 패널티 insert
		
		// if (receiptNum 이 프로필이면서 selectPenalty 가 6일때), 피신고자 계정정지확인
		// else(selectPenalty 값이 2 일때, 신고자 계정정지 확인 
		// 						   7 일때, 피신고자 계정정지 확인
		
		String blockStart = "";
		String id = "";
		// receiptNum.equals("ROOM")
		// if 2			2
		// if 7			6
		
		if (receiptNum.equals("ROOM"))
		{
			if (selectPenalty == 2)
			{
				id = dto.getReporterId();
				blockStart = dao.checkStopId(id);
			}
			else if (selectPenalty == 7)
			{
				id = dto.getReportedId(); 
				blockStart = dao.checkStopId(id);
			}
			
			dto.setBlockStart(blockStart);
			dto.setAdminId(adminId);
			
			dao.addRoom(dto);
			dao.addRoomPenalty(dto);
		}
		else if (receiptNum.equals("COLLECTION"))
		{
			if (selectPenalty == 2)
			{
				id = dto.getReporterId();
				blockStart = dao.checkStopId(id);
			}
			else if (selectPenalty == 7)
			{
				id = dto.getReportedId(); 
				blockStart = dao.checkStopId(id);
			}
			
			dto.setBlockStart(blockStart);
			dto.setAdminId(adminId);
			
			dao.addCollectionMemo(dto);
			dao.addCollectionMemoPenalty(dto);
			
		}
		else if (receiptNum.equals("PLANMEMO"))
		{
			if (selectPenalty == 2)
			{
				id = dto.getReporterId();
				blockStart = dao.checkStopId(id);
			}
			else if (selectPenalty == 7)
			{
				id = dto.getReportedId(); 
				blockStart = dao.checkStopId(id);
			}
			
			dto.setBlockStart(blockStart);
			dto.setAdminId(adminId);
			
			dao.addPlannerMemo(dto);
			dao.addPlannerMemoPenalty(dto);
		}
		else if (receiptNum.equals("PROFILE"))
		{
			if (selectPenalty == 2)
			{
				id = dto.getReporterId();
				blockStart = dao.checkStopId(id);
			}
			else if (selectPenalty == 6)
			{
				id = dto.getReportedId(); 
				blockStart = dao.checkStopId(id);
			}
			
			dto.setBlockStart(blockStart);
			dto.setAdminId(adminId);
			
			dao.addProfile(dto);
			dao.addProfilePenalty(dto);
		}
		else if (receiptNum.equals("FEED"))
		{
			if (selectPenalty == 2)
			{
				id = dto.getReporterId();
				blockStart = dao.checkStopId(id);
			}
			else if (selectPenalty == 7)
			{
				id = dto.getReportedId(); 
				blockStart = dao.checkStopId(id);
			}
			
			dto.setBlockStart(blockStart);
			dto.setAdminId(adminId);
			
			dao.addFeed(dto);
			dao.addFeedPenalty(dto);
		}
		
		result = "redirect:reportlist.action";
		
		return result;
	}
}
