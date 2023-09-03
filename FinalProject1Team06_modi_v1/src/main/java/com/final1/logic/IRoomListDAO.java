/*============================
	IRoomListDAO.java
	- DAO 인터페이스
============================*/

package com.final1.logic;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

public interface IRoomListDAO
{	
	// 아이디를 통해 아이디 NUM 을 알 수 있는 메소드  
	public String selectIdNum(String id);
	
	
	// 아이디 NUM 을 통해 MEM_NUM 을 알 수 있는 쿼리문 
	public String selectMemNum(String id_num);
	
	// 룸 리스트 출력 및 정렬
	//public ArrayList<RoomListDTO> list(@Param("id_num") String id_num,@Param("sort") String sort);
	
	// 여행 스타일 모드 저장 
	public int modeAdd(@Param("mem_num") String mem_num, @Param("plan_num") String plan_num,@Param("money_option_num") String money_option_num, @Param("stay_type_num") String stay_type_num
		    ,@Param("traffic_num") String traffic_num, @Param("cycle_num") String cycle_num, @Param("pace_num") String pace_num,@Param("desti_type_num") String desti_type_num,@Param("to_do_num") String to_do_num
		    ,@Param("to_see_num") String to_see_num, @Param("food_num") String food_num, @Param("meal_count_num") String meal_count_num, @Param("supply_num") String supply_num, @Param("photo_num") String photo_num
		    , @Param("mode_name") String mode_name);
	
	// 여행 스타일 모드 업데이트 
	public int modeUpdate(@Param("plan_num") String plan_num,@Param("money_option_num") String money_option_num, @Param("stay_type_num") String stay_type_num
		    ,@Param("traffic_num") String traffic_num, @Param("cycle_num") String cycle_num, @Param("pace_num") String pace_num,@Param("desti_type_num") String desti_type_num,@Param("to_do_num") String to_do_num
		    ,@Param("to_see_num") String to_see_num, @Param("food_num") String food_num, @Param("meal_count_num") String meal_count_num, @Param("supply_num") String supply_num, @Param("photo_num") String photo_num
		    ,@Param("mem_num") String mem_num, @Param("mode_name") String mode_name);
	
	// 여행 스타일 모드 갯수 조회 
	public int modeCount(@Param("mem_num") String mem_num, @Param("mode_name") String mode_name);
	
	// 여행 스타일 모드 조회 
	public RoomListDTO modeSelect(@Param("mem_num") String mem_num, @Param("mode_name") String mode_name); 
	
	
	// 비공개 방 비번 조회 
	public int pwRoom(RoomListDTO dto);
	
	// 총 검색 및 페이지 조회 
	public ArrayList<RoomListDTO> searchList(@Param("id_num") String id_num,@Param("sort") String sort, @Param(value = "dto") RoomListDTO dto);
	
	// 총 방 갯수
	public int searchListCount(@Param("id_num") String id_num,@Param("sort") String sort, @Param(value = "dto") RoomListDTO dto);
	
	
	// 방 개설
	public int addRoom(RoomListDTO dto);
	
	// 비공개 방
	public int addPw(RoomListDTO dto);
	
	// 참여인원 테이블에 추가
	public int memJoinAdd(String id_num);
	// 진행중 테이블에 추가
	public int ongoingAdd(String id_num);
	
	
	public String findRoomNum(@Param("id_num") String id_num);
	
	
}
