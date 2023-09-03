/*===================================
	PlannerLocMemoDTO.java
	- 세부일정 및 메모 출력용 DTO
===================================*/

package com.final1.logic;

/*
SELECT PLANNER_LOC_NUM AS LOC_MEMO_NUM, ROOM_NUM, DAY, SEQUENCE, LOC_NAME AS LOC_CONTENT, MAP_LAT, MAP_LNG
FROM PLANNER_LOC
WHERE ROOM_NUM = 'ROOM-00001'
UNION ALL
SELECT PLANNER_MEMO_NUM, ROOM_NUM, DAY, SEQUENCE, CONTENT, NULL,  NULL
FROM PLANNER_MEMO
WHERE ROOM_NUM = 'ROOM-00001'
ORDER BY DAY, SEQUENCE
*/

public class PlannerLocMemoDTO
{
	// 주요 속성 구성
	private String loc_memo_num, room_num, day, sequence, loc_content, map_lat, map_lng,checkfix;
	
	private String mem_join_num, write_date;
	
	
	// getter / setter 구성
	
	public String getLoc_memo_num()
	{
		return loc_memo_num;
	}

	public String getMem_join_num()
	{
		return mem_join_num;
	}

	public void setMem_join_num(String mem_join_num)
	{
		this.mem_join_num = mem_join_num;
	}

	public String getWrite_date()
	{
		return write_date;
	}

	public void setWrite_date(String write_date)
	{
		this.write_date = write_date;
	}

	public String getCheckfix()
	{
		return checkfix;
	}

	public void setCheckfix(String checkfix)
	{
		this.checkfix = checkfix;
	}

	public String getMap_lat()
	{
		return map_lat;
	}

	public void setMap_lat(String map_lat)
	{
		this.map_lat = map_lat;
	}

	public String getMap_lng()
	{
		return map_lng;
	}

	public void setMap_lng(String map_lng)
	{
		this.map_lng = map_lng;
	}

	public void setLoc_memo_num(String loc_memo_num)
	{
		this.loc_memo_num = loc_memo_num;
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

	public String getSequence()
	{
		return sequence;
	}

	public void setSequence(String sequence)
	{
		this.sequence = sequence;
	}

	public String getLoc_content()
	{
		return loc_content;
	}

	public void setLoc_content(String loc_content)
	{
		this.loc_content = loc_content;
	}
	
	
}
