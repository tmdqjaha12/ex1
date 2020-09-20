<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="신고 목록" />
<%@ include file="../part/head.jspf"%>

<style>

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

/*테이블*/

@media (max-width: 990px) {
    .list-background  { width: 100%; }
}
@media screen and (max-width: 620px) {
    .regdate  { display: none; }
}
@media screen and (max-width: 420px) {
    .Rbody  { display: none; }
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

.table-tbody td.body a{
	display:block;
	width:600px;
	word-break: break-all;
}

.table-tbody td a.detail{
	font-weight: bold;
}
.table-tbody td a.detail:hover{
	color:red;
}
.table-tbody td a.detail:active{
	color:blue;
}

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

	<div class="list-box-1">
		<div class="backA">
			<a href="javascript:window.history.back();" class="cancel">뒤로가기</a>
		</div>
		
		<table border="1">
			<colgroup>
				<col width="50" />
				<col width="100" />
				<col width="200" />
				<col width="150" />
				<col width="50" />
				<col width="50" />
			</colgroup>
			<thead class="table-thead">
				<tr>
					<th>신고번호</th>
					<th>신고사유</th>
					<th>신고내용</th>
					<th class="regDate">날짜</th>
					<th>신고게시물(이동)</th>
					<th>신고자</th>
				</tr>
			</thead>



			<tbody class="table-tbody">
				<c:set var="i" value="1" />
				<c:forEach items="${reportDocs}" var="reportDoc">
					<tr>
						<td class="padding-left-10">${i}</td>
						<td class="padding-left-10">${ reportDoc.reportType}</td>
						<td class="text-center body"><a>${reportDoc.reportBody}</a></td>
						<td class="text-center regDate">${reportDoc.regDate}</td>
						<td><a class="detail" href="/usr/article/${boardCode}-detail?id=${reportDoc.articleId}">이동</a></td>
						<td class="padding-left-10">${reportDoc.extra.Mnickname}</td>
						
					</tr>
					<c:set var="i" value="${i+1}" />
				</c:forEach>
			</tbody>
		</table>
	</div>
	
	<!-- 게시물 페이징 시작
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
	게시물 페이징 끝 -->


</div>

<%@ include file="../part/foot.jspf"%>