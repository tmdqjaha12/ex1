<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="회원가입" />
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

.join-background{
	display:block;
	margin:0 auto;
	margin-top:100px;
	margin-bottom:60px;
	width:500px;
	height:750px;
	background-color:#ebebf1;
	border:5px solid #6b6880;
}

.join-form {
	border:1px solid #6b6880;
	margin:0 20px;
	margin-top:65px;
}




.join-form > table {
	width: 100%;
	border-collapse: collapse;
}

.join-form>table th,
 .table-box>table td  {
	border-right:none;
	padding: 10px;
	text-align: left;
	color:black;
}

/* 폼 관련 */
.join-form .form-control-box>input, .join-form .form-control-box>textarea{
	width: 100%;
	padding: 0;
	display: block;
	box-sizing: border-box;
	padding: 10px;
}

.join-form .form-control-box>textarea {
	min-height: 300px;
	resize: none;
}

.join-form th {
	/* `로그인 아이디` 문구가 줄 바꿈 될 때 공백기준으로 줄바꿈 되도록 */
	word-break: keep-all;
}

.join-form .btn {
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

.join-form .btn:hover {
	background: linear-gradient(to bottom, #b8b3c6, #ebebf1);
}

.join-form .btn-success {
	background-color: green;
}

.join-form .btn-danger {
	background-color: red;
}

/* 프로파일 이미지 */
.pre-pro-img {
	text-align: center;
	margin-top:100px;
}

.pre-pro-img > img {
	border:2px solid black;
	border-radius : 33.333%;
	width: 100px;
	height: 100px;
	margin-top:-100px;
}

</style>

<script>
	var MemberJoinForm__submitDone = false;
	var JoinForm__validLoginId = '';
	var JoinForm__validNickName = '';
	var JoinForm__validEmail = '';
	// var JoinForm__proIng = '';
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
		
		form.email.value = form.email.value.trim();

		if (form.email.value.length == 0) {
			form.email.focus();
			alert('이메일을 입력해주세요.');

			return;
		}

		// form.loginPwReal.value = sha256(form.loginPw.value);
		// form.loginPw.value = '';
		// form.loginPwConfirm.value = '';

		//MemberJoinForm__submitDone = true;
		// form.submit();
		//alert(getFile(form.file__member__0__common__proImg__1.value));
		//form.file__member__0__common__proImg__1.value.split('.')[1] != 'png'
		//alert(form.file__member__0__common__proImg__1.value.split('.')[1].toString());
		
		var maxSizeMb = 50;
		var maxSize = maxSizeMb * 1024 * 1024 //50MB
		if (form.file__member__0__common__proImg__1.value) {
			
			if( form.file__member__0__common__proImg__1.value.split('.')[1].toString() == 'jpg'||
					form.file__member__0__common__proImg__1.value.split('.')[1].toString() == 'png' ||
						form.file__member__0__common__proImg__1.value.split('.')[1].toString() == 'gif'){
			} else {
				alert("옳바른 형식의 파일을 선택해 주세요.");
				return;
			}
			
			if (form.file__member__0__common__proImg__1.files[0].size > maxSize) {
				alert(maxSizeMb + "MB 이하의 파일을 업로드 해주세요.");
				return;
			}
		}
		var startUploadFiles = function(onSuccess) {
			var needToUpload = form.file__member__0__common__proImg__1.value.length > 0;
			if (needToUpload == false) {
				onSuccess();
				return;
			}

			
			var fileUploadFormData = new FormData(form);
			$.ajax({
				url : './../file/doUploadAjax',
				data : fileUploadFormData,
				processData : false,
				contentType : false,
				dataType : "json",
				type : 'POST',
				success : onSuccess
			});
		}
		
		MemberJoinForm__submitDone = true;
		
		startUploadFiles(function(data) {
			var fileIdsStr = '';
			if (data && data.body && data.body.fileIdsStr) {
				fileIdsStr = data.body.fileIdsStr;
			}
			form.loginPwReal.value = sha256(form.loginPw.value);
			form.loginPw.value = '';
			form.loginPwConfirm.value = '';
			form.fileIdsStr.value = fileIdsStr;
			form.file__member__0__common__proImg__1.value = '';
			form.submit();
	
		});
	}

	
	// dup_start
	var JoinForm__checkLoginIdDup = _.debounce(function(input) {
		var form = input.form;
		
		form.loginId.value = form.loginId.value.trim();
		
		if (form.loginId.value.length == 0) {
			//return;
		}
		
		$.get('./../member/getLoginIdDup', {
			loginId : form.loginId.value
		}, function(data) {
			var $message = $(form.loginId).next();
			
			if (data.resultCode.substr(0, 2) == 'S-') {
				$message.empty().append(
						'<div style="color:green;">' + data.msg + '</div>');
				JoinForm__validLoginId = data.loginId;
			} else if (data.resultCode.substr(0, 2) == 'F-') {
				$message.empty().append(
						'<div style="color:red;">' + data.msg + '</div>');
				JoinForm__validLoginId = '';
			} else if (data.resultCode.substr(0, 2) == 'L-') {
				$message.empty().append(
						'<div style="color:red;">' + data.msg + '</div>');
				JoinForm__validLoginId = '';
			} else if (data.resultCode.substr(0, 2) == 'X-') {
				$message.empty();
				JoinForm__validLoginId = '';
			}
		}, 'json');
	}, 1000);

	var JoinForm__checkNickNameDup = _.debounce(function(input) {
		var form = input.form;
		form.nickname.value = form.nickname.value.trim();
		
		if (form.nickname.value.length == 0) {
			
			//return;
		}
		
		$.get('./../member/getNickNameDup', {
			nickname : form.nickname.value
		}, function(data) {
			var $message = $(form.nickname).next();
			
			if (data.resultCode.substr(0, 2) == 'S-') {
				$message.empty().append(
						'<div style="color:green;">' + data.msg + '</div>');
				JoinForm__validNickName = data.nickname;
			} else if (data.resultCode.substr(0, 2) == 'F-') {
				$message.empty().append(
						'<div style="color:red;">' + data.msg + '</div>');
				JoinForm__validNickName = '';
			} else if (data.resultCode.substr(0, 2) == 'X-') {
				$message.empty();
				JoinForm__validLoginId = '';
			}
		}, 'json');
	}, 1000);

	var JoinForm__checkEmailDup = _.debounce(function(input) {
		var form = input.form;
		form.email.value = form.email.value.trim();
		if (form.email.value.length == 0) {
			//return;
		}
		$.get('./../member/getEmailDup', {
			email : form.email.value
		}, function(data) {
			var $message = $(form.email).next();
			if (data.resultCode.substr(0, 2) == 'S-') {
				$message.empty().append(
						'<div style="color:green;">' + data.msg + '</div>');
				JoinForm__validNickName = data.nickname;
			} else if (data.resultCode.substr(0, 2) == 'F-') {
				$message.empty().append(
						'<div style="color:red;">' + data.msg + '</div>');
				JoinForm__validNickName = '';
			} else if (data.resultCode.substr(0, 2) == 'A-') {
				$message.empty().append(
						'<div style="color:red;">' + data.msg + '</div>');
				JoinForm__validNickName = '';
			} else if (data.resultCode.substr(0, 2) == 'X-') {
				$message.empty();
				JoinForm__validLoginId = '';
			}
		}, 'json');
	}, 1000);


	// 프로필 이미지 미리보기
	function setThumbnail(event) { 
		
		if(document.querySelector("div#image_container")){ // 엘리먼트 제거
			var header = document.querySelector("div#image_container");
			header.parentNode.removeChild(header); 
		}

		var div = document.createElement("div"); // 엘리먼트 추가
		div.className = 'pre-pro-img';
		div.id = 'image_container';
		document.querySelector("div#div-pro-img").append(div);
		
		var reader = new FileReader(); 
		
		reader.onload = function(event) {
			var img = document.createElement("img"); 
			img.id = 'profile-img';
			img.setAttribute("src", event.target.result); 
			document.querySelector("div#image_container").appendChild(img); 
		};
		 
		reader.readAsDataURL(event.target.files[0]); 
	}

</script>

<div class="join-background">

	<div class="page-title"><h1>${pageTitle}</h1></div>

	<form method="POST" class="join-form" action="doJoin" onsubmit="MemberJoinForm__submit(this); return false;">
		<input type="hidden" name="fileIdsStr" /> 
		<input type="hidden" name="loginPwReal">
		<input type="hidden" name="redirectUri" value="/usr/member/login">
		<div id="div-pro-img"></div> <!-- 프로필 이미지 미리보기 -->
		<div class="pre-pro-img" id="image_container"></div>

		<table>
			<colgroup>
				<col width="200">
			</colgroup>
			<tbody>
				<c:forEach var="i" begin="1" end="1" step="1">
					<c:set var="fileNo" value="${String.valueOf(i)}" />
					<c:set var="fileExtTypeCode"
						value="${appConfig.getAttachmentFileExtTypeCode('member', i)}" />
					<tr id="tr_pro">
						<th>프로필
							${appConfig.getAttachmentFileExtTypeDisplayName('member', i)}</th>
						<td>
							<div class="form-control-box">
								<input type="file"
									accept="image/png, image/jpeg"
									name="file__member__0__common__proImg__${fileNo}" 
									onchange="setThumbnail(event);">
							</div>
						</td>
					</tr>
				</c:forEach>
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
						<a href="javascript:window.history.back();" class="cancel">취소</a>
					</td>
				</tr>
			</tbody>
		</table>
	</form>
</div>
<%@ include file="../part/foot.jspf"%>