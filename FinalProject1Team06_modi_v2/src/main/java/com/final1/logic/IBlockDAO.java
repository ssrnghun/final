/*======================
 	ISampleDAO.java
 	- 인터페이스
========================*/

package com.final1.logic;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

public interface IBlockDAO
{
	public ArrayList<blockDTO> blockList(String id);
	public int blockCancle(@Param("blockedId") String blockedId, @Param("id")String id);
	public int count(String id);
}
