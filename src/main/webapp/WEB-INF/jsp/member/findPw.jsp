<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="비번 찾기" />
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

.findPw-background{
	display:block;
	margin:0 auto;
	margin-top:100px;
	width:500px;
	height:500px;
	background-color:#ebebf1;
	border:5px solid #6b6880;
}

.findPw-form {
	border:1px solid #6b6880;
	margin:0 20px;
	margin-top:100px;
}




.findPw-form > table {
	width: 100%;
	border-collapse: collapse;
}

.findPw-form>table th,
 .table-box>table td  {
	border-right:none;
	padding: 10px;
	text-align: left;
	color:black;
}

/* 폼 관련 */
.findPw-form .form-control-box>input, .findPw-form .form-control-box>textarea{
	width: 100%;
	padding: 0;
	display: block;
	box-sizing: border-box;
	padding: 10px;
}

.findPw-form .form-control-box>textarea {
	min-height: 300px;
	resize: none;
}

.findPw-form th {
	/* `로그인 아이디` 문구가 줄 바꿈 될 때 공백기준으로 줄바꿈 되도록 */
	word-break: keep-all;
}

.findPw-form .btn {
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

.findPw-form .btn:hover {
	background: linear-gradient(to bottom, #b8b3c6, #ebebf1);
}

.findPw-form .btn-success {
	background-color: green;
}

.findPw-form .btn-danger {
	background-color: red;
}

@media (max-width: 465px){
		.findPw-background {
			width:350px;
		}
}

</style>

<script>
function submitFindIdForm(form) {
	form.loginId.value = form.loginId.value.trim();
	if (form.loginId.value.length == 0) {
		alert('아이디를 입력해주세요.');
		form.loginId.focus();
		return;
	}
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
<div class="findPw-background">
	
	<div class="page-title"><h1>${pageTitle}</h1></div>

	<form method="POST" class="findPw-form table-box con form1" action="doFindPw" onsubmit="submitFindIdForm(this); return false;">
		<input type="hidden" name="redirectUri" value="/usr/member/login">

		<table>
			<colgroup>
				<col width="100">
			</colgroup>
			<tbody>
				<tr>
					<th>아이디</th>
					<td>
						<div class="form-control-box">
							<input type="text" placeholder="아이디를 입력해주세요." name="loginId"
								maxlength="30" autofocus="autofocus" />
						</div>
					</td>
				</tr>
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
					<th>비번 찾기</th>
					<td>
						<button class="btn btn-primary" type="submit">비번 찾기</button>
						<a href="javascript:window.history.back();" class="cancel">취소</a>
					</td>
				</tr>
			</tbody>
		</table>
	</form>
</div>

<%@ include file="../part/foot.jspf"%>