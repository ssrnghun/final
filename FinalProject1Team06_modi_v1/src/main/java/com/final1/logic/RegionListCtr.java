/*=====================================
	RegionListCtr.java
	- mybatis 객체 활용(Controller)
=====================================*/


package com.final1.logic;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class RegionListCtr
{
	@Autowired
	private SqlSession sqlSession;
	// 지역 검색 하는 기능
	@RequestMapping(value = "/regionsearch.action", method = RequestMethod.GET)
	public String regionFind(Model model, @RequestParam("tripSearch") String tripSearch)
	{
		// 검색값 확인
		System.out.println("tripSearch : " + tripSearch);
		
		
		IRegionDAO dao = sqlSession.getMapper(IRegionDAO.class);
		
		// 검색된 지역 리스트 확인 
		System.out.println(dao.regionSearch(tripSearch).get(0).getRegionName());
		ArrayList<RegionDTO> list = dao.regionSearch(tripSearch);
		
		
		String str = "";
		
		// 출력부분 반복문 돌리기  
		for (RegionDTO dto : list)
		{
			str +="<input type='radio' class='btn-check' name='options-outlined' id='"+dto.getRegion_num()+"' autocomplete='off' >"
		               + "<label class='btn btn-outline-success' for='"+dto.getRegion_num()+"'>"+dto.getRegionName()+"</label> ";
			
		}
		
		model.addAttribute("str", str);
		
		return "RegionSelect.jsp";
	}
	
}
