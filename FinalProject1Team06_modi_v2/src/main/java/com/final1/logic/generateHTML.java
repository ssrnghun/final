package com.final1.logic;

import java.util.ArrayList;

public class generateHTML
{
	public static String passCheck(ArrayList<RoomMemberDTO> arrayList)
	{
		StringBuilder htmlBuilder = new StringBuilder();
		htmlBuilder.append("<div id=\"passCheck\" class='justify-content-center row'>");
		String floating = "'";
	    for (RoomMemberDTO pass : arrayList) 
	    {
	    	if(Integer.parseInt(pass.getDay()) % 10 != 0)
	    	{
	    		floating = "float:left;'";
	    	}
	    	
	    	htmlBuilder.append("<div class=\"col-2\" style='margin: 4px;"+floating+">&nbsp;"+pass.getDay()+"일차<br>");
	    	
	    	// 방장 요청 없을 때
	    	if(pass.getHostCount() ==0)
	    	{
	    		htmlBuilder.append("<button type='button' class='btn btn-light shadow'"
	    				+ "onclick=\"hostPass(this)\"} "
	    				+ "id='"+pass.getDay()+"/cancle' style='border-radius: 1rem; border: 2px solid #ffef85;background-color: white;width: 110px; height: 65px;'>"
	    				+"<span style=\"font-weight: normal; font-size: smaller; color: orange;\">PASS 하기</span></button>");
	    	}
	    	else //방장 요청 있을 때
	    	{
	    		//
	    		if(!pass.getCheckFix().equals("0"))
    			{
    				htmlBuilder.append("<button type='button' class='btn btn-light shadow'"
    						+ "id='"+pass.getDay()+"/' style='border-radius: 1rem; background-color: #C6C6C6; width: 110px; height: 65px;' disabled>"
    						+"<span style=\"font-weight: bold; font-size: 15px; color: red;\">FIX</span></button>");
    				
    			}else if(pass.getCheckFix().equals("0") && pass.getPassdelcheck().equals("CANDEL"))
    			{

    				htmlBuilder.append("<button type='button' class='btn btn-light shadow'"
    						+ "onclick=\"hostPass(this)\"" 
    						+ "id='"+pass.getDay()+"/cancle' style='border-radius: 1rem; border: 2px solid #ffef85;background-color: orange;width: 110px; height: 65px;'>"
    						+"<span style=\"font-weight: normal; font-size: smaller; color: white;\">PASS 취소 </span></button>"
    						+ "<br><button class=\"mx-3 passList\" id='"+pass.getDay()+"' onclick=\"passList(this)\"><i class=\"bi bi-arrow-right\"></i>패스현황보기</button>");
    			}
    			else if (pass.getCheckFix().equals("0") && pass.getPassdelcheck().equals("CANNOTDEL"))
    			{
    				htmlBuilder.append("<button type='button' class='btn btn-light shadow'"
    						+ "onclick=\"hostPass(this)\" disabled} "
    						+ "id='"+pass.getDay()+"/cancle' style='border-radius: 1rem; border: 2px solid #909090;background-color: gray;width: 110px; height: 65px;'disabled>"
    						+"<span style=\"font-weight: bold; font-size: smaller; \">PASS<br> 취소 불가</span></button>"
    						+ "<br><button class=\"mx-3 passList\" id='"+pass.getDay()+"' onclick=\"passList(this)\"><i class=\"bi bi-arrow-right\"></i>패스현황보기</button>");
    			}
	    	}
	    	
	    	htmlBuilder.append("</div>");
	    }
	    htmlBuilder.append("<div id=\"dayPassList\"></div></div>");

	    return htmlBuilder.toString();
	}
	
	public static String passMemCheck(ArrayList<RoomMemberDTO> arrayList)
	{
		StringBuilder htmlBuilder = new StringBuilder();
		
		String floating = "'";
		htmlBuilder.append("<div id=\"passCheck\" class='justify-content-center row'>");
	    for (RoomMemberDTO pass : arrayList) 
	    {
	    	if(Integer.parseInt(pass.getDay()) % 10 != 0)
	    	{
	    		floating = "float:left;'";
	    	}
	    	
	    	htmlBuilder.append("<div class=\"col-2\" style='margin: 4px;"+floating+">&nbsp;"+pass.getDay()+"일차<br>");
	    	
	    	// 방장 패스 요청이 없을 때 → PASS 요청 없음 버튼
	    	if(pass.getHostCount() ==0 )
	    	{
	    		htmlBuilder.append("<button type='button' class='btn btn-light shadow'"
	    				+ "id='"+pass.getDay()+"/' style='border-radius: 1rem; border: 3px solid #909090; width: 110px; height: 65px; "
	    						+ "background-color: white;' disabled>"
	    				+"<span style=\"font-weight: bold; font-size: smaller; color:#909090;\">PASS</span><br>"
	    				+ "<span style=\"font-weight: bold; font-size: smaller; color: #909090;\">요청 없음</span></button>");
	    	}
	    	else  //방장 패스 요청 있을 때 
	    	{
	    		if(pass.getMemCount()==0 && pass.getCheckFix().equals("0")) // 멤버 패스 버튼 안눌렀을 때 → 방장 PASS 요청 ! 
	    		{
	    			htmlBuilder.append("<button type='button' class='btn btn-light shadow' onclick=\"memPass(this)\""
		    				+ "id='"+pass.getDay()+"/pass' style='border-radius: 1rem; border: 3px solid #ffef85; background-color: white;width: 110px; height: 65px;'>"
		    				+"<span style=\"font-weight: bold; font-size:  15px; color: orange;\">PASS 하기</span>"
		    				+ "<br><span style=\"font-size: 6px; color: red\">방장 PASS 요청!</span></button>"
		    				+ "<br><button class=\"mx-3 passList\" id='"+pass.getDay()+"'onclick=\"passList(this)\"><i class=\"bi bi-arrow-right\"></i>패스현황보기</button>");
	    		}
	    		else // 멤버 패스 버튼 눌렀을 때 → PASS 완료  
	    		{
	    			if(!pass.getCheckFix().equals("0"))
	    			{
	    				htmlBuilder.append("<button type='button' class='btn btn-light shadow'"
	    						+ "id='"+pass.getDay()+"/' style='border-radius: 1rem; background-color: #C6C6C6; width: 110px; height: 65px;' disabled>"
	    						+"<span style=\"font-weight: bold; font-size: 15px; color: red;\">FIX</span></button>");
	    			}
	    			else
	    			{
	    				htmlBuilder.append("<button type='button' class='btn btn-light shadow' onclick='memPass(this)'"
	    						+ "id='"+pass.getDay()+"/cancle' style='border-radius: 1rem; border: 2px solid #ffef85;background-color: orange; width: 110px; height: 65px;'>"
	    						+"<span style=\"font-weight: bold; font-size: 15px; color: white;\">PASS 취소</span></button>"
	    						+ "<br><button class=\"mx-3 passList\" id='"+pass.getDay()+"' onclick=\"passList(this)\"><i class=\"bi bi-arrow-right\"></i>패스현황보기</button>");
	    			}
	    		}
	    	}
	    	
	    	htmlBuilder.append("</div>");
	    }
	    htmlBuilder.append("<div id=\"dayPassList\"></div></div>");

	    return htmlBuilder.toString();
	}
	
	public static String dayPassList(RoomMemberDTO hostDto, ArrayList<RoomMemberDTO> memList, String day)
	{
		StringBuilder htmlBuilder = new StringBuilder();
		
		htmlBuilder.append("<hr>");
		htmlBuilder.append("<span class=\"px-3\" style=\"font-size: 16px; font-weight: bold\">"+day+"일차 패스 현황</span>");
		htmlBuilder.append("   		<div class=\"g-1 justify-content-center position-relative d-flex\">");
		htmlBuilder.append("<div class=\"mx-1 my-2 p-1 justify-content-center passMem\">");
		htmlBuilder.append("<span class=\"p-3 passNik\">"+hostDto.getNickname()+"<img src=\"images/왕관.png\" width=\"20px;\"/></span><br>");
		htmlBuilder.append("<img class=\"p-1 mx-4 passImg\" src=\""+hostDto.getPhoto()+"\" ><br>");
		htmlBuilder.append("<span class=\"p-4 yespass\" >PASS</span></div>");
		
		
		for(RoomMemberDTO mem: memList)
		{
			htmlBuilder.append("<div class=\"mx-1 my-2 p-1 justify-content-center passMem\">");
			htmlBuilder.append("<span class=\"p-4 mx-2 passNik\" >"+mem.getNickname()+"</span><br>");
			htmlBuilder.append("<img class=\"p-1 mx-4 passImg\" src=\""+mem.getPhoto()+"\" ><br>");
			
			if(mem.getCheckPass().equals("PASS"))
			{
				htmlBuilder.append("<span class=\"p-4 yespass\" >PASS</span>");
			}
			else
			{
				htmlBuilder.append("<span class=\"p-2 nopass\">NO PASS</span>");
			}
			
			htmlBuilder.append("</div>");
		}
		
		return htmlBuilder.toString();
	}
	
	public static String checkListHTML(ArrayList<CollectionDTO> arraylist)
	{
		StringBuilder htmlBuilder = new StringBuilder();
		
		for(CollectionDTO dto :arraylist)
		{
			htmlBuilder.append("<ul class='shadow bg-body p-2 rounded list-group list-group-horizontal rounded bg-white'>");
			htmlBuilder.append("	<li class='list-group-item d-flex align-items-center rounded-0 border-0 bg-transparen'> ");                                                                     
			htmlBuilder.append("	<div class='form-check'>  ");                                                                                                                                         
			htmlBuilder.append("		<input class='form-check-input me-0' type='checkbox' value='' id='flexCheckChecked2' aria-label='...' />    ");                                                                                                                                           
			htmlBuilder.append("	 </div>    ");                                                                                                                                                         
			htmlBuilder.append("	</li>");
			htmlBuilder.append("	 <li class='list-group-item d-flex align-items-center flex-grow-1 border-0 bg-transparent'>");
			htmlBuilder.append("		<p class='lead fw-normal mb-0'>"+dto.getChklist_cnt()+"</p>");
			htmlBuilder.append("			</li>");
			htmlBuilder.append("	<li class='list-group-item ps-3 pe-10 py-1 rounded-0 border-0 bg-transparent'>");
			if(dto.getChecking().equals("1"))
			{
				htmlBuilder.append("		<button type='submit' class='btn btn-danger' style='border:none;'");
				htmlBuilder.append("			value='"+dto.getChklist_num()+"' onclick='deleteCheckList(this.value)'>삭제</button>");
			}
			htmlBuilder.append("	 </li>");
			htmlBuilder.append(" </ul>  ");
		}
		
		return htmlBuilder.toString();
	}
}

