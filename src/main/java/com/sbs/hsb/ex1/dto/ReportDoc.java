package com.sbs.hsb.ex1.dto;

import java.util.Map;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class ReportDoc {
	private int id;
	private String regDate;
	private String delDate;
	private boolean delStatus;
	private int boardId;
	private int articleId;
	private int memberId;
	private String reportType;
	private String reportBody;
	private Map<String, Object> extra;
}