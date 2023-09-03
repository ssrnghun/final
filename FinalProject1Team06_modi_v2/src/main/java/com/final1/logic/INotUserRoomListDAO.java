/*============================
	IRoomListDAO.java
	- DAO 인터페이스
============================*/

package com.final1.logic;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.RequestParam;

public interface INotUserRoomListDAO
{	
	// 총 검색 및 페이지 조회 
	public ArrayList<IRoomListDAO> searchList(@Param("sort") String sort, @Param(value = "dto") NotUserRoomListDTO dto, @Param("start")int start, @Param("end")int end);
	
	// 총 방 갯수
	public int searchListCount(@Param("sort") String sort, @Param(value = "dto") NotUserRoomListDTO dto);
	
}
