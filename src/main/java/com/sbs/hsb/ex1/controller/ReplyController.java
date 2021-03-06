package com.sbs.hsb.ex1.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sbs.hsb.ex1.dto.Member;
import com.sbs.hsb.ex1.dto.Reply;
import com.sbs.hsb.ex1.dto.ResultData;
import com.sbs.hsb.ex1.service.MemberService;
import com.sbs.hsb.ex1.service.ReplyService;
import com.sbs.hsb.ex1.util.Util;


@Controller
public class ReplyController {
	@Autowired
	private ReplyService replyService;
	@Autowired
	private MemberService memberService;

	@RequestMapping("/usr/reply/getForPrintReplies")
	@ResponseBody
	public ResultData getForPrintReplies(@RequestParam Map<String, Object> param, HttpServletRequest req) {
		Member loginedMember = (Member) req.getAttribute("loginedMember");
		Map<String, Object> rsDataBody = new HashMap<>();

		param.put("relTypeCode", "article");
		Util.changeMapKey(param, "articleId", "relId");

		param.put("actor", loginedMember);
		List<Reply> replies = replyService.getForPrintReplies(param);
		rsDataBody.put("replies", replies);
		
		System.out.println("replies :: " + replies);

		return new ResultData("S-1", String.format("%d개의 댓글을 불러왔습니다.", replies.size()), rsDataBody);
	}

	@RequestMapping("/usr/reply/doWriteReplyAjax")
	@ResponseBody
	public ResultData doWriteReplyAjax(@RequestParam Map<String, Object> param, HttpServletRequest request) {
		Map<String, Object> rsDataBody = new HashMap<>();
		param.put("memberId", request.getAttribute("loginedMemberId"));
		
		boolean isValidBan = memberService.isValidUserBan((int)param.get("memberId"), (String)param.get("boardCode"));
		System.out.println("과연 " + isValidBan);
		if(isValidBan) {
			return new ResultData("B-1", String.format("회원님은 해당커뮤니티 밴 상태입니다."), rsDataBody);
		}

		int newReplyId = replyService.writeReply(param);
		rsDataBody.put("replyId", newReplyId);

		return new ResultData("S-1", String.format("%d번 댓글이 생성되었습니다.", newReplyId), rsDataBody);
	}

	@RequestMapping("/usr/reply/doDeleteReplyAjax")
	@ResponseBody
	public ResultData doDeleteReplyAjax(int id, HttpServletRequest req) {
		Member loginedMember = (Member) req.getAttribute("loginedMember");
		Reply reply = replyService.getForPrintReplyById(id);

		if (replyService.actorCanDelete(loginedMember, reply) == false) {
			return new ResultData("F-1", String.format("%d번 댓글을 삭제할 권한이 없습니다.", id));
		}

		replyService.deleteReply(id);

		return new ResultData("S-1", String.format("%d번 댓글을 삭제하였습니다.", id));
	}

	@RequestMapping("/usr/reply/doModifyReplyAjax")
	@ResponseBody
	public ResultData doModifyReplyAjax(@RequestParam Map<String, Object> param, HttpServletRequest req, int id) {
		Member loginedMember = (Member) req.getAttribute("loginedMember");
		Reply reply = replyService.getForPrintReplyById(id);

		if (replyService.actorCanModify(loginedMember, reply) == false) {
			return new ResultData("F-1", String.format("%d번 댓글을 수정할 권한이 없습니다.", id));
		}

		Map<String, Object> modfiyReplyParam = Util.getNewMapOf(param, "id", "body");
		ResultData rd = replyService.modfiyReply(modfiyReplyParam);

		return rd;
	}
	
	// 내 댓글 목록
	@RequestMapping("/usr/reply/myPageReplyList")
	public String showMyPageReplyList(Model model, HttpServletRequest req) {
		int loginedMemberId = (int) req.getAttribute("loginedMemberId");
		
		List<Reply> myReplyList = replyService.getMyReplyList(loginedMemberId);
		
		model.addAttribute("myReplyList", myReplyList);
		
		return "reply/myPageReplyList";
	}
}