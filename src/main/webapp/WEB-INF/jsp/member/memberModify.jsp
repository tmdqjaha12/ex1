<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="개인정보 수정" />
<%@ include file="../part/head.jspf"%>


<script>
	var MemberModifyForm__submitDone = false;
	var JoinForm__validLoginId = '';
	function MemberModifyForm__submit(form) {
		if (MemberModifyForm__submitDone) {
			alert('처리중입니다.');
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
		
		form.email.value = form.email.value.trim();

		if (form.email.value.length == 0) {
			form.email.focus();
			alert('이메일을 입력해주세요.');

			return;
		}

		form.loginPwReal.value = sha256(form.loginPw.value);
		form.loginPw.value = '';
		form.loginPwConfirm.value = '';

		form.submit();
		MemberJoinForm__submitDone = true;
	}

	var JoinForm__checkNickNameDup = _.debounce(function(input) {
		var form = input.form;
		form.nickname.value = form.nickname.value.trim();
		if (form.nickname.value.length == 0) {
			//return;
		}
		$.get('./../member/getNickNameDupForMemberModify', {
			nickname : form.nickname.value
		}, function(data) {
			var $message = $(form.nickname).next();
			if (data.resultCode.substr(0, 2) == 'S-') {
				$message.empty().append(
						'<div style="color:green;">' + data.msg + '</div>');
				JoinForm__validNickName = data.nickname;
			} else if(data.resultCode.substr(0, 2) == 'F-') {
				$message.empty().append(
						'<div style="color:red;">' + data.msg + '</div>');
				JoinForm__validNickName = '';
			} else if(data.resultCode.substr(0, 2) == 'X-') {
				$message.empty();
				JoinForm__validNickName = '';
			}
		}, 'json');
	}, 1000);

	var JoinForm__checkEmailDup = _.debounce(function(input) {
		var form = input.form;
		form.email.value = form.email.value.trim();
		if (form.email.value.length == 0) {
			//return;
		}
		$.get('./../member/getEmailDupFormMemberModify', {
			email : form.email.value
		}, function(data) {
			var $message = $(form.email).next();
			if (data.resultCode.substr(0, 2) == 'S-') {
				$message.empty().append(
						'<div style="color:green;">' + data.msg + '</div>');
				JoinForm__validEmail = data.email;
			} else if(data.resultCode.substr(0, 2) == 'F-'){
				$message.empty().append(
						'<div style="color:red;">' + data.msg + '</div>');
				JoinForm__validEmail = '';
			} else if(data.resultCode.substr(0, 2) == 'S-'){
				$message.empty();
				JoinForm__validEmail = '';
			}
		}, 'json');
	}, 1000);

</script>

<div class="modify-background">

	<div class="page-title"><h1>${pageTitle}</h1></div>

	<form method="POST" class="modify-form table-box" action="doMemberModify" onsubmit="MemberModifyForm__submit(this); return false;">
		<input type="hidden" name="redirectUri" value="/usr/home/myPage">
		

		<table>
			<colgroup>
				<col width="200">
			</colgroup>
			<tbody>
				<tr>
					<th>아이디</th>
					<td>
						<div class="form-control-box">
							<div style="color:white;">${loginedMember.loginId }</div>
						</div>
					</td>
				</tr>
				<tr>
					<th>이름</th>
					<td>
						<div class="form-control-box">
							<div style="color:white;">${loginedMember.name }</div>
						</div>
					</td>
				</tr>
				<tr>
					<th>활동명</th>
					<td>
						<div class="form-control-box">
							<input onkeyup="JoinForm__checkNickNameDup(this);" type="text" value="${loginedMember.nickname }" placeholder="활동명 입력해주세요." name="nickname" maxlength="20" />
							<div class="nick-message-msg"></div>
						</div>
					</td>
				</tr>
				<tr>
					<th>이메일</th>
					<td>
						<div class="form-control-box">
							<input onkeyup="JoinForm__checkEmailDup(this);" type="email" value="${loginedMember.email }" placeholder="이메일 입력해주세요." name="email" maxlength="50" />
							<div class="mail-message-msg"></div>
						</div>
					</td>
				</tr>
				<tr>
					<th>수정</th>
					<td>
						<button class="btn btn-primary" type="submit">수정</button>
						<a href="../home/myPage" class="cancel">취소</a>
					</td>
				</tr>
			</tbody>
		</table>
	</form>
</div>
<%@ include file="../part/foot.jspf"%>