/*============================
	HostPassDTO.java
	- 방장 패스 출력용 DTO
============================*/

/*
SELECT HOST_PASS_NUM, ROOM_NUM, DAY, PASS_DATE
FROM HOST_PASS 
*/

package com.final1.logic;

public class HostPassDTO
{
	// 주요 속성 구성
	private String host_pass_num, room_num, day, pass_date;

	// getter / setter
	public String getHost_pass_num()
	{
		return host_pass_num;
	}

	public void setHost_pass_num(String host_pass_num)
	{
		this.host_pass_num = host_pass_num;
	}

	public String getRoom_num()
	{
		return room_num;
	}

	public void setRoom_num(String room_num)
	{
		this.room_num = room_num;
	}

	public String getDay()
	{
		return day;
	}

	public void setDay(String day)
	{
		this.day = day;
	}

	public String getPass_date()
	{
		return pass_date;
	}

	public void setPass_date(String pass_date)
	{
		this.pass_date = pass_date;
	}
	
	
}
