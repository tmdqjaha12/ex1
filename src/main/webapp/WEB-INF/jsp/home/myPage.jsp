<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="메인" />
<%@ include file="../part/head.jspf"%>

<script>
	var ModifyForm__submitDone = false;
	function ModifyForm__submit(form) {
		
	}
	ModifyForm__submitDone = true;
</script>

<div class="my-page-background">
	<div class="my-page-box table-box">
		<table>
			<tr>
				<th>아이디</th>
				<td>${loginedMember.loginId}</td>
			</tr>

			<tr>
				<th>가입 날짜</th>
				<td>${loginedMember.regDate}</td>
			</tr>

			<tr>
				<th>활동명</th>
				<td>${loginedMember.nickname}</td>
			</tr>

			<tr>
				<th>이름</th>
				<td>${loginedMember.name}</td>
			</tr>

			<tr>
				<th>이메일</th>
				<td>${loginedMember.email}</td>
			</tr>

		</table>

	</div>


	<form action="" method=""
		class="all-modify" onsubmit="">
		
		<input type="button" value="회원 탈퇴" onclick="if ( confirm('탈퇴하시겠습니까?') == false ) return false; location.href='/usr/member/passwordForPrivate?isvalTag=secession'" /> 
		<input type="button" value="정보 수정" onclick="location.href='/usr/member/passwordForPrivate?isvalTag=memberModify'" /> 
		<input type="button" value="비번 변경" onclick="location.href='/usr/member/passwordForPrivate?isvalTag=modifyPassword'" /> 
	</form>

</div>

<%@ include file="../part/foot.jspf"%>