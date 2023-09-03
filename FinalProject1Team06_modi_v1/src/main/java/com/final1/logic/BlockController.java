/*======================
 	Sample.java
 	- 컨트롤러 객체
========================*/

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
public class BlockController
{
	@Autowired
	private SqlSession sqlSession;
	
	// 차단 리스트 페이지 요청
	@RequestMapping(value = "blocklist.action", method = RequestMethod.GET)
	public String blockList(HttpServletRequest request, Model model)
	{
		String result = "";
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id"); 
		System.out.println(id);
		
		IBlockDAO dao = sqlSession.getMapper(IBlockDAO.class);
		
		// 차단 계정 리스트 
		model.addAttribute("list", dao.blockList(id));
		
		System.out.println(dao.blockList(id).get(0).getReason());
		
		
		// 차단 계정 인원수
		model.addAttribute("count", dao.count(id));
		
		result = "/WEB-INF/view/BlockList.jsp";
		
		return result;
			
	}
	
	// 차단 취소
	@RequestMapping(value = "blockcancle.action", method = RequestMethod.GET)
	public String blockCancle(HttpServletRequest request, String blockedId)
	{
		String result = "";
		
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id"); 
		
		IBlockDAO dao = sqlSession.getMapper(IBlockDAO.class);
		
		// 차단 취소
		dao.blockCancle(blockedId,id);
		
		// 마이페이지 요청
		result = "redirect:mypage1.action";
		
		return result;
	}
	
	
}
