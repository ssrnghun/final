/*=============================
   StatisticsController.java
=============================*/

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
public class StatisticsController
{
	@Autowired
	private SqlSession sqlSession;
	
	// 통계 selectbox 옵션 선택 바꿀 때
	@RequestMapping(value = "statistic.action", method = RequestMethod.GET)
	public String statisticsList(Model model, String option, String style, HttpServletRequest request)
	{
		String result = "";
		
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		
		IStatisticsDAO dao = sqlSession.getMapper(IStatisticsDAO.class);
		
		String statisticStr ="";
		
		// 구글 차트에 담을 JSON 문자열 생성
		if(option.equals("2")) // 지역
		{
			statisticStr= CalStatistics.CalRegion(dao,id);
		}
		else if(option.equals("3")) // 스타일
		{
			statisticStr = CalStatistics.CalStyle(dao, style,id);
		}
		else // 횟수
		{
			statisticStr = CalStatistics.CalCount(dao,id);
			System.out.println("왔다감");
		}
		
		model.addAttribute("statisticStr", statisticStr);
		
		// 마이페이지 요청에 여행 통계 분류 및 여행 스타일 옵션 넘기기
		result = "redirect:mypage1.action?option="+option+"&style="+style;
		
		return result;
	}
}
