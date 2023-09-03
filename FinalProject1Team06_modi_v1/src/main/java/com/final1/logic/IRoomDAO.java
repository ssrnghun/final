/*============================
	IRoomListDAO.java
	- DAO 인터페이스
============================*/

package com.final1.logic;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

public interface IRoomDAO
{
	public RoomDTO planner(@Param("my_id") String my_id, @Param("room_num") String room_num);
	public ArrayList<RoomMemberDTO> roomMembers(@Param("room_num") String room_num);
	public int ready(@Param("choice") String choice, @Param("my_id") String my_id, @Param("room_num") String room_num);
	public RoomMemberDTO isReady(@Param("my_id") String my_id, @Param("room_num") String room_num);
	public String allReady(@Param("room_num") String room_num);
	public int go(@Param("room_num") String room_num);
	public String searchBookmark(@Param("my_id") String my_id, @Param("room_num") String room_num);
	public int addBookmark(@Param("my_id") String my_id, @Param("room_num") String room_num);
	public int removeBookmark(@Param("my_id") String my_id, @Param("room_num") String room_num);
	public int readyAlarm(@Param("my_id") String my_id, @Param("room_num") String room_num);
	public int memberPlus(@Param("room_num") String room_num);
	public int memberMinus(@Param("room_num") String room_num);
	public String goCheck(@Param("room_num") String room_num);
	public int removeMember(@Param("idNum") String idNum, @Param("room_num") String room_num);
	public int insertExitMember(@Param("idNum") String idNum, @Param("room_num") String room_num, @Param("reason") int reason);
	public ArrayList<PlannerLocMemoDTO> plannerLocMemo(@Param("room_num") String room_num);
	public ArrayList<PlannerLocMemoDTO> plannerLocMemoDay(@Param("room_num") String room_num, @Param("day") int day);
	public String findIdNum(String my_real_id);
	public String compareDate(@Param("startDate") String startDate, @Param("endDate") String endDate, @Param("my_real_id") String my_real_id);
	public int memJoin(@Param("id_num") String id_num, @Param("room_num") String room_num);
	public int ongoing(@Param("id_num") String id_num, @Param("room_num") String room_num);
	public int addMemo(@Param("content") String content, @Param("room_num") String room_num, @Param("day") String day);
	public int addPlan(@Param("title") String title, @Param("lat") String lat, @Param("lng") String lng, @Param("room_num") String room_num, @Param("day") String day);
	public int removePlan(@Param("loc_memo_num")String loc_memo_num);
	public int removeMemo(@Param("loc_memo_num")String loc_memo_num);
	public int changeReady(@Param("room_num")String room_num);
	public int addHostPass(@Param("room_num")String room_num, @Param("day")int day);
	public int isHostPassDay(@Param("room_num")String room_num, @Param("day")int day);
	public int removeHostPass(@Param("room_num")String room_num, @Param("day")int day);
	
	
	// 추가 ★★★★★★
	public ArrayList<RoomMemberDTO> hostpassList(@Param("room_num")String room_num);
	public ArrayList<RoomMemberDTO> memPassList(@Param("room_num")String room_num, @Param("my_id") String my_id);
	public int isMemPass(@Param("room_num")String room_num, @Param("my_id") String my_id,@Param("day") int day);
	public int addMemPass(@Param("room_num")String room_num, @Param("my_id") String my_id,@Param("day") int day);
	public int removeMemPass(@Param("room_num")String room_num, @Param("my_id") String my_id,@Param("day") int day);
	public String isFix(@Param("room_num")String room_num,@Param("day") int day);
	public int addFix(@Param("room_num")String room_num,@Param("day") int day);
	public RoomMemberDTO hostPassCheck(@Param("room_num")String room_num);
	public ArrayList<RoomMemberDTO> memPassCheck(@Param("room_num")String room_num, @Param("day") int day);
	public int roomDel(@Param("room_num")String room_num);
	public ArrayList<String> ongoingMemCheck(@Param("room_num")String room_num);
	public int ongoingDel(@Param("room_num")String room_num);
	public int roomDelExit(@Param("mem_join_num")String mem_join_num);
	public int fixCount(@Param("room_num")String room_num);
	public int modiPlace(PlannerLocMemoDTO dto);
	public int modiMemo(PlannerLocMemoDTO dto);
	public RoomMemberDTO menuBarInfo(String my_id);
	public int bookmarkDel(String room_num);
	public RoomDTO searchRoom(String room_num);
	public int modifyRoom(RoomDTO dto);
	public String findJoinNum(@Param("my_id") String my_id, @Param("room_num") String room_num);
	public ArrayList<PlannerLocMemoDTO> collectionList(String room_num);
	public ArrayList<PlannerLocMemoDTO> myCollectionList(@Param("my_id") String my_id, @Param("room_num") String room_num);
	public int addMemoCollection(@Param("content") String content, @Param("room_num") String room_num, @Param("my_id") String my_id);
	public int addCollection(@Param("title") String title, @Param("lat") String lat, @Param("lng") String lng, @Param("room_num") String room_num, @Param("my_id") String my_id);
	public int removeCollection(String loc_memo_num);
	public int removeCollectionMemo(String loc_memo_num);
	public int modifyCollection(PlannerLocMemoDTO dto);
	public int modifyCollectionMemo(PlannerLocMemoDTO dto);
	public int dayCal(String room_num);
	
	
	public ArrayList<CollectionDTO> myCheckList(@Param("my_id") String my_id, @Param("room_num") String room_num);
	public int deleteCheckList(@Param("my_id") String my_id, @Param("room_num") String room_num, @Param("chklist_num") String chklist_num);
	public int insertCheckList(@Param("my_id") String my_id, @Param("room_num") String room_num, @Param("chklist_cnt") String chklist_cnt);
	
	public ArrayList<VotesDTO> voteslist(@Param("room_num") String room_num);
	public ArrayList<VotesDTO> voteform(@Param("vote_num") String vote_num);
	public ArrayList<VoteCateDTO> votecatelist(@Param("vote_num") String vote_num);
	
	//추가 
	public ArrayList<String> ogMemJoin(String room_num);
	public int finAdd(String mem_join_num);
	public int hostPassAlarmAdd(@Param("my_id") String my_id, @Param("room_num") String room_num);
	public ArrayList<BookMarkDTO> bookMarkList(String room_num);
	public int bookMarkAlarm(String bookMarkNum);
	public int goAlarm(String room_num);
	public int allFix(String room_num);
	public ArrayList<RoomMemberDTO> tripScoreMate(@Param("room_num") String room_num, @Param("my_id") String my_id);
	public int tripScoreAdd(@Param("give_mem_join_num") String give_mem_join_num, @Param("mem_finish_num") String mem_finish_num , @Param("score") String score);
	public int finMemCount(@Param("my_id") String my_id, @Param("room_num") String room_num);
	public int tsCount(@Param("my_id") String my_id, @Param("room_num") String room_num);
	public int exitCount(@Param("id_num") String id_num, @Param("room_num") String room_num);
	public ArrayList<RoomMemberDTO> plannerLocMemoSel(@Param("num") String num,@Param("room_num") String room_num,@Param("day") String day);
	
	public int plannerLocUpdate(@Param("sequence") int sequence, @Param("num") String num);
	public int plannerMemoUpdate(@Param("sequence") int sequence, @Param("num") String num);
}
