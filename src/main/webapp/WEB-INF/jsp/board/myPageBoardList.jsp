<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="관리자 - 커뮤니티 신청서 관리" />
<%@ include file="../part/head.jspf"%>

<style>
	.create-title {
		text-align: center; 
		margin-top: 150px; 
		margin-bottom: 50px;
	}

	.create-board {
		background-color: #ebebf1; 
		max-width:1000px; 
		margin:0 auto;
	}
</style>

<div class="con create-title">
	<h1>${pageTitle}</h1>
</div>

<div class="create-board">

	<div class="list-box-1">
		<table border="1">
			<colgroup>
				<col width="100" />
				<col width="250" />
				<col width="400" />
				<col width="180" />
				<col width="100" />
			</colgroup>
			<thead class="table-thead">
				<tr>
					<th>신청번호</th>
					<th>커뮤니티이름</th>
					<th>커뮤니티설명</th>
					<th>신청날짜</th>
					<th>승인여부</th>
				</tr>
			</thead>

			<tbody class="table-tbody">

				<c:forEach items="${myBoardList}" var="myBoard">
					<tr>
						<td class="padding-left-10">${myBoard.id}</td>
						<td class="padding-left-10">${myBoard.name}</td>
						<td class="padding-left-10">${myBoard.body}</td>
						<td class="text-center">${myBoard.regDate}</td>
						<td class="text-center">
							<c:if test="${myBoard.applyStatus == true}">승인완료</c:if>
							<c:if test="${myBoard.applyStatus == false}">미승인</c:if>
						</td>
						
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>

</div>
<%@ include file="../part/foot.jspf"%>