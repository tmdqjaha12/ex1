package com.sbs.hsb.ex1.service;

import java.sql.Connection;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbs.hsb.ex1.dao.AttrDao;
import com.sbs.hsb.ex1.dto.Attr;

@Service
public class AttrService {
	
	@Autowired
	private AttrDao attrDao;

	public void setValue(String string, String value) {
		
		String[] nameBits = string.split("__");
		String relTypeCode = nameBits[0];
		int relId = Integer.parseInt(nameBits[1]);
		String typeCode = nameBits[2];
		String type2Code = nameBits[3];
		
		Map<String, Object> param = new HashMap<>();
		param.put("relTypeCode", relTypeCode);
		param.put("relId", relId);
		param.put("typeCode", typeCode);
		param.put("type2Code", type2Code);
		param.put("value", value);
		
		attrDao.setValue(param);
	}

	public String getValue(String string) {
		
		String[] nameBits = string.split("__");
		String relTypeCode = nameBits[0];
		int relId = Integer.parseInt(nameBits[1]);
		String typeCode = nameBits[2];
		String type2Code = nameBits[3];
		
		Map<String, Object> param = new HashMap<>();
		param.put("relTypeCode", relTypeCode);
		param.put("relId", relId);
		param.put("typeCode", typeCode);
		param.put("type2Code", type2Code);
		
		return attrDao.getValue(param);
	}

	public int remove(String string) {
		
		String[] nameBits = string.split("__");
		String relTypeCode = nameBits[0];
		int relId = Integer.parseInt(nameBits[1]);
		String typeCode = nameBits[2];
		String type2Code = nameBits[3];
		
		Map<String, Object> param = new HashMap<>();
		param.put("relTypeCode", relTypeCode);
		param.put("relId", relId);
		param.put("typeCode", typeCode);
		param.put("type2Code", type2Code);
		
		return attrDao.remove(param);
	}	
	
	// 밴 자동 해제 
	public void userBanAttrDelete() {
		attrDao.userBanAttrDelete();
	}
}