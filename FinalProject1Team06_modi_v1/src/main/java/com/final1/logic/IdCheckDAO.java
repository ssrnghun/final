package com.final1.logic;

public interface IdCheckDAO
{
	public int count(String id);
	
	public int checkNick(String nick);
	
	public int updatePhoto(String filePath);
}
