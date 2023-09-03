package com.final1.logic;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class FindController
{
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping(value = "findidform.action")
	public String findIdform()
	{
		return "/WEB-INF/view/Find_ID_Form.jsp";
	}
	
	@RequestMapping(value = "findidadminform.action")
	public String findIdAdmin()
	{
		return "/WEB-INF/view/Find_ID_Form_Admin.jsp";
	}
	
	@RequestMapping(value = "findid.action")
	public String findId(FindDTO dto, Model model)
	{
		String result = "";
		
		IFindDAO dao = sqlSession.getMapper(IFindDAO.class);
		
		String id = dao.findId(dto);
		
		int count = dao.count(dto);
		
		String str = "";
		
		if (count == 1)
		{
			str = "회원님의 아이디는 " + id + "입니다.";
		}
		else if (count == 0)
		{
			str = "입력하신 정보와 일치하는 회원 아이디가 존재하지 않습니다.";
		}
		
		model.addAttribute("str", str);
		result = "/WEB-INF/view/Find_ID_Form.jsp";
		
		return result;
	}
	
	@RequestMapping(value = "findidadmin.action")
	public String findIdAdmin(FindDTO dto, Model model)
	{
		String result = "";
		
		IFindDAO dao = sqlSession.getMapper(IFindDAO.class);
		
		String id = dao.findIdAdmin(dto);
		
		int count = dao.adminCount(dto);
		
		String str = "";
		
		if (count == 1)
		{
			str = "관리자님의 아이디는 " + id + "입니다.";
		}
		else if (count == 0)
		{
			str = "입력하신 정보와 일치하는 관리자 아이디가 존재하지 않습니다.";
		}
		
		model.addAttribute("str", str);
		result = "/WEB-INF/view/Find_ID_Form_Admin.jsp";
		
		return result;
	}
	
	@RequestMapping(value = "findpwform.action")
	public String findPwForm()
	{
		return "/WEB-INF/view/Find_PW_Form.jsp";
	}
	
	@RequestMapping(value = "findpwadminform.action")
	public String findPwFormAdmin()
	{
		return "/WEB-INF/view/Find_PW_Form_Admin.jsp";
	}
	
	@RequestMapping(value = "findpw.action")
	public String findPw(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		String id = request.getParameter("id");
		String ssn = request.getParameter("ssn");
		
		IFindDAO dao = sqlSession.getMapper(IFindDAO.class);
		
		FindDTO dto = new FindDTO();
		
		dto.setId(id);
		dto.setSsn(ssn);
		
		request.setAttribute("pwCount", dao.pwCount(dto));
		
		return "FindPw.jsp";
	}
	
	@RequestMapping(value = "findpwadmin.action")
	public String findPwAdmin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		String id = request.getParameter("id");
		String ssn = request.getParameter("ssn");
		
		IFindDAO dao = sqlSession.getMapper(IFindDAO.class);
		
		FindDTO dto = new FindDTO();
		
		dto.setId(id);
		dto.setSsn(ssn);
		
		request.setAttribute("pwCount", dao.pwCountAdmin(dto));
		
		return "FindPwAdmin.jsp";
	}
	
	@RequestMapping(value = "updatepw.action")
	public String findUpdatePw(FindDTO dto)
	{
		String result = "";
		
		IFindDAO dao = sqlSession.getMapper(IFindDAO.class);
		
		dao.findUpdatePw(dto);
		
		result = "redirect:loginform.action";
		
		return result;
	}
	
	@RequestMapping(value = "updatepwadmin.action")
	public String findUpdatePwAdmin(FindDTO dto)
	{
		String result = "";
		
		IFindDAO dao = sqlSession.getMapper(IFindDAO.class);
		
		dao.findUpdatePwAdmin(dto);
		
		result = "redirect:adminloginform.action";
		
		return result;
	}
	
	
	
	
}
