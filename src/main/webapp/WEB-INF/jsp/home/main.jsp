<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="메인" />
<%@ include file="../part/head.jspf"%>

<style>

	.background-home {
		background-color:#ebebf1; 
		height:100%; 
		padding:200px; 
		padding-top:10px;
		text-align: center;
	}
	
	
	.background-home > .search-box > form {
		display:block;
		white-space: nowrap;
	}
	
	.background-home > .search-box > form > select {
		width:100px;
		height:50px;
	} 
	
	.background-home > .search-box > form > input{
		padding: 10px 30px;
		font-size: 1.7rem;
	}
	
	.background-home > .search-box > form > button{
		padding: 16px 30px;
	}
	
	.background-home > .main-top-box {
		display:block;
		text-align:center;
		margin:0 auto;
		margin-top:40px;
	}
	
	.background-home > .main-top-box > .board-list-box{
		background-color: white; 
		display:inline-block;
		width:400px; 
		height:170px; 
		border:2px solid #6b6880; 
		overflow-x:hidden; 
		overflow-y:auto;
		margin:10px;
	}
	
	.background-home > .main-top-box > .board-list-box > select{
		width:100%;
		height:50px;
	}
	
	.background-home > .main-top-box > .board-list-box > .select-text-box {
		margin-top:16px;
	}
	
	.background-home > .main-top-box > .board-list-box > .select-text-box > a {
		font-weight: bold;
		font-size: 2rem;	
	}
	
	.background-home > .main-top-box > .member-box{
		background-color: white;
		display:inline-block;
		width:400px; 
		height:170px; 
		border:2px solid #6b6880; 
		overflow-x:hidden; 
		overflow-y:hidden;
		margin:10px;
	}
	
	.background-home > .main-top-box > .member-box > .login-box {
		margin-top:25px;
	}
	
	.background-home > .main-top-box > .member-box > .login-box > a {
		text-decoration: none;
		background: linear-gradient(to top, #b8b3c6, #ebebf1);
		border:3px solid #6b6880;
		font-weight: bold;
		font-size: 2rem;
		display: block;
		margin:0 10px;
		padding:10px;
	}
	
	.background-home > .main-top-box > .member-box > .login-box > a:hover {
	    background: linear-gradient(to bottom, #b8b3c6, #ebebf1);
        opacity: 0.7;
	}
	
	.background-home > .main-top-box > .member-box > .login-box > a:active {
        opacity: 1;
	}
	
	.background-home > .main-top-box > .member-box > .find-box {
		text-align:left;
		margin-left:20px;
		margin-top:20px;
	}
	.background-home > .main-top-box > .member-box > .join-box {
		text-align:right;
		margin-right:20px;
		margin-top:-24px;
	}

	.board {
		display: inline-block;
		background-color:white;
		border:2px solid #6b6880;
		width:400px;
		margin:50px;
	}

	
	/*
	@media (max-width: 600px) {
    .board  { width: 100%; }
	}
	@media (max-width: 600px) {
    .board-list-box  { width: 100%; }
	}
	@media (max-width: 600px) {
    .member-box  { width: 100%; }
	}margin:0 auto;
*/

	
	@media (max-width: 800px){
			.background-home {
				padding: 100px;
		}
	}
	
	@media (max-width: 800px) {
			.board {
				margin:0 auto;
				margin-top:30px;
				margin-bottom:30px;
		}
	}
	
	
		
	/*게시판박스*/	
	/*서치박스*/
	@media (max-width: 730px){
		.background-home > .search-box > form > select {
			width:70px;
			height:40px;
		} 
		
		.background-home > .search-box > form > input{
			width:260px;
			padding: 8px 12px;
			font-size:20px;
		}
		
		.background-home > .search-box > form > button{
			padding: 10px 15px;
		}
	}
	
	@media (max-width: 570px){
	/*서치박스*/
		.background-home > .search-box > form > select {
			width:70px;
			height:40px;
		} 
		
		.background-home > .search-box > form > input{
			width:165px;
			padding: 8px 12px;
			font-size:15px;
		}
		
		.background-home > .search-box > form > button{
			padding: 10px 15px;
		}
		
		
		/* 박스 */
			.board {
				width:300px;
		} 
		
		/* 박스 제목 */
		    .article-title {
		    	width:70px !important;
		}
		/* 커뮤니티 박스 & 회원 박스 */
			.background-home > .main-top-box {
		}    
		    .background-home > .main-top-box > .board-list-box,
		     .background-home > .main-top-box > .member-box{
		    	width:300px;
		    	margin-left:0px;
		}
		/* 커뮤니티 리스트 */
			.background-home > .main-top-box > .board-list-box > .select-text-box > a {
				font-size:1rem !important;		
		}
		/* 찾기 가입 */
			.background-home > .main-top-box > .member-box .find-box, 
			.background-home > .main-top-box > .member-box .join-box{
				font-size:0.5rem;
				display:inline-block;	
		}
	}

	@media (max-width: 445px) {
		/*서치박스*/
		.background-home > .search-box{
			text-align: center !important;
			margin: 0 auto !important;
		}
		.background-home > .search-box > form > select {
			width:70px;
			height:40px;
		} 
		
		.background-home > .search-box > form > input{
			width:100px;
			padding: 12px 12px;
			font-size:10px;
		}
		
		.background-home > .search-box > form > button{
			padding: 10px 15px;
		}
		/* 박스 */
			.board {
				width:200px;
		} 
		
		/* 박스 제목 */
		    .article-title {
		    	width:70px !important;
		}
		/* 커뮤니티 박스 & 회원 박스 */
			.background-home > .main-top-box {
		}    
		    .background-home > .main-top-box > .board-list-box,
		     .background-home > .main-top-box > .member-box{
		    	width:200px !important;
		    	margin-left:0px;
		}
		/* 커뮤니티 리스트 */
			.background-home > .main-top-box > .board-list-box > .select-text-box > a {
				font-size:1rem !important;		
		}
		/* 찾기 가입 */
			.background-home > .main-top-box > .member-box .find-box, 
			.background-home > .main-top-box > .member-box .join-box{
				font-size:0.5rem;
				display:inline-block;	
		}
		/* 상단 목차 */
			.menu-box-1 > ul > li {
				margin-left:10px;	
		}
			.menu-box-1 > ul > li:first-child:after, .menu-box-1 > ul > li:last-child:before {
				width:0.5px !important;
		}
	}
	
	.board > .board-title{
		background: linear-gradient(to right, #6b6880, #ebebf1);
		border-bottom:2px solid #6b6880;
		text-align: right;
		padding: 5px 0;
		padding-right: 10px;
	}
	
	.board a {
		text-decoration: none;
		font-weight: bold;
	}
	
	.board a:hover{
		color:blue;
	}
	
	.board a:active{
		color:red;
	}
	
	.board > ul > li > a{
		font-weight: normal;
	}
</style>
<style>
/* 메뉴 박스 */
	.menu-box-1 {
	margin:0 auto;
 	margin-top:50px;
 	padding-left: 20px;
 	padding-right: 20px;
 	text-align: center;
	}
	.menu-box-1 > ul {
		
		display: inline-block;
	}
	.menu-box-1 > ul > li {
		float:left;
		margin-bottom:10px;
		margin-top:10px;
		position: relative;
	}
	
	.menu-box-1 > ul > li:after, .menu-box-1 > ul > li:before {
		content: "";
		display:block;
		width:1px;
		height: 12px;
		background-color:black;
		position: absolute;
		top:50%;
		left:0;
		transform:translateY(-50%);
	}
	
	.menu-box-1 > ul > li:before {
		left:auto;
		right: 0;
	}
	
	.menu-box-1 > ul > li:last-child:before, .menu-box-1 > ul > li:first-child:after{
		width:2px;
	}
	
	.menu-box-1 > ul > li > a{
		text-decoration: none;
		font-weight: bold;
		position: relative;
		font-size: 16px;
	    font-weight: 200;
	    padding:10px;
	    display:block;
	    padding-bottom: 8px;
	}
	
	.menu-box-1 > ul > li > a::after {
	    content: "";
	    position: absolute;
	    height: 2px;
	    width: 0;
	    background: linear-gradient(to right, #6b6880, #ebebf1);
	    left: 50%;
	    transform: translatex(-50%);
	    top: 100%;
	    transition: width 0.3s;
	}
	
	.menu-box-1 > ul > li:hover > a::after{
		width:100%;
	}
	
	
	
</style>
<style>
	.board ul > li {
		text-align: left;
		margin:0 10px;
		margin-bottom:10px;
	}
	
	.board ul > li:first-child{
		margin-top:3px;
	}
	
	.board ul > li:after {
		content: "";
		display:block;
		clear: both;
	}
	
	.board ul > li > a {
		display:block;
	}

	.article-regDate{
		float:left;
		overflow: hidden;
		text-overflow: ellipsis;
		white-space: nowrap;
		width: 100px;
		height: 20px;
	}
	.article-title{
		float:right;
		overflow: hidden;
		text-overflow: clip;
		white-space: nowrap;
		width: 100px;
		height: 20px;
		text-align: right;

	}
</style>
<style>
	
	.background-home > .main-top-box > .member-box > .my-page {
		margin-top:50px;
	}
	
	.background-home > .main-top-box > .member-box > .my-page > a:hover {
	    background: linear-gradient(to bottom, #b8b3c6, #ebebf1);
        opacity: 0.7;
	}
	
	.background-home > .main-top-box > .member-box > .my-page > a {
		text-decoration: none;
		background: linear-gradient(to top, #b8b3c6, #ebebf1);
		border:3px solid #6b6880;
		font-weight: bold;
		font-size: 2rem;
		display: block;
		margin:0 10px;
		padding:10px;
	}
</style>

<script>

	$(document).ready(function () {
	    $("#select-search").select2();
	});
</script>


<div class="background-home">

	<!-- 검색 폼 시작 -->
	<div class="con search-box" style="text-align: center; margin-top:20px;">

		<form action="/usr/article/alllist" method="POST">
			<input type="hidden" name="page" value="1" /> 
			
			<select name="searchKeywordType" style="padding:5px;">
				<option value="title">제목</option>
				<option value="body">내용</option>
			</select>   
			<input type="text" name="searchKeyword" value="${param.searchKeyword}" />
			<button type="submit">검색</button>
		</form>
	</div>
	<!-- 검색 폼 끝 -->

	<!-- 상단 메뉴 시작 -->
	<nav class="menu-box-1">
		<ul class="">
			<li class="padding-0-10">
				<a class="btn-info" href="/usr/article/notice-list">공지사항</a>
			</li>
			<li class="padding-0-10">
				<a class="btn-info" href="/usr/article/update-list">업데이트</a>
			</li>
			<li class="padding-0-10">
				<a class="btn-info" href="/usr/article/question-list">문의사항</a>
			</li>
			<c:if test="${isLogined}">
				<li class="padding-0-10">
					<a class="btn-info" href="/usr/member/doLogout">로그아웃</a>
				</li>
				<li class="padding-0-10">
					<a class="btn-info" href="/usr/board/createBoard">새 커뮤니티 게시판 신청</a>
				</li>
			</c:if>
		</ul>
	</nav>
	<!-- 상단 메뉴 끝 -->
	
	<!--  메인 탑 박스 시작(커뮤니티찾기/로그인) -->
	<div class="main-top-box">
		
		<div class="board-list-box">
			<select id="select-search" onchange="location.href=this.value">
					<c:forEach items="${boards}" var="board">
							<option value="/usr/article/${board.code }-list">
								<a href="/usr/article/${board.code }-list">${board.name }</a>
							</option>
					</c:forEach>
			</select>
			<div class="select-text-box">
				<a>원하는 커뮤니티를 찾아보세요.</a>
			</div>
		</div>
	
	
		<div class="member-box">
			<c:if test="${!isLogined}">
				<div class="login-box">
					<a class="login" href="/usr/member/login">ex1 로그인</a>
				</div>
				<div class="find-box">
					<a href="/usr/member/findId">아이디찾기 </a>
					/
					<a href="/usr/member/findPw"> 비밀번호 찾기</a>
				</div>
				<div class="join-box">
					<a href="/usr/member/join">회원가입</a>
				</div>
			</c:if>
			
			<c:if test="${isLogined}">
				<div class="my-page">
					<a href="/usr/member/myPage">MY PAGE</a>
				</div>
			</c:if>
		</div>
		
	</div>
	<!--  메인 탑 박스 끝(커뮤니티찾기/로그인) -->


 	<!-- 중 하단 아이템 박스 *6 시작 -->
	<div class="board notice-board">
		<div class="board-title">
			<a href="/usr/article/notice-list">공지사항</a>	
		</div>
		<ul>
			<c:forEach items="${notices}" var="notice">
				<li>			
					<a href="${notice.getDetailLink('notice')}">
						<div class="article-regDate">${notice.regDate}</div>
						<div class="article-title">${notice.title}</div>
					</a>
				</li>
			</c:forEach>
		</ul>
	</div>
	
	<div class="board update-board">
		<div class="board-title">
			<a href="/usr/article/update-list"">업데이트</a>
		</div>
		<ul>
			<c:forEach items="${updates}" var="update">
				<li>			
					<a href="${update.getDetailLink('update')}">
						<div class="article-regDate">${update.regDate}</div>
						<div class="article-title">${update.title}</div>
					</a>
				</li>
			</c:forEach>
		</ul>
	</div>
	
	<div class="board question-board">
		<div class="board-title">
			<a href="/usr/article/question-list">문의</a>
		</div>
		<ul>
			<c:forEach items="${questions}" var="question">
				<li>			
					<a href="${question.getDetailLink('question')}">
						<div class="article-regDate">${question.regDate}</div>
						<div class="article-title">${question.title}</div>
					</a>
				</li>
			</c:forEach>
		</ul>
	</div>
	
	<div class="board best-article-board">
		<div class="board-title">
			<a href="#">HOT 게시글</a>
		</div>
		<ul>
			<c:forEach items="${hotArticles}" var="hotArticle">
				<li>			
					<a href="${hotArticle.getDetailLink(hotArticle.extra.boardCode)}">
						<div class="article-regDate">${hotArticle.regDate}</div>
						<div class="article-title">${hotArticle.title}</div>
					</a>
				</li>
			</c:forEach>
		</ul>
	</div>
	
	<div class="board best-articleItem-board">
		<div class="board-title">
			<a href="#">HOT 커뮤니티</a>
		</div>
		<ul>
			<c:forEach items="${hotBoards}" var="hotBoard">
				<li>			
					<a href="${hotBoard.getBoardLink(hotBoard.code)}">
						<div class="article-regDate">${hotBoard.regDate}</div>
						<div class="article-title">${hotBoard.name}</div>
					</a>
				</li>
			</c:forEach>
		</ul>
	</div>
	
	<div class="board board-list">
		<div class="board-title">
			<a href="#">NEW 커뮤니티</a>
		</div>
		<ul>
			<c:forEach items="${newBoards}" var="newBoard">
				<li>			
					<a href="${newBoard.getBoardLink(newBoard.code)}">
						<div class="article-regDate">${newBoard.regDate}</div>
						<div class="article-title">${newBoard.name}</div>
					</a>
				</li>
			</c:forEach>
		</ul>
	</div>
	<!-- 중 하단 아이템 박스 *6 끝 -->
</div>

<%@ include file="../part/foot.jspf"%>