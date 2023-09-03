/*=====================================
	BookmarkCtr.java
	- mybatis 객체 활용(Controller)
=====================================*/

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
public class BookMarkCtr
{	
	@Autowired
	private SqlSession sqlSession;
	
	
	// 북마크 조회하는 기능 
	@RequestMapping(value = "/selectmark.action", method = RequestMethod.POST)
	public String BMSelect(HttpServletRequest request, Model model, BookMarkDTO dto)
	{
		String result = "";
		
		IBookmarkDAO dao = sqlSession.getMapper(IBookmarkDAO.class);
		IRoomListDAO dao1 = sqlSession.getMapper(IRoomListDAO.class);
		
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		String idNum = dao1.selectIdNum(id);
		
		dto.setIdNum(idNum);
		
		int count = dao.select(dto);
		System.out.println("count :" + count);
		int resultCount = 0;
		//String str = "";
		
		if (count == 0)
		{
			resultCount = dao.add(dto);
			System.out.println("북마크 추가! :" + resultCount);
			//str += "<i class=\"bi-bookmark-fill\" id=\"bookmark\"></i>";
		}
		else if (count == 1)
		{
			resultCount = dao.remove(dto);
			System.out.println("북마크 제거! : " + resultCount);
			//str += "<i class=\"bi bi-bookmark\" id=\"bookmark\"></i>";
		}
		
		model.addAttribute("count",count);
		//model.addAttribute("str",str);
		result = "/bookmarkStr.jsp";
		
		return result;
	}
	
}
