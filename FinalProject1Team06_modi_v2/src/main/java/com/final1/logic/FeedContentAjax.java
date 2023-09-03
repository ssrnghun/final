package com.final1.logic;

import java.util.ArrayList;

public class FeedContentAjax
{
	public static String addContent(ArrayList<FeedDTO> arrayList, String id)
	{
		StringBuilder sb = new StringBuilder();
		
		for (FeedDTO dto : arrayList)
		{
			sb.append("<div class='mooon'>");
			sb.append("		<div class='peed_profile' style='margin-top: 1vh; margin-bottom: 0px;'>");
			sb.append("			<img alt='' src='" + dto.getPhoto() + " ' style='width: 70px; height: 70px; border-radius: 50%;'>");
			sb.append("			<p style='color: white; text-align: center;'>" + dto.getNickName() + "</p>");
			sb.append("		</div>");
			sb.append("		<div class='mooon2'>");
			sb.append("			<div class='peed_content_content'>");
			sb.append("				<p style='color: white; width: 800px; text-align: left;'>" + dto.getContent() +"</p>");
			sb.append("			</div>");
			sb.append("			<div class='peed_time'>");
			sb.append("				<p style='color: white;'>" + dto.getWriteTime() + "</p>");
			sb.append("			</div>");
			sb.append("			<div class='contentDelete'>");
			
			if (dto.getId().equals(id) && dto.getCount().equals("0"))
			{
				sb.append("<button type='button' class='btn btn-success btnDel' id='btnDel' name='btnDel' value='" + dto.getFeedNum() + "'>삭제</button>");
			}
			else
			{
				sb.append("<button type='button' class='btn btn-danger' id='btnReport' name='btnReport'>신고</button>");
			}

			sb.append("			</div>");
			sb.append("		</div>");
			sb.append("</div>");
			
		}
		
		return sb.toString();
		
	}
}
