/*===================
   ILoginDAO.java
===================*/

package com.final1.logic;

public interface ILoginDAO
{
	public int login(LoginDTO dto);
	
	public int adminLogin(LoginDTO dto);
	
	// 추가
	public int ongoingDel(String id);
}
