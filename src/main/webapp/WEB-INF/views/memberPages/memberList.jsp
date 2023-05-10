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
            <th>email</th>
            <th>password</th>
            <th>name</th>
            <th>mobile</th>
<%--            <th>profile</th>--%>
            <th>조회</th>
<%--            <th>삭제</th>--%>
        </tr>
        <c:forEach items="${memberList}" var="member">
            <tr>
                <td>${member.id}</td>
                <td>${member.memberEmail}</td>
                <td>${member.memberPassword}</td>
                <td>${member.memberName}</td>
                <td>${member.memberMobile}</td>
<%--                <td>${member.memberProfile}</td>--%>
                <td>
                    <button onclick="member_detail('${member.id}')">조회</button>
                </td>
<%--                <td>--%>
<%--                    <button onclick="member_delete('${member.id}')">삭제</button>--%>
<%--                </td>--%>
            </tr>
        </c:forEach>
    </table>
    <div id="detail-area"></div>
</div>
<%@include file="../component/footer.jsp"%>
</body>
<script>
    const member_detail = (id) => {
        location.href = "/member/detail?id=" + id;
    }
    // const member_delete = (id) => {
    //     location.href = "/delete?id=" + id;
    // }
</script>
</html>
