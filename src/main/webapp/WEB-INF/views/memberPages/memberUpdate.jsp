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
  <form action="/member/update" method="post" enctype="multipart/form-data" onsubmit="return update_check()">
      <input type="hidden" name="id" id="member-id" placeholder="id" value="${member.id}" readonly>
      <input type="text" name="memberEmail" id="member-email" placeholder="이메일" value="${member.memberEmail}" readonly>
      <input type="text" name="memberPassword" id="member-password" placeholder="비밀번호" value="${member.memberPassword}" onblur="password_check()">
      <p id="password-result"></p>
      <input type="text" name="memberName" id="member-name" placeholder="이름" value="${member.memberName}">
      <input type="text" name="memberMobile" id="member-mobile" placeholder="전화번호" value="${member.memberMobile}" onblur="mobile_check()">
      <p id="mobile-result"></p>
      <img src="${pageContext.request.contextPath}/upload/${memberFile.storedFileName}" alt="" width="100" height="100">
      <input type="file" name="memberProfile" multiple><br>
      <input type="submit" value="수정">
  </form>
</div>
<%@include file="../component/footer.jsp"%>
</body>
<script>
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

    const update_check = () => {
        const password = document.getElementById("member-password");
        const name = document.getElementById("member-name");
        const mobile = document.getElementById("member-mobile");
        if (password.value == "") {
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
