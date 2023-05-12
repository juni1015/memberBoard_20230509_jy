<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-05-12
  Time: 오전 10:12
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
    <form action="/member/delete?id=${member.id}" method="post" onsubmit="return delete_check()">
        <input type="text" name="memberPassword" id="member-password" placeholder="비밀번호 확인">
        <input type="submit" value="탈퇴">
    </form>
</div>
<%@include file="../component/footer.jsp"%>
</body>
<script>
    const delete_check = () => {
        const password = document.getElementById("member-password");
        if (password.value == "") {
            alert("비밀번호을 입력하십시오");
            password.focus();
            return false;
        } else if (password.value != '${member.memberPassword}') {
            alert("비밀번호가 다릅니다");
            password.focus();
            return false;
        } else {
            alert("탈퇴완료")
            return true;
        }
    }
</script>

</html>
