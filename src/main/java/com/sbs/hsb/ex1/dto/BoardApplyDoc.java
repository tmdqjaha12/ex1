package com.sbs.hsb.ex1.dto;

import java.util.Map;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class BoardApplyDoc {
	private int id;
	private String regDate;
	private String updateDate;
	private String delDate;
	private boolean delStatus;
	private boolean applyStatus;
	private int memberId;
	private String name;
	private String body;
	private Map<String, Object> extra;
}