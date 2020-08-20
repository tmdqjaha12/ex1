<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="회원 탈퇴" />
<%@ include file="../part/head.jspf"%>

<script src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>

<form action="../home/main" method="POST">
	<div class="g-recaptcha" data-sitekey="6Ldk98AZAAAAAIKX8ymzAN96VNenwnFWuDZcOE6u"></div>
	<button id="test_btn">테스트 버튼</button>
</form>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src='https://www.google.com/recaptcha/api.js'></script>



<script>
        $(document).ready(function() {
            $("#test_btn").click(function() {
                $.ajax({
                    url: './VerifyRecaptcha',
                    type: 'POST',
                    data: {
                        recaptcha: $("#g-recaptcha-response").val()
                    },
                    success: function(data) {
                        switch (data) {
                            case 0:
                                alert("자동 가입 방지 봇 통과");
                                break;
 
                            case 1:
                                alert("자동 가입 방지 봇을 확인 한뒤 진행 해 주세요.");
                                break;
 
                            default:
                                alert("자동 가입 방지 봇을 실행 하던 중 오류가 발생 했습니다. [Error bot Code : " + Number(data) + "]");
                                break;
                        }
                    }
                });
            });
        });
 
</script>



<%@ include file="../part/foot.jspf"%>