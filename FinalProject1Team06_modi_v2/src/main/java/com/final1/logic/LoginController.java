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
public class LoginController
{
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping(value = "loginform.action")
	public String loginform()
	{
		return "/WEB-INF/view/UserLogin.jsp";
	}
	
	@RequestMapping(value = "mypage.action")
	public String myPage()
	{
		return "/WEB-INF/view/MyPage.jsp";
	}
	
	@RequestMapping(value = "login.action", method = RequestMethod.GET)
	public String login(LoginDTO dto, HttpServletRequest request, Model model)
	{
		String result = "";
		
		ILoginDAO dao = sqlSession.getMapper(ILoginDAO.class);
		IFindLimitDAO dao2 = sqlSession.getMapper(IFindLimitDAO.class);
		
		// 계정정지 리스트에 값이 있을 때
		if(dao2.limitCount(dto) == 1)
		{
			// 계정정지 리스트 담기
			model.addAttribute("endDate", dao2.findLimit1(dto));
			model.addAttribute("total", dao2.total(dto));
			model.addAttribute("count", dao2.limitCount(dto));
			model.addAttribute("list", dao2.findLimitList(dto));
			model.addAttribute("useStart", dao2.UseStart(dto));
			
			result = "/WEB-INF/view/UserLogin.jsp";
		}
		else // 계정정지 리스트에 값이 없을 때
		{
			// 사용자 로그인
			int res = dao.login(dto);
			String str = "";
			
			// 사용자 로그인 성공 시
			if (res == 1)
			{
				HttpSession session = request.getSession();
				session.setAttribute("id", dto.getId());
				//마이페이지 이동 (추후 룸리스트로 변경)
				
				// 추가 ★★★★★
				// 진행 중 방 중에 여행 종료일이 지난 방 table delete
				dao.ongoingDel(dto.getId());
				
				result = "/roomlist.action";
				//result = "/WEB-INF/view/Feed.jsp";
			}
			// 사용자 로그인 실패 시
			else
			{
				str = "계정 정보가 일치하지 않습니다.";
				model.addAttribute("str", str);
				// 로그인 페이지로 이동
				result = "/WEB-INF/view/UserLogin.jsp";
			}
			
		}
		
		return result;
		
	}
}
