<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="로그인" />
<%@ include file="../part/head.jspf"%>

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>
	
	
<style>

.page-title {
	display:block;
	padding-top:30px;
	text-align:center;
}

.page-title > h1 {
	color:black;
}

.login-background{
	display:block;
	margin:0 auto;
	margin-top:100px;
	width:500px;
	height:500px;
	background-color:#ebebf1;
	border:5px solid #6b6880;
}

.login-form {
	border:1px solid #6b6880;
	margin:0 20px;
	margin-top:100px;
}




.login-form > table {
	width: 100%;
	border-collapse: collapse;
}

.login-form>table th,
 .table-box>table td  {
	border-right:none;
	padding: 10px;
	text-align: left;
	color:black;
}

/* 폼 관련 */
.login-form .form-control-box>input, .login-form .form-control-box>textarea{
	width: 100%;
	padding: 0;
	display: block;
	box-sizing: border-box;
	padding: 10px;
}

.login-form .form-control-box>textarea {
	min-height: 300px;
	resize: none;
}

.login-form th {
	/* `로그인 아이디` 문구가 줄 바꿈 될 때 공백기준으로 줄바꿈 되도록 */
	word-break: keep-all;
}

.login-form .btn {
	width:100%;
	margin:0 auto;
	padding: 10px 15px;
	font-weight: bold;
	border-radius: 10px;
	outline: 0;
	border: 1px solid #6b6880;
	cursor: pointer;
	background: linear-gradient(to top, #b8b3c6, #ebebf1);
	color: black;
	text-shadow: 1px 1px 20px #000000;
}

.login-form .btn:hover {
	background: linear-gradient(to bottom, #b8b3c6, #ebebf1);
}

.login-form .btn-success {
	background-color: green;
}

.login-form .btn-danger {
	background-color: red;
}
</style>

<script>
	var MemberLoginForm__submitDone = false;
	function MemberLoginForm__submit(form) {
		if (MemberLoginForm__submitDone) {
			alert('처리중입니다.');
			return;
		}

		form.loginId.value = form.loginId.value.trim();
		form.loginId.value = form.loginId.value.replaceAll('-', '');
		form.loginId.value = form.loginId.value.replaceAll('_', '');
		form.loginId.value = form.loginId.value.replaceAll(' ', '');

		if (form.loginId.value.length == 0) {
			form.loginId.focus();
			alert('로그인 아이디를 입력해주세요.');

			return;
		}

		if (form.loginId.value.length < 4) {
			form.loginId.focus();
			alert('로그인 아이디 4자 이상 입력해주세요.');

			return;
		}

		form.loginPw.value = form.loginPw.value.trim();

		if (form.loginPw.value.length == 0) {
			form.loginPw.focus();
			alert('로그인 비밀번호를 입력해주세요.');

			return;
		}

		if (form.loginPw.value.length < 5) {
			form.loginPw.focus();
			alert('로그인 비밀번호를 5자 이상 입력해주세요.');

			return;
		}

		form.loginPwReal.value = sha256(form.loginPw.value);
		form.loginPw.value = '';

		form.submit();
		MemberLoginForm__submitDone = true;
	}
</script>


<div class="login-background">

	<div class="page-title"><h1>${pageTitle}</h1></div>

	<form method="POST" class="login-form table-box con form1" action="doLogin"
		onsubmit="MemberLoginForm__submit(this); return false;">
		<input type="hidden" name="redirectUri" value="${param.redirectUri}">
		<input type="hidden" name="loginPwReal">

		<table>
			<colgroup>
				<col width="100">
			</colgroup>
			<tbody>
				<tr>
					<th>로그인 아이디</th>
					<td>
						<div class="form-control-box">
							<input type="text" placeholder="로그인 아이디 입력해주세요." name="loginId"
								maxlength="30" autofocus="autofocus" />
						</div>
					</td>
				</tr>
				<tr>
					<th>로그인 비번</th>
					<td>
						<div class="form-control-box">
							<input type="password" placeholder="로그인 비번을 입력해주세요."
								name="loginPw" maxlength="30" />
						</div>
					</td>
				</tr>
				<tr>
					<th>로그인</th>
					<td>
						<button class="btn btn-primary" type="submit">로그인</button>
						<a href="javascript:window.history.back();" class="cancel">취소</a>
					</td>
				</tr>
			</tbody>
		</table>
	</form>
</div>

<%@ include file="../part/foot.jspf"%>