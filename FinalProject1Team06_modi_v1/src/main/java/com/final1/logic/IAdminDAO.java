package com.final1.logic;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

public interface IAdminDAO
{
	// 회원 리스트 출력
	public ArrayList<MemberListDTO> memberList(@Param("start")int start, @Param("end")int end);
	
	// 회원 인원 수
	public int count();
	
	// 회원 검색 리스트 출력
	public ArrayList<MemberListDTO> searchMemberList(@Param("searchKey") String searchKey
			, @Param("searchValue") String searchValue, @Param("start")int start, @Param("end")int end);
	
	// 회원 검색 리스트 인원 수
	public int searchMemberCount(@Param("searchKey") String searchKey, @Param("searchValue") String searchValue);
	
	
	
	
	// 전체 패널티 현황 출력
	public ArrayList<PenaltyListDTO> penaltyList(@Param("start")int start, @Param("end")int end);
	
	// 검색 패널티 현황 출력
	public ArrayList<PenaltyListDTO> searchPenaltyList(@Param("searchKey") String searchKey, @Param("searchValue") String searchValue
			, @Param("start")int start, @Param("end")int end);
	
	// 검색 패널티 현황 건수
	public int searchPenaltyCount(@Param("searchKey") String searchKey, @Param("searchValue") String searchValue);
	
	// 전체 패널티 현황 건수
	public int penaltyCount();
	
	
	
	
	// 전체 신고 현황 출력
	public ArrayList<ReportListDTO> reportList(@Param("start")int start, @Param("end")int end);
	
	// 검색 신고 현황 출력
	public ArrayList<ReportListDTO> searchReportList(@Param("searchKey") String searchKey, @Param("searchValue") String searchValue
			, @Param("start")int start, @Param("end")int end);
	
	// 검색 신고 현황 건수
	public int searchReportCount(@Param("searchKey") String searchKey, @Param("searchValue") String searchValue);
	
	// 전체 신고 현황 건수
	public int reportCount();
	
	
	
	
	// 특정 인원의 신고 세부 현황
	public ReportListDTO searchId(int num);
	
	// 계정 정지 여부 확인
	public String checkStopId(String id);
	
	// 방 신고처리 테이블 삽입
	public int addRoom(ReportListDTO dto);
	
	// 방 신고 패널티 테이블 삽입
	public int addRoomPenalty(ReportListDTO dto);
	
	// 컬렉션메모 신고처리 테이블 삽입
	public int addCollectionMemo(ReportListDTO dto);
	
	// 컬렉션메모 신고 패널티 테이블 삽입
	public int addCollectionMemoPenalty(ReportListDTO dto);
	
	// 플래너메모 신고처리 테이블 삽입
	public int addPlannerMemo(ReportListDTO dto);
	
	// 플래너메모 신고 패널티 테이블 삽입
	public int addPlannerMemoPenalty(ReportListDTO dto);
	
	// 프로필 신고 처리 테이블 삽입
	public int addProfile(ReportListDTO dto);
	
	// 프로필 신고 패널티 테이블 삽입
	public int addProfilePenalty(ReportListDTO dto);
	
	// 피드 신고 처리 테이블 삽입
	public int addFeed(ReportListDTO dto);
	
	// 피드 신고 패널티 테이블 삽입
	public int addFeedPenalty(ReportListDTO dto);

	
}
