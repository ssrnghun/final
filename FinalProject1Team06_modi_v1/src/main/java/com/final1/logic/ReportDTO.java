package com.final1.logic;

public class ReportDTO
{
	String reportedId,reporterId, content;
	int  report_reason_num;
	public String getContent()
	{
		return content;
	}

	public void setContent(String content)
	{
		this.content = content;
	}
	public String getReportedId()
	{
		return reportedId;
	}

	public void setReportedId(String reportedId)
	{
		this.reportedId = reportedId;
	}

	public int getReport_reason_num()
	{
		return report_reason_num;
	}

	public void setReport_reason_num(int report_reason_num)
	{
		this.report_reason_num = report_reason_num;
	}

	public String getReporterId()
	{
		return reporterId;
	}

	public void setReporterId(String reporterId)
	{
		this.reporterId = reporterId;
	}
	
	
}
