/*============================
	IRegionDAO.java
	- DAO 인터페이스
============================*/

package com.final1.logic;

import java.util.ArrayList;

public interface IRegionDAO
{
	// 지역 검색 (사용자 검색)
	public ArrayList<RegionDTO> regionSearch(String tripSearch);
}
