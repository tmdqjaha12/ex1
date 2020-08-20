<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="개인정보 수정" />
<%@ include file="../part/head.jspf"%>

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js">
</script>
<script>
	function ModifyPrivateForm__submit(form) {
		form.loginPw.value = form.loginPw.value.trim();
		if (form.loginPw.value.length == 0) {
			alert('새 로그인 비번을 입력해주세요.');
			form.loginPw.focus();
			return;
		}

		if (form.loginPw.value.length < 5) {
			form.loginPw.focus();
			alert('새 로그인 비밀번호를 5자 이상 입력해주세요.');

			return;
		}
		
		form.loginPwConfirm.value = form.loginPwConfirm.value.trim();
		if (form.loginPwConfirm.value.length == 0) {
			alert('새 로그인 비번 확인을 입력해주세요.');
			form.loginPwConfirm.focus();
			return;
		}

		if(form.loginPw.value != form.loginPwConfirm.value){
			alert('비밀번호를 정확히 입력해 주세요.');
			form.loginPwConfirm.focus();
			return;
		}
		
		form.loginPwReal.value = sha256(form.loginPw.value);
		form.loginPw.value = '';
		form.loginPwConfirm.value = '';

		form.ooldPw.value = fomr.ooldPw.value.trim();

		if(form.ooldPw.value == form.loginPwReal.value){
			alert('기존의 비번과 같습니다.');


			return
		}

		
		form.submit();
	}
</script>

<div class="modify-password-background">
	<form action="doModifyPrivate" method="POST" class="modify-password-form table-box" 
	onsubmit="ModifyPrivateForm__submit(this); return false;">
		<input type="hidden" name="loginPwReal" />
		
		<table>
			<colgroup>
				<col width="100">
			</colgroup>
			<tbody>
				<tr>
					<th>새 로그인 비번</th>
					<td>
						<div class="form-control-box">
							<input type="password" placeholder="로그인 비번을 입력해주세요." name="loginPw" maxlength="30" autofocus="autofocus" />
						</div>
					</td>
				</tr>
				<tr>
					<th>새 로그인 비번 확인</th>
					<td>
						<div class="form-control-box">
							<input type="password" placeholder="새 로그인 비번을 입력해주세요." name="loginPwConfirm" maxlength="30" autofocus="autofocus" />
						</div>
					</td>
				</tr>
				<tr>
					<th>비밀번호 변경</th>
					<td>
						<button class="btn btn-primary" type="submit">확인</button>
						<a href="../home/myPage" class="cancel">취소</a>
					</td>
				</tr>
			</tbody>
		</table>
		
	</form>
</div>

<%@ include file="../part/foot.jspf"%>