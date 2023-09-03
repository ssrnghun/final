package com.final1.logic;

public class FindDTO
{
	private String name, id, ssn;
	private String hiddenId, hiddenSsn, newPwd;

	public String getHiddenId()
	{
		return hiddenId;
	}

	public void setHiddenId(String hiddenId)
	{
		this.hiddenId = hiddenId;
	}

	public String getHiddenSsn()
	{
		return hiddenSsn;
	}

	public void setHiddenSsn(String hiddenSsn)
	{
		this.hiddenSsn = hiddenSsn;
	}

	public String getNewPwd()
	{
		return newPwd;
	}

	public void setNewPwd(String newPwd)
	{
		this.newPwd = newPwd;
	}

	public String getName()
	{
		return name;
	}

	public void setName(String name)
	{
		this.name = name;
	}

	public String getId()
	{
		return id;
	}

	public void setId(String id)
	{
		this.id = id;
	}

	public String getSsn()
	{
		return ssn;
	}

	public void setSsn(String ssn)
	{
		this.ssn = ssn;
	}
	
	
}
