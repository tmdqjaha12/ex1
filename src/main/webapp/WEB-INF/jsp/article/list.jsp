<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="${board.name} 게시판" />
<%@ include file="../part/head.jspf"%>

<style>
/* 게시판 리스트 시작 */
.list-background {
	background-color:white;
	margin:0 auto;
	margin-bottom:100px;
	margin-top:50px;
	width:1000px;
}

.list-page-title {
	background-color:#6b6880;
}

.list-page-title h1{
	background-color:white;
	text-align: center;
}

/*페이지박스*/
.page-box {
	margin-top:20px;
}

.page-box a {
}

/*서치박스*/
.list-background .search-box > form{
}

.list-background .search-box > form > select {
	width:70px;
	height:40px;
} 

.list-background .search-box > form > input{
	width:150px;
	padding: 8px 12px;
}

.list-background .search-box > form > button{
	padding: 10px 15px;
}

.search-box{
	margin-left:5px;
	float:left;
}

/*글쓰기*/
.write-box {
	float:right;
	margin-bottom:4px;
}

.go-write-form {
	background-color:white;
	text-align: right;
}

.go-write-form input{
	padding: 20px 40px;
}
/* search-write */
.search-write {
	margin:0 20px;
}

/*테이블*/

@media (max-width: 990px) {
    .list-background  { width: 100%; }
}
@media screen and (max-width: 820px) {
    .recommed  { display: none; }
}
@media screen and (max-width: 720px) {
    .view  { display: none; }
}
@media screen and (max-width: 720px) {
    .regdate  { display: none; }
}

.list-background >  .list-box-1 {
	margin:0 20px;
}

.list-background >  .list-box-1 > table {
	width:100%;
}

.list-background >  .list-box-1 .table-thead{
	background-color:#6b6880;
	color:#ebebf1;
}

.list-background >  .list-box-1 .table-thead > tr{
	height:70px;
}

.list-background >  .list-box-1 .table-tbody > tr {
	height: 44px;
}

.list-background >  .list-box-1 .table-tbody > tr a {
	text-decoration: none;
}

.list-background >  .list-box-1 .table-tbody > tr:hover{
	background-color:#c6bcda;
}

.list-background >  .list-box-1  colgroup{
	background-color:#ebebf1;
}

.list-background >  .list-box-1 > table {
	border-spacing : 5px;

}

.list-background >  .list-box-1  .table-tbody td a {
	display:block;
	width:80px;
	text-overflow:ellipsis;  
	overflow:hidden;  
	white-space:nowrap;
	cursor: default;
}
/*
@media ( max-width: 780px ) {
  .list-background >  .list-box-1  .table-tbody td a {
    width:50px;
  }
}
*/
.list-background >  .list-box-1 .table-tbody  .list-title-1 > a:hover {
	text-decoration:underline;
	color:blue;
}

.list-background >  .list-box-1 .table-tbody  .list-title-1 > a:active {
	color:red;
}


/* 게시판 리스트 끝 */
</style>




<div class="list-background">

	<div class="list-page-title">
		<h1>* ${pageTitle} *</h1>
	</div>
	
	<div class="search-write">
	
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
		
		<div class="write-box">
			<c:if test="${board.code != 'question' }">
				<c:if test="${isLogined}">	
			
					<c:choose>
						<c:when test="${board.code == 'notice' || board.code == 'update'}">
							<c:if test="${loginedMember.level == 10 }">
								<form class="go-write-form" action="${boardCode}-write" method="POST">
									<input type="submit" value="글쓰기" />
								</form>			
							</c:if>
						</c:when>
						<c:otherwise>
			        		<form class="go-write-form" action="${boardCode}-write" method="POST">
								<input type="submit" value="글쓰기" />
							</form>	
					    </c:otherwise>	
					</c:choose>
		
				</c:if>
			</c:if>
		</div>
	
	</div>
	
	

	<div class="list-box-1">
		<table border="1">
			<colgroup>
				<col width="100" />
				<col width="1000" />
				<col width="150" />
				<col width="200" />
				<col width="100" />
				<col width="100" />
			</colgroup>
			<thead class="table-thead">
				<tr>
					<th>글번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th class="regdate">작성시간</th>
					<th class="view">조회수</th>
					<th class="recommed ">추천수</th>
				</tr>
			</thead>



			<tbody class="table-tbody">

				<c:forEach items="${articles}" var="article">


					<tr>
						<td class="padding-left-10"><a href="#">${article.id}</a></td>
						<td class="padding-left-10 list-title-1">
							<a style="width: 200px; cursor: pointer;"
							 href="${article.getDetailLink(board.code)}">
							 	${article.forPrintTitle}
							 	<c:if test="${article.extra.applyPoint != 0}">
							 		 &nbsp&nbsp(* ${article.extra.applyPoint})
							 	</c:if>
							 </a>
						<td class="padding-left-10"><a href="#">${article.extra.writer}</a></td>
						<td class="text-center regdate"><a style="width: 170px;" href="#">${article.regDate}</a></td>
						<td class="padding-left-10 view"><a href="#">${article.hit}</a></td>
						<td class="padding-left-10 recommed "><a href="#">${article.extra.likePoint}</a></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	
	<!-- 게시물 페이징 시작 -->
	<div class="con page-box">
		<ul>
			<c:if test="${page-5 > 0}">
				<span><a
					href="?cateItemId=${param.cateItemId}&searchKeywordType=${param.searchKeywordType}&searchKeyword=${param.searchKeyword}&page=${page-5}">◀</a></span>
			</c:if>

			<c:forEach var="i" begin="${page}" end="${page+4}" step="1">
				<li class="${i == param.page ? 'current' : ''}"><a
					href="?cateItemId=${param.cateItemId}&searchKeywordType=${param.searchKeywordType}&searchKeyword=${param.searchKeyword}&page=${i}"
					class="block"
					<c:if test="${i > totalPage}">style="display:none;"</c:if>>${i}</a></li>
			</c:forEach>

			<c:if test="${totalPage-page > 4}">
				<span><a
					href="?cateItemId=${param.cateItemId}&searchKeywordType=${param.searchKeywordType}&searchKeyword=${param.searchKeyword}&page=${page+5}">▶</a></span>
			</c:if>
		</ul>
	</div>
	<!-- 게시물 페이징 끝 -->


</div>

<!-- 게시판을 위한, 게시판의 게시판들의 리스트 
<div class="list-mypage" style="position: fixed; top:10px; right:2%; height: 267px; width:300px; background-color: gray; border-top:33px solid black;">
	<ul>
		<c:forEach items="${boardDetailLists}" var="boardDetailList">
			<li><a href="">${boardDetailList.name}</a></li>
		</c:forEach>
	</ul>
</div>
 -->
<%@ include file="../part/foot.jspf"%>