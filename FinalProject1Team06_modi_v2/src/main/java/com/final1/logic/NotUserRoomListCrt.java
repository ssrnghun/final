/*=====================================
	RoomListCrt.java
	- mybatis 객체 활용(Controller)
=====================================*/

package com.final1.logic;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.final1.util.MyUtil;




@Controller
public class NotUserRoomListCrt
{
	@Autowired
	private SqlSession sqlSession;
	
	// ★★★★★★★ 비 회 원 ★★★★★★★★★★
	
	// 비회원 방 조회 및 검색 합친 구문 
	@RequestMapping(value = "not_roomlist.action", method = RequestMethod.GET)
	public String searchRoom(Model model,@RequestParam(value = "sort", required = false, defaultValue = "1") String sort, NotUserRoomListDTO dto,
			
			@Param("pageNum") String pageNum)
	{
		String result = "";
		INotUserRoomListDAO dao = sqlSession.getMapper(INotUserRoomListDAO.class);
		
		int dataCount = 0;
		// 이전 페이지(?)로부터 넘어온 페이지 번호 수신
		int currentPage = 1;
		if(pageNum != null)
			currentPage = Integer.parseInt(pageNum);
		
		
		dataCount = dao.searchListCount(sort, dto);
		System.out.println("총 방 갯수 : " + dataCount);
		
		model.addAttribute("count", dataCount);
		
		MyUtil myUtil = new MyUtil();
		
		int numPerPage = 5;				
		int totalPage = myUtil.getPageCount(numPerPage, dataCount);
		
		if(currentPage > totalPage)
			currentPage = totalPage;
		
		int start = (currentPage-1) * numPerPage + 1;
		int end = currentPage * numPerPage;
		
		System.out.println("시작 : " + start);
		System.out.println("끝 : " + end);
		
		String param = "";
		
		System.out.println("제목 : " + dto.getRoom_title());
		System.out.println("계획옵션번호 : " + dto.getPlan_onoff_num());
		System.out.println("비공개방옵션 : " + dto.getRoom_onoff_name());
		System.out.println("성별제한 : " + dto.getGender_limit_num());
		System.out.println("연령제한 : " + dto.getAge_limit_num());
		System.out.println("지역번호 : " + dto.getRegion_num());
		System.out.println("최소금액: " + dto.getBudget_min());
		System.out.println("최대금액: " + dto.getBudget_max());
		System.out.println("여행시작일 : " + dto.getTrip_start_date());
		System.out.println("여행종료일 : " + dto.getTrip_end_date());
		
		model.addAttribute("searchList", dao.searchList(sort, dto, start, end));
		
		
		String listUrl = "not_roomlist.action" + param;
		String pageIndexList = myUtil.pageIndexList(currentPage, totalPage, listUrl);
		
		model.addAttribute("pageIndexList", pageIndexList);
		
		
		System.out.println("처리된 값 : " + dao.searchList(sort, dto, start, end).isEmpty());
		model.addAttribute("sortList", sort);
		
		
		result = "/WEB-INF/view/notUser_roomListPage.jsp";
		return result;
	}
	
	
}
