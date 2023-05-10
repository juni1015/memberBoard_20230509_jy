<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-05-10
  Time: 오후 5:29
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
  <form action="/board/save" method="post" enctype="multipart/form-data">
    <input type="text" name="boardTitle" id="board-title" placeholder="제목">
    <textarea name="boardContents" id="board-contents" placeholder="내용" cols="30" rows="10"></textarea> <br>
    <input type="file" name="boardFile" multiple><br>
    <input type="submit" value="작성">
  </form>
</div>
<%@include file="../component/footer.jsp"%>
</body>
</html>
