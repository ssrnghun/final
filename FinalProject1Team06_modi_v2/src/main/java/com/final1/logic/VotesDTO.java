package com.final1.logic;

import java.util.List;

public class VotesDTO
{
	//투표 번호, 투표 제목, 투표시작일, 투표종료일, 투표 카테고리, 복수단수, 익명실명
	private String vote_num;
	private String title, start_date, end_date, vote_select_num, vote_name_num;
	// 투표 항목
	private List<VoteCateDTO> voteItems;

	public String getVote_num()
	{
		return vote_num;
	}

	public void setVote_num(String vote_num)
	{
		this.vote_num = vote_num;
	}

	public List<VoteCateDTO> getVoteItems()
	{
		return voteItems;
	}

	public void setVoteItems(List<VoteCateDTO> voteItems)
	{
		this.voteItems = voteItems;
	}

	public String getTitle()
	{
		return title;
	}

	public void setTitle(String title)
	{
		this.title = title;
	}

	public String getStart_date()
	{
		return start_date;
	}

	public void setStart_date(String start_date)
	{
		this.start_date = start_date;
	}

	public String getEnd_date()
	{
		return end_date;
	}

	public void setEnd_date(String end_date)
	{
		this.end_date = end_date;
	}

	public String getVote_select_num()
	{
		return vote_select_num;
	}

	public void setVote_select_num(String vote_select_num)
	{
		this.vote_select_num = vote_select_num;
	}

	public String getVote_name_num()
	{
		return vote_name_num;
	}

	public void setVote_name_num(String vote_name_num)
	{
		this.vote_name_num = vote_name_num;
	}
	
	
	
}
