package com.final1.logic;

import java.util.ArrayList;

public interface IFeedDAO
{
	public ArrayList<FeedDTO> feedList(String room_num);
	
	public FeedDTO searchId(FeedDTO dto);
	
	// 방 참여 시 피드에 입장 내용 자동 삽입
	public int addContentInto(FeedDTO dto);
	// 방 퇴장 시 피드에 퇴장 내용 자동 삽입
	public int addContentExit(FeedDTO dto);
	
	// 피드 내용 삽입
	public int addContent(FeedDTO dto);
	
	// 피드 내용 삭제
	public int removeContent(String feedNum);
}
