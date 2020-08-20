<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="아이디 찾기" />
<%@ include file="../part/head.jspf"%>

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>

<script>
function submitFindIdForm(form) {
	form.name.value = form.name.value.trim();
	if (form.name.value.length == 0) {
		alert('이름을 입력해주세요.');
		form.name.focus();
		return;
	}
	form.email.value = form.email.value.trim();
	if (form.email.value.length == 0) {
		alert('이메일을 입력해주세요.');
		form.email.focus();
		return;
	}
	form.submit();
}
</script>
<div class="findId-background login-background">
	
	<div class="page-title"><h1>${pageTitle}</h1></div>

	<form method="POST" class="findId-form login-form table-box con form1" action="doFindId" onsubmit="submitFindIdForm(this); return false;">
		<input type="hidden" name="redirectUri" value="/usr/member/login">

		<table>
			<colgroup>
				<col width="100">
			</colgroup>
			<tbody>
				<tr>
					<th>이름</th>
					<td>
						<div class="form-control-box">
							<input type="text" placeholder="이름을 입력해주세요." name="name"
								maxlength="30" autofocus="autofocus" />
						</div>
					</td>
				</tr>
				<tr>
					<th>이메일</th>
					<td>
						<div class="form-control-box">
							<input type="email" placeholder="이메일을 입력해주세요."
								name="email" maxlength="30" />
						</div>
					</td>
				</tr>
				<tr>
					<th>아이디 찾기</th>
					<td>
						<button class="btn btn-primary" type="submit">아이디 찾기</button>
						<a href="../member/login" class="cancel">취소</a>
					</td>
				</tr>
			</tbody>
		</table>
	</form>
</div>

<%@ include file="../part/foot.jspf"%>