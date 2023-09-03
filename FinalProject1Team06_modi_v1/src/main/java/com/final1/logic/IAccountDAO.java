/*====================
   ISampleDAO.java
   - 인터페이스
====================*/

package com.final1.logic;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

public interface IAccountDAO
{
	public ArrayList<AccountDTO> AccountList(String room_num);
	public ArrayList<AccountDTO> AccountListSel(@Param("room_num") String room_num,
			@Param("day") String day);
	
	public int totalCost(String room_num);
	public int dayCost(@Param("room_num") String room_num,@Param("day") String day);
	
	public RoomDTO planner(String room_num);
	public ArrayList<AccountDTO> sumCost(String room_num);
	
	public int AccountAdd(AccountDTO dto);
	public int memPayAdd(AccountDTO dto);
	public int memWithAdd(AccountDTO dto);
	
	public int accountDel(String pay_num);
	
	public ArrayList<AccountDTO> payCal(String pay_num);
	public ArrayList<AccountDTO> giveMem(String pay_num);
	public ArrayList<AccountDTO> takeMem(String pay_num);
	public int takeMemCount(String pay_num);
	public ArrayList<AccountDTO> payNum(String room_num);
	public ArrayList<AccountDTO> payMemJoin(String room_num);
	
	public String findNikname(String id_num);
	
	
	
}
