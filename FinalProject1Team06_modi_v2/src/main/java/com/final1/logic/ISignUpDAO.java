package com.final1.logic;

public interface ISignUpDAO
{
	//private String idNum, id, memNum, name, nickName, pw, ssn1, ssn2, photo, introduce;
	
	public int memberRegi(SignUpDTO dto);
	
	public int memberAdd(SignUpDTO dto);
	
	public String searchId(String id);
	
	public int ssnCheck(String ssn);
}
