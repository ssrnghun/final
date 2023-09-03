/*======================
 	MyPageDAO.java
 	- 인터페이스
========================*/

package com.final1.logic;

import java.util.ArrayList;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

public interface IMyPageDAO
{
	// 계정 닉네임, 사진 정보  
	public MyPageDTO info(String id);
	// 계정 에티켓 점수
	public MyPageDTO etiScore(String id);
	// 계정 여행 점수
	public MyPageDTO tripScore(String id);
	// 차단한 계정 정보
	public ArrayList<MyPageDTO> block(String id);
	
	// 참여중인 방 리스트
	public ArrayList<RoomListDTO> joinRooms(String id);
	// 완료한 방 리스트
	public ArrayList<RoomListDTO> finRooms(String id);
	
	// 해당 계정 정보(회원정보수정)
	public MyPageDTO searchId(String id);
	
	// 현재 비밀번호 확인
	public int pwCorrect1(@Param("pwNow") String pwNow, @Param("id") String id);
	// 비밀번호 변경
	public int pwModify(@Param("newPw") String newPw, @Param("id") String id);
	
	// 닉네임 중복 확인
	public int nikCheck(@Param("nikname") String nikname, @Param("id") String id);
	
	
	// 탈퇴 전 비밀번호 확인
	public int pwCorrect2(@Param("pwSg")String pwSg,@Param("id") String id);
	// 탈퇴 가능 여부 확인
	public void PRC_MEMBER_TAL_CHECK(Map<String, String> parameterMap);
	// 탈퇴
	public void PRC_MEMBER_TAL(Map<String, String> parameterMap);
	
	// 정보 수정
	public int totalUpdate(MyPageDTO dto);
	
	
	// 사진 보류 ㅜㅜ
	//public int updatePhoto(String srcName,String id);
}
