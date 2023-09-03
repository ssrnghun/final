package com.final1.logic;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class IdCheckController
{
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping(value = "signup.action")
	public String signup(/* HttpServletRequest request, Model model */)
	{
		String result = "";
		
		/*
		 * String count =request.getParameter("count"); String id
		 * =request.getParameter("id"); String note=request.getParameter("note");
		 * 
		 * String checkNick = request.getParameter("checkNick"); String nick =
		 * request.getParameter("nick"); String str = request.getParameter("str");
		 * 
		 * model.addAttribute("count", count); model.addAttribute("id", id);
		 * model.addAttribute("note", note);
		 * 
		 * model.addAttribute("checkNick", checkNick); model.addAttribute("nick", nick);
		 * model.addAttribute("str", str);
		 */
		
		result = "/WEB-INF/view/SignUp.jsp";
		
		return result;
	}
	
	@RequestMapping(value = "idcheck.action")
	public void idCheck(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		
		String id = request.getParameter("id");
		
		IdCheckDAO dao = sqlSession.getMapper(IdCheckDAO.class);
		
		
		request.setAttribute("count", dao.count(id));
		 
		RequestDispatcher dispatcher = request.getRequestDispatcher("IdCheck.jsp");
		dispatcher.forward(request, response);
		
	}
	
	@RequestMapping(value = "checknickname.action")
	public void checkNick(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		String nickName = request.getParameter("nickName");
		
		IdCheckDAO dao = sqlSession.getMapper(IdCheckDAO.class);
		
		request.setAttribute("result", dao.checkNick(nickName));
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("NickNameCheck.jsp");
		dispatcher.forward(request, response);
	}
	
	/*
	 * @RequestMapping(value = "photoupdate.action", method = RequestMethod.POST)
	 * public String updatePhoto(HttpSession session,HttpServletRequest request,
	 * Model model) { String result = ""; String filePath ="";
	 * 
	 * String root ="/"; root = request.getServletContext().getRealPath(root);
	 * String savePath = root + "images";
	 * 
	 * 
	 * File dir = new File(savePath); if(!dir.exists()) dir.mkdirs();
	 * 
	 * String encType = "UTF-8"; int maxFileSize = 5*1024*1024;
	 * 
	 * MultipartRequest req = null;
	 * 
	 * result = "redirect:signup.action";
	 * 
	 * try { req = new MultipartRequest(request, savePath, maxFileSize, encType, new
	 * DefaultFileRenamePolicy()); String value = req.getParameter("photo");
	 * 
	 * if(value.equals("default")) filePath = "images/non_profile.jpg"; else
	 * if(value.equals("new")) filePath =
	 * "images/"+req.getFilesystemName("filePath"); else return result; }
	 * catch(Exception e) { System.out.println(e.toString()); }
	 * 
	 * model.addAttribute("filePath", filePath);
	 * 
	 * return result;
	 * 
	 * }
	 */
	/*
	 * @RequestMapping(value = "photoupdate.action", method = RequestMethod.POST)
	 * public ResponseEntity<String> updatePhoto(@RequestParam("photo")
	 * MultipartFile file, HttpSession session) { String root = "/"; root =
	 * session.getServletContext().getRealPath(root); String savePath = root +
	 * "/images";
	 * 
	 * System.out.println(savePath);
	 * 
	 * File dir = new File(savePath); if (!dir.exists()) { dir.mkdirs(); }
	 * 
	 * try { String value = file.isEmpty() ? "default" : "new"; String filePath;
	 * 
	 * if (value.equals("default")) { filePath = "images/non_profile.jpg"; } else if
	 * (value.equals("new")) { String fileName = file.getOriginalFilename(); String
	 * saveFileName = UUID.randomUUID().toString() + "_" + fileName; File saveFile =
	 * new File(savePath, saveFileName); file.transferTo(saveFile);
	 * 
	 * filePath = "images/" + saveFileName; } else { return
	 * ResponseEntity.badRequest().body("Invalid value"); }
	 * 
	 * return ResponseEntity.ok(filePath); } catch (Exception e) {
	 * System.out.println(e.toString()); return
	 * ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error occurred"
	 * ); } }
	 */
}
