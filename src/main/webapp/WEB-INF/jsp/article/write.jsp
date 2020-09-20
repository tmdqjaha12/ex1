<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="글 쓰기" />
<%@ include file="../part/head.jspf"%>
<%@ include file="../part/toastUiEditor.jspf"%>


<script>
	var ArticleWriteForm__submitDone = false;
	function ArticleWriteForm__submit(form) {
		if (ArticleWriteForm__submitDone) {
			alert('처리중입니다.');
			return;
		}
		form.title.value = form.title.value.trim();
		if (form.title.value.length == 0) {
			form.title.focus();
			alert('제목을 입력해주세요.');
			return;
		}
		var bodyEditor = $(form).find('.toast-editor.input-body').data(
				'data-toast-editor');
		var body = bodyEditor.getMarkdown().trim();
		if (body.length == 0) {
			bodyEditor.focus();
			alert('특이사항을 입력해주세요.');
			return;
		}
		form.body.value = body;
		var maxSizeMb = 50;
		var maxSize = maxSizeMb * 1024 * 1024 //50MB
		if (form.file__article__0__common__attachment__1.value) {
			if (form.file__article__0__common__attachment__1.files[0].size > maxSize) {
				alert(maxSizeMb + "MB 이하의 파일을 업로드 해주세요.");
				return;
			}
		}
		if (form.file__article__0__common__attachment__2.value) {
			if (form.file__article__0__common__attachment__2.files[0].size > maxSize) {
				alert(maxSizeMb + "MB 이하의 파일을 업로드 해주세요.");
				return;
			}
		}
		if (form.file__article__0__common__attachment__3.value) {
			if (form.file__article__0__common__attachment__3.files[0].size > maxSize) {
				alert(maxSizeMb + "MB 이하의 파일을 업로드 해주세요.");
				return;
			}
		}
		var startUploadFiles = function(onSuccess) {
			var needToUpload = form.file__article__0__common__attachment__1.value.length > 0;
			if (!needToUpload) {
				needToUpload = form.file__article__0__common__attachment__2.value.length > 0;
			}
			if (!needToUpload) {
				needToUpload = form.file__article__0__common__attachment__3.value.length > 0;
			}
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
		
		ArticleWriteForm__submitDone = true;
		
		startUploadFiles(function(data) {
			var fileIdsStr = '';
			if (data && data.body && data.body.fileIdsStr) {
				fileIdsStr = data.body.fileIdsStr;
			}
			form.fileIdsStr.value = fileIdsStr;
			form.file__article__0__common__attachment__1.value = '';
			form.file__article__0__common__attachment__2.value = '';
			form.file__article__0__common__attachment__3.value = '';
			if (bodyEditor.inBodyFileIdsStr) {
				form.fileIdsStr.value += bodyEditor.inBodyFileIdsStr;
			}
			form.submit();
	
		});
	}
</script>

<div class="write-background">

	<c:if test="${board.code == 'question'}">
		<div class="write-page-title">
			<h1>문의하기</h1>
		</div>
	</c:if>

	<form method="POST" class="write-form table-box con form1"
		action="${board.code}-doWrite"
		onsubmit="ArticleWriteForm__submit(this); return false;">
		<input type="hidden" name="fileIdsStr" /> 
		<input type="hidden" name="redirectUri" value="/usr/article/${board.code}-detail?id=#id">

		<table border="1">
			<colgroup>
				<col class="table-first-col">
			</colgroup>
			<tbody>
				<tr>
					<th>글쓰기</th>
					<td>
						<div style="font-weight: bold;">${board.name}게시판 글쓰기</div>
					</td>
				</tr>
				<tr>
					<th>제목</th>
					<td>
						<div class="form-control-box">
							<input type="text" placeholder="제목을 입력해주세요." name="title"
								maxlength="100" />
						</div>
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td>
						<div class="form-control-box">
							<div class="form-control-box">
								<input type="hidden" name="body" />
								<script type="text/x-template"></script>
								<div data-relTypeCode="article" data-relId="0" class="toast-editor input-body"></div>
							</div>
						</div>
					</td>
				</tr>
				<c:forEach var="i" begin="1" end="3" step="1">
					<c:set var="fileNo" value="${String.valueOf(i)}" />
					<c:set var="fileExtTypeCode"
						value="${appConfig.getAttachmentFileExtTypeCode('article', i)}" />
					<tr>
						<th>첨부${fileNo}
							${appConfig.getAttachmentFileExtTypeDisplayName('article', i)}</th>
						<td>
							<div class="form-control-box">
								<input type="file"
									accept="${appConfig.getAttachemntFileInputAccept('article', i)}"
									name="file__article__0__common__attachment__${fileNo}">
							</div>
						</td>
					</tr>
				</c:forEach>
				<tr>
					<th>작성</th>
					<td>
						<button class="btn btn-primary" type="submit"
							style="margin-bottom: 12px;">작성</button> <a class="btn btn-info"
						style="padding: 10px;" href="${listUrl}">리스트</a>
					</td>
				</tr>
			</tbody>
		</table>
	</form>

</div>


<%@ include file="../part/foot.jspf"%>