/*=======================
   - 인터페이스
=======================*/

package com.final1.logic;

import java.util.ArrayList;

public interface IStatisticsDAO
{
	// 여행 횟수별 통계
	public ArrayList<StatisticsDTO> list1(String id);
	
	// 여행 지역별 통계
	public ArrayList<StatisticsDTO> list2(String id);
	
	// 여행 스타일별 통계
	public StatisticsDTO plan(String id);
	public StatisticsDTO moneyoption(String id);
	public StatisticsDTO staytype(String id);
	public StatisticsDTO traffic(String id);
	public StatisticsDTO cycle(String id);
	public StatisticsDTO pace(String id);
	public StatisticsDTO desti(String id);
	public StatisticsDTO todo(String id);
	public StatisticsDTO tosee(String id);
	public StatisticsDTO food(String id);
	public StatisticsDTO mealcount(String id);
	public StatisticsDTO supply(String id);
	public StatisticsDTO photo(String id);
}
