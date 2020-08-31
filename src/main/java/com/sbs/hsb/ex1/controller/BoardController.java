package com.sbs.hsb.ex1.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sbs.hsb.ex1.dto.ResultData;
import com.sbs.hsb.ex1.service.BoardService;

@Controller
public class BoardController {
	@Autowired
	private BoardService boardService;

	@Autowired

	@RequestMapping("/usr/board/createBoard")
	public String showCreateBoard(HttpServletRequest req, HttpSession session) {

		return "board/createBoard";
	}

	@RequestMapping("/usr/board/doSendBoardApplyDoc")
	public String doCreateBoard(@RequestParam Map<String, Object> param, HttpServletRequest req, Model model) {
		int loginedMemberId = (int) req.getAttribute("loginedMemberId");
		param.put("memberId", loginedMemberId);

		int newBoardApplyDocId = boardService.setBoardApplyDoc(param); // 신청서 저장

		String redirectUri = (String) param.get("redirectUri");

		model.addAttribute("redirectUri", redirectUri);
		// 추후에 myPage로 바로 이동 예정

		return "common/redirect";
	}

	// 게시판 증설 신청 name 중복 방지
	@RequestMapping("/usr/board/getNameDup")
	@ResponseBody
	public ResultData getNameDup(@RequestParam Map<String, Object> param, Model model) {
		String name = "";
		if (param.get("name").equals("")) {
			return new ResultData("X-1", "");
		}

		name = (String) param.get("name");
		return boardService.checkBoardNameable(name);
	}
}