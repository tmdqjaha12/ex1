package com.sbs.hsb.ex1.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sbs.hsb.ex1.dto.Article;
import com.sbs.hsb.ex1.dto.Board;
import com.sbs.hsb.ex1.dto.Member;
import com.sbs.hsb.ex1.dto.ResultData;
import com.sbs.hsb.ex1.service.ArticleService;
import com.sbs.hsb.ex1.util.Util;

@Controller
public class ArticleController {
	@Autowired
	private ArticleService articleService;

	@RequestMapping("/usr/article/{boardCode}-list")
	public String showList(Model model, @PathVariable("boardCode") String boardCode, HttpServletRequest req ) {
		Board board = articleService.getBoardByCode(boardCode);
		model.addAttribute("board", board);
		
		// 검색 관련 기능 추가 시작
		//page
		int page = 1;
		if (Util.isNum(req.getParameter("page"))) {
			page = Util.getInt(req, "page");
		}
		
		//boardid
		int boardId = board.getId();
		
		//searchKeywordType
		String searchKeywordType = "";
		if (Util.isNum(req.getParameter("searchKeywordType"))) {
			searchKeywordType = Util.getString(req, "searchKeywordType");
		}
		
		//searchKeyword
		String searchKeyword = "";
		if (Util.isNum(req.getParameter("searchKeyword"))) {
			searchKeyword = Util.getString(req, "searchKeyword");
		}
		
		//page AND count
		int itemsInAPage = 10;
		int totalCount = articleService.getForPrintListArticlesCount(boardId, searchKeywordType, searchKeyword);
		int totalPage = (int) Math.ceil(totalCount / (double) itemsInAPage);
		
		int nowPage = page;
		
		if(page % 5 != 0) {
			page = page/5;
			page = (page*5)+1;
		} else if(page % 5 == 0) {
			page = page - 4;
		}
		
		req.setAttribute("page", page);
		
		req.setAttribute("totalCount", totalCount);
		req.setAttribute("totalPage", totalPage);
		req.setAttribute("cPagedoReply", page);
		
		
		List<Article> articles = articleService.getForPrintListArticles(nowPage, itemsInAPage, boardId,
				searchKeywordType, searchKeyword);

		model.addAttribute("articles", articles);

		System.out.println("articles~~ : " + articles);
		
		return "article/list";
	}

	@RequestMapping("/usr/article/{boardCode}-detail")
	public String showDetail(Model model, @RequestParam Map<String, Object> param, HttpServletRequest req, @PathVariable("boardCode") String boardCode, String listUrl) {
		if ( listUrl == null ) {
			listUrl = "./" + boardCode + "-list";
		}
		model.addAttribute("listUrl", listUrl);
		
		Board board = articleService.getBoardByCode(boardCode);
		model.addAttribute("board", board);
		
		int id = Integer.parseInt((String) param.get("id"));
		articleService.increaseArticleHit(id);
		
		Member loginedMember = (Member)req.getAttribute("loginedMember");
		Article article = articleService.getForPrintArticleById(loginedMember, id);
		model.addAttribute("article", article);

		return "article/detail";
	}
	
	@RequestMapping("/usr/article/{boardCode}-modify")
	public String showModify(Model model, @RequestParam Map<String, Object> param, HttpServletRequest req, @PathVariable("boardCode") String boardCode, String listUrl) {
		model.addAttribute("listUrl", listUrl);
		
		Board board = articleService.getBoardByCode(boardCode);
		model.addAttribute("board", board);
		
		int id = Integer.parseInt((String) param.get("id"));
		
		Member loginedMember = (Member)req.getAttribute("loginedMember");
		Article article = articleService.getForPrintArticleById(loginedMember, id);

		model.addAttribute("article", article);

		return "article/modify";
	}

	@RequestMapping("/usr/article/{boardCode}-write")
	public String showWrite(@PathVariable("boardCode") String boardCode, Model model, String listUrl) {
		if ( listUrl == null ) {
			listUrl = "./" + boardCode + "-list";
		}
		model.addAttribute("listUrl", listUrl);
		Board board = articleService.getBoardByCode(boardCode);
		model.addAttribute("board", board);
		
		return "article/write";
	}
	
	@RequestMapping("/usr/article/{boardCode}-doModify")
	public String doModify(@RequestParam Map<String, Object> param, HttpServletRequest req, int id, @PathVariable("boardCode") String boardCode, Model model) {
		Board board = articleService.getBoardByCode(boardCode);
		model.addAttribute("board", board);
		Map<String, Object> newParam = Util.getNewMapOf(param, "title", "body", "fileIdsStr", "articleId", "id");
		Member loginedMember = (Member)req.getAttribute("loginedMember");
		
		ResultData checkActorCanModifyResultData = articleService.checkActorCanModify(loginedMember, id);
		
		if (checkActorCanModifyResultData.isFail() ) {
			model.addAttribute("historyBack", true);
			model.addAttribute("msg", checkActorCanModifyResultData.getMsg());
			
			return "common/redirect";
		}
		
		articleService.modify(newParam);
		
		String redirectUri = (String) param.get("redirectUri");

		return "redirect:" + redirectUri;
	}

	@RequestMapping("/usr/article/{boardCode}-doWrite")
	public String doWrite(@RequestParam Map<String, Object> param, HttpServletRequest req, @PathVariable("boardCode") String boardCode, Model model) {
		Board board = articleService.getBoardByCode(boardCode);
		model.addAttribute("board", board);
		
		Map<String, Object> newParam = Util.getNewMapOf(param, "title", "body", "fileIdsStr");
		int loginedMemberId = (int)req.getAttribute("loginedMemberId");
		newParam.put("boardId", board.getId());
		newParam.put("memberId", loginedMemberId);
		int newArticleId = articleService.write(newParam);

		String redirectUri = (String) param.get("redirectUri");
		redirectUri = redirectUri.replace("#id", newArticleId + "");

		return "redirect:" + redirectUri;
	}
	
	@RequestMapping("/usr/article/{boardCode}-doDelete")
	public String doDelete(Model model, @PathVariable("boardCode") String boardCode, HttpServletRequest req) {
		Board board = articleService.getBoardByCode(boardCode);
		model.addAttribute("board", board);
		int loginedMemberId = (int)req.getAttribute("loginedMemberId");
		int id = Integer.parseInt((String)req.getParameter("id"));

		articleService.doDelete(loginedMemberId, board.getId() ,id);
		
		model.addAttribute("redirectUri", "/usr/article/"+ board.getCode() +"-list");
		model.addAttribute("msg", "삭제 완료");
		
		return "common/redirect";
	}
	
	//좋아요 기능
	@RequestMapping("/usr/article/doLike")
	public String doDelete(Model model, int id, String redirectUrl, HttpServletRequest request) {

		int loginedMemberId = (int) request.getAttribute("loginedMemberId");

		Map<String, Object> articleLikeAvailableRs = articleService.getArticleLikeAvailable(id, loginedMemberId);

		if (((String) articleLikeAvailableRs.get("resultCode")).startsWith("F-")) {
			model.addAttribute("alertMsg", articleLikeAvailableRs.get("msg"));
			model.addAttribute("historyBack", true);

			return "common/redirect";
		}

		Map<String, Object> rs = articleService.likeArticle(id, loginedMemberId);

		String msg = (String) rs.get("msg");

		model.addAttribute("alertMsg", msg);
		model.addAttribute("locationReplace", redirectUrl);

		return "common/redirect";
	}
}