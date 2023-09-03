/*==============
 * MyUtil.java
 * - 게시판 페이징 처리
 ==============*/

// check!@@@
// 이번에 같이 확인해보고자 하는 페이징 처리 기법은
// 다양한 방법들 중 한가지(그나마 쉬운 것을 골라....) 이다.
// 학습을 마친 이후에.. 꼭~!!! 추가적으로 개념을 정리하고
// 확장 시키고, 다른 방법들도 찾아보고 공부할 수 있도록 하자~!!! 꼭~!!! 네~!!!

package com.final1.util;

public class MyUtil
{
	// ■ 전체 페이지 수를 구하는 메소드
	// numPerPage : 한 페이지에 표시할 데이터(게시물)의 수
	// dataCount : 전체 데이터(게시물) 수
	public int getPageCount(int numPerPage, int dataCount)
	{
		int pageCount = 0;
		
		pageCount = dataCount / numPerPage;
		
		if(dataCount%numPerPage != 0)
			pageCount++;
		
		return pageCount;
		
	}
	//-- 한 페이지에 10개의 게시물을 출력할 때
	//   총 32개의 게시물을 페이지로 구성하기 위해서는
	//  『32/10』 의 연산을 수행하여 결과 3을 얻을 수 있다.
	//   → 『pageCount = dataCount / numPerPage;』
	//   그런데 이 떄, 나머지 2개의 게시물을 출력해 주기 위해서는
	//   페이지 하나가 더 필요하다.
	//   → 『pageCount++;』

	
	// ■ 페이징 처리 기능의 메소드
	// currentPage : 현재 표시할 페이지
	// totalPage : 전체 페이지 수
	// listUrl : 링크를 설정할 url
	public String pageIndexList(int currentPage, int totalPage, String listUrl)
	{
		// 실제 페이징을 저장할 StringBuffer 변수 
		StringBuffer strList = new StringBuffer();
		
		int numPerBlock = 5;
		//-- 페이징 처리 시 게시물 리스트 하단의 숫자를 10개씩 보여주겠다. 
		
		int currentPageSetup;
		//-- 현재 페이지를 세팅하는 변수 (이 페이지를 기준으로 보여주는 숫자가 달라져야 하기 때문..)
	
		int page;
		int n;
		//-- 이전 페이지 블럭과 같은 처리에서 이동하기 위한 변수
		//   (얼마만큼 이동해야 하는지..)
		
		// 페이징 처리가 별도로 필요하지 않은 경우 
		//-- 데이터가 즉, 게시물이 존재하지 않아 페이징 처리를 할 필요가 없는 경우
		if(currentPage==0)
			return "";
		//-- 게시물이 하나도 없음 → 페이지 블럭 필요 없엉
		
		// ※ 페이지 요청을 처리하는 과정에서
		//    URL 경로의 패턴에 대한 처리
		/*
		 * 	- 클라이언트 요청의 형태 → List.jsp → (가공) → List.jsp + 『?』 + pageNum=1
		 * 							 → 『List.jsp?pageNum=1』 와 같은 형태
		 * 
		 * 	- 클라이언트 요청의 형태 → List.jsp?searchKey=title
		 * 							 → (가공)
		 * 							 → List.jsp?searchKey=title + 『&』 + pageNum=1
		 * 							 → 『List.jsp?searchKey=title&pageNum=1』 와 같은 형태
		 */
		
		// 링크를 설정할 URL 에 대한 사전 가공 처리~!!!
		if(listUrl.indexOf("?") != -1) 	// 링크를 설정할 URL 에 『?』 가 들어있으면...
			listUrl = listUrl + "&";	// listUrl += "&";
		else							// 링크를 설정할 URL 에 『?』 가 없으면...
			listUrl = listUrl + "?";	// listUrl += "?";
		//-- 예를 들어, 검색값이 존재하면,,,
		//   이미 request 에 searchKey 와 searchValue 가 들어있는 상황이므로
		//   『&』를 붙여서 속성을 추가해 주어야 한다. 
		
		// currentPageSetup = 표시할 리스트 페이지 중 첫 페이지 - 1 (즉, 0, 10, 20, 30. ... 이 될 수 있음)
		currentPageSetup = (currentPage / numPerBlock) * numPerBlock;
		//-- 현재 페이지(currentPage)의 1의 자리를 버리는 과정 (ex. 28 -> 20)
		//-- 만약 현재 페이지가 5페이지이고(currentPage=5)
		//   리스트 하단에 보여줄 페이지 갯수가 10 이면(numPerBlock=10)
		//   『5 / 10 = 0』 이며... 여기에 『* 10』 (10을 곱해도) 0 이다.
		//   하지만, 현재 페이가 11페이지라면(currentPate=11)
		//   『11 / 10 = 1』 이며... 여기에 『* 10』 (10을 곱해면) 10 이다.
		//   그러면... currentPateSetup 은 10 이 되는 것이다. 
		
		if(currentPage % numPerBlock == 0)
			currentPageSetup = currentPageSetup - numPerBlock;
		//-- 만약 위 처리에서... (라인 88)
		//   현재 페이지가 20 페이지였다면(currentPage=20)
		//   『20 / 10 = 2』 이며... 여기에 『* 10』 (10을 곱해서) 20이 되는데, 
		//   이와 같은 상황이라면.. 다시 10을 빼서 10으로 만들어주기 위한 구문. 
		
		// 1 페이지(맨처음으로)
		if((totalPage>numPerBlock) && (currentPageSetup>0))
			strList.append("<li class=\"page-item\"><a class=\"page-link\" href=\""+listUrl+"pageNum=1\" aria-label=\"Previous\">"
					
					+ "<span aria-hidden=\"true\">&laquo;</span></a></li>");
		//-- listUrl 은 위에서 (라인 79~82) 이미 전처리가 끝난 상황이기 때문에
		//   『...?』 상태 또는 『...?...&』 인 상태이다.
		//   이로 인해 결과는
		//   『...?pageNum=1』 인거나 『...&pageNum=1』 이 되는 상황이다. 
		
		// Prev 페이지(이전페이지로)
		n = currentPage - numPerBlock;
		//-- n : 해당 페이지만큼 앞으로 가기 위한 변수
		//-- 현재 24페이지에서 Prev(이전)을 누르면 10~20의 블럭이 보여지고 현재 페이지는 14가 되는겨. 
		
		if((totalPage>numPerBlock) && (currentPageSetup>0))
			strList.append("<li class=\"page-item\"><a class=\"page-link\" href=\""+listUrl 
					+ "pageNum=" + n +"\">Prev</a></li>");
		//-- currentPateSetup 이 0 보다 큰 경우는
		//   이미 페이지가 11 페이지 이상이라는 의미이며
		//   이 떄, 현재 페이지가(currentPage)가 11 이상일 경우
		//   『Prev』 를 붙이기 위한 구문.
		//   『Prev』 를 클릭할 경우
		//   n 변수 페이지로 이동하는데
		//   12 에서 『Prev』 할 경우 2 페이지가 되고,
		//   22에서 『Prev』 할 경우 12 페이지가 될 수 있도록 처리하는 방식이다. 
		
		// 각 페이지 바로가기
		page = currentPageSetup + 1;
		//-- 『+1』을 수행하는 이유는
		//   앞에서 currentPageSetup 에서 10 을 가져왔다면
		//   10 부터 시작하는 것이 아니라
		//   바로가기 페이지는 11 부터 시작해야 하기 때문이다. 
		
		while((page<=totalPage) && (page<=currentPageSetup+numPerBlock))
		{
			if(page==currentPage)
				strList.append("<li class=\"page-item active\" aria-current=\"page\">"
						+ "<a class=\"page-link\">"+page+"</a></li>");
			else
				strList.append("<li class=\"page-item\"><a class=\"page-link\" "
						+ "href=\""+listUrl+"pageNum="+page+"\">"+page+"</a></li>");
			page++;
		}
		
		// Next 페이지 (다음페이지로)
		n = currentPage + numPerBlock;
		if((totalPage-currentPageSetup) > numPerBlock )
			strList.append("<li class=\"page-item\"><a class=\"page-link\" href=\""
							+listUrl + "pageNum=" + n +"\">Next</a></li>");
		
		
		// 마지막 페이지(마지막으로)
		if( (totalPage>numPerBlock) && (currentPageSetup+numPerBlock)<totalPage )
			strList.append(" <a href='" + listUrl + "pageNum=" + totalPage +
					"'>" + totalPage + "</a>");
		
		// 최종 페이징 처리된 내용 반환
		return strList.toString();
		
	}// end pageIndexList(int currentPage, int totalPage, String listUrl)
	
	/*
	 <a href='...'>1</a> <a href='...'>Prev</a> <a href='...'>11</a> <a href='...'>12</a> 
	  		...  <span>19</span> <a href='...'>20</a> <a href='...'>Next</a> <a href='...'>32</a>
	 				  ----
	 				  현재 있는 페이지
	 ↓
	 
	 1 Prev 11 12 13 14 15 16 17 18 19 20 Next 32
	 								--
	 
	 */
	
	
		
	
	
}













































