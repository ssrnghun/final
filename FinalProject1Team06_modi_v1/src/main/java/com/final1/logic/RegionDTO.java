/*============================
	RegionDTO.java
	- 지역 조회용 DTO
============================*/


package com.final1.logic;

public class RegionDTO
{
	private int region_num, area_num;
	private String regionName, regionLat, regionLng;
	
	// getter / setter 구성
	public int getRegion_num()
	{
		return region_num;
	}
	public void setRegion_num(int region_num)
	{
		this.region_num = region_num;
	}
	public int getArea_num()
	{
		return area_num;
	}
	public void setArea_num(int area_num)
	{
		this.area_num = area_num;
	}
	public String getRegionName()
	{
		return regionName;
	}
	public void setRegionName(String regionName)
	{
		this.regionName = regionName;
	}
	public String getRegionLat()
	{
		return regionLat;
	}
	public void setRegionLat(String regionLat)
	{
		this.regionLat = regionLat;
	}
	public String getRegionLng()
	{
		return regionLng;
	}
	public void setRegionLng(String regionLng)
	{
		this.regionLng = regionLng;
	}
	
	
}
