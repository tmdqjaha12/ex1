<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="회원 탈퇴" />
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

.secession-background{
	display:block;
	margin:0 auto;
	margin-top:100px;
	width:500px;
	height:500px;
	background-color:#ebebf1;
	border:5px solid #6b6880;
}

.secession-form {
	margin:0 20px;
	margin-top:100px;
	padding:25px 0;
}

.secession-form * {
	margin:0 auto;
	text-align: center;
}

.secession-btn {
	display:block;
	width:100%;
	margin-top:20px;
	padding: 10px 15px;
	cursor: pointer;
}



.
</style>


<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://www.google.com/recaptcha/api.js"></script>
<script>
		var secession = false;
        $(document).ready(function() {
            $("#test_btn").click(function() {
                $.ajax({
                    url: '/usr/member/VerifyRecaptcha',
                    type: 'POST',
                    data: {
                        recaptcha: $("#g-recaptcha-response").val()
                    },
                    success: function(data) {
                        if ( data.msg ) {
                            alert(data.msg);
                        }
                        if ( data.resultCode.substr(0, 2) =='S-' ) {
                            location.replace('/usr/home/main');
                        }
                    },
                    dataType:'json'
                });
            });

          
        });
 
</script>

<div class="secession-background">
	
	<div class="page-title"><h1>${pageTitle}</h1></div>

	<div class="my-page-box">
	
		<form class="secession-form">
			<input type="hidden" name="redirectUri" value="/usr/home/main">
			<div class="g-recaptcha" data-sitekey="6Ldk98AZAAAAAIKX8ymzAN96VNenwnFWuDZcOE6u"></div>
			<button type="button" id="test_btn" class="secession-btn">탈퇴  확인</button>
			<a href="javascript:window.history.back();" class="cancel">취소</a>
		</form>
	
	</div>
</div>



<%@ include file="../part/foot.jspf"%>