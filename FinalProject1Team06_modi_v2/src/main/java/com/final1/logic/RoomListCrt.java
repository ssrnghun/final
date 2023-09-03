/*=====================================
   RoomListCrt.java
   - mybatis 객체 활용(Controller)
=====================================*/

package com.final1.logic;



import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.final1.util.MyUtil;


@Controller
public class RoomListCrt
{   
   @Autowired
   private SqlSession sqlSession;
   
   
   // 방 개설하기 페이지 호출
   @RequestMapping(value = "/room_make.action", method = RequestMethod.GET)
   public String roomMake() // String id
   {   
      return "/WEB-INF/view/User_roomMake.jsp";
   }
   
   
   // 방 개설
   @RequestMapping(value = "buildroom.action")
   public String buildRoom(RoomListDTO dto, HttpServletRequest request)
   {
      String result = "";
      
      IRoomListDAO dao = sqlSession.getMapper(IRoomListDAO.class);

      HttpSession session = request.getSession();
      String id = (String)session.getAttribute("id");
      
      String id_num = dao.selectIdNum(id);
      dto.setId_num(id_num); 
      
      String room_num = dto.getRoom_num();
      dao.addRoom(dto);
      dao.memJoinAdd(id_num);
      dao.ongoingAdd(id_num);
      
      if (dto.getPw_code() != null)
      {
		dao.addPw(dto);
      }
      
      IFeedDAO dao2 = sqlSession.getMapper(IFeedDAO.class);

      FeedDTO dto2 = new FeedDTO();
      
      dto2.setId(id);
      dto2.setIdNum(id_num);
      dto2.setRoomNum(dao.findRoomNum(id_num)); 
      
      // 피드에 참여하였습니다 추가
        dao2.addContentInto(dto2);
      
      
      // 추후 플래너로 변경
      result = "redirect:roomlist.action";
      
      return result;
   }
   
   
   
   // 여행 스타일 모드 저장 및 수정 
   @RequestMapping(value = "/mode_save.action", method = RequestMethod.GET)
   public String modeSave(HttpServletRequest request,@RequestParam("plan_num") String plan_num,@RequestParam("money_option_num") String money_option_num, @RequestParam("stay_type_num") String stay_type_num
          ,@RequestParam("traffic_num") String traffic_num, @RequestParam("cycle_num") String cycle_num, @RequestParam("pace_num") String pace_num,@RequestParam("desti_type_num") String desti_type_num,@RequestParam("to_do_num") String to_do_num
          ,@RequestParam("to_see_num") String to_see_num, @RequestParam("food_num") String food_num, @RequestParam("meal_count_num") String meal_count_num, @RequestParam("supply_num") String supply_num, @RequestParam("photo_num") String photo_num
          ,@RequestParam("mode_name") String mode_name)
   {
      String result = "";
      
      // session 에 있는 id 로 mem_num 을 구하는 쿼리문을 짜서.....
      // "" mem_num = 위 쿼리문 결과
      
      IRoomListDAO dao = sqlSession.getMapper(IRoomListDAO.class);
      
      // 저장 및 수정 잘됐는지 확인을 위한 변수 생성
      int result1 = 0;
      int result2 = 0;
      
      HttpSession session = request.getSession();
      String id = (String)session.getAttribute("id");
      
      String id_num = dao.selectIdNum(id);
      String mem_num = dao.selectMemNum(id_num);
      
      
      // 사용자 당 모드의 갯수 
      int modeCount = dao.modeCount(mem_num, mode_name);
      System.out.println(modeCount);
      
     
      // 처음 모드를 저장할 때 
      if (modeCount == 0)
      {
         // 사용자가 선택한 해당 모드 옵션 저장 
         result1 = dao.modeAdd(mem_num, plan_num, money_option_num, stay_type_num, traffic_num, cycle_num, pace_num
               ,desti_type_num, to_do_num, to_see_num, food_num, meal_count_num, supply_num, photo_num, mode_name);
      }
      // 기존 모드를 수정할 때 
      else if (modeCount == 1)
      {   
         // 사용자가 선택한 해당 모드 옵션 업데이트
         result2 = dao.modeUpdate(plan_num, money_option_num, stay_type_num, traffic_num, cycle_num, pace_num
               , desti_type_num, to_do_num, to_see_num, food_num, meal_count_num, supply_num, photo_num, mem_num, mode_name);
      }
      
      
      System.out.println(result1 + "데이터 첫 저장 성공");
      System.out.println(result2 + "데이터 업데이트 성공");
      
      result = "redirect:roomlist.action";
      
      return result; 
   }
   
   
   // 여행 스타일 모드 조회 
   @RequestMapping(value = "/mode_select.action", method = RequestMethod.GET)
   public String modeSelect(Model model, HttpServletRequest request,@RequestParam("mode_name") String mode_name)
   {
      String result = "";
      
      //System.out.println(mem_num);
      //System.out.println(mode_name);
      
      IRoomListDAO dao = sqlSession.getMapper(IRoomListDAO.class);
      
      HttpSession session = request.getSession();
      String id = (String)session.getAttribute("id");
      
      String id_num = dao.selectIdNum(id);
      String mem_num = dao.selectMemNum(id_num);
      
      if(dao.modeCount(mem_num, mode_name) == 0)
      {
    	  model.addAttribute("result", "1");
    	  result = "ModeSelResult.jsp";
      }
      else
      {
    	  model.addAttribute("modeSelect",dao.modeSelect(mem_num, mode_name));
    	  result = "ModeSelect.jsp";
      }
      
      return result;
   }
   
   
   // 비공개 방 비번 조회 
   @RequestMapping(value = "/pw_check.action", method = RequestMethod.GET)
   public String pwCheck(Model model,RoomListDTO dto)
   {
      String result = "";
      IRoomListDAO dao = sqlSession.getMapper(IRoomListDAO.class);
      
      model.addAttribute("pwRoom", dao.pwRoom(dto));
      System.out.println("비밀번호 맞으면 1번을 외쳐 ~ : " + dao.pwRoom(dto));
      
      result = "pwCount.jsp";
      
      return result;
   }
   
   
   // 방 조회 및 검색 합친 구문 
   @RequestMapping(value = "/roomlist.action", method = RequestMethod.GET)
   public String searchRoom(Model model,@RequestParam(value = "sort", required = false, defaultValue = "1") String sort, RoomListDTO dto,
          HttpServletRequest request)
   {
      String result = "";
      IRoomListDAO dao = sqlSession.getMapper(IRoomListDAO.class);
      
      HttpSession session = request.getSession();
      String id = (String)session.getAttribute("id");
      System.out.println("RoomListCrt 에서 확인하는 아이디세션 : " + id);
      
      String id_num = dao.selectIdNum(id);
      
      int dataCount = dao.searchListCount(id_num, sort, dto);
      
      model.addAttribute("count", dataCount);
      
      MyUtil myUtil = new MyUtil();
      
      int numPerPage = 5;            
      int totalPage = myUtil.getPageCount(numPerPage, dataCount);
      
      System.out.println("제목 : " + dto.getRoom_title());
      System.out.println("계획옵션번호 : " + dto.getPlan_onoff_num());
      System.out.println("비공개방옵션 : " + dto.getRoom_onoff_name());
      System.out.println("성별제한 : " + dto.getGender_limit_num());
      System.out.println("연령제한 : " + dto.getAge_limit_num());
      System.out.println("지역번호 : " + dto.getRegion_num());
      System.out.println("최소금액: " + dto.getBudget_min());
      System.out.println("최대금액: " + dto.getBudget_max());
      System.out.println("여행시작일 : " + dto.getTrip_start_date());
      System.out.println("여행종료일 : " + dto.getTrip_end_date());
      
      model.addAttribute("searchList", dao.searchList(id_num, sort, dto));
      
      model.addAttribute("sortList", sort);
      
      // 추가
      IAlarmDAO dao3 = sqlSession.getMapper(IAlarmDAO.class);
	
      String my_id= id_num;
		model.addAttribute("alarmList", dao3.alarmList(my_id));
		model.addAttribute("alarmCount", dao3.alarmCount(my_id));
      
      result = "/WEB-INF/view/User_roomListPage.jsp";
      return result;
   }
   
}