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
  <button onclick="member_update()">정보수정</button>
  <button onclick="member_delete()">탈퇴</button>
</div>
<%@include file="../component/footer.jsp"%>
</body>
<script>
  const member_update = () => {
    location.href = "/member/update";
  }

  const member_delete = () => {
    location.href = "/member/delete";
  }
</script>
</html>
