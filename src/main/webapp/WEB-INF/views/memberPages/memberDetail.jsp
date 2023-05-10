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
            <td>${memberDetail.id}</td>
        <tr>
            <th>email</th>
            <td>${memberDetail.memberEmail}</td>
        </tr>
        <tr>
            <th>password</th>
            <td>${memberDetail.memberPassword}</td>
        </tr>
        <tr>
            <th>name</th>
            <td>${memberDetail.memberName}</td>
        </tr>
        <tr>
            <th>mobile</th>
            <td>${memberDetail.memberMobile}</td>
        </tr>
        <%--        파일 있으면 보여지고 없으면 안 보여짐--%>
        <c:if test="${memberDetail.profileAttached == 1}">
            <tr>
                <th>image</th>
                <td>
                        <%--               src="${pageContext.request.contextPath} : 현재 돌고있는 서버에 접근한다--%>
                        <img src="${pageContext.request.contextPath}/upload/${memberFile.storedFileName}" alt="" width="100" height="100">
                </td>
            </tr>
        </c:if>
    </table>
    <button onclick="member_list()">목록</button>
<%--    <button onclick="board_delete()">삭제</button>--%>
</div>
<%@include file="../component/footer.jsp"%>
</body>
<script>
    const member_list = (id) => {
        location.href = "/member/list";
    }
    // const member_delete = (id) => {
    //     location.href = "/delete?id=" + id;
    // }
</script>
</html>
