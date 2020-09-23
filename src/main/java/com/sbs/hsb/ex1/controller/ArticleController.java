package com.sbs.hsb.ex1.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sbs.hsb.ex1.dto.Article;
import com.sbs.hsb.ex1.dto.Board;
import com.sbs.hsb.ex1.dto.Member;
import com.sbs.hsb.ex1.dto.Reply;
import com.sbs.hsb.ex1.dto.ResultData;
import com.sbs.hsb.ex1.service.ArticleService;
import com.sbs.hsb.ex1.service.MemberService;
import com.sbs.hsb.ex1.util.Util;

@Controller
public class ArticleController {
	@Autowired
	private ArticleService articleService;
	@Autowired
	private MemberService memberService;

	// 커뮤니티별 리스트
	@RequestMapping("/usr/article/{boardCode}-list")
	public String showList(Model model, @PathVariable("boardCode") String boardCode, HttpServletRequest req, @RequestParam Map<String, Object> param ) {
		Board board = articleService.getBoardByCode(boardCode);
		model.addAttribute("board", board);
		
		//기본값 넣어주자
		int boardId = 1;
		int page = 1; 		
		String searchKeywordType = ""; 
		String searchKeyword = "";
		
		boardId = board.getId();
		if(param.get("page") != null) {
			page = Integer.parseInt((String) param.get("page"));
		}
		if(param.get("searchKeywordType") != null) {
			searchKeywordType = (String) param.get("searchKeywordType");
		}
		if(param.get("searchKeyword") != null) {
			searchKeyword = (String) param.get("searchKeyword");
		}

		
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

		req.setAttribute("nowPage", nowPage);	
		req.setAttribute("page", page);		
		req.setAttribute("totalCount", totalCount);
		req.setAttribute("totalPage", totalPage);
		req.setAttribute("cPagedoReply", page);
		
		List<Article> articles = articleService.getForPrintListArticles(nowPage, itemsInAPage, boardId,
				searchKeywordType, searchKeyword);
		model.addAttribute("articles", articles);
		
		List<Article> notices = articleService.getForPrintNotices();
		model.addAttribute("notices", notices);
		
		List<Article> comuNotices = articleService.getForPrintComuNotices(boardId);
		model.addAttribute("comuNotices", comuNotices);
		
		return "article/list";
	}
	
	// 전체 검색 리스트
	@RequestMapping("/usr/article/alllist")
	public String showAlllist(Model model, HttpServletRequest req, @RequestParam Map<String, Object> param ) {
		
		//기본값 넣어주자
		int boardId = 1;
		int page = 1; 		
		String searchKeywordType = ""; 
		String searchKeyword = "";
		
		if(param.get("page") != null) {
			page = Integer.parseInt((String) param.get("page"));
		}
		if(param.get("searchKeywordType") != null) {
			searchKeywordType = (String) param.get("searchKeywordType");
		}
		if(param.get("searchKeyword") != null) {
			searchKeyword = (String) param.get("searchKeyword");
		}

		
		int itemsInAPage = 10;
		int totalCount = articleService.getNotBoardIdForPrintListArticlesCount(searchKeywordType, searchKeyword);
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
		
		List<Article> articles = articleService.getNotBoardIdForPrintListArticles(nowPage, itemsInAPage,
				searchKeywordType, searchKeyword);

		model.addAttribute("articles", articles);
		
		return "article/list";
	}

	// 디테일
	@RequestMapping("/usr/article/{boardCode}-detail")
	public String showDetail(Model model, HttpSession session, @RequestParam Map<String, Object> param, HttpServletRequest req, @PathVariable("boardCode") String boardCode, String listUrl) {
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
		
	
		Member member = memberService.getProImg(article.getMemberId()); // 게시글 프로필 가져오기
		model.addAttribute("member", member);
		
		if(loginedMember != null) {// 추천 가능여부는 로그인이 되어있을때만
			Map<String, Object> articleLikeAvailableRs = articleService.getArticleLikeAvailable(id, loginedMember.getId());

			model.addAttribute("liked", true);
			if (((String) articleLikeAvailableRs.get("resultCode")).startsWith("F-")) {
				model.addAttribute("liked", false);
			}
		}
		

		return "article/detail";
	}
	
	// 수정 페이지
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

	// 글쓰기 페이지
	@RequestMapping("/usr/article/{boardCode}-write")
	public String showWrite(@PathVariable("boardCode") String boardCode, HttpServletRequest req, Model model, String listUrl) {
		if ( listUrl == null ) {
			listUrl = "./" + boardCode + "-list";
		}
		
		if(boardCode.equals("notice")) {
			Member loginedMember = (Member)req.getAttribute("loginedMember");
			if(loginedMember.getLevel() != 10) {
				model.addAttribute("historyBack", true);
				model.addAttribute("msg", "관리자 권한이 필요합니다.");
				
				return "common/redirect";
			}
		}
		
		model.addAttribute("listUrl", listUrl);
		Board board = articleService.getBoardByCode(boardCode);
		model.addAttribute("board", board);
		
		return "article/write";
	}
	
	// 수정 실행
	@RequestMapping("/usr/article/{boardCode}-doModify")
	public String doModify(@RequestParam Map<String, Object> param, HttpServletRequest req, int id, @PathVariable("boardCode") String boardCode, Model model) {
		
		if(param.get("displayStatus") == null){
			param.put("displayStatus", 1);
		}
		
		Board board = articleService.getBoardByCode(boardCode);
		model.addAttribute("board", board);
		Map<String, Object> newParam = Util.getNewMapOf(param, "title", "body", "fileIdsStr", "articleId", "id", "displayStatus");
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

	// 글쓰기 실행
	@RequestMapping("/usr/article/{boardCode}-doWrite")
	public String doWrite(@RequestParam Map<String, Object> param, HttpServletRequest req, @PathVariable("boardCode") String boardCode, Model model) {
		Board board = articleService.getBoardByCode(boardCode);
		model.addAttribute("board", board);
		
		if(param.get("displayStatus") == null){
			param.put("displayStatus", 1);
		}
		
		Map<String, Object> newParam = Util.getNewMapOf(param, "title", "body", "fileIdsStr", "displayStatus");
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
	
	// 게시물 신고 기능(리포트 저장)
	@RequestMapping("/usr/article/doSingoAjax")
	@ResponseBody
	public ResultData doSingoAjax(Model model, HttpServletRequest req, @RequestParam Map<String, Object> param ) {
		int loginedMemberId = (int) req.getAttribute("loginedMemberId");
		param.put("loginedMemberId", loginedMemberId);
		
		// 본인 게시물 신고 방지 (굳이 필요한가? jstl에서 방지했는데, 우선 보류.....!)ㄴㄴ
		// if() {
		// }				
		// articleBadPoint 말고 report 저장
		
		return articleService.setReportDoc(param);
	}
	
	//////////////////////////////////////////MYPAGE START//////////////////////////////////////////
	
	// 내 글 목록
	@RequestMapping("/usr/article/myPageArticleList")
	public String showMyPageArticleList(Model model, HttpServletRequest req, @RequestParam Map<String, Object> param ) {
		int loginedMemberId = (int) req.getAttribute("loginedMemberId");
		
		//기본값 넣어주자
		int boardId = 1;
		int page = 1; 		
		String searchKeywordType = ""; 
		String searchKeyword = "";
		
		if(param.get("page") != null) {
			page = Integer.parseInt((String) param.get("page"));
		}

		
		int itemsInAPage = 10;
		int totalCount = articleService.getNotBoardIdForPrintListArticlesCount(searchKeywordType, searchKeyword);
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
		
		List<Article> articles = articleService.getMyPageArticles(nowPage, itemsInAPage, loginedMemberId);

		model.addAttribute("articles", articles);
		
		return "article/myPageArticleList";
	}
}