<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="접근 확인" />
<%@ include file="../part/head.jspf"%>

<style>

.page-title {
	display:block;
	padding-top:30px;
	text-align:center;
}

.page-title > h1 {
	color:black;
}

.passwordForPrivate-background{
	display:block;
	margin:0 auto;
	margin-top:100px;
	width:500px;
	height:500px;
	background-color:#ebebf1;
	border:5px solid #6b6880;
}

.passwordForPrivate-form {
	border:1px solid #6b6880;
	margin:0 20px;
	margin-top:100px;
	padding:25px 0;
}

.passwordForPrivate-form th{
	color:black !important;
}

.passwordForPrivate-btn {
	cursor: pointer;
}


</style>

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js">
	
</script>
<script>
	function submitLoginForm(form) {
		form.loginPw.value = form.loginPw.value.trim();
		if (form.loginPw.value.length == 0) {
			alert('로그인 비번을 입력해주세요.');
			form.loginPw.focus();
			return;
		}
		form.loginPwReal.value = sha256(form.loginPw.value);
		form.loginPw.value = '';
		form.submit();
	}
</script>
<div class="passwordForPrivate-background">
	
	<div class="page-title"><h1>${pageTitle}</h1></div>

	<form action="doPasswordForPrivate" method="POST" class="passwordForPrivate-form con table-box"
		onsubmit="submitLoginForm(this); return false;">
		<input type="hidden" name="loginPwReal" />
		<input type="hidden" name="isvalTag" value="${isvalTag}" />
		<input type="hidden" name="redirectUri" value="/usr/member/passwordForPrivate?isvalTag=${isvalTag}">
		
		<table>
			<colgroup>
				<col width="100">
			</colgroup>
			<tbody>
				<tr>
					<th>로그인 비번</th>
					<td>
						<div class="form-control-box">
							<input type="password" placeholder="로그인 비번을 입력해주세요." name="loginPw"
								maxlength="30" autofocus="autofocus" />
						</div>
					</td>
				</tr>
				<tr>
					<th></th>
					<td>
						<button class="passwordForPrivate-btn" type="submit">확인</button>
						<a href="javascript:window.history.back();" class="cancel">취소</a>
					</td>
				</tr>
			</tbody>
		</table>
		
	</form>
</div>

<%@ include file="../part/foot.jspf"%>