<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="메인" />
<%@ include file="../part/head.jspf"%>

<script>
	var ModifyForm__submitDone = false;
	function ModifyForm__submit(form) {
		var isvalTagText = '';
		
		if(ModifyForm__submitDone){
			alert('처리 중입니다.');
		}
		
		function RemoveModifyForm__submit(input) {
			isvalTagText = 'remove';
		}

		function AllModifyForm__submit(input) {
			isvalTagText = 'modify';
		}

		function PasswordModifyForm__submit(input) {
			isvalTagText = 'password';
		}

		form.isvalTag.value = isvalTagText;
	}
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


	<form action="/usr/member/passwordForPrivate" method="POST"
		class="all-modify" onsubmit="ModifyForm__submit(this); return false;">
		<input type="hidden" name="isvalTag"/> 
		<input type="button" name="remove" value="회원 탈퇴" onclick="if ( confirm('삭제하시겠습니까?') == false ) RemoveModifyForm__submit(this); return false;" /> 
		<input type="button" name="modify" value="정보 수정" onclick="AllModifyForm__submit(this); return false;" /> 
		<input type="button" name="password" value="비번 변경" onclick="PasswordModifyForm__submit(this); return false;" />
	</form>

</div>

<%@ include file="../part/foot.jspf"%>