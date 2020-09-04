<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="메인" />
<%@ include file="../part/head.jspf"%>

<style>

	.background-home {
		background-color:#ebebf1; 
		width:100%; 
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
		border:1px solid #6b6880;
		font-weight: bold;
		font-size: 2rem;
		display: block;
		margin:0 10px;
		padding:10px;
	}
	
	.background-home > .main-top-box > .member-box > .login-box > a:hover {
        opacity: 0.5;
	}
	
	.background-home > .main-top-box > .member-box > .login-box > a:active {
        opacity: 1;
	}
	
	.background-home > .main-top-box > .member-box > .find-box {
		margin-top:20px;
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

<script>

	$(document).ready(function () {
	    $("#select-search").select2();
	});
</script>


<div class="background-home">

	<!-- 검색 폼 시작 -->
	<div class="con search-box" style="text-align: center; margin-top:20px;">

		<form action="${boardCode}-list" method="POST">
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
	<nav class="menu-box-1" style="margin:50px;">
		<ul class="flex">
			<li class="padding-0-10">
				<a href="/usr/home/main" class="btn btn-info">홈</a>
			</li>
			<li class="padding-0-10">
				<a class="btn btn-info" href="/usr/article/notice-list">공지 게시판</a>
			</li>
			<li class="padding-0-10">
				<a class="btn btn-info" href="/usr/article/question-list">문의 게시판</a>
			</li>
			<c:if test="${isLogined}">
				<li class="padding-0-10">
					<a class="btn btn-info" href="/usr/member/doLogout">로그아웃</a>
				</li>
				<li class="padding-0-10">
					<a class="btn btn-info" href="/usr/home/myPage">myPage</a>
				</li>
				<c:if test="${userLever < 6}">
					<li class="padding-0-10">
						<a class="btn btn-info" href="/usr/board/createBoard">새 커뮤니티 게시판 신청</a>
					</li>
				</c:if>
				<c:if test="${userLever > 5}">
					<li class="padding-0-10">
						<a class="btn btn-info" href="/usr/home/adminPage">관리자 페이지</a>
					</li>
				</c:if>
			</c:if>
			<c:if test="${isLogined == false}">
				<li class="padding-0-10">
					<a class="btn btn-info" href="/usr/member/login?redirectUri=${encodedAfterLoginUri}">로그인</a>
				</li>
				<li class="padding-0-10">
					<a class="btn btn-info" href="/usr/member/join">회원가입</a>
				</li>
			</c:if>
			<c:if test="${userLever < 6}">
				<li class="padding-0-10">
					<a class="btn btn-info" href="/usr/article/question-write">문의하기</a>
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
			<div class="login-box">
				<a class="login" href="#">ex1 로그인</a>
			</div>
			<div class="find-box">
				<a href="#">아이디 찾기 </a>
				/
				<a href="#"> 비밀번호 찾기</a>
			</div>
		</div>
	</div>
	<!--  메인 탑 박스 끝(커뮤니티찾기/로그인) -->


 	<!-- 중 하단 아이템 박스 *6 시작 -->
	<div class="board notice-board">
		<div class="board-title">
			<a href="#">공지사항</a>	
		</div>
		<ul>
			<li><a href="#">imshi</a></li>
			<li><a href="#">imshi</a></li>
			<li><a href="#">imshi</a></li>
			<li><a href="#">imshi</a></li>
			<li><a href="#">imshi</a></li>
		</ul>
	</div>
	
	<div class="board update-board">
		<div class="board-title">
			<a href="#">업데이트</a>
		</div>
		<ul>
			<li><a href="#">imshi</a></li>
			<li><a href="#">imshi</a></li>
			<li><a href="#">imshi</a></li>
			<li><a href="#">imshi</a></li>
			<li><a href="#">imshi</a></li>
		</ul>
	</div>
	
	<div class="board question-board">
		<div class="board-title">
			<a href="#">문의</a>
		</div>
		<ul>
			<li><a href="#">imshi</a></li>
			<li><a href="#">imshi</a></li>
			<li><a href="#">imshi</a></li>
			<li><a href="#">imshi</a></li>
			<li><a href="#">imshi</a></li>
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