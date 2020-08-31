<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="커뮤니티 게시판 신청" />
<%@ include file="../part/head.jspf"%>

<!-- 일반 회원들이 자기만의 게시판을 만들기위해, 신청하는 공간, 신청서 -->

<script>
	var CreateBoardForm__submitDone = false;
	var CreateBoardForm__validBoardName = '';
	function CreateBoardForm__submit(form) {
		if (CreateBoardForm__submitDone) {
			alert('처리중입니다.');
			return;
		}
		form.name.value = form.name.value.trim();
		if (form.name.value.length == 0) {
			form.name.focus();
			alert('게시판 명을 입력해주세요.');
			return;
		}

		form.body.value = form.body.value.trim();
		if (form.body.value.length == 0) {
			form.body.focus();
			alert('게시판 설명을 입력해주세요.');
			return;
		}

		form.submit();
		CreateBoardForm__submitDone = true;
	}

	var CreateBoardForm__checkNameDup = _.debounce(function(input) {
		var form = input.form;
		
		form.name.value = form.name.value.trim();
		
		if (form.name.value.length == 0) {
			//return;
		}
		
		$.get('./../board/getNameDup', {
			name : form.name.value
		}, function(data) {
			var $message = $(form.name).next();
			
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
				CreateBoardForm__validBoardName = '';
			}
		}, 'json');
	}, 1000);
</script>

<div class="create-board con" style="background-color:#ebebf1;">

	<div class="write-page-title">
		<h1>${pageTitle}</h1>
	</div>

	<form method="POST" class="write-form table-box con form1" action="doSendBoardApplyDoc"
		onsubmit="CreateBoardForm__submit(this); return false;">
		<input type="hidden" name="redirectUri" value="/usr/home/main">

		<table border="1">
			<colgroup>
				<col class="table-first-col">
			</colgroup>
			<tbody>
				<tr>
					<th>커뮤니티 게시판 이름</th>
					<td>
						<div class="form-control-box">
							<input onkeyup="CreateBoardForm__checkNameDup(this);" type="text" placeholder="게시판명을 입력해주세요." name="name"/>
							<div class="name-message-msg"></div>
						</div>
					</td>
				</tr>
				<tr>
					<th>커뮤니티 게시판 설명</th>
					<td>
						<div class="form-control-box">
							<textarea maxlength="300" name="body" placeholder="게시판에 관한 설명을 입력해주세요." class="height-300" style="resize: none; width: 800px;"></textarea>
						</div>
					</td>
				</tr>
				<tr>
					<th>신청</th>
					<td>
						<button class="btn btn-primary" type="submit" style="margin-bottom: 12px;">신청</button> 
							<a class="btn btn-info" style="padding: 10px;" href="/usr/home/main">메인으로</a>
					</td>
				</tr>
			</tbody>
		</table>
	</form>

</div>
<%@ include file="../part/foot.jspf"%>