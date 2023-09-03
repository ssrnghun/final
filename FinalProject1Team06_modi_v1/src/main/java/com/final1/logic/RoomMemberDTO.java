/*============================
	RoomListDTO.java
	- 방 멤버 출력용 DTO
============================*/

package com.final1.logic;

public class RoomMemberDTO
{
	// 주요 속성 구성
	private String ongoing_num, mem_join_num, id_num, room_num, photo, nickname, age, ready, id, passdelcheck, pass_date,room_title;
					
	private String day, checkFix, checkPass;
	private int hostCount, memCount;
	// 추가 ★
	private String mem_finish_num, loc_memo_num,sequence, prenum, nextnum, preorder, nextorder;

	// getter / setter 구성
	
	
	public String getDay()
	{
		return day;
	}

	public String getLoc_memo_num()
	{
		return loc_memo_num;
	}

	public void setLoc_memo_num(String loc_memo_num)
	{
		this.loc_memo_num = loc_memo_num;
	}

	public String getSequence()
	{
		return sequence;
	}

	public void setSequence(String sequence)
	{
		this.sequence = sequence;
	}

	public String getPrenum()
	{
		return prenum;
	}

	public void setPrenum(String prenum)
	{
		this.prenum = prenum;
	}

	public String getNextnum()
	{
		return nextnum;
	}

	public void setNextnum(String nextnum)
	{
		this.nextnum = nextnum;
	}

	public String getPreorder()
	{
		return preorder;
	}

	public void setPreorder(String preorder)
	{
		this.preorder = preorder;
	}

	public String getNextorder()
	{
		return nextorder;
	}

	public void setNextorder(String nextorder)
	{
		this.nextorder = nextorder;
	}

	public String getMem_finish_num()
	{
		return mem_finish_num;
	}

	public void setMem_finish_num(String mem_finish_num)
	{
		this.mem_finish_num = mem_finish_num;
	}

	public String getRoom_title()
	{
		return room_title;
	}

	public void setRoom_title(String room_title)
	{
		this.room_title = room_title;
	}

	public String getPass_date()
	{
		return pass_date;
	}

	public void setPass_date(String pass_date)
	{
		this.pass_date = pass_date;
	}

	public String getPassdelcheck()
	{
		return passdelcheck;
	}

	public void setPassdelcheck(String passdelcheck)
	{
		this.passdelcheck = passdelcheck;
	}

	public String getId()
	{
		return id;
	}

	public void setId(String id)
	{
		this.id = id;
	}

	public String getCheckPass()
	{
		return checkPass;
	}

	public void setCheckPass(String checkPass)
	{
		this.checkPass = checkPass;
	}

	public String getCheckFix()
	{
		return checkFix;
	}

	public void setCheckFix(String checkFix)
	{
		this.checkFix = checkFix;
	}

	public void setDay(String day)
	{
		this.day = day;
	}
	public int getHostCount()
	{
		return hostCount;
	}

	public void setHostCount(int hostCount)
	{
		this.hostCount = hostCount;
	}

	public int getMemCount()
	{
		return memCount;
	}

	public void setMemCount(int memCount)
	{
		this.memCount = memCount;
	}

	public String getReady()
	{
		return ready;
	}

	public void setReady(String ready)
	{
		this.ready = ready;
	}

	public String getOngoing_num()
	{
		return ongoing_num;
	}

	public void setOngoing_num(String ongoing_num)
	{
		this.ongoing_num = ongoing_num;
	}

	public String getMem_join_num()
	{
		return mem_join_num;
	}

	public void setMem_join_num(String mem_join_num)
	{
		this.mem_join_num = mem_join_num;
	}

	public String getId_num()
	{
		return id_num;
	}

	public void setId_num(String id_num)
	{
		this.id_num = id_num;
	}

	public String getRoom_num()
	{
		return room_num;
	}

	public void setRoom_num(String room_num)
	{
		this.room_num = room_num;
	}

	public String getPhoto()
	{
		return photo;
	}

	public void setPhoto(String photo)
	{
		this.photo = photo;
	}

	public String getNickname()
	{
		return nickname;
	}

	public void setNickname(String nickname)
	{
		this.nickname = nickname;
	}

	public String getAge()
	{
		return age;
	}

	public void setAge(String age)
	{
		this.age = age;
	}

}
