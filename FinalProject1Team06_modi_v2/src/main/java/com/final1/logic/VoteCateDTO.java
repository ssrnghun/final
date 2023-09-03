package com.final1.logic;

public class VoteCateDTO
{
	//투표 번호, 투표 항목, 투표 인물, 투표한 날짜, 항목에 투표한 사람 수
	private String vote_num;
    private String vote_category_num;
    private String mem_join_num;
    private String mem_vote_num;
    private String vote_date;
    private Integer cate_people;
    
	public Integer getCate_people()
	{
		return cate_people;
	}
	public void setCate_people(Integer cate_people)
	{
		this.cate_people = cate_people;
	}
	public String getVote_num()
	{
		return vote_num;
	}
	public void setVote_num(String vote_num)
	{
		this.vote_num = vote_num;
	}
	public String getVote_category_num()
	{
		return vote_category_num;
	}
	public void setVote_category_num(String vote_category_num)
	{
		this.vote_category_num = vote_category_num;
	}
	public String getMem_join_num()
	{
		return mem_join_num;
	}
	public void setMem_join_num(String mem_join_num)
	{
		this.mem_join_num = mem_join_num;
	}
	public String getMem_vote_num()
	{
		return mem_vote_num;
	}
	public void setMem_vote_num(String mem_vote_num)
	{
		this.mem_vote_num = mem_vote_num;
	}
	public String getVote_date()
	{
		return vote_date;
	}
	public void setVote_date(String vote_date)
	{
		this.vote_date = vote_date;
	}
    
    
    
}
