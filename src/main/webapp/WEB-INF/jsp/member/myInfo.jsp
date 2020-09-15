<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="내 정보" />
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

.my-page-background{
	display:block;
	margin:0 auto;
	margin-top:100px;
	width:500px;
	height:500px;
	background-color:#ebebf1;
	border:5px solid #6b6880;
}

.my-page-box > table {
	width: 100%;
	border-collapse: collapse;
}

.my-page-box>table th,
       .table-box>table td {
	border-right:none;
	padding: 10px;
	text-align: left;
	color:white;
}

.my-page-box th {
	color:black !important;
}

.my-page-box {
	margin-top:50px;
	margin-left:10px;
	margin-right: 10px;
}

.my-page-box .btn {
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

.my-page-box .btn:hover {
	background: linear-gradient(to bottom, #b8b3c6, #ebebf1);
}

.my-page-box .btn-success {
	background-color: green;
}

.my-page-box .btn-danger {
	background-color: red;
}












.findId-form {
	border:1px solid #6b6880;
	margin:0 20px;
	margin-top:100px;
}




.findId-form > table {
	width: 100%;
	border-collapse: collapse;
}

.findId-form>table th,
 .table-box>table td  {
	border-right:none;
	padding: 10px;
	text-align: left;
	color:black;
}

/* 폼 관련 */
.findId-form .form-control-box>input, .findId-form .form-control-box>textarea{
	width: 100%;
	padding: 0;
	display: block;
	box-sizing: border-box;
	padding: 10px;
}

.findId-form .form-control-box>textarea {
	min-height: 300px;
	resize: none;
}

.findId-form th {
	/* `로그인 아이디` 문구가 줄 바꿈 될 때 공백기준으로 줄바꿈 되도록 */
	word-break: keep-all;
}

/* 수정 */
.all-modify {
	text-align: center;
	margin-top:15px;
}

.all-modify input {
	cursor: pointer;
}

@media (max-width: 465px){
		.my-page-background {
			width:350px;
			height: 400px;
		}
}

</style>


<script>
	var ModifyForm__submitDone = false;
	function ModifyForm__submit(form) {
		
	}
	ModifyForm__submitDone = true;
</script>


<div class="my-page-background">

	<div class="page-title"><h1>${pageTitle}</h1></div>
	
	<div class="my-page-box table-box">
		<table>
			<tr>
				<th>아이디</th>
				<td>${loginedMember.loginId}</td>
			</tr>

			<tr>
				<th>가입 날짜</th>
				<td>${loginedMember.regDate}</td>
			</tr>

			<tr>
				<th>활동명</th>
				<td>${loginedMember.nickname}</td>
			</tr>

			<tr>
				<th>이름</th>
				<td>${loginedMember.name}</td>
			</tr>

			<tr>
				<th>이메일</th>
				<td>${loginedMember.email}</td>
			</tr>
			<c:if test="${!isMailAuthed}">
			<tr>
				<th>비고</th>
				<td>
				<form action="/usr/member/doSendMail" method="POST"  onclick="if ( confirm('인증메일을 보내시겠습니까?') == false ) return false;">
					<input type="hidden" name="memberId" value="${loginedMember.id}" />
					<input type="hidden" name="email" value="${loginedMember.email}" />
					<input type="hidden" name="redirectUri" value="/usr/home/main" />
					<button class="btn" type="submit">이메일 인증보내기</button>
				</form>
				</td>
			</tr>
			</c:if>

		</table>

	</div>

</div>

<div class="all-modify">
	<form>
		
		<input type="button" value="회원 탈퇴" onclick="if ( confirm('탈퇴하시겠습니까?') == false ) return false; location.href='/usr/member/passwordForPrivate?isvalTag=secession'" /> 
		<input type="button" value="정보 수정" onclick="location.href='/usr/member/passwordForPrivate?isvalTag=memberModify'" /> 
		<input type="button" value="비번 변경" onclick="location.href='/usr/member/passwordForPrivate?isvalTag=modifyPassword'" /> 
	</form>
</div>

<%@ include file="../part/foot.jspf"%>