<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="상세 게시물" />
<%@ include file="../part/head.jspf"%>
<%@ include file="../part/toastUiEditor.jspf"%>

<style>
/* 배경 */
.detail-background{
	margin-top:100px;
	width:860px;
	border:2px solid black;
	
}
/* 탑바 시작 */
.top-bar{
	margin-top:5px;
	width:100%;
	height:33px;
	background-color:#ebebf1;
	border-bottom:5px solid #6b6880;
	text-align: right;
}
.top-bar > a {
	padding:5px;
	display: block;
}
/* 탑바 끝 */
/* 제목 시작 */
.top-title {
	padding-top:10px;
	padding-bottom:10px;
}

.top-title > .title{
	padding: 0 20px;
}

.top-title > .title > h1{
	word-break: break-all; /* 영어 줄바꿈 */
}

.top-title:after {
	content: "";
	display: block;
	width: 95%;
	border-bottom:3px solid #bfbfd2;
	margin:0 auto;
	margin-top:20px;
}
     
.top-title > .writer{ /* 글쓴이 */
	margin-left:30px;
	margin-top:4px;
}
.top-title > .writer .nickname, .nickname{
	text-decoration: none; 
	font-weight: bold; 
}
.top-title > .writer .regdate, .regdate{
	font-size:0.8rem; 
	display:block;
}
.top-title > .writer .article-info{
	width:100%;
	text-align: right;
	padding-right: 25px;
}
/* 제목 끝 */
.article-body {
	padding: 20px;
}
.article-body > * {
	word-break: break-all; /* 영어 줄바꿈 */	
}

.pro-img > img {
	border:1px solid black;
	border-radius : 33.333%;
	width: 33px;
	height: 33px;
}

/* 신고 */
.singo{
	text-align: right;
	margin-bottom:-28px;
}

.singo-form-modal-actived, singo-form-modal-actived>body {
	overflow: hidden;
}

.singo-form-modal {
	position: fixed;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	background-color: rgba(0, 0, 0, 0.4);
	display: none;
	z-index: 20;
}

.singo-form-modal>div {
	position: absolute;
	left: 50%;
	top: 50%;
	transform: translateX(-50%) translateY(-50%);
	max-width: 100vw;
	min-width: 320px;
	max-height: 100vh;
	overflow-y: auto;
	border: 3px solid black;
	box-sizing: border-box;
}

.singo-form-modal-actived .singo-form-modal {
	display: flex;
}

.singo-form-modal .form-control-label {
	width: 60px;
}

.singo-form-modal .form-control-box {
	flex: 1 0 0;
}

.singo-form-modal .video-box {
	width: 100px;
}

.write-btn-box{
	margin-right: 10px;
}

.write-btn-box:after{
	content: "";
	display: block;
	clear: both;	
}

.write-btn-box a {
	appearance: button;
    -webkit-writing-mode: horizontal-tb !important;
    text-rendering: auto;
    color: -internal-light-dark(buttontext, rgb(170, 170, 170));
    letter-spacing: normal;
    word-spacing: normal;
    text-transform: none;
    text-indent: 0px;
    text-shadow: none;
    display: inline-block;
    text-align: center;
    align-items: flex-start;
    cursor: default;
    background-color: -internal-light-dark(rgb(239, 239, 239), rgb(74, 74, 74));
    box-sizing: border-box;
    margin: 0em;
    font: 400 13.3333px Arial;
    padding: 1px 6px;
    border-width: 2px;
    border-style: outset;
    border-color: -internal-light-dark(rgb(118, 118, 118), rgb(195, 195, 195));
    border-image: initial;
    text-decoration: none;
    font-weight: bold;
    float: right;
    border-radius:10%;
    border:1.5px solid #ababab;
    
}

.write-btn-box a:last-child {
	background-color:#efefef;
}
</style>

<script>
/* 신고 */

function Singo__showSingoFormModal(el) {
			$('html').addClass('singo-form-modal-actived');
			var $tr = $(el).closest('tr');
			var form = $('.singo-form-modal form').get(0);
			$(form).find('[data-name]').each(function(index, el) {
				var $el = $(el);
				var name = $el.attr('data-name');
				name = name.replaceAll('__0__', '__' + id + '__');
				$el.attr('name', name);
				if ($el.prop('type') == 'file') {
					$el.val('');
				} else if ($el.prop('type') == 'checkbox') {
					$el.prop('checked', false);
				}
			});

		}
function Singo__hideSingoFormModal() {
	$('html').removeClass('singo-form-modal-actived');
}




var singo__submitSingoFormDone = false;
function singo__submitSingoForm(form) {
	if (singo__submitSingoFormDone) {
		alert('처리중입니다.');
		return;
	}

	var SingoFormData = new FormData(form);
	$.ajax({
		url : './../article/doSingoAjax',
		data : SingoFormData,
		processData : false,
		contentType : false,
		dataType : "json",
		type : 'POST',
		success : onSingoComplete
	});

	
	Singo__hideSingoFormModal();
	singo__submitSingoFormDone = false;
	
	var onSingoComplete = function(data) {
		var fileIdsStr = '';
		if (data && data.body && data.body.fileIdsStr) {
			fileIdsStr = data.body.fileIdsStr;
		}
		if (data.msg) {
			alert(data.msg);
		}
		//submit();
	};
}
</script>



<div class="detail-background con">

	<div class="backA" style="margin-top:-30px;">
		<a href="javascript:window.history.back();" class="cancel">뒤로가기</a>
		<a href="${listUrl}" class="btn btn-info">목록으로</a>
	</div>
	
	<div class="article-detail-box con">
		
		<div class="top-bar">
			<a>No.${article.id}</a>
		</div>
		
		<div class="top-title">
			<div class="title">
				<h1>${article.forPrintTitle}</h1>
			</div>
			
			<div class="writer">
				<table>
					<tbody>
						<tr>
							<th>
								<c:forEach var="i" begin="1" end="1" step="1">
									<c:set var="fileNo" value="${String.valueOf(i)}" />
									<c:set var="file" value="${member.extra.file__common__proImg[fileNo]}" />
									<c:if test="${file != null && file.fileExtTypeCode == 'img'}">
										<div class="img-box img-box-auto pro-img">
											<img src="/usr/file/img?id=${file.id}&updateDate=${file.updateDate}" alt="ㅎㅇㅎㅇ" />
										</div>
									</c:if>
								</c:forEach>
							</th>
							<td>
								<a class="nickname" href="#">&nbsp${article.extra.writer}</a>
								<a class="regdate">&nbsp${article.regDate}</a>
							</td>
						</tr>
						<tr>
							<th></th>
							<td class="article-info">
								<div>
									조회수 ${article.hit} 
									┃ 추천 ${article.extra.likePoint} 
									┃ 댓글 ${article.extra.repliesCount}
								</div>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		
		<!-- body -->
		<div class="article-body">
			<script type="text/x-template">${article.body}</script>
			<div class="toast-editor toast-editor-viewer"></div>
		</div>
		
		<!-- 첨부파일 -->
		<table border="1" style="width:100%;">
			<c:forEach var="i" begin="1" end="3" step="1">
				<c:set var="fileNo" value="${String.valueOf(i)}" />
				<c:set var="file"
					value="${article.extra.file__common__attachment[fileNo]}" />
				<c:if test="${file != null}">
					<tbody>
						<tr>
							<th>첨부파일 ${fileNo}</th>
							<td>
								<c:if test="${file.fileExtTypeCode == 'video'}">
									<div class="video-box">
										<video controls
											src="/usr/file/streamVideo?id=${file.id}&updateDate=${file.updateDate}">video
											not supported
										</video>
									</div>
								</c:if> 
								<c:if test="${file.fileExtTypeCode == 'img'}">
									<div class="img-box img-box-auto">
										<img src="/usr/file/img?id=${file.id}&updateDate=${file.updateDate}" alt="" />
									</div>
								</c:if>
							</td>
						</tr>
					</tbody>
				</c:if>
			</c:forEach>
		</table>

		<c:if test="${isLogined}">	<!-- 로그인일 때만 -->
			<c:if test="${article.memberId != loginedMemberId }"><!-- 본인 게시물은 신고 좋아요 불가 -->
				<!-- 좋아요 -->
				<c:if test="${liked}">
					<div class="likeit" style="margin-left:20px; margin-top:10px;">
						<a href="/usr/article/doLike?id=${article.id}&redirectUrl=/usr/article/${board.code}-detail?id=${article.id}"
							onclick="if ( confirm('추천하시겠습니까?') == false ) { return false; }"><i class="fab fa-gratipay" style="font-size: 1.5rem;"></i></a>
					</div>
				</c:if>
				<c:if test="${!liked}">
					<div style="margin-left:20px; margin-bottom:20px; margin-top:10px;">
						<i class="fab fa-gratipay" style="font-size: 1.5rem; color:red;"></i>
					</div>
				</c:if>
				<!-- 끝 -->
				<!-- 신고 -->
				<c:if test="${board.code != 'notice' && board.code != 'update' && board.code != 'question'}">
					<div class="singo">
						<button class="btn btn-info" type="button" onclick="Singo__showSingoFormModal(this);">신고</button>
					</div>
				</c:if>
				<!-- 끝 -->
			</c:if>
			
			<!-- 게시물 수정 삭제 리스트 -->
			<div class="write-btn-box con margin-top-20  con" >
				<c:if test="${article.extra.actorCanDelete}">
					<a class="btn btn-danger" href="${board.code}-doDelete?id=${article.id}" onclick="if ( confirm('삭제하시겠습니까?') == false ) return false;">삭제</a>
				</c:if>
				<c:if test="${article.extra.actorCanModify}">
					<a class="btn btn-info" href="${board.code}-modify?id=${article.id}&listUrl=${Util.getUriEncoded(listUrl)}">수정</a>
				</c:if>
			</div>
			<!-- 끝 -->
		</c:if>	
	</div>

</div>



<div class="singo-form-modal">
	<div class="bg-white">
		<h3 class="text-align-center" style="margin-left:10px;">신고하기</h3>
		<form action="" class="form1 padding-10" onsubmit="singo__submitSingoForm(this); return false;">
			<input type="hidden" name="articleId" value="${article.id}"/>
			<input type="hidden" name="boardId" value="${board.id}"/>
			
			<div class="form-row" style="margin-top:10px;">
				<table border="1">
					<tbody>
						<tr>
							<th>제목</th>
							<td>${article.title }</td>
						</tr>
						<tr>
							<th>작성자</th>
							<td>${article.extra.writer }</td>
						</tr>
						<tr>
							<th>신고사유</th>
							<td>
								<p class="desc5">해당하는 사유 1개를 선택해 주세요 </p>
				                <ul class="list_type">
				                    <li>
				                        <input type="radio" name="reportType" id="rdo_illegal" value="ba1" class="input_rdo" checked="checked"><label for="rdo_illegal">&nbsp;부적절한 홍보 게시글</label>
				                      
				                    </li>
				                    <li>
				                        <input type="radio" name="reportType" id="rdo_obscenity" value="ba2" class="input_rdo"> <label for="rdo_obscenity">음란성 또는 청소년에게 부적합한 내용</label>
				                    </li>
				                    <li>
				                        <input type="radio" name="reportType" id="rdo_libel" value="ba3" class="input_rdo"> <label for="rdo_libel">명예훼손/사생활 침해 및 저작권침해등</label>
				                    </li>
				                    <li>
				                        <input type="radio" name="reportType" id="rdo_etc" value="ba4" class="input_rdo"> <label for="rdo_etc">기타</label>
				                    </li>
				                </ul>
		                
		                		<textarea name="reportBody" id="etcTxtBox" cols="50" rows="5" class="txt_area" style="margin-left:10px; width:405px; height:80px;" placeholder="내용"></textarea>
							</td>
						</tr>
					</tbody>
				</table>
			</div>

			<div class="form-row">
				<div class="form-control-label">수정</div>
				<div class="form-control-box">
					<button class="btn btn-primary" type="submit">신고</button>
					<button class="btn btn-info" type="button" onclick="Singo__hideSingoFormModal();">취소</button>
				</div>
			</div>
			
		</form>
	</div>
</div>




<style>
/* 댓글 리스트 */
.reply-list-box * {
	color:black !important;
	word-break: break-all; /* 영어 줄바꿈 */
}

.reply-list-box:before{
	content: "";
	display: block;
	height: 10px;
	background-color:black;
	margin-top:-5px;
}

.reply-list-box {
	display:block;
	color:black;
	background-color:#ebebf1;
	border:1px solid white;
	width:860px;
	margin-bottom:50px;
}

.reply-list-box table {
	border-collapse : collapse;
	width:100%;
}
.img-box {
	display:inline-block;
}
</style>
<!-- 번호, 작성자(프로필,이름,날짜), 내용, 비고 -->
<!-- 댓글 리스트 -->
<div class="reply-list-box table-box con">
		<table border="1">
			<colgroup>
				<col class="table-first-col table-first-col-tight" width="30">
				<col width="120" class="visible-on-md-up">
				<col width="400" class="visible-on-md-up">
				<col width="50">
				<col width="50" class="visible-on-md-up">
			</colgroup>
			<thead>
				<tr>
					<th>번호</th>
					<th class="visible-on-md-up">작성자</th>
					<th class="visible-on-md-up">내용</th>
					<th>좋아요???</th>
					<th class="visible-on-md-up">비고</th>
				</tr>
			</thead>
			<tbody>

			</tbody>
		</table>
	</div>

	<style>
.reply-modify-form-modal-actived, reply-modify-form-modal-actived>body {
	overflow: hidden;
}

.reply-modify-form-modal {
	position: fixed;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	background-color: rgba(0, 0, 0, 0.4);
	display: none;
	z-index: 20;
}

.reply-modify-form-modal>div {
	position: absolute;
	left: 50%;
	top: 50%;
	transform: translateX(-50%) translateY(-50%);
	max-width: 100vw;
	min-width: 320px;
	max-height: 100vh;
	overflow-y: auto;
	border: 3px solid black;
	box-sizing: border-box;
}

.reply-modify-form-modal-actived .reply-modify-form-modal {
	display: flex;
}

.reply-modify-form-modal .form-control-label {
	width: 60px;
}

.reply-modify-form-modal .form-control-box {
	flex: 1 0 0;
}

.reply-modify-form-modal .form-control-box textarea{
	width:100%;
	height:100px;
}

.reply-modify-form-modal .video-box {
	width: 100px;
}
</style>

<!-- 댓글 수정 -->

	<div class="reply-modify-form-modal">
		<div class="bg-white">
			<h3 class="text-align-center" style="margin-left:10px;">댓글 수정</h3>
			<form action="" class="form1 padding-10" onsubmit="ReplyList__submitModifyForm(this); return false;">
				<input type="hidden" name="id" />
				<div class="form-row" style="margin-top:10px;">
					<div class="form-control-label">내용</div>
					<div class="form-control-box">
						<textarea name="body" placeholder="내용을 입력해주세요."></textarea>
					</div>
				</div>

				<div class="form-row">
					<div class="form-control-label">수정</div>
					<div class="form-control-box">
						<button class="btn btn-primary" type="submit">수정</button>
						<button class="btn btn-info" type="button"
							onclick="ReplyList__hideModifyFormModal();">취소</button>
					</div>
				</div>
			</form>
		</div>
	</div>

	<script>
		var ReplyList__$box = $('.reply-list-box');
		var ReplyList__$tbody = ReplyList__$box.find('tbody');
		var ReplyList__lastLodedId = 0;
		var ReplyList__submitModifyFormDone = false;
		function ReplyList__submitModifyForm(form) {
			if (ReplyList__submitModifyFormDone) {
				alert('처리중입니다.');
				return;
			}
			form.body.value = form.body.value.trim();
			if (form.body.value.length == 0) {
				alert('내용을 입력해주세요.');
				form.body.focus();
				return;
			}
			var id = form.id.value;
			var body = form.body.value;
			var fileInput1 = form['file__reply__' + id
					+ '__common__attachment__1'];
			var fileInput2 = form['file__reply__' + id
					+ '__common__attachment__2'];
			var fileInput3 = form['file__reply__' + id
					+ '__common__attachment__3'];
			var deleteFileInput1 = form["deleteFile__reply__" + id
					+ "__common__attachment__1"];
			var deleteFileInput2 = form["deleteFile__reply__" + id
					+ "__common__attachment__2"];
			var deleteFileInput3 = form["deleteFile__reply__" + id
					+ "__common__attachment__3"];
			if (fileInput1 && deleteFileInput1 && deleteFileInput1.checked) {
				fileInput1.value = '';
			}
			if (fileInput2 && deleteFileInput2 && deleteFileInput2.checked) {
				fileInput2.value = '';
			}
			if (fileInput3 && deleteFileInput3 && deleteFileInput3.checked) {
				fileInput3.value = '';
			}
			ReplyList__submitModifyFormDone = true;
			// 파일 업로드 시작
			var startUploadFiles = function() {
				var needToUpload = false;
				if (needToUpload == false) {
					needToUpload = fileInput1 && fileInput1.value.length > 0;
				}
				if (needToUpload == false) {
					needToUpload = deleteFileInput1 && deleteFileInput1.checked;
				}
				if (needToUpload == false) {
					needToUpload = fileInput2 && fileInput2.value.length > 0;
				}
				if (needToUpload == false) {
					needToUpload = deleteFileInput2 && deleteFileInput2.checked;
				}
				if (needToUpload == false) {
					needToUpload = fileInput3 && fileInput3.value.length > 0;
				}
				if (needToUpload == false) {
					needToUpload = deleteFileInput3 && deleteFileInput3.checked;
				}
				if (needToUpload == false) {
					onUploadFilesComplete();
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
					success : onUploadFilesComplete
				});
			}
			// 파일 업로드 완료시 실행되는 함수
			var onUploadFilesComplete = function(data) {
				var fileIdsStr = '';
				if (data && data.body && data.body.fileIdsStr) {
					fileIdsStr = data.body.fileIdsStr;
				}
				startModifyReply(fileIdsStr);
			};
			// 댓글 수정 시작
			var startModifyReply = function(fileIdsStr) {
				$.post('../reply/doModifyReplyAjax', {
					id : id,
					body : body,
					fileIdsStr : fileIdsStr
				}, onModifyReplyComplete, 'json');
			};
			// 댓글 수정이 완료되면 실행되는 함수
			var onModifyReplyComplete = function(data) {
				if (data.resultCode && data.resultCode.substr(0, 2) == 'S-') {
					// 성공시에는 기존에 그려진 내용을 수정해야 한다.!!
					$('.reply-list-box tbody > tr[data-id="' + id + '"]').data('data-originBody', body);
					$('.reply-list-box tbody > tr[data-id="' + id + '"] .reply-body').empty().append(body.replaceAll('\n', '<br>'));
					$('.reply-list-box tbody > tr[data-id="' + id + '"] .video-box').empty();
					//$('.reply-list-box tbody > tr[data-id="' + id + '"] .img-box').empty();
					
				}
				if (data.msg) {
					alert(data.msg);
				}
				ReplyList__hideModifyFormModal();
				ReplyList__submitModifyFormDone = false;
			};
			startUploadFiles();
		}
		function ReplyList__showModifyFormModal(el) {
			$('html').addClass('reply-modify-form-modal-actived');
			var $tr = $(el).closest('tr');
			var originBody = $tr.data('data-originBody');
			var id = $tr.attr('data-id');
			var form = $('.reply-modify-form-modal form').get(0);
			$(form).find('[data-name]').each(function(index, el) {
				var $el = $(el);
				var name = $el.attr('data-name');
				name = name.replaceAll('__0__', '__' + id + '__');
				$el.attr('name', name);
				if ($el.prop('type') == 'file') {
					$el.val('');
				} else if ($el.prop('type') == 'checkbox') {
					$el.prop('checked', false);
				}
			});
			
			form.id.value = id;
			form.body.value = originBody;
		}
		function ReplyList__hideModifyFormModal() {
			$('html').removeClass('reply-modify-form-modal-actived');
		}
		// 10초
		ReplyList__loadMoreInterval = 1 * 10000;
		function ReplyList__loadMoreCallback(data) {
			if (data.body.replies && data.body.replies.length > 0) {
				ReplyList__lastLodedId = data.body.replies[data.body.replies.length - 1].id;
				ReplyList__drawReplies(data.body.replies);
			}
			setTimeout(ReplyList__loadMore, ReplyList__loadMoreInterval);
		}
		function ReplyList__loadMore() {
			$.get('../reply/getForPrintReplies', {
				articleId : param.id,
				from : ReplyList__lastLodedId + 1
			}, ReplyList__loadMoreCallback, 'json');
		}
		function ReplyList__drawReplies(replies) {
			for (var i = 0; i < replies.length; i++) {
				var reply = replies[i];
				ReplyList__drawReply(reply);
			}
		}
		function ReplyList__delete(el) {
			if (confirm('삭제 하시겠습니까?') == false) {
				return;
			}
			var $tr = $(el).closest('tr');
			var id = $tr.attr('data-id');
			$.post('./../reply/doDeleteReplyAjax', {
				id : id
			}, function(data) {
				$tr.remove();
			}, 'json');
		}


		
	
		var i = 1;
		function ReplyList__drawReply(reply) {
			var html = '';
			html += '<tr data-id="' + reply.id + '">';
			html += '<td>' + i + '</td>';
			
			html += '<td class="visible-on-md-up">';
			for (var fileNo = 1; fileNo <= 1; fileNo++) {
				var file = null;
				if (reply.extra.file__common__proImg && reply.extra.file__common__proImg[fileNo]) {
					file = reply.extra.file__common__proImg[fileNo];
				}
				html += '</div>';
				html += '<div class="img-box img-box-auto pro-img" data-img-name="reply__' + reply.memberId + '__common__proImg__' + fileNo + '" data-file-no="' + fileNo + '">';
				if (file && file.fileExtTypeCode == 'img') {
					html += '<img style="float:left;" src="/usr/file/img?id=' + file.id + '&updateDate=' + file.updateDate + '">';
				}
				html += '<a class="nickname" href="#">&nbsp' + reply.extra.writer + '</a>';
				html += '<a class="regdate" style="white-space:nowrap; ">&nbsp' + reply.regDate + '</a>';
				html += '</div>';
			}
			html += '</td>';

			html += '<td>';
			html += '<div class="reply-body">' + reply.forPrintBody + '</div>';
			
			html += '<div class="visible-on-sm-down margin-top-10">';
			
			html += '</div>';
			html += '</td>';

			html += '<td>';
			html += '좋아요???';
			html += '</td>';
			
			html += '<td class="visible-on-md-up">';
			if (reply.extra.actorCanDelete) {
				html += '<button style="width:100%;" class="btn btn-danger" type="button" onclick="ReplyList__delete(this);">삭제</button>';
			}
			if (reply.extra.actorCanModify) {
				html += '<button style="width:100%;" class="btn btn-info" type="button" onclick="ReplyList__showModifyFormModal(this);">수정</button>';
			}
			html += '</td>';
			html += '</tr>';
			i++
			var $tr = $(html);
			$tr.data('data-originBody', reply.body);
			ReplyList__$tbody.prepend($tr);
		}
		ReplyList__loadMore();
	</script>



<style>
.article-apply-box {
	text-align: center;
}

.article-apply-box textarea {
	width:100% !important;
}

.article-apply-box table{
	display: inline-block;
	width:860px;
}
.article-apply-box table td {
	width:100%;
}
</style>


<script>
		var WriteReplyForm__submitDone = false;
		function WriteReplyForm__submit(form) {
			if (isNowLoading()) {
				alert('처리중입니다.');
			}
			form.body.value = form.body.value.trim();
			if (form.body.value.length == 0) {
				alert('댓글을 입력해주세요.');
				form.body.focus();
				return;
			}
			WriteReplyForm__submitDone = true;
			var startUploadFiles = function(onSuccess) {
				var needToUpload = false;
				if (needToUpload == false) {
					needToUpload = form.file__reply__0__common__attachment__1 && form.file__reply__0__common__attachment__1.value.length > 0;
				}
				if (needToUpload == false) {
					needToUpload = form.file__reply__0__common__attachment__2 && form.file__reply__0__common__attachment__2.value.length > 0;
				}
				if (needToUpload == false) {
					needToUpload = form.file__reply__0__common__attachment__3 && form.file__reply__0__common__attachment__3.value.length > 0;
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
			var startWriteReply = function(fileIdsStr, onSuccess) {
				$.ajax({
					url : './../reply/doWriteReplyAjax',
					data : {
						fileIdsStr : fileIdsStr,
						body : form.body.value,
						boardCode : form.boardCode.value,
						relTypeCode : form.relTypeCode.value,
						relId : form.relId.value
					},
					dataType : "json",
					type : 'POST',
					success : onSuccess
				});
			};
			startUploadFiles(function(data) {
				var idsStr = '';
				if (data && data.body && data.body.fileIdsStr) {
					idsStr = data.body.fileIdsStr;
				}
				startWriteReply(idsStr, function(data) {
					if (data.msg) {
						alert(data.msg);
					}
					form.body.value = '';
					endLoading();
				});
			});
		}
	</script>


<!-- 댓글 작성 --><!-- 댓글 권한 설정 -->
	<c:if test="${isLogined}">
		<c:choose>
		<c:when test="${board.code == 'notice' || board.code == 'update' || board.code == 'question'}">
			<c:if test="${userLever > 5}">
			
				<form class="article-apply-box table-box con form1" onsubmit="WriteReplyForm__submit(this); return false;">
					<input type="hidden" name="relTypeCode" value="article" />
					<input type="hidden" name="relId" value="${article.id}" />
					<input type="hidden" name="boardCode" value="${board.code}" />
		
					<table border="1">
						<colgroup>
							<col class="table-first-col">
						</colgroup>
						<tbody>
							<tr>
								<th></th>
								<td>
									<div class="form-control-box">
										<textarea maxlength="300" name="body" placeholder="내용을 입력해주세요." class="height-300" style="resize: none; width: 420px;"></textarea>
									</div>
								</td>
							</tr>
							<tr class="tr-do">
								<th>작성</th>
								<td>
									<input style="width:100%;" class="btn btn-primary" type="submit" value="작성">
								</td>
							</tr>
						</tbody>
					</table>
				</form>
				
			</c:if>
		</c:when>
		<c:otherwise>
			<form class="article-apply-box table-box con form1" onsubmit="WriteReplyForm__submit(this); return false;">
				<input type="hidden" name="relTypeCode" value="article" />
				<input type="hidden" name="relId" value="${article.id}" />
				<input type="hidden" name="boardCode" value="${board.code}" />
	
				<table border="1">
					<colgroup>
						<col class="table-first-col">
					</colgroup>
					<tbody>
						<tr>
							<th>내용</th>
							<td>
								<div class="form-control-box">
									<textarea maxlength="300" name="body" placeholder="내용을 입력해주세요." class="height-300" style="resize: none; width: 420px;"></textarea>
								</div>
							</td>
						</tr>
						<tr class="tr-do">
							<th>작성</th>
							<td>
								<input style="width:100%;" class="btn btn-primary" type="submit" value="작성">
							</td>
						</tr>
					</tbody>
				</table>
			</form>
	    </c:otherwise>	
		</c:choose>
	</c:if>
	


<%@ include file="../part/foot.jspf"%>