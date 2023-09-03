package com.final1.logic;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AdminLoginController
{
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping(value = "adminloginform.action")
	public String adminLoginForm()
	{
		return "/WEB-INF/view/AdminLogin.jsp";
	}
	
	@RequestMapping(value = "adminlogin.action")
	public String adminLogin(LoginDTO dto, Model model, HttpServletRequest request)
	{
		String result = "";
		
		ILoginDAO dao = sqlSession.getMapper(ILoginDAO.class);
		
		int adminCount = dao.adminLogin(dto);
		
		// 관리자 로그인
		String str = "";
		
		if (adminCount == 1)
		{
			HttpSession session = request.getSession();
			session.setAttribute("adminId", dto.getId());
			// 회원관리 페이지로 이동
			result = "redirect:memberlist.action";
		}
		else
		{
			str = "계정 정보가 일치하지 않습니다.";
			model.addAttribute("str", str);
			
			result = "/WEB-INF/view/AdminLogin.jsp";
		}
		
		return result;
	}
}
