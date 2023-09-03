/*============================
	IBookmarkDAO.java
	- DAO 인터페이스
============================*/

package com.final1.logic;

import java.util.ArrayList;

public interface IBookmarkDAO
{	
	// 북마크 조회
	public int select(BookMarkDTO dto);
	
	// 북마크 추가 
	public int add(BookMarkDTO dto); 
	
	// 북마크 삭제 
	public int remove(BookMarkDTO dto);
	
	public ArrayList<RoomListDTO> list(String id);
}
