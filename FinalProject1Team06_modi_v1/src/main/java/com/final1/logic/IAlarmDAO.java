/*====================
   ISampleDAO.java
   - 인터페이스
====================*/

package com.final1.logic;

import java.util.ArrayList;

public interface IAlarmDAO
{
	public ArrayList<AlarmDTO> alarmList(String my_id);
	public int alarmCount(String my_id);
	
	public int alarmReadExit(String num);
	public int alarmReadHP(String num);
	public int alarmReadMark(String num);
	public int alarmReadGoAlarm(String num);
	public int alarmReadMF(String num);
	public int alarmReadMFG(String num);
	
	public int alarmReadFRR(String num);
	public int alarmReadCRR(String num);
	public int alarmReadPMRR(String num);
	public int alarmReadRRR(String num);
	public int alarmReadPFRR(String num);
	
	public int alarmReadRPP(String num);
	public int alarmReadFRP(String num);
	public int alarmReadPMRP(String num);
	public int alarmReadCRP(String num);
	public int alarmReadPFRP(String num);
	public int alarmReadNJRP(String num);
}
