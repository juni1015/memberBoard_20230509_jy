<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-05-09
  Time: 오전 11:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
    <link rel="stylesheet" href="/resources/css/main.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
</head>
<body>
<%@include file="../component/header.jsp"%>
<%@include file="../component/nav.jsp"%>
<div id="section">
  <form action="/member/save" method="post" enctype="multipart/form-data" onsubmit="return save_check()">
      <input type="text" name="memberEmail" id="member-email" placeholder="이메일" onblur="email_check()">
      <input type="hidden" id="email-ok"><p id="email-result"></p>
      <input type="text" name="memberPassword" id="member-password" placeholder="비밀번호" onblur="password_check()">
      <p id="password-result"></p>
      <input type="text" name="memberName" id="member-name" placeholder="이름">
      <input type="text" name="memberMobile" id="member-mobile" placeholder="전화번호" onblur="mobile_check()">
      <p id="mobile-result"></p>
      <input type="file" name="memberProfile" multiple><br>
      <input type="submit" value="작성">
  </form>
</div>
<%@include file="../component/footer.jsp"%>
</body>
<script>
    const email_check = () => {
        const email = document.getElementById("member-email");
        const emailResult = document.getElementById("email-result");
        const emailOk = document.getElementById("email-ok");
        $.ajax({
            type: "post",
            url: "/member/email-check",
            data: {
                "memberEmail": email.value
            },
            success: function (res) {
                emailResult.innerHTML = "사용가능 이메일";
                emailResult.style.color = "green";
                // $('email-ok').val('1');
                emailOk.value = "1";
            },
            error: function (err) {
                // // 성공이 아닌경우 응답을 err로 받음.
                // //err 내부의 status에는 서버에서 응답한 http status code값이 담겨있음.
                // //status code 값으로 화면에 출력하는 부분 제어
                if(err.status == "409") { //중복되는 경우
                    emailResult.innerHTML = "중복 이메일이 있습니다";
                    emailResult.style.color = "red";
                    emailOk.value = "0";
                } else if(err.status == "404"){ // 아무값도 입력하지 않은 경우
                    emailResult.innerHTML = "입력해주세요";
                    emailResult.style.color ="red";
                    emailOk.value = "0";
                }
            }
        });
    }

    const password_check = () => {
        const password = document.getElementById("member-password").value;
        const passwordResult = document.getElementById("password-result");
        const exp = /^(?=.*[a-z])(?=.*\d)(?=.*[!#$%])[a-z\d!#$%]{8,16}$/;

        if(password.match(exp)) {
            return false;
        } else {
            passwordResult.innerHTML = "영문 소문자와 숫자, 특수문자(!, #, $, %) 필수 입력";
            passwordResult.style.color = "red";
            return true;
        }
    }

    const mobile_check = () => {
        const mobile = document.getElementById("member-mobile").value;
        const mobileResult = document.getElementById("mobile-result");
        const exp = /^\d{3}-\d{4}-\d{4}$/;
        // match는 정규식에 맞는지 안 맞는지를 확인하고 true, flass를 줌
        if(mobile.match(exp)) {
            return false;
        } else {
            mobileResult.innerHTML = "000-0000-0000 형식에 맞게 작성";
            mobileResult.style.color = "red";
            return true;
        }

    }

    const save_check = () => {
        const email = document.getElementById("member-email");
        const password = document.getElementById("member-password");
        const name = document.getElementById("member-name");
        const mobile = document.getElementById("member-mobile");
        const emailOk = document.getElementById("email-ok").value;
        if (email.value == "") {
            alert("이메일을 입력하십시오");
            email.focus();
            return false;
        } else if (password.value == "") {
            alert("비밀번호을 입력하십시오");
            password.focus();
            return false;
        } else if (name.value == "") {
            alert("이름을 입력하십시오");
            name.focus();
            return false;
        } else if (mobile.value == "") {
            alert("전화번호를 입력하십시오");
            mobile.focus();
            return false;
        } else if (emailOk == "0") {
            alert("이메일 중복입니다. 다른 이메일을 작성하십시오");
            email.focus();
            return false;
        } else if (password_check()) {
            alert("형식에 맞게 비밀번호를 입력하십시오");
            password.focus();
            return false;
        } else if (mobile_check()) {
            alert("형식에 맞게 전화번호를 입력하십시오");
            mobile.focus();
            return false;
        } else {
            return true;
        }
    }
</script>
</html>
