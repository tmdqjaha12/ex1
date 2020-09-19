<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="커뮤니티 관리" />
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

	var BoardModifyForm__submitDone = false;
	function BoardModifyForm__submit(form) {
		if (BoardModifyForm__submitDone) {
			alert('처리중입니다.');
			return;
		}


		var maxSizeMb = 50;
		var maxSize = maxSizeMb * 1024 * 1024 //50MB
		if (form.file__board__0__common__doorImg__1.value) {
			
			if( form.file__board__0__common__doorImg__1.value.split('.')[1].toString() == 'jpg'||
					form.file__board__0__common__doorImg__1.value.split('.')[1].toString() == 'png' ||
						form.file__board__0__common__doorImg__1.value.split('.')[1].toString() == 'gif'){
			} else {
				alert("옳바른 형식의 파일을 선택해 주세요.(.jpg/.png/.gif)");
				return;
			}
			
			if (form.file__board__0__common__doorImg__1.files[0].size > maxSize) {
				alert(maxSizeMb + "MB 이하의 파일을 업로드 해주세요.");
				return;
			}
		}
		var startUploadFiles = function(onSuccess) {
			var needToUpload = form.file__board__0__common__doorImg__1.value.length > 0;
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
		
		BoardModifyForm__submitDone = true;
		
		startUploadFiles(function(data) {
			var fileIdsStr = '';
			if (data && data.body && data.body.fileIdsStr) {
				fileIdsStr = data.body.fileIdsStr;
			}
			form.fileIdsStr.value = fileIdsStr;
			form.file__board__0__common__doorImg__1.value = '';
			form.submit();
	
		});
	}

	// 보드 이미지 미리보기notnull
	function setThumbnail(event) { 
		var reader = new FileReader(); 
		
		reader.onload = function(event) {
			var img = document.querySelector("img#my-pro-img"); 
			img.setAttribute("src", event.target.result);
		};
		 
		reader.readAsDataURL(event.target.files[0]); 
	}

	// 보드 이미지 미리보기null
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

	<form method="POST" class="modify-form table-box" action="${board.code}-doBoardModify" onsubmit="BoardModifyForm__submit(this); return false;">
		<input type="hidden" name="fileIdsStr" />
		<input type="hidden" name="id" value="${board.id}" />
		<input type="hidden" name="redirectUri" value="/usr/board/${board.code}-manager" /> 

		<table border="1">
			<colgroup>
				<col width="200">
			</colgroup>
			<tbody>
				<c:forEach var="i" begin="1" end="1" step="1">
					<c:set var="fileNo" value="${String.valueOf(i)}" />
					<c:set var="file" value="${board.extra.file__common__doorImg[fileNo]}" />
					<c:set var="fileExtTypeCode" value="${appConfig.getAttachmentFileExtTypeCode('board', i)}" />
					<tr>
						<th>대문이미지
							${appConfig.getAttachmentFileExtTypeDisplayName('board', i)}</th>
						<td> 
							<!-- 내 프로필 이미지  -->
							<c:choose>
							
								<c:when test="${file != null && file.fileExtTypeCode == 'img'}">
									<div class="img-box img-box-auto pro-img" style="text-align: center;">
										<img id="my-pro-img" src="/usr/file/img?id=${file.id}&updateDate=${file.updateDate}" alt="ㅎㅇㅎㅇ" />
									</div>
									
									<!-- 이미지 input -->
									<div class="form-control-box">
										<input type="file"
											accept="image/png, image/jpeg"
											name="file__board__0__common__doorImg__${fileNo}" 
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
											name="file__board__0__common__doorImg__${fileNo}" 
											onchange="setThumbnailNull(event);">
									</div>
								</c:otherwise>
							</c:choose>
							
							
						</td>
					</tr>
				</c:forEach>
				<tr>
					<th>이름</th>
					<td>
						<div class="form-control-box">
							<div>${board.name }</div>
						</div>
					</td>
				</tr>
				<tr>
					<th>개설일</th>
					<td>
						<div class="form-control-box">
							<div>${board.regDate }</div>
						</div>
					</td>
				</tr>
				<tr>
					<th>주소</th>
					<td>
						<div class="form-control-box">
							<div>http://localhost:8085/usr/article/${board.code}-list</div>
						</div>
					</td>
				</tr>
				<tr>
					<th>신고 목록</th>
					<td>
						<div class="form-control-box">
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