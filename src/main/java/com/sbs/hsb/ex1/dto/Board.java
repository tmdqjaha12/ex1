package com.sbs.hsb.ex1.dto;

import java.util.Map;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class Board {
	private int id;
	private String regDate;
	private String updateDate;
	private String delDate;
	private boolean delStatus;
	private String name;
	private String code;
	private boolean applyStatus;
	
	private Map<String, Object> extra;
}