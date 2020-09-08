<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="메인" />
<%@ include file="../part/head.jspf"%>

<style>

	.background-home {
		background-color:#ebebf1; 
		height:100%; 
		padding:50px; 
		padding-top:10px;
		text-align: center;
	}
	
	.background-home > .search-box {
		
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
		margin-top:40px;
	}
	
	.background-home > .main-top-box > .board-list-box{
		background-color: white; 
		display:inline-block;
		width:500px; 
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
		width:500px; 
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
	.menu-box-1 {
 	margin-top:50px;
 	background-color: #6b6880;
 	border:10px solid #6b6880;
 	border-radius:30%;
 	padding-left: 20px;
 	padding-right: 20px;
 	margin-left:150px;
 	margin-right:150px;
	}
	.menu-box-1 > ul {
		
		display: inline-block;
	}
	.menu-box-1 li {
		display: inline-block;
		margin-bottom:10px;
		margin-top:10px;
	}
	
	
</style>
<style>
	.board ul > li {
		text-align: left;
		margin-left:10px;
	}
	.board ul > li > a {
		display:block;
	}

	.article-regDate{
		display:inline-block;
		overflow: hidden;
		text-overflow: ellipsis;
		white-space: nowrap;
		width: 100px;
		height: 20px;
	}
	.article-title{
		display:inline-block;
		overflow: hidden;
		text-overflow: clip;
		white-space: nowrap;
		width: 100px;
		height: 20px;
		margin-left:175px;
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
				<a class="btn btn-info" href="/usr/article/notice-list">공지사항</a>
			</li>
			<li class="padding-0-10">
				<a class="btn btn-info" href="/usr/article/question-list">문의사항</a>
			</li>
			<c:if test="${isLogined}">
				<li class="padding-0-10">
					<a class="btn btn-info" href="/usr/member/doLogout">로그아웃</a>
				</li>
				<li class="padding-0-10">
					<a class="btn btn-info" href="/usr/board/createBoard">새 커뮤니티 게시판 신청</a>
				</li>
				<c:if test="${userLever > 5}">
					<li class="padding-0-10">
						<a class="btn btn-info" href="/usr/home/adminPage">관리자 페이지</a>
					</li>
				</c:if>
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
					<a href="/usr/home/myPage">MY PAGE</a>
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
			<c:forEach items="${notices}" var="article">
				<li>			
					<a href="${article.getDetailLink('update')}">
						<div class="article-regDate">${article.regDate}</div>
						<div class="article-title">${article.title}</div>
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
			<c:forEach items="${updates}" var="article">
				<li>			
					<a href="${article.getDetailLink('update')}">
						<div class="article-regDate">${article.regDate}</div>
						<div class="article-title">${article.title}</div>
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
			<c:forEach items="${question}" var="article">
				<li>			
					<a href="${article.getDetailLink('update')}">
						<div class="article-regDate">${article.regDate}</div>
						<div class="article-title">${article.title}</div>
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
			<li><a href="#">imshi</a></li>
			<li><a href="#">imshi</a></li>
			<li><a href="#">imshi</a></li>
			<li><a href="#">imshi</a></li>
			<li><a href="#">imshi</a></li>
		</ul>
	</div>
	
	<div class="board best-articleItem-board">
		<div class="board-title">
			<a href="#">HOT 커뮤니티</a>
		</div>
		<ul>
			<li><a href="#">imshi</a></li>
			<li><a href="#">imshi</a></li>
			<li><a href="#">imshi</a></li>
			<li><a href="#">imshi</a></li>
			<li><a href="#">imshi</a></li>
		</ul>
	</div>
	
	<div class="board board-list">
		<div class="board-title">
			<a href="#">NEW 커뮤니티</a>
		</div>
		<ul>
			<li><a href="#">imshi</a></li>
			<li><a href="#">imshi</a></li>
			<li><a href="#">imshi</a></li>
			<li><a href="#">imshi</a></li>
			<li><a href="#">imshi</a></li>
		</ul>
	</div>
	<!-- 중 하단 아이템 박스 *6 끝 -->
</div>

<%@ include file="../part/foot.jspf"%>