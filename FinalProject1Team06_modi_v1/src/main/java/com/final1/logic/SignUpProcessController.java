package com.final1.logic;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class SignUpProcessController
{
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping(value = "signupprocess.action")
	public String signUpProcess(SignUpDTO dto,Model model)
	{
		String result = "";
		
		ISignUpDAO dao = sqlSession.getMapper(ISignUpDAO.class);
		
		int ssnCheck = dao.ssnCheck(dto.getSsn());

		if (ssnCheck >= 1)
		{
			model.addAttribute("ssnCheck", ssnCheck);
			result = "/WEB-INF/view/SignUp.jsp";
		}
		else
		{
			dao.memberRegi(dto);
			String id = dto.getId();
			String idNum = dao.searchId(id);
			
			dto.setIdNum(idNum);
			dao.memberAdd(dto);
			result = "redirect:loginform.action";
		}

		return result;
	}
	
	

}
