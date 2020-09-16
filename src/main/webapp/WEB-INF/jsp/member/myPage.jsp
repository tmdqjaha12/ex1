<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="MY PAGE" />
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

.adminPage-background{
	display:block;
	margin:0 auto;
	margin-top:200px;
	width:500px;
	height:600px;
	background-color:#ebebf1;
	border:5px solid #6b6880;
	margin-bottom:50px;
}

.adminPage-form {
	border:1px solid #6b6880;
	margin:0 20px;
	margin-top:100px;
}




.adminPage-form > table {
	width: 100%;
	border-collapse: collapse;
}

.adminPage-form>table th,
 .table-box>table td  {
	border-right:none;
	padding: 10px;
	text-align: left;
	color:black;
}

/* 폼 관련 */
.adminPage-form .form-control-box>input, .adminPage-form .form-control-box>textarea{
	width: 100%;
	padding: 0;
	display: block;
	box-sizing: border-box;
	padding: 10px;
}

.adminPage-form .form-control-box>textarea {
	min-height: 300px;
	resize: none;
}

.adminPage-form th {
	/* `로그인 아이디` 문구가 줄 바꿈 될 때 공백기준으로 줄바꿈 되도록 */
	word-break: keep-all;
}

.adminPage-form .btn {
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

.adminPage-form .btn:hover {
	background: linear-gradient(to bottom, #b8b3c6, #ebebf1);
}

.adminPage-form .btn-success {
	background-color: green;
}

.adminPage-form .btn-danger {
	background-color: red;
}
</style>

<div class="adminPage-background con">
	
	<div class="page-title">
		<h1>${pageTitle}</h1>
	</div>

	<form method="POST" class="adminPage-form table-box con form1" style="border:none;">
		<div class="backA">
			<a href="javascript:window.history.back();" class="cancel">뒤로가기</a>
		</div>
		
		<table border="1">
			<colgroup>
				<col class="table-first-col">
			</colgroup>
			<tbody>
				<tr>
					<th>내 글 목록</th>
					<td>
						<div class="form-control-box">
							<a href="/usr/article/myPageArticleList">이동</a> 
						</div>
					</td>
				</tr>
				<tr>
					<th>내 댓글 목록</th><!-- 낮은 단계의 관리자가 이용 가능하도록. -->
					<td>
						<div class="form-control-box">
							<a href="/usr/reply/myPageReplyList">이동</a> 
						</div>
					</td>
				</tr>
				<tr>
					<th>내 신청서 목록</th>
					<td>
						<div class="form-control-box">
							<a href="/usr/board/myPageBoardApplyList">이동</a> 
						</div>
					</td>
				</tr>
				<tr>
					<th>내 커뮤니티 관리</th><!-- 낮은 단계의 관리자가 이용 가능하도록. -->
					<td>
						<div class="form-control-box">
							<a href="/usr/board/myPageBoardList">이동</a> 
						</div>
					</td>
				</tr>
				<tr>
					<th>내 문의사항 목록</th><!-- 낮은 단계의 관리자가 이용 가능하도록. -->
					<td>
						<div class="form-control-box">
							<a href="/usr/article/question-list">이동</a> 
						</div>
					</td>
				</tr>
				<tr>
					<th>내 신고 진행상황 목록</th><!-- 낮은 단계의 관리자가 이용 가능하도록. -->
					<td>
						<div class="form-control-box">
							<a href="/usr/article/question-list">이동</a> 
						</div>
					</td>
				</tr>
			</tbody>
		</table>
	</form>

</div>

<%@ include file="../part/foot.jspf"%>