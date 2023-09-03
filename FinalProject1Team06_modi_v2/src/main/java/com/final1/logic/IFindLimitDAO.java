package com.final1.logic;

import java.util.ArrayList;

public interface IFindLimitDAO
{
	public ArrayList<FindLimitDTO> findLimitList(LoginDTO dto);
	
	public FindLimitDTO findLimit1(LoginDTO dto);
	
	public int limitCount(LoginDTO dto);
	
	public FindLimitDTO total(LoginDTO dto);
	
	public String UseStart(LoginDTO dto);
	
}
