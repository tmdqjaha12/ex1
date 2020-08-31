<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="사이트 관리자 페이지" />
<%@ include file="../part/head.jspf"%>

<div class="create-board con" style="background-color:#ebebf1;">

	<div class="write-page-title">
		<h1>${pageTitle}</h1>
	</div>

	<form method="POST" class="write-form table-box con form1">

		<table border="1">
			<colgroup>
				<col class="table-first-col">
			</colgroup>
			<tbody>
				<tr>
					<th>회원 관리</th>
					<td>
						<div class="form-control-box">
							<a href="/usr/~~~~~~~~~~~~">이동</a> 
						</div>
					</td>
				</tr>
				<tr>
					<th>커뮤니티 게시판 신청서 관리</th>
					<td>
						<div class="form-control-box">
							<a href="/usr/board/boardApplyList">이동</a> 
						</div>
					</td>
				</tr>
				<tr>
					<th>고객센터 문의 내역 관리</th><!-- 낮은 단계의 관리자가 이용 가능하도록. -->
					<td>
						<div class="form-control-box">
							<a href="/usr/~~~~~~~~~~~~">이동</a> 
						</div>
					</td>
				</tr>
			</tbody>
		</table>
	</form>

</div>

<%@ include file="../part/foot.jspf"%>