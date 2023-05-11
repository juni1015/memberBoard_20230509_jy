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
  <form action="/board/update" method="post" enctype="multipart/form-data">
    <input type="text" name="id" id="board-id" value="${board.id}" readonly>
    <input type="text" name="boardTitle" id="board-title" placeholder="제목" value="${board.boardTitle}">
    <input type="text" name="boardWriter" id="board-writer" value="${board.boardWriter}" readonly>
    <textarea name="boardContents" id="board-contents" placeholder="내용" cols="30" rows="10">${board.boardContents}</textarea> <br>
    <c:forEach items="${boardFileList}" var="boardFile">
      <%--               src="${pageContext.request.contextPath} : 현재 돌고있는 서버에 접근한다--%>
      <img src="${pageContext.request.contextPath}/upload/${boardFile.storedFileName}" alt="" width="100" height="100">
    </c:forEach>
    <input type="file" name="boardFile" multiple><br>
    <input type="submit" value="수정">
  </form>
</div>
<%@include file="../component/footer.jsp"%>
</body>
</html>
