<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="${board.name} 게시물 리스트" />
<%@ include file="../part/head.jspf"%>

<div class="list-background">
	<div class="list-box-1">
		<table>
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
						<td class="padding-left-10">${article.id}</td>		
						<td class="padding-left-10 list-title-1"><a href="${article.getDetailLink(board.code)}">${article.forPrintTitle}</a>
						<td class="padding-left-10">임시작성자</td>
						<td class="text-center">${article.regDate}</td>
						<td class="padding-left-10">임시조회수</td>
						<td class="padding-left-10">임시추천수</td>	
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</div>
<%@ include file="../part/foot.jspf"%>