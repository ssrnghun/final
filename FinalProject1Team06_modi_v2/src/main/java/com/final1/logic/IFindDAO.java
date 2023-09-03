package com.final1.logic;

public interface IFindDAO
{
	public String findId(FindDTO dto);
	
	public int count(FindDTO dto);
	
	public int pwCount(FindDTO dto);
	
	public int findUpdatePw(FindDTO dto);
	
	public String findIdAdmin(FindDTO dto);
	
	public int adminCount(FindDTO dto);
	
	public int pwCountAdmin(FindDTO dto);
	
	public int findUpdatePwAdmin(FindDTO dto);
	
}
