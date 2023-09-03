/*======================
 	Sample.java
 	- 컨트롤러 객체
========================*/

package com.final1.logic;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MyPageController
{
	@Autowired
	private SqlSession sqlSession;
	
	// 마이페이지 페이지 요청 
	@RequestMapping(value = "mypage1.action", method = RequestMethod.GET)
	public String memberList(Model model, HttpServletRequest request, String option,String style)
	{
		String result = "";
		String statisticStr = "";
		
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		
		IMyPageDAO dao1 = sqlSession.getMapper(IMyPageDAO.class);
		IBookmarkDAO dao2 = sqlSession.getMapper(IBookmarkDAO.class);
		IStatisticsDAO dao3 = sqlSession.getMapper(IStatisticsDAO.class);
		
		// 계정 닉네임, 사진 정보 
		model.addAttribute("info", dao1.info(id));
		
		model.addAttribute("etiScore",dao1.etiScore(id));
		// 계정 여행 점수
		model.addAttribute("tripScore", dao1.tripScore(id));
		// 차단한 계정 정보
		model.addAttribute("block",dao1.block(id));
		
		// 북마크 리스트 
		model.addAttribute("bookmark",dao2.list(id));
		// 참여중인 방 리스트
		model.addAttribute("joinroom",dao1.joinRooms(id));
		// 완료한 방 리스트
		model.addAttribute("finroom", dao1.finRooms(id));
		
		// 통계 분류 선택 안했을 때
		if(option!=null)
		{
			// statisticsController 로부터 넘겨받은 값
			statisticStr = request.getParameter("statisticStr");
		}
		
		model.addAttribute("statisticStr", statisticStr);
		
		// statisticsController 에서 받아온 통계분류 및 여행스타일 옵션 값
		model.addAttribute("option", option);
		model.addAttribute("style", style);
		
		result = "/WEB-INF/view/MyPage.jsp";
		
		return result;
		
	}
	// 로그아웃
	@RequestMapping(value = "logout.action", method = RequestMethod.GET)
	public String logout(HttpServletRequest request)
	{
		String result = "";
		HttpSession session = request.getSession();
		session.removeAttribute("id");
		
		// id 같이 넘기기
		result = "redirect:loginform.action";
		
		return result;
	}
	
	// 회원 정보 수정 페이지 요청
	@RequestMapping(value = "infomodify.action", method = RequestMethod.GET)
	public String infoModify(Model model, HttpServletRequest request)
	{
		String result = "";
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id"); 
		
		IMyPageDAO dao = sqlSession.getMapper(IMyPageDAO.class);
		// 로그인 계정의 정보 가져오기
		model.addAttribute("info", dao.searchId(id));
		
		// id 같이 넘기기
		result = "/WEB-INF/view/InfoModify.jsp?id="+id;
		
		return result;
	}
	
	// 현재 비밀번호 확인
	@RequestMapping(value = "pwcheck1.action")
	public String pwCheck1(String pwNow,Model model, HttpServletRequest request) throws ServletException, IOException
	{
		String str ="";
		IMyPageDAO dao = sqlSession.getMapper(IMyPageDAO.class);
		
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id"); 
	
		// 입력한 비밀번호가 현재 비밀번호와 일치하는지 확인
		if(dao.pwCorrect1(pwNow, id)==1)
			str = "비밀번호 변경 가능합니다. 새로운 비밀번호를 입력해주세요.";
		else
			str = "비밀번호가 일치하지 않습니다.";
		
		model.addAttribute("result", str);
		
		return "PwCheck.jsp";
		
	}
	
	// 비밀번호 변경
	@RequestMapping(value = "pwmodify.action")
	public String pwModify(@RequestParam("newPw")String newPw, Model model, HttpServletRequest request) throws ServletException, IOException
	{
		String result ="";
		String str ="";
		
		IMyPageDAO dao = sqlSession.getMapper(IMyPageDAO.class);
		
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id"); 
		
		// 비밀번호가 변경되었을 때
		if(dao.pwModify(newPw,id)==1)
			str = "비밀번호가 변경되었습니다.";
		
		model.addAttribute("str", str);
		
		result ="PwModify.jsp";
		
		return result;
	}
	
	// 닉네임 중복 확인
	@RequestMapping(value = "nikcheck.action")
	public void nikCheck(String nikname, Model model, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		String str ="";
		IMyPageDAO dao = sqlSession.getMapper(IMyPageDAO.class);
		
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id"); 

		// 입력한 닉네임이 존재하지 않을 때
		if(dao.nikCheck(nikname,id)==0)
			str = "변경 가능한 닉네임입니다.";
		else
			str = "이미 존재하는 닉네임입니다.";
		
		model.addAttribute("str", str);
		
		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(str);
		//return "nikCheck.jsp";
	}
	
	// 탈퇴 전 비밀번호 확인
	@RequestMapping(value = "pwcheck2.action")
	public String pwCheck2(String pwSg, Model model, HttpServletRequest request) throws ServletException, IOException
	{
		
		String str ="";
		IMyPageDAO dao = sqlSession.getMapper(IMyPageDAO.class);
		
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id"); 
		
		// 탈퇴 전 비밀번호 확인
		if(dao.pwCorrect2(pwSg,id)==1)
		{
			Map<String, String> testMap = new HashMap<String, String>();

			// 매개변수 지정
			testMap.put("V_ID", id);
			
			// 리턴값 지정
			testMap.put("V_RESULT", "");
			
			// 프로시저 시행 : 퇴장 여부 확인, 완료된 여행 여부 확인
			dao.PRC_MEMBER_TAL_CHECK(testMap);

			// 리턴값 추출
			if( testMap.get("V_RESULT") != null && !"".equals(testMap.get("V_RESULT").toString()) )
			{
				str = testMap.get("V_RESULT").toString();
			}
		}
		else
			str = "비밀번호가 일치하지 않습니다.";
		
		model.addAttribute("result", str);
		
		return "PwCheck.jsp";
		
	}
	
	// 탈퇴 
	@RequestMapping(value = "leave.action")
	public String leave(HttpServletRequest request) throws ServletException, IOException
	{
		
		String result ="";
		IMyPageDAO dao = sqlSession.getMapper(IMyPageDAO.class);
		
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id"); 
		
		// 해당 계정 정보 가져오기
		MyPageDTO dto = dao.searchId(id); 
		
		Map<String, String> testMap = new HashMap<String, String>();
		
		// 매개변수 지정
		testMap.put("V_ID", id); 
		testMap.put("V_ID_NUM", dto.getIdNum());
		testMap.put("V_NAME", dto.getName());
		testMap.put("V_SSN", dto.getSsn());
	
		// 프로시저 시행 : 일반회원 데이터 DELETE -> 탈퇴회원 INSERT
		dao.PRC_MEMBER_TAL(testMap);

		// 세션 지우기
		session.removeAttribute("id");
		
		result ="redirect:loginform.action"; // 로그인 페이지로 이동 
		
		return result;
	}
	
	// 정보수정 
	@RequestMapping(value = "infoupdate.action", method = RequestMethod.GET)
	public String infoUpdate(MyPageDTO dto, HttpServletRequest request)
	{
		String result = "";
		
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		
		dto.setId(id);
		
		IMyPageDAO dao = sqlSession.getMapper(IMyPageDAO.class);
		
		dao.totalUpdate(dto);
		
		result = "redirect:mypage1.action"; // 마이페이지로 이동
		
		return result;
	}
	
	
	
	
	/* 사진 보류 .... ㅜㅜㅜ 
	@RequestMapping(value ="photoupdate.action", method = RequestMethod.POST)
	public String updatePhoto(@RequestParam("f") MultipartFile file,@RequestParam("photo") String photo, HttpServletRequest request, Model model) 
	{	
		String result = "";
		String filePath ="";
			
		
	
		
		File dir = new File(savePath);
		if(!dir.exists())
			dir.mkdirs();
		
		
		String encType = "UTF-8";
		int maxFileSize = 5*1024*1024;
		
		MultipartRequest req = null;
		
		String result="";
		String srcName ="";
		System.out.println(file);
		System.out.println(photo);
		
		try
		{
				String uploadPath =request.getServletContext().getRealPath("/")+"images\\";
				System.out.println(uploadPath);
			 
				String fileName = file.getOriginalFilename();
				// srcName = "images/"+file.getOriginalFilename();
				
				 Path filePath = Paths.get(uploadPath).resolve(fileName);
			        Resource resource = new UrlResource(filePath.toUri());

			       
				 
				 
				 
				File targetFile = new File(uploadPath + fileName);

				// 파일을 업로드할 경로에 저장
				//file.transferTo(targetFile);
				
				//String id= (String)session.getAttribute("id");
				IMyPageDAO dao = sqlSession.getMapper(IMyPageDAO.class);
				
				int result1 = dao.updatePhoto(srcName);
				System.out.println(result1);
				srcName ="images/non_profile.jpg";
			
			model.addAttribute("srcName", srcName);
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		result = "UpdatePhoto.jsp";
				
		return result;
		
	}
	*/
	
	// 사진 보류 ...
	/*
	@RequestMapping(value ="photoupdate.action", method = RequestMethod.POST)
	  public void getDownloadUrl(@RequestParam("filename") String filename, HttpServletResponse response) 
	  {
	    try {
	            // 파일이 저장된 경로
	            String uploadPath = "/path/to/upload/directory/";
	
	            // 파일 다운로드를 위한 URL 생성
	            String downloadUrl = "/download?filename=" + filename;
	
	            // 다운로드 URL을 HTTP 응답 헤더에 추가
	            response.setHeader("Download-URL", downloadUrl);
	        }
	    catch (Exception e) {
	            // 예외 처리
	            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
	        }
	    }
	    */
	
	
}
