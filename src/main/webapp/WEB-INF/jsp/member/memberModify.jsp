<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="개인정보 수정" />
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

.modify-background{
	display:block;
	margin:0 auto;
	margin-top:100px;
	width:500px;
	padding-bottom:100px;
	background-color:#ebebf1;
	border:5px solid #6b6880;
}

.modify-form {
	border:1px solid #6b6880;
	margin:0 20px;
	margin-top:100px;
	padding:25px 0;
}

.modify-btn {
	cursor: pointer;
}

@media (max-width: 465px){
		.modify-background {
			width:350px;
		}
		
		col{
			width:0;
		}
		
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
.pro-img > img {
	border:2px solid black;
	border-radius : 33.333%;
	width: 100px;
	height: 100px;
}
</style>


<script>

	var MemberModifyForm__submitDone = false;
	var modifyForm_nickNameData = '';
	var modifyForm_emailData = '';
	function MemberModifyForm__submit(form) {
		if (MemberModifyForm__submitDone) {
			alert('처리중입니다.');
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

		if(modifyForm_nickNameData == 'F-'){
			form.nickname.focus();
			alert('이미 사용중인 활동명 입니다.');
			return;
		}
		if(modifyForm_nickNameData == 'X-'){
			form.nickname.focus();
			alert('활동명을 입력해 주세요.');
			return;
		}

		if(modifyForm_emailData == 'F-'){
			form.nickname.focus();
			alert('이미 사용중인 이메일 입니다.');
			return;
		}
		if(modifyForm_emailData == 'X-'){
			form.nickname.focus();
			alert('이메일을 입력해 주세요.');
			return;
		}

		
		
		// form.loginPwReal.value = sha256(form.loginPw.value);
		// form.loginPw.value = '';
		// form.loginPwConfirm.value = '';
		// form.submit();
		// MemberModifyForm__submitDone = true;


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
		
		MemberModifyForm__submitDone = true;
		
		startUploadFiles(function(data) {
			var fileIdsStr = '';
			if (data && data.body && data.body.fileIdsStr) {
				fileIdsStr = data.body.fileIdsStr;
			}
			form.fileIdsStr.value = fileIdsStr;
			form.file__member__0__common__proImg__1.value = '';
			form.submit();
	
		});
	}



	// dup
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
			modifyForm_nickNameData = data.resultCode.substr(0, 2);
			
			if (data.resultCode.substr(0, 2) == 'S-') {
				$message.empty().append(
						'<div style="color:green;">' + data.msg + '</div>');
				JoinForm__validNickName = data.nickname;
			} else if(data.resultCode.substr(0, 2) == 'F-') {
				$message.empty().append(
						'<div style="color:red;">' + data.msg + '</div>');
				JoinForm__validNickName = '';
			} else if(data.resultCode.substr(0, 2) == 'Z-') {
				$message.empty().append(
						'<div style="color:blue;">' + data.msg + '</div>');
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
			modifyForm_emailData = data.resultCode.substr(0, 2);
			
			if (data.resultCode.substr(0, 2) == 'S-') {
				$message.empty().append(
						'<div style="color:green;">' + data.msg + '</div>');
				JoinForm__validEmail = data.email;
			} else if(data.resultCode.substr(0, 2) == 'F-'){
				$message.empty().append(
						'<div style="color:red;">' + data.msg + '</div>');
				JoinForm__validEmail = '';
			} else if(data.resultCode.substr(0, 2) == 'Z-') {
				$message.empty().append(
						'<div style="color:blue;">' + data.msg + '</div>');
				JoinForm__validNickName = '';
			} else if(data.resultCode.substr(0, 2) == 'A-') {
				$message.empty().append(
						'<div style="color:red;">' + data.msg + '</div>');
				JoinForm__validNickName = '';
			} else if(data.resultCode.substr(0, 2) == 'S-'){
				$message.empty();
				JoinForm__validEmail = '';
			}
		}, 'json');
	}, 1000);

	// 프로필 이미지 미리보기notnull
	function setThumbnail(event) { 
		var reader = new FileReader(); 
		
		reader.onload = function(event) {
			var img = document.querySelector("img#my-pro-img"); 
			img.setAttribute("src", event.target.result);
		};
		 
		reader.readAsDataURL(event.target.files[0]); 
	}

	// 프로필 이미지 미리보기null
	function setThumbnailNull(event) { 
		
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

<div class="modify-background">

	<div class="page-title"><h1>${pageTitle}</h1></div>

	<form method="POST" class="modify-form table-box" action="doMemberModify" onsubmit="MemberModifyForm__submit(this); return false;">
		<input type="hidden" name="fileIdsStr" />
		<input type="hidden" name="memberId" value="${loginedMember.id}" />
		<input type="hidden" name="redirectUri" value="/usr/member/myPage">

		<table>
			<colgroup>
				<col width="200">
			</colgroup>
			<tbody>
				<c:forEach var="i" begin="1" end="1" step="1">
					<c:set var="fileNo" value="${String.valueOf(i)}" />
					<c:set var="file" value="${member.extra.file__common__proImg[fileNo]}" />
					<c:set var="fileExtTypeCode" value="${appConfig.getAttachmentFileExtTypeCode('member', i)}" />
					<tr>
						<th>프로필
							${appConfig.getAttachmentFileExtTypeDisplayName('member', i)}</th>
						<td> 
							<!-- 내 프로필 이미지  -->
							<c:choose>
							
								<c:when test="${file != null && file.fileExtTypeCode == 'img'}">
									<div class="img-box img-box-auto pro-img">
										<img id="my-pro-img" src="/usr/file/img?id=${file.id}&updateDate=${file.updateDate}" alt="ㅎㅇㅎㅇ" />
									</div>
									
									<!-- 이미지 input -->
									<div class="form-control-box">
										<input type="file"
											accept="image/png, image/jpeg"
											name="file__member__0__common__proImg__${fileNo}" 
											onchange="setThumbnail(event);">
									</div>
								</c:when>
								<c:otherwise>
									<div id="div-pro-img"></div> <!-- 프로필 이미지 미리보기 -->
									<div class="pre-pro-img" id="image_container"></div>
									
									<!-- 이미지 input -->
									<div class="form-control-box">
										<input type="file"
											accept="image/png, image/jpeg"
											name="file__member__0__common__proImg__${fileNo}" 
											onchange="setThumbnailNull(event);">
									</div>
								</c:otherwise>
							</c:choose>
							
							
						</td>
					</tr>
				</c:forEach>
				<tr>
					<th>아이디</th>
					<td>
						<div class="form-control-box">
							<div>${loginedMember.loginId }</div>
						</div>
					</td>
				</tr>
				<tr>
					<th>이름</th>
					<td>
						<div class="form-control-box">
							<div>${loginedMember.name }</div>
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
						<button class="modify-btn" type="submit">수정</button>
						<a href="javascript:window.history.back();" class="cancel">취소</a>
					</td>
				</tr>
			</tbody>
		</table>
	</form>
</div>
<%@ include file="../part/foot.jspf"%>