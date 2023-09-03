package com.final1.logic;

// 통계 JSON 문자열 생성 클래스
public class CalStatistics
{
	// 월별 여행 횟수 데이터 담은 JSON 문자열
	public static String CalCount(IStatisticsDAO dao3, String id)
	{
		String statisticStr = "[";
		
		int size = dao3.list1(id).size();
		
			statisticStr +="[\"월\",";
			for(int i=0; i<size;i++)
			{
				statisticStr += "\""+dao3.list1(id).get(i).getYear()+"\"";
				
				if(i==(size-1))
				{
					statisticStr +="],";
					break;
				}
				statisticStr +=",";
			}
		
			statisticStr +="[\"1월\",";
			for(int i=0; i<size;i++)
			{
				
				statisticStr += dao3.list1(id).get(i).getJan();
				
				if(i==(size-1))
				{
					statisticStr +="],";
					break;
				}
				statisticStr +=",";
			}
			statisticStr +="[\"2월\",";
			for(int i=0; i<size;i++)
			{
				
				statisticStr += dao3.list1(id).get(i).getFeb();
				
				if(i==(size-1))
				{
					statisticStr +="],";
					break;
				}
				statisticStr +=",";
			}
			statisticStr +="[\"3월\",";
			for(int i=0; i<size;i++)
			{
				
				statisticStr += dao3.list1(id).get(i).getMar();
				
				if(i==(size-1))
				{
					statisticStr +="],";
					break;
				}
				statisticStr +=",";
			}
			statisticStr +="[\"4월\",";
			for(int i=0; i<size;i++)
			{
				
				statisticStr += dao3.list1(id).get(i).getApr();
				
				if(i==(size-1))
				{
					statisticStr +="],";
					break;
				}
				statisticStr +=",";
			}
			statisticStr +="[\"5월\",";
			for(int i=0; i<size;i++)
			{
				
				statisticStr += dao3.list1(id).get(i).getMay();
				
				if(i==(size-1))
				{
					statisticStr +="],";
					break;
				}
				statisticStr +=",";
			}
			statisticStr +="[\"6월\",";
			for(int i=0; i<size;i++)
			{
				
				statisticStr += dao3.list1(id).get(i).getJun();
				
				if(i==(size-1))
				{
					statisticStr +="],";
					break;
				}
				statisticStr +=",";
			}
			statisticStr +="[\"7월\",";
			for(int i=0; i<size;i++)
			{
				
				statisticStr += dao3.list1(id).get(i).getJul();
				
				if(i==(size-1))
				{
					statisticStr +="],";
					break;
				}
				statisticStr +=",";
			}
			statisticStr +="[\"8월\",";
			for(int i=0; i<size;i++)
			{
				
				statisticStr += dao3.list1(id).get(i).getAug();
				
				if(i==(size-1))
				{
					statisticStr +="],";
					break;
				}
				statisticStr +=",";
			}
			statisticStr +="[\"9월\",";
			for(int i=0; i<size;i++)
			{
				
				statisticStr += dao3.list1(id).get(i).getSept();
				
				if(i==(size-1))
				{
					statisticStr +="],";
					break;
				}
				statisticStr +=",";
			}
			statisticStr +="[\"10월\",";
			for(int i=0; i<size;i++)
			{
				statisticStr += dao3.list1(id).get(i).getOct();
				
				if(i==(size-1))
				{
					statisticStr +="],";
					break;
				}
				statisticStr +=",";
			}
			statisticStr +="[\"11월\",";
			for(int i=0; i<size;i++)
			{
				statisticStr += dao3.list1(id).get(i).getNov();
				
				if(i==(size-1))
				{
					statisticStr +="],";
					break;
				}
				statisticStr +=",";
			}
			statisticStr +="[\"12월\",";
			for(int i=0; i<size;i++)
			{
				statisticStr += dao3.list1(id).get(i).getDec();
				
				if(i==(size-1))
				{
					statisticStr +="]";
					break;
				}
				statisticStr +=",";
			}
		
		
		statisticStr += "]";
		
		return statisticStr;
	}
	
	// 지역별 통계 데이터 담은 JSON 문자열
	public static String CalRegion(IStatisticsDAO dao3, String id)
	{
		String statisticStr = "[";
		
		int size = dao3.list2(id).size();
		
			statisticStr +="[\"지역\",";
			for(int i=0; i<size;i++)
			{
				statisticStr += "\""+dao3.list2(id).get(i).getYear()+"\"";
				
				if(i==(size-1))
				{
					statisticStr +="],";
					break;
				}
				statisticStr +=",";
			}
		
			statisticStr +="[\"서울\",";
			for(int i=0; i<size;i++)
			{
				
				statisticStr += dao3.list2(id).get(i).getSeoul();
				
				if(i==(size-1))
				{
					statisticStr +="],";
					break;
				}
				statisticStr +=",";
			}
			statisticStr +="[\"부산\",";
			for(int i=0; i<size;i++)
			{
				
				statisticStr += dao3.list2(id).get(i).getBusan();
				
				if(i==(size-1))
				{
					statisticStr +="],";
					break;
				}
				statisticStr +=",";
			}
			statisticStr +="[\"인천\",";
			for(int i=0; i<size;i++)
			{
				
				statisticStr += dao3.list2(id).get(i).getIncheon();
				
				if(i==(size-1))
				{
					statisticStr +="],";
					break;
				}
				statisticStr +=",";
			}
			statisticStr +="[\"대구\",";
			for(int i=0; i<size;i++)
			{
				
				statisticStr += dao3.list2(id).get(i).getDaegu();
				
				if(i==(size-1))
				{
					statisticStr +="],";
					break;
				}
				statisticStr +=",";
			}
			statisticStr +="[\"대전\",";
			for(int i=0; i<size;i++)
			{
				
				statisticStr += dao3.list2(id).get(i).getDaejeon();
				
				if(i==(size-1))
				{
					statisticStr +="],";
					break;
				}
				statisticStr +=",";
			}
			statisticStr +="[\"광주\",";
			for(int i=0; i<size;i++)
			{
				statisticStr += dao3.list2(id).get(i).getGwangju();
				
				if(i==(size-1))
				{
					statisticStr +="],";
					break;
				}
				statisticStr +=",";
			}
			statisticStr +="[\"울산\",";
			for(int i=0; i<size;i++)
			{
				
				statisticStr += dao3.list2(id).get(i).getUlsan();
				
				if(i==(size-1))
				{
					statisticStr +="],";
					break;
				}
				statisticStr +=",";
			}
			statisticStr +="[\"세종\",";
			for(int i=0; i<size;i++)
			{
				
				statisticStr += dao3.list2(id).get(i).getSejong();
				
				if(i==(size-1))
				{
					statisticStr +="],";
					break;
				}
				statisticStr +=",";
			}
			statisticStr +="[\"경기\",";
			for(int i=0; i<size;i++)
			{
				
				statisticStr += dao3.list2(id).get(i).getGyeongi();
				
				if(i==(size-1))
				{
					statisticStr +="],";
					break;
				}
				statisticStr +=",";
			}
			statisticStr +="[\"충북\",";
			for(int i=0; i<size;i++)
			{
				statisticStr += dao3.list2(id).get(i).getChoongbuk();
				
				if(i==(size-1))
				{
					statisticStr +="],";
					break;
				}
				statisticStr +=",";
			}
			statisticStr +="[\"충남\",";
			for(int i=0; i<size;i++)
			{
				statisticStr += dao3.list2(id).get(i).getChoongnam();
				
				if(i==(size-1))
				{
					statisticStr +="],";
					break;
				}
				statisticStr +=",";
			}
			statisticStr +="[\"전북\",";
			for(int i=0; i<size;i++)
			{
				statisticStr += dao3.list2(id).get(i).getJeonbuk();
				
				if(i==(size-1))
				{
					statisticStr +="],";
					break;
				}
				statisticStr +=",";
			}
			statisticStr +="[\"전남\",";
			for(int i=0; i<size;i++)
			{
				statisticStr += dao3.list2(id).get(i).getJeonnam();
				
				if(i==(size-1))
				{
					statisticStr +="],";
					break;
				}
				statisticStr +=",";
			}
			statisticStr +="[\"경북\",";
			for(int i=0; i<size;i++)
			{
				statisticStr += dao3.list2(id).get(i).getGyeongbuk();
				
				if(i==(size-1))
				{
					statisticStr +="],";
					break;
				}
				statisticStr +=",";
			}
			statisticStr +="[\"경남\",";
			for(int i=0; i<size;i++)
			{
				statisticStr += dao3.list2(id).get(i).getGyeongnam();
				
				if(i==(size-1))
				{
					statisticStr +="],";
					break;
				}
				statisticStr +=",";
			}
			statisticStr +="[\"강원\",";
			for(int i=0; i<size;i++)
			{
				statisticStr += dao3.list2(id).get(i).getGangwon();
				
				if(i==(size-1))
				{
					statisticStr +="],";
					break;
				}
				statisticStr +=",";
			}
			statisticStr +="[\"제주\",";
			for(int i=0; i<size;i++)
			{
				statisticStr += dao3.list2(id).get(i).getJeju();
				
				if(i==(size-1))
				{
					statisticStr +="]";
					break;
				}
				statisticStr +=",";
			}
		
		statisticStr += "]";
		return statisticStr;
	}
	
	// 여행 스타일 통계 데이터 담은 JSON 문자열
	public static String CalStyle(IStatisticsDAO dao, String style, String id)
	{
		String statisticStr="";
		
		if(style.equals("1")) // 계획
		{
			if(dao.plan(id)!=null)
			{
				StatisticsDTO dto = dao.plan(id);
				statisticStr+="[[\"계획 스타일\", \"선택 횟수\"],[\"완벽한 계획\", "+dto.getPLAN1()+"],"
						+"[\"대략적인 계획\", "+dto.getPLAN2()+"],"+"[\"계획 없음\", "+dto.getPLAN3()+"],"
						+"[\"무관\", "+dto.getPLAN4()+"]]";
			}
		}
		else if(style.equals("2"))
		{
			if(dao.moneyoption(id)!=null)
			{
				StatisticsDTO dto = dao.moneyoption(id);
				statisticStr+="[[\"경비 스타일\", \"선택 횟수\"],[\"N분의 1\", "+dto.getMoneyoption1()+"],"
						+"[\"각자 계산\", "+dto.getMoneyoption2()+"],"+"[\"후청구\", "+dto.getMoneyoption3()+"],"
						+"[\"무관\", "+dto.getMoneyoption4()+"]]";
			}
		}
		else if(style.equals("3"))
		{
			if(dao.staytype(id)!=null)
			{
				StatisticsDTO dto = dao.staytype(id);
				statisticStr+="[[\"숙소 유형 스타일\", \"선택 횟수\"],[\"리조트\", "+dto.getSTAYTYPE1()+"],"
						+"[\"호텔\", "+dto.getSTAYTYPE2()+"],"+"[\"호스텔\", "+dto.getSTAYTYPE3()+"],"
						+"[\"민박\", "+dto.getSTAYTYPE4()+"],"+"[\"무관\", "+dto.getSTAYTYPE5()+"]]";
			}
		}
		else if(style.equals("4"))
		{
			if(dao.traffic(id)!=null)
			{
				StatisticsDTO dto = dao.traffic(id);
				statisticStr+="[[\"교통 스타일\", \"선택 횟수\"],[\"렌트\", "+dto.getTRAFFIC1()+"],"
						+"[\"뚜벅이선호\", "+dto.getTRAFFIC2()+"],"+"[\"대중교통\", "+dto.getTRAFFIC3()+"],"
						+"[\"무관\", "+dto.getTRAFFIC4()+"]]";
			}
		}
		
		else if(style.equals("5"))
		{
			if(dao.cycle(id)!=null)
			{
				StatisticsDTO dto = dao.cycle(id);
				statisticStr+="[[\"수면 패턴 스타일\", \"선택 횟수\"],[\"늦은 취침, 늦은 기상\", "+dto.getCYCLE1()+"],"
						+"[\"이른 취침, 이른 기상\", "+dto.getCYCLE2()+"],"+"[\"무관\", "+dto.getCYCLE3()+"]]";
			}
		}
		
		else if(style.equals("6"))
		{
			if(dao.pace(id)!=null)
			{
				StatisticsDTO dto = dao.pace(id);
				statisticStr+="[[\"여행 속도 스타일\", \"선택 횟수\"],[\"느긋함 선호\", "+dto.getPACE1()+"],"
						+"[\"촘촘한 일정 선호\", "+dto.getPACE2()+"],"+"[\"무관\", "+dto.getPACE3()+"]]";
			}
		}
		
		else if(style.equals("7"))
		{
			if(dao.desti(id)!=null)
			{
				StatisticsDTO dto = dao.desti(id);
				statisticStr+="[[\"여행지 스타일\", \"선택 횟수\"],[\"자연\", "+dto.getDESTI1()+"],"
						+"[\"도시\", "+dto.getDESTI2()+"],"+"[\"휴양지\", "+dto.getDESTI3()+"],"
						+"[\"역사유적지\", "+dto.getDESTI4()+"],"+"[\"무관\", "+dto.getDESTI5()+"]]";
			}
		}
		
		else if(style.equals("8"))
		{
			if(dao.todo(id)!=null)
			{
				StatisticsDTO dto = dao.todo(id);
				statisticStr+="[[\"여행 할것 스타일\", \"선택 횟수\"],[\"휴식\", "+dto.getTODO1()+"],"
						+"[\"쇼핑\", "+dto.getTODO2()+"],"+"[\"액티비티\", "+dto.getTODO3()+"],"
						+"[\"여행영상 촬영\", "+dto.getTODO4()+"],"+"[\"맛집탐방\", "+dto.getTODO5()+"],"
						+"[\"새친구 만들기\", "+dto.getTODO6()+"],"+"[\"무관\", "+dto.getTODO7()+"]]";
			}
		}
		
		else if(style.equals("9"))
		{
			if(dao.tosee(id)!=null)
			{
				StatisticsDTO dto = dao.tosee(id);
				statisticStr+="[[\"여행 볼것 스타일\", \"선택 횟수\"],[\"역사\", "+dto.getTOSEE1()+"],"
						+"[\"예술\", "+dto.getTOSEE2()+"],"+"[\"문화\", "+dto.getTOSEE3()+"],"
						+"[\"자연경관\", "+dto.getTOSEE4()+"],"+"[\"무관\", "+dto.getTOSEE5()+"]]";
			}
		}
		else if(style.equals("10"))
		{
			if(dao.food(id)!=null)
			{
				StatisticsDTO dto = dao.food(id);
				statisticStr+="[[\"음식점 선정 스타일\", \"선택 횟수\"],[\"SNS 맛집\", "+dto.getFOOD1()+"],"
						+"[\"현지인 맛집\", "+dto.getFOOD2()+"],"+"[\"지역특산물 위주\", "+dto.getFOOD3()+"],"
						+"[\"즉흥적으로\", "+dto.getFOOD4()+"],"+"[\"무관\", "+dto.getFOOD5()+"]]";
			}
		}
		
		else if(style.equals("11"))
		{
			if(dao.mealcount(id)!=null)
			{
				StatisticsDTO dto = dao.mealcount(id);
				statisticStr+="[[\"식사 빈도 스타일\", \"선택 횟수\"],[\"자주, 적게\", "+dto.getMEALCOUNT1()+"],"
						+"[\"한번에 많이\", "+dto.getMEALCOUNT2()+"],"+"[\"다이어트\", "+dto.getMEALCOUNT3()+"],"
						+"[\"무관\", "+dto.getMEALCOUNT4()+"]]";
			}
		}
		
		else if(style.equals("12"))
		{
			if(dao.supply(id)!=null)
			{
				StatisticsDTO dto = dao.supply(id);
				statisticStr+="[[\"물품 준비 스타일\", \"선택 횟수\"],[\"모두 챙김\", "+dto.getSUPPLY1()+"],"
						+"[\"반반\", "+dto.getSUPPLY2()+"],"+"[\"현지조달\", "+dto.getSUPPLY3()+"],"
						+"[\"무관\", "+dto.getSUPPLY4()+"]]";
			}
		}
		
		else if(style.equals("13"))
		{
			if(dao.photo(id)!=null)
			{
				StatisticsDTO dto = dao.photo(id);
				statisticStr+="[[\"사진 촬영 스타일\", \"선택 횟수\"],[\"인생샷을 위해\", "+dto.getPHOTO1()+"],"
						+"[\"대충 흔적만\", "+dto.getPHOTO2()+"],"+"[\"풍경 위주\", "+dto.getPHOTO3()+"],"
						+"[\"무관\", "+dto.getPHOTO4()+"]]";
			}
		}
		
		return statisticStr;
	}
}
