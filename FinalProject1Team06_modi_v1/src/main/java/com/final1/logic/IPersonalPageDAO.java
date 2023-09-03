/*======================
 	ISampleDAO.java
 	- 인터페이스
========================*/

package com.final1.logic;

import org.apache.ibatis.annotations.Param;

public interface IPersonalPageDAO
{
	// 에티켓 점수 부여 시 오늘 에티켓 점수 부여 여부 확인
	public int etiCount(MyPageDTO dto);
	// 에티켓 점수 부여
	public int etiScore(MyPageDTO dto);
	// 프로필 신고 접수
	public int pfReport1(ReportDTO dto);
	// 차단
	public int block(blockDTO dto);
	// 에티켓 점수 삭제
	public int etiDel(blockDTO dto);
	// 여행 점수 삭제
	public int tripDel(blockDTO dto);
	
	// 추가 ★
	public int blockCheck(@Param("blockedIdNum") String blockedIdNum, @Param("blockerIdNum") String blockerIdNum);
}
