/*============================
	RoomListDTO.java
	- 방 리스트 출력용 DTO
============================*/

package com.final1.logic;

public class RoomDTO
{
	// 주요 속성 구성
	private String room_num, id_num, nikname, profile_photo, plan_num, money_option_num, stay_type_num, traffic_num, cycle_num, pace_num;     
	private String desti_type_num, to_do_num, to_see_num, food_num, meal_count_num, supply_num, photo_num, region_num;
	private String plan_onoff_num, gender_limit_num, age_limit_num, trip_start_date, trip_end_date, mem_max, room_build_date; 
	private String room_title, budget, start_loc_lat, start_loc_lng,start_loc_name, start_loc_date, final_go_date, room_del_date, mem_curr;
	private String pw_code, ongoing, bookmark;
	private String plan, money_option, stay_type, traffic, cycle, pace;     
	private String desti_type, to_do, to_see, food, meal_count, supply, photo, region;
	private String plan_onoff, gender_limit, age_limit, days;
	
	
	
	// getter / setter 구성
	
	public String getNikname()
	{
		return nikname;
	}
	public String getStart_loc_name()
	{
		return start_loc_name;
	}
	public void setStart_loc_name(String start_loc_name)
	{
		this.start_loc_name = start_loc_name;
	}
	public void setNikname(String nikname)
	{
		this.nikname = nikname;
	}
	public String getProfile_photo()
	{
		return profile_photo;
	}
	public void setProfile_photo(String profile_photo)
	{
		this.profile_photo = profile_photo;
	}
	public String getRoom_num()
	{
		return room_num;
	}
	public void setRoom_num(String room_num)
	{
		this.room_num = room_num;
	}
	public String getId_num()
	{
		return id_num;
	}
	public void setId_num(String id_num)
	{
		this.id_num = id_num;
	}
	public String getPlan_num()
	{
		return plan_num;
	}
	public void setPlan_num(String plan_num)
	{
		this.plan_num = plan_num;
	}
	public String getMoney_option_num()
	{
		return money_option_num;
	}
	public void setMoney_option_num(String money_option_num)
	{
		this.money_option_num = money_option_num;
	}
	public String getStay_type_num()
	{
		return stay_type_num;
	}
	public void setStay_type_num(String stay_type_num)
	{
		this.stay_type_num = stay_type_num;
	}
	public String getTraffic_num()
	{
		return traffic_num;
	}
	public void setTraffic_num(String traffic_num)
	{
		this.traffic_num = traffic_num;
	}
	public String getCycle_num()
	{
		return cycle_num;
	}
	public void setCycle_num(String cycle_num)
	{
		this.cycle_num = cycle_num;
	}
	public String getPace_num()
	{
		return pace_num;
	}
	public void setPace_num(String pace_num)
	{
		this.pace_num = pace_num;
	}
	public String getDesti_type_num()
	{
		return desti_type_num;
	}
	public void setDesti_type_num(String desti_type_num)
	{
		this.desti_type_num = desti_type_num;
	}
	public String getTo_do_num()
	{
		return to_do_num;
	}
	public void setTo_do_num(String to_do_num)
	{
		this.to_do_num = to_do_num;
	}
	public String getTo_see_num()
	{
		return to_see_num;
	}
	public void setTo_see_num(String to_see_num)
	{
		this.to_see_num = to_see_num;
	}
	public String getFood_num()
	{
		return food_num;
	}
	public void setFood_num(String food_num)
	{
		this.food_num = food_num;
	}
	public String getMeal_count_num()
	{
		return meal_count_num;
	}
	public void setMeal_count_num(String meal_count_num)
	{
		this.meal_count_num = meal_count_num;
	}
	public String getSupply_num()
	{
		return supply_num;
	}
	public void setSupply_num(String supply_num)
	{
		this.supply_num = supply_num;
	}
	public String getPhoto_num()
	{
		return photo_num;
	}
	public void setPhoto_num(String photo_num)
	{
		this.photo_num = photo_num;
	}
	public String getRegion_num()
	{
		return region_num;
	}
	public void setRegion_num(String region_num)
	{
		this.region_num = region_num;
	}
	public String getPlan_onoff_num()
	{
		return plan_onoff_num;
	}
	public void setPlan_onoff_num(String plan_onoff_num)
	{
		this.plan_onoff_num = plan_onoff_num;
	}
	public String getGender_limit_num()
	{
		return gender_limit_num;
	}
	public void setGender_limit_num(String gender_limit_num)
	{
		this.gender_limit_num = gender_limit_num;
	}
	public String getAge_limit_num()
	{
		return age_limit_num;
	}
	public void setAge_limit_num(String age_limit_num)
	{
		this.age_limit_num = age_limit_num;
	}
	public String getTrip_start_date()
	{
		return trip_start_date;
	}
	public void setTrip_start_date(String trip_start_date)
	{
		this.trip_start_date = trip_start_date;
	}
	public String getTrip_end_date()
	{
		return trip_end_date;
	}
	public void setTrip_end_date(String trip_end_date)
	{
		this.trip_end_date = trip_end_date;
	}
	public String getMem_max()
	{
		return mem_max;
	}
	public void setMem_max(String mem_max)
	{
		this.mem_max = mem_max;
	}
	public String getRoom_build_date()
	{
		return room_build_date;
	}
	public void setRoom_build_date(String room_build_date)
	{
		this.room_build_date = room_build_date;
	}
	public String getRoom_title()
	{
		return room_title;
	}
	public void setRoom_title(String room_title)
	{
		this.room_title = room_title;
	}
	public String getBudget()
	{
		return budget;
	}
	public void setBudget(String budget)
	{
		this.budget = budget;
	}
	public String getStart_loc_lat()
	{
		return start_loc_lat;
	}
	public void setStart_loc_lat(String start_loc_lat)
	{
		this.start_loc_lat = start_loc_lat;
	}
	public String getStart_loc_lng()
	{
		return start_loc_lng;
	}
	public void setStart_loc_lng(String start_loc_lng)
	{
		this.start_loc_lng = start_loc_lng;
	}
	public String getStart_loc_date()
	{
		return start_loc_date;
	}
	public void setStart_loc_date(String start_loc_date)
	{
		this.start_loc_date = start_loc_date;
	}
	public String getFinal_go_date()
	{
		return final_go_date;
	}
	public void setFinal_go_date(String final_go_date)
	{
		this.final_go_date = final_go_date;
	}
	public String getRoom_del_date()
	{
		return room_del_date;
	}
	public void setRoom_del_date(String room_del_date)
	{
		this.room_del_date = room_del_date;
	}
	public String getMem_curr()
	{
		return mem_curr;
	}
	public void setMem_curr(String mem_curr)
	{
		this.mem_curr = mem_curr;
	}
	public String getPw_code()
	{
		return pw_code;
	}
	public void setPw_code(String pw_code)
	{
		this.pw_code = pw_code;
	}
	public String getOngoing()
	{
		return ongoing;
	}
	public void setOngoing(String ongoing)
	{
		this.ongoing = ongoing;
	}
	public String getBookmark()
	{
		return bookmark;
	}
	public void setBookmark(String bookmark)
	{
		this.bookmark = bookmark;
	}
	public String getPlan()
	{
		return plan;
	}
	public void setPlan(String plan)
	{
		this.plan = plan;
	}
	public String getMoney_option()
	{
		return money_option;
	}
	public void setMoney_option(String money_option)
	{
		this.money_option = money_option;
	}
	public String getStay_type()
	{
		return stay_type;
	}
	public void setStay_type(String stay_type)
	{
		this.stay_type = stay_type;
	}
	public String getTraffic()
	{
		return traffic;
	}
	public void setTraffic(String traffic)
	{
		this.traffic = traffic;
	}
	public String getCycle()
	{
		return cycle;
	}
	public void setCycle(String cycle)
	{
		this.cycle = cycle;
	}
	public String getPace()
	{
		return pace;
	}
	public void setPace(String pace)
	{
		this.pace = pace;
	}
	public String getDesti_type()
	{
		return desti_type;
	}
	public void setDesti_type(String desti_type)
	{
		this.desti_type = desti_type;
	}
	public String getTo_do()
	{
		return to_do;
	}
	public void setTo_do(String to_do)
	{
		this.to_do = to_do;
	}
	public String getTo_see()
	{
		return to_see;
	}
	public void setTo_see(String to_see)
	{
		this.to_see = to_see;
	}
	public String getFood()
	{
		return food;
	}
	public void setFood(String food)
	{
		this.food = food;
	}
	public String getMeal_count()
	{
		return meal_count;
	}
	public void setMeal_count(String meal_count)
	{
		this.meal_count = meal_count;
	}
	public String getSupply()
	{
		return supply;
	}
	public void setSupply(String supply)
	{
		this.supply = supply;
	}
	public String getPhoto()
	{
		return photo;
	}
	public void setPhoto(String photo)
	{
		this.photo = photo;
	}
	public String getRegion()
	{
		return region;
	}
	public void setRegion(String region)
	{
		this.region = region;
	}
	public String getPlan_onoff()
	{
		return plan_onoff;
	}
	public void setPlan_onoff(String plan_onoff)
	{
		this.plan_onoff = plan_onoff;
	}
	public String getGender_limit()
	{
		return gender_limit;
	}
	public void setGender_limit(String gender_limit)
	{
		this.gender_limit = gender_limit;
	}
	public String getAge_limit()
	{
		return age_limit;
	}
	public void setAge_limit(String age_limit)
	{
		this.age_limit = age_limit;
	}
	public String getDays()
	{
		return days;
	}
	public void setDays(String days)
	{
		this.days = days;
	}
		
	
	
}
