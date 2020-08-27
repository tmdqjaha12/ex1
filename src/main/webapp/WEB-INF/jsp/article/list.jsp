<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="${board.name} 게시판" />
<%@ include file="../part/head.jspf"%>



<div class="list-background">

	<div class="list-page-title">
		<h1>${pageTitle}</h1>
	</div>

	<c:if test="${isLogined}">	
	
		<c:choose>
			<c:when test="${board.code == 'notice'}">
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
					<th>작성시간</th>
					<th>조회수</th>
					<th>추천수</th>
				</tr>
			</thead>



			<tbody class="table-tbody">

				<c:forEach items="${articles}" var="article">


					<tr>
						<td class="padding-left-10"><a href="#">${article.id}</a></td>
						<td class="padding-left-10 list-title-1"><a
							style="width: 200px; cursor: pointer;"
							href="${article.getDetailLink(board.code)}">${article.forPrintTitle}</a>
						<td class="padding-left-10"><a href="#">${article.extra.writer}</a></td>
						<td class="text-center"><a style="width: 170px;" href="#">${article.regDate}</a></td>
						<td class="padding-left-10"><a href="#">${article.hit}</a></td>
						<td class="padding-left-10"><a href="#">${article.extra.likePoint}</a></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>

	<!-- 검색 폼 시작 -->
	<div class="con search-box" style="text-align: center; margin-top:20px;">

		<form action="${boardCode}-list" method="POST">
			<input type="hidden" name="page" value="1" /> 
			<input type="hidden" name="searchKeywordType" value="title" /> 
			<input type="text" name="searchKeyword" value="${param.searchKeyword}" />
			<button type="submit">검색</button>
		</form>
		<!-- <select name="searchKeywordType" style="padding:5px;">
				<option value="title">제목</option>
				<option value="body">내용</option>
			</select>  -->

	</div>
	<!-- 검색 폼 끝 -->

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

<div class="list-mypage" style="position: fixed; top:10px; right:2%; height: 267px; width:300px; background-color: gray; border-top:33px solid black;">
	
</div>
<%@ include file="../part/foot.jspf"%>