package com.sbs.hsb.ex1.dto;

import java.util.Map;

import org.springframework.web.util.HtmlUtils;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class Reply {
	private int id;
	private String regDate;
	private String updateDate;
	private boolean delStatus;
	private String delDate;
	private boolean displayStatus;
	private int relId;
	private String relTypeCode;
	private int memberId;
	private String body;
	private Map<String, Object> extra;

	@JsonProperty("forPrintBody")
	public String getForPrintBody() {
		String bodyForPrint = HtmlUtils.htmlEscape(body);
		bodyForPrint = bodyForPrint.replace("\n", "<br>");

		return bodyForPrint;
	}
	
	public String getDetailLink(String boardCode, int articleId) {
		return "/usr/article/" + boardCode + "-detail?id=" + articleId;
	}
}