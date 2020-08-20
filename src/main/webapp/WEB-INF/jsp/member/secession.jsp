<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="회원 탈퇴" />
<%@ include file="../part/head.jspf"%>


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

<div class="my-page-background">
	<div class="my-page-box table-box">
	
		<form action="" method="">
			<input type="hidden" name="redirectUri" value="/usr/home/main">
			<div class="g-recaptcha" data-sitekey="6Ldk98AZAAAAAIKX8ymzAN96VNenwnFWuDZcOE6u"></div>
			<button type="button" id="test_btn" style="width:100%;">탈퇴  확인</button>
		</form>
	
	</div>
</div>



<%@ include file="../part/foot.jspf"%>