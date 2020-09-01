<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="관리자 - 커뮤니티 신청서 관리" />
<%@ include file="../part/head.jspf"%>

<!-- 일반 회원들이 자기만의 게시판을 만들기위해, 신청하는 공간, 신청서 -->

<div class="con"
	style="text-align: center; margin-top: 150px; margin-bottom: 50px;">
	<h1>${pageTitle}</h1>
</div>

<div class="create-board con" style="background-color: #ebebf1;">

	<div class="list-box-1">
		<table border="1">
			<colgroup>
				<col width="100" />
				<col width="200" />
				<col width="150" />
				<col width="180" />
				<col width="1000" />
				<col width="120" />
			</colgroup>
			<thead class="table-thead">
				<tr>
					<th>신청서 번호</th>
					<th>커뮤니티 이름</th>
					<th>신청자 이름</th>
					<th>신청 날짜</th>
					<th>세부 내용</th>
					<th>비고</th>
				</tr>
			</thead>

<script>
	Code__submit(){
		
	}
</script>

			<tbody class="table-tbody">

				<c:forEach items="${BoardApplyDocs}" var="BoardApplyDoc">
					<tr>
						<td class="padding-left-10">${BoardApplyDoc.id}</td>
						<td class="padding-left-10 list-title-1">${BoardApplyDoc.name}</td>
						<td class="padding-left-10">${BoardApplyDoc.extra.writer}</td>
						<td class="text-center">${BoardApplyDoc.regDate}</td>
						<td class="padding-left-10">${BoardApplyDoc.body}</td>
						<td class="" style="padding-left: 5px;">
							<!-- ajax화는 나중에... -->
							<form action="doBoardApply" method="POST">
								<input type="hidden" name="name" value="${BoardApplyDoc.name}"/>
								<input type="hidden" name="memberId" value="${BoardApplyDoc.memberId}"/>
								<input type="hidden" name="redirectUri" value="/usr/board/boardApplyList">
								<input type="submit" value="승인" onclick="if ( confirm('승인하시겠습니까?') == false ) return false;" />
							</form>
							<form action="doBoardReject" method="POST">
								<input type="hidden" name="name" value="${BoardApplyDoc.name}"/>
								<input type="hidden" name="memberId" value="${BoardApplyDoc.memberId}"/>
								<input type="hidden" name="boardId" value="${BoardApplyDoc.boardId}"/>
								<input type="hidden" name="redirectUri" value="/usr/board/boardApplyList">
								<input type="submit" value="거절" onclick="if ( confirm('거절하시겠습니까?') == false ) return false;" />
							</form>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>

</div>
<%@ include file="../part/foot.jspf"%>