<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-05-10
  Time: 오후 1:11
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
    <table>
        <tr>
            <th>id</th>
            <td>${board.id}</td>
        <tr>
            <th>제목</th>
            <td>${board.boardTitle}</td>
        </tr>
        <tr>
            <th>작성자</th>
            <td>${board.boardWriter}</td>
        </tr>
        <tr>
            <th>내용</th>
            <td>${board.boardContents}</td>
        </tr>
        <tr>
            <th>조회수</th>
            <td>${board.boardHits}</td>
        </tr>
        <tr>
            <th>작성일자</th>
            <td>
                <fmt:formatDate value="${board.boardCreatedDate}" pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate>
            </td>
        </tr>
        <%--        파일 있으면 보여지고 없으면 안 보여짐--%>
        <c:if test="${board.fileAttached == 1}">
            <tr>
                <th>image</th>
                <td>
                    <c:forEach items="${boardFileList}" var="boardFile">
                        <%--               src="${pageContext.request.contextPath} : 현재 돌고있는 서버에 접근한다--%>
                        <img src="${pageContext.request.contextPath}/upload/${boardFile.storedFileName}" alt="" width="100" height="100">
                    </c:forEach>
                </td>
            </tr>
        </c:if>
    </table>
    <button onclick="board_list()">목록</button>
    <c:if test="${sessionScope.loginEmail == board.boardWriter}">
        <button onclick="board_update(${board.id})">수정</button>
        <button onclick="board_delete(${board.id})">삭제</button>
    </c:if>
    <c:if test="${sessionScope.loginEmail == 'admin'}">
        <button onclick="board_delete(${board.id})">삭제</button>
    </c:if>
</div>
<%@include file="../component/footer.jsp"%>
</body>
<script>
    const board_list = () => {
        const type = '${type}';
        const q = '${q}';
        const page = '${page}';
        location.href = "/board/list?page=" + page + "&q=" + q + "&type=" + type;
    }

    const board_update = (id) => {
        location.href = "/board/update?id=" + id;
    }

    const board_delete = (id) => {
        location.href = "/board/delete?id=" + id;
    }
</script>
</html>
