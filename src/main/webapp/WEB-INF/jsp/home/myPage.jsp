<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="내 정보" />
<%@ include file="../part/head.jspf"%>

<script>
	var ModifyForm__submitDone = false;
	function ModifyForm__submit(form) {
		
	}
	ModifyForm__submitDone = true;
</script>

<div class="my-page-background">

	<div class="page-title"><h1>${pageTitle}</h1></div>
	
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
			<c:if test="${!isMailAuthed}">
			<tr>
				<th>비고</th>
				<td>
				<form action="/usr/member/doSendMail" method="POST"  onclick="if ( confirm('인증메일을 보내시겠습니까?') == false ) return false;">
					<input type="hidden" name="memberId" value="${loginedMember.id}" />
					<input type="hidden" name="authCode" value="${authCode}" />
					<input type="hidden" name="email" value="${loginedMember.email}" />
					<input type="hidden" name="redirectUri" value="/usr/home/myPage" />
					<button class="btn btn-primary" type="submit">이메일 인증보내기</button>
				</form>
				</td>
			</tr>
			</c:if>

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