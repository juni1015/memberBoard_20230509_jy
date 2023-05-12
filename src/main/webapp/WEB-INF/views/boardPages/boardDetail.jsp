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
    <%--    시간 형식에 사용하는 라이브러리 --%>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>

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
    <c:if test="${sessionScope.loginEmail.length() > 0}">
        <div id="comment-write-area">
            <input type="text" id="comment-writer" placeholder="댓글 작성자" value="${sessionScope.loginEmail}" readonly>
            <input type="text" id="comment-contents" placeholder="댓글 내용">
            <button onclick="comment_write()">댓글 작성</button>
        </div>
    </c:if>
    <div id="comment-list">
        <c:choose>
            <c:when test="${commentList == null}">
                <h2>작성된 댓글 없음</h2>
            </c:when>
            <c:otherwise>
                <table>
                    <tr>
                        <th>id</th>
                        <th>작성자</th>
                        <th>내용</th>
                        <th>작성시간</th>
                    </tr>
                    <c:forEach items="${commentList}" var="comment">
                        <tr>
                            <td>${comment.id}</td>
                            <td>${comment.commentWriter}</td>
                            <td>${comment.commentContents}</td>
                            <td>
                                <fmt:formatDate value="${comment.commentCreatedDate}" pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate>
                            </td>
<%--                            <c:if test="${sessionScope.loginEmail == comment.commentWriter}">--%>
<%--                                <td><button onclick="comment_update(${comment.id})">수정</button></td>--%>
<%--                                <td><button onclick="comment_delete(${comment.id})">삭제</button></td>--%>
<%--                            </c:if>--%>
<%--                            <c:if test="${sessionScope.loginEmail == 'admin'}">--%>
<%--                                <td><button onclick="comment_delete(${comment.id})">삭제</button></td>--%>
<%--                            </c:if>--%>
                        </tr>
                    </c:forEach>
                </table>
            </c:otherwise>
        </c:choose>
    </div>
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
    const comment_write = () => {
        const commentWriter = document.getElementById("comment-writer").value;
        const commentContents = document.getElementById("comment-contents").value;
        const boardId = '${board.id}';
        const result = document.getElementById("comment-list");
        $.ajax({
            type: "post",
            url: "/comment/save",
            data: {
                "commentWriter": commentWriter,
                "commentContents": commentContents,
                "boardId": boardId
            },
            success: function (res) {
                console.log(res);
                let output = "<table>";
                output += "<tr>";
                output += "<tr>";
                output += "<th>id</th>";
                output += "<th>작성자</th>";
                output += "<th>내용</th>";
                output += "<th>작성시간</th>";
                output += "</tr>";
                for (let i in res) {
                    output += "<tr>";
                    output += "<td>" + res[i].id + "</td>";
                    output += "<td>" + res[i].commentWriter + "</td>";
                    output += "<td>" + res[i].commentContents + "</td>";
                    output += "<td>" + moment(res[i].commentCreatedDate).format("YYYY-MM-DD HH:mm:ss") + "</td>";
                    output += "</tr>";
                }
                output += "</table>";
                result.innerHTML = output;
                document.getElementById("comment-contents").value = "";
            },
            error: function () {
                console.log("실패");
            }
        });
    }

    const comment_update = (id) => {
        location.href = "/comment/update?id=" + id;
    }
</script>
</html>
