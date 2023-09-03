/*======================
   StatisticsDTO.java
======================*/

package com.final1.logic;

public class StatisticsDTO
{
	// 년도
	private String year;
	
	// 월
	private int jan, feb, mar, apr, may, jun, jul, aug, sept, oct, nov, dec;
	// 지역
	private int seoul, busan, incheon, daegu, daejeon, gwangju, ulsan, sejong, gyeongi, choongbuk, choongnam
				,jeonbuk, jeonnam, gyeongbuk, gyeongnam, gangwon, jeju;
	
	// 여행 스타일
	private int PLAN1, PLAN2, PLAN3, PLAN4;
	private int moneyoption1, moneyoption2, moneyoption3, moneyoption4;
	private int STAYTYPE1,STAYTYPE2,STAYTYPE3,STAYTYPE4,STAYTYPE5;
	private int TRAFFIC1, TRAFFIC2, TRAFFIC3, TRAFFIC4;
	private int CYCLE1, CYCLE2, CYCLE3;
	private int PACE1, PACE2, PACE3;
	private int DESTI1, DESTI2, DESTI3, DESTI4, DESTI5;
	private int TODO1, TODO2, TODO3, TODO4, TODO5, TODO6, TODO7;
	private int TOSEE1, TOSEE2, TOSEE3, TOSEE4, TOSEE5;
	private int FOOD1, FOOD2, FOOD3, FOOD4, FOOD5;
	private int MEALCOUNT1, MEALCOUNT2, MEALCOUNT3, MEALCOUNT4;
	private int SUPPLY1,SUPPLY2, SUPPLY3, SUPPLY4;
	private int PHOTO1, PHOTO2,PHOTO3, PHOTO4;
	
	public int getSejong()
	{
		return sejong;
	}

	public void setSejong(int sejong)
	{
		this.sejong = sejong;
	}

	public String getYear()
	{
		return year;
	}

	public void setYear(String	 year)
	{
		this.year = year;
	}

	public int getJan()
	{
		return jan;
	}

	public void setJan(int jan)
	{
		this.jan = jan;
	}

	public int getFeb()
	{
		return feb;
	}

	public void setFeb(int feb)
	{
		this.feb = feb;
	}

	public int getMar()
	{
		return mar;
	}

	public void setMar(int mar)
	{
		this.mar = mar;
	}

	public int getApr()
	{
		return apr;
	}

	public void setApr(int apr)
	{
		this.apr = apr;
	}

	public int getMay()
	{
		return may;
	}

	public void setMay(int may)
	{
		this.may = may;
	}

	public int getJun()
	{
		return jun;
	}

	public void setJun(int jun)
	{
		this.jun = jun;
	}

	public int getJul()
	{
		return jul;
	}

	public void setJul(int jul)
	{
		this.jul = jul;
	}

	public int getAug()
	{
		return aug;
	}

	public void setAug(int aug)
	{
		this.aug = aug;
	}

	public int getSept()
	{
		return sept;
	}

	public void setSept(int sept)
	{
		this.sept = sept;
	}

	public int getOct()
	{
		return oct;
	}

	public void setOct(int oct)
	{
		this.oct = oct;
	}

	public int getNov()
	{
		return nov;
	}

	public void setNov(int nov)
	{
		this.nov = nov;
	}

	public int getDec()
	{
		return dec;
	}

	public void setDec(int dec)
	{
		this.dec = dec;
	}

	public int getSeoul()
	{
		return seoul;
	}

	public void setSeoul(int seoul)
	{
		this.seoul = seoul;
	}

	public int getBusan()
	{
		return busan;
	}

	public void setBusan(int busan)
	{
		this.busan = busan;
	}

	public int getIncheon()
	{
		return incheon;
	}

	public void setIncheon(int incheon)
	{
		this.incheon = incheon;
	}

	public int getDaegu()
	{
		return daegu;
	}

	public void setDaegu(int daegu)
	{
		this.daegu = daegu;
	}

	public int getDaejeon()
	{
		return daejeon;
	}

	public void setDaejeon(int daejeon)
	{
		this.daejeon = daejeon;
	}

	public int getGwangju()
	{
		return gwangju;
	}

	public void setGwangju(int gwangju)
	{
		this.gwangju = gwangju;
	}

	public int getUlsan()
	{
		return ulsan;
	}

	public void setUlsan(int ulsan)
	{
		this.ulsan = ulsan;
	}

	public int getGyeongi()
	{
		return gyeongi;
	}

	public void setGyeongi(int gyeongi)
	{
		this.gyeongi = gyeongi;
	}

	public int getChoongbuk()
	{
		return choongbuk;
	}

	public void setChoongbuk(int choongbuk)
	{
		this.choongbuk = choongbuk;
	}

	public int getChoongnam()
	{
		return choongnam;
	}

	public void setChoongnam(int choongnam)
	{
		this.choongnam = choongnam;
	}

	public int getJeonbuk()
	{
		return jeonbuk;
	}

	public void setJeonbuk(int jeonbuk)
	{
		this.jeonbuk = jeonbuk;
	}

	public int getJeonnam()
	{
		return jeonnam;
	}

	public void setJeonnam(int jeonnam)
	{
		this.jeonnam = jeonnam;
	}

	public int getGyeongbuk()
	{
		return gyeongbuk;
	}

	public void setGyeongbuk(int gyeongbuk)
	{
		this.gyeongbuk = gyeongbuk;
	}

	public int getGyeongnam()
	{
		return gyeongnam;
	}

	public void setGyeongnam(int gyeongnam)
	{
		this.gyeongnam = gyeongnam;
	}

	public int getGangwon()
	{
		return gangwon;
	}

	public void setGangwon(int gangwon)
	{
		this.gangwon = gangwon;
	}

	public int getJeju()
	{
		return jeju;
	}

	public void setJeju(int jeju)
	{
		this.jeju = jeju;
	}

	public int getPLAN1()
	{
		return PLAN1;
	}

	public void setPLAN1(int pLAN1)
	{
		PLAN1 = pLAN1;
	}

	public int getPLAN2()
	{
		return PLAN2;
	}

	public void setPLAN2(int pLAN2)
	{
		PLAN2 = pLAN2;
	}

	public int getPLAN3()
	{
		return PLAN3;
	}

	public void setPLAN3(int pLAN3)
	{
		PLAN3 = pLAN3;
	}

	public int getPLAN4()
	{
		return PLAN4;
	}

	public void setPLAN4(int pLAN4)
	{
		PLAN4 = pLAN4;
	}

	public int getMoneyoption1()
	{
		return moneyoption1;
	}

	public void setMoneyoption1(int moneyoption1)
	{
		this.moneyoption1 = moneyoption1;
	}

	public int getMoneyoption2()
	{
		return moneyoption2;
	}

	public void setMoneyoption2(int moneyoption2)
	{
		this.moneyoption2 = moneyoption2;
	}

	public int getMoneyoption3()
	{
		return moneyoption3;
	}

	public void setMoneyoption3(int moneyoption3)
	{
		this.moneyoption3 = moneyoption3;
	}

	public int getMoneyoption4()
	{
		return moneyoption4;
	}

	public void setMoneyoption4(int moneyoption4)
	{
		this.moneyoption4 = moneyoption4;
	}

	public int getSTAYTYPE1()
	{
		return STAYTYPE1;
	}

	public void setSTAYTYPE1(int sTAYTYPE1)
	{
		STAYTYPE1 = sTAYTYPE1;
	}

	public int getSTAYTYPE2()
	{
		return STAYTYPE2;
	}

	public void setSTAYTYPE2(int sTAYTYPE2)
	{
		STAYTYPE2 = sTAYTYPE2;
	}

	public int getSTAYTYPE3()
	{
		return STAYTYPE3;
	}

	public void setSTAYTYPE3(int sTAYTYPE3)
	{
		STAYTYPE3 = sTAYTYPE3;
	}

	public int getSTAYTYPE4()
	{
		return STAYTYPE4;
	}

	public void setSTAYTYPE4(int sTAYTYPE4)
	{
		STAYTYPE4 = sTAYTYPE4;
	}
	
	public int getSTAYTYPE5()
	{
		return STAYTYPE5;
	}

	public void setSTAYTYPE5(int sTAYTYPE5)
	{
		STAYTYPE5 = sTAYTYPE5;
	}

	public int getTRAFFIC1()
	{
		return TRAFFIC1;
	}

	public void setTRAFFIC1(int tRAFFIC1)
	{
		TRAFFIC1 = tRAFFIC1;
	}

	public int getTRAFFIC2()
	{
		return TRAFFIC2;
	}

	public void setTRAFFIC2(int tRAFFIC2)
	{
		TRAFFIC2 = tRAFFIC2;
	}

	public int getTRAFFIC3()
	{
		return TRAFFIC3;
	}

	public void setTRAFFIC3(int tRAFFIC3)
	{
		TRAFFIC3 = tRAFFIC3;
	}

	public int getTRAFFIC4()
	{
		return TRAFFIC4;
	}

	public void setTRAFFIC4(int tRAFFIC4)
	{
		TRAFFIC4 = tRAFFIC4;
	}

	public int getCYCLE1()
	{
		return CYCLE1;
	}

	public void setCYCLE1(int cYCLE1)
	{
		CYCLE1 = cYCLE1;
	}

	public int getCYCLE2()
	{
		return CYCLE2;
	}

	public void setCYCLE2(int cYCLE2)
	{
		CYCLE2 = cYCLE2;
	}

	public int getCYCLE3()
	{
		return CYCLE3;
	}

	public void setCYCLE3(int cYCLE3)
	{
		CYCLE3 = cYCLE3;
	}

	public int getPACE1()
	{
		return PACE1;
	}

	public void setPACE1(int pACE1)
	{
		PACE1 = pACE1;
	}

	public int getPACE2()
	{
		return PACE2;
	}

	public void setPACE2(int pACE2)
	{
		PACE2 = pACE2;
	}

	public int getPACE3()
	{
		return PACE3;
	}

	public void setPACE3(int pACE3)
	{
		PACE3 = pACE3;
	}

	public int getDESTI1()
	{
		return DESTI1;
	}

	public void setDESTI1(int dESTI1)
	{
		DESTI1 = dESTI1;
	}

	public int getDESTI2()
	{
		return DESTI2;
	}

	public void setDESTI2(int dESTI2)
	{
		DESTI2 = dESTI2;
	}

	public int getDESTI3()
	{
		return DESTI3;
	}

	public void setDESTI3(int dESTI3)
	{
		DESTI3 = dESTI3;
	}

	public int getDESTI4()
	{
		return DESTI4;
	}

	public void setDESTI4(int dESTI4)
	{
		DESTI4 = dESTI4;
	}

	public int getDESTI5()
	{
		return DESTI5;
	}

	public void setDESTI5(int dESTI5)
	{
		DESTI5 = dESTI5;
	}

	public int getTODO1()
	{
		return TODO1;
	}

	public void setTODO1(int tODO1)
	{
		TODO1 = tODO1;
	}

	public int getTODO2()
	{
		return TODO2;
	}

	public void setTODO2(int tODO2)
	{
		TODO2 = tODO2;
	}

	public int getTODO3()
	{
		return TODO3;
	}

	public void setTODO3(int tODO3)
	{
		TODO3 = tODO3;
	}

	public int getTODO4()
	{
		return TODO4;
	}

	public void setTODO4(int tODO4)
	{
		TODO4 = tODO4;
	}

	public int getTODO5()
	{
		return TODO5;
	}

	public void setTODO5(int tODO5)
	{
		TODO5 = tODO5;
	}

	public int getTODO6()
	{
		return TODO6;
	}

	public void setTODO6(int tODO6)
	{
		TODO6 = tODO6;
	}
	public int getTODO7()
	{
		return TODO7;
	}

	public void setTODO7(int tODO7)
	{
		TODO7 = tODO7;
	}

	public int getTOSEE1()
	{
		return TOSEE1;
	}

	public void setTOSEE1(int tOSEE1)
	{
		TOSEE1 = tOSEE1;
	}

	public int getTOSEE2()
	{
		return TOSEE2;
	}

	public void setTOSEE2(int tOSEE2)
	{
		TOSEE2 = tOSEE2;
	}

	public int getTOSEE3()
	{
		return TOSEE3;
	}

	public void setTOSEE3(int tOSEE3)
	{
		TOSEE3 = tOSEE3;
	}

	public int getTOSEE4()
	{
		return TOSEE4;
	}

	public void setTOSEE4(int tOSEE4)
	{
		TOSEE4 = tOSEE4;
	}

	public int getTOSEE5()
	{
		return TOSEE5;
	}

	public void setTOSEE5(int tOSEE5)
	{
		TOSEE5 = tOSEE5;
	}

	public int getFOOD1()
	{
		return FOOD1;
	}

	public void setFOOD1(int fOOD1)
	{
		FOOD1 = fOOD1;
	}

	public int getFOOD2()
	{
		return FOOD2;
	}

	public void setFOOD2(int fOOD2)
	{
		FOOD2 = fOOD2;
	}

	public int getFOOD3()
	{
		return FOOD3;
	}

	public void setFOOD3(int fOOD3)
	{
		FOOD3 = fOOD3;
	}

	public int getFOOD4()
	{
		return FOOD4;
	}

	public void setFOOD4(int fOOD4)
	{
		FOOD4 = fOOD4;
	}

	public int getFOOD5()
	{
		return FOOD5;
	}

	public void setFOOD5(int fOOD5)
	{
		FOOD5 = fOOD5;
	}

	public int getMEALCOUNT1()
	{
		return MEALCOUNT1;
	}

	public void setMEALCOUNT1(int mEALCOUNT1)
	{
		MEALCOUNT1 = mEALCOUNT1;
	}

	public int getMEALCOUNT2()
	{
		return MEALCOUNT2;
	}

	public void setMEALCOUNT2(int mEALCOUNT2)
	{
		MEALCOUNT2 = mEALCOUNT2;
	}

	public int getMEALCOUNT3()
	{
		return MEALCOUNT3;
	}

	public void setMEALCOUNT3(int mEALCOUNT3)
	{
		MEALCOUNT3 = mEALCOUNT3;
	}

	public int getMEALCOUNT4()
	{
		return MEALCOUNT4;
	}

	public void setMEALCOUNT4(int mEALCOUNT4)
	{
		MEALCOUNT4 = mEALCOUNT4;
	}

	public int getSUPPLY1()
	{
		return SUPPLY1;
	}

	public void setSUPPLY1(int sUPPLY1)
	{
		SUPPLY1 = sUPPLY1;
	}

	public int getSUPPLY2()
	{
		return SUPPLY2;
	}

	public void setSUPPLY2(int sUPPLY2)
	{
		SUPPLY2 = sUPPLY2;
	}

	public int getSUPPLY3()
	{
		return SUPPLY3;
	}

	public void setSUPPLY3(int sUPPLY3)
	{
		SUPPLY3 = sUPPLY3;
	}

	public int getSUPPLY4()
	{
		return SUPPLY4;
	}

	public void setSUPPLY4(int sUPPLY4)
	{
		SUPPLY4 = sUPPLY4;
	}

	public int getPHOTO1()
	{
		return PHOTO1;
	}

	public void setPHOTO1(int pHOTO1)
	{
		PHOTO1 = pHOTO1;
	}

	public int getPHOTO2()
	{
		return PHOTO2;
	}

	public void setPHOTO2(int pHOTO2)
	{
		PHOTO2 = pHOTO2;
	}

	public int getPHOTO3()
	{
		return PHOTO3;
	}

	public void setPHOTO3(int pHOTO3)
	{
		PHOTO3 = pHOTO3;
	}

	public int getPHOTO4()
	{
		return PHOTO4;
	}

	public void setPHOTO4(int pHOTO4)
	{
		PHOTO4 = pHOTO4;
	}
	

}
