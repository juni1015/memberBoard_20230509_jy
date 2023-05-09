<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-05-09
  Time: 오후 4:38
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
  <form action="/member/login" method="post" onsubmit="return login_check()">
    <input type="text" name="memberEmail" id="member-email" placeholder="이메일">
    <input type="text" name="memberPassword" id="member-password" placeholder="비밀번호">
    <input type="submit" value="로그인">
  </form>
</div>
<%@include file="../component/footer.jsp"%>
</body>
</html>
