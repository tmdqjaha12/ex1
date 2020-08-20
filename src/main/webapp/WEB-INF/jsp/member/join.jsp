<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="회원가입" />
<%@ include file="../part/head.jspf"%>

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>

<script>
	var MemberJoinForm__submitDone = false;
	var JoinForm__validLoginId = '';
	var JoinForm__validNickName = '';
	var JoinForm__validEmail = '';
	function MemberJoinForm__submit(form) {
		if (MemberJoinForm__submitDone) {
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

		//if (form.loginId.value != JoinForm__validLoginId) {
		//	alert('다른 아이디를 입력해주세요.');
		//	form.loginId.focus();
		//	return;
		//}
		

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

		if (form.loginPwConfirm.value.length == 0) {
			form.loginPwConfirm.focus();
			alert('로그인 비밀번호 확인을 입력해주세요.');

			return;
		}

		if (form.loginPw.value != form.loginPwConfirm.value) {
			form.loginPwConfirm.focus();
			alert('로그인 비밀번호 확인이 일치하지 않습니다.');

			return;
		}

		form.name.value = form.name.value.trim();

		if (form.name.value.length == 0) {
			form.name.focus();
			alert('이름을 입력해주세요.');

			return;
		}

		form.nickname.value = form.nickname.value.trim();

		if (form.nickname.value.length == 0) {
			form.nickname.focus();
			alert('활동명을 입력해주세요.');

			return;
		}

		//if (form.nickname.value != JoinForm__checkNickNameDup) {
		//	alert('다른 활동명을 입력해주세요.');
		//	form.nickname.focus();
		//	return;
		//}

		form.email.value = form.email.value.trim();

		if (form.email.value.length == 0) {
			form.email.focus();
			alert('이메일을 입력해주세요.');

			return;
		}

		//if (form.email.value != JoinForm__checkEmailDup) {
		//	alert('다른 이메일을 입력해주세요.');
		//	form.email.focus();
		//	return;
		//}

		form.loginPwReal.value = sha256(form.loginPw.value);
		form.loginPw.value = '';
		form.loginPwConfirm.value = '';

		form.submit();
		MemberJoinForm__submitDone = true;
	}

	function JoinForm__checkLoginIdDup(input) {
		var form = input.form;
		form.loginId.value = form.loginId.value.trim();
		if (form.loginId.value.length == 0) {
			return;
		}
		$.get('./../member/getLoginIdDup', {
			loginId : form.loginId.value
		}, function(data) {
			var $message = $(form.loginId).next();
			if (data.resultCode.substr(0, 2) == 'S-') {
				$message.empty().append(
						'<div style="color:green;">' + data.msg + '</div>');
				JoinForm__validLoginId = data.loginId;
			} else {
				$message.empty().append(
						'<div style="color:red;">' + data.msg + '</div>');
				JoinForm__validLoginId = '';
			}
		}, 'json');
	}

	function JoinForm__checkNickNameDup(input) {
		var form = input.form;
		form.nickname.value = form.nickname.value.trim();
		if (form.nickname.value.length == 0) {
			return;
		}
		$.get('./../member/getNickNameDup', {
			nickname : form.nickname.value
		}, function(data) {
			var $message = $(form.nickname).next();
			if (data.resultCode.substr(0, 2) == 'S-') {
				$message.empty().append(
						'<div style="color:green;">' + data.msg + '</div>');
				JoinForm__validNickName = data.nickname;
			} else {
				$message.empty().append(
						'<div style="color:red;">' + data.msg + '</div>');
				JoinForm__validNickName = '';
			}
		}, 'json');
	}

	function JoinForm__checkEmailDup(input) {
		var form = input.form;
		form.email.value = form.email.value.trim();
		if (form.email.value.length == 0) {
			return;
		}
		$.get('./../member/getEmailDup', {
			email : form.email.value
		}, function(data) {
			var $message = $(form.email).next();
			if (data.resultCode.substr(0, 2) == 'S-') {
				$message.empty().append(
						'<div style="color:green;">' + data.msg + '</div>');
				JoinForm__validEmail = data.email;
			} else {
				$message.empty().append(
						'<div style="color:red;">' + data.msg + '</div>');
				JoinForm__validEmail = '';
			}
		}, 'json');
	}


	//function JoinForm__checkLoginIdDup(input) {
		//var form = input.form;
		//var checkLoginIdFormData = new FormData(form); 
	//	
	//	$.ajax({
	//		url : './../member/getLoginIdDup',
	//		data : checkLoginIdFormData,
	//		processData : false,
		//	contentType : false,
	//		dataType:"json",
	//		type : 'POST',
	//		success : onSuccess
	//	});
	//}
</script>

<div class="join-background">
	<form method="POST" class="join-form" action="doJoin" onsubmit="MemberJoinForm__submit(this); return false;">
		<input type="hidden" name="redirectUri" value="/usr/member/login">
		<input type="hidden" name="loginPwReal">

		<table>
			<colgroup>
				<col width="200">
			</colgroup>
			<tbody>
				<tr>
					<th>로그인 아이디</th>
					<td>
						<div class="form-control-box">
							<input onkeyup="JoinForm__checkLoginIdDup(this);" type="text" placeholder="로그인 아이디 입력해주세요." name="loginId" maxlength="30" />
							<div class="id-message-msg"></div>
						</div>
					</td>
				</tr>
				<tr>
					<th>로그인 비번</th>
					<td>
						<div class="form-control-box">
							<input type="password" placeholder="로그인 비밀번호를 입력해주세요." name="loginPw" maxlength="30" />
						</div>
					</td>
				</tr>
				<tr>
					<th>로그인 비번 확인</th>
					<td>
						<div class="form-control-box">
							<input type="password" placeholder="로그인 비밀번호 확인을 입력해주세요." name="loginPwConfirm" maxlength="30" />
						</div>
					</td>
				</tr>
				<tr>
					<th>이름</th>
					<td>
						<div class="form-control-box">
							<input type="text" placeholder="이름을 입력해주세요." name="name" maxlength="20" />
						</div>
					</td>
				</tr>
				<tr>
					<th>활동명</th>
					<td>
						<div class="form-control-box">
							<input onkeyup="JoinForm__checkNickNameDup(this);" type="text" placeholder="활동명 입력해주세요." name="nickname" maxlength="20" />
							<div class="nick-message-msg"></div>
						</div>
					</td>
				</tr>
				<tr>
					<th>이메일</th>
					<td>
						<div class="form-control-box">
							<input onkeyup="JoinForm__checkEmailDup(this);" type="email" placeholder="이메일 입력해주세요." name="email" maxlength="50" />
							<div class="mail-message-msg"></div>
						</div>
					</td>
				</tr>
				<tr>
					<th>가입</th>
					<td>
						<button class="btn btn-primary" type="submit">가입</button>
					</td>
				</tr>
			</tbody>
		</table>
	</form>
</div>
<%@ include file="../part/foot.jspf"%>