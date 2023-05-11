<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-05-10
  Time: 오후 5:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
    <link rel="stylesheet" href="/resources/css/main.css">
    <link rel="stylesheet" href="/resources/css/bootstrap.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
</head>
<body>
<%@include file="../component/header.jsp"%>
<%@include file="../component/nav.jsp"%>
<div id="section">
    <div id="search-area">
        <form action="/board/list" method="get">
            <select name="type">
                <option value="boardTitle">제목</option>
                <option value="boardWriter">작성자</option>
            </select>
            <input type="text" name="q" placeholder="검색어 입력">
            <input type="submit" value="검색">
        </form>
    </div>
    <div class="container" id="list">
        <table>
            <tr>
                <th>id</th>
                <th>제목</th>
                <th>작성자</th>
                <th>조회수</th>
                <th>작성일자</th>
            </tr>
            <c:forEach items="${boardList}" var="board">
                <tr>
                    <td>${board.id}</td>
                    <td><a href="/board/detail?id=${board.id}&page=${paging.page}&q=${q}&type=${type}">${board.boardTitle}</a></td>
                    <td>${board.boardWriter}</td>
                    <td>${board.boardHits}</td>
                    <td>
                        <fmt:formatDate value="${board.boardCreatedDate}" pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </div>
    <div class="container">
        <ul class="pagination justify-content-center">
            <c:choose>
<%--                현재 페이지에서 이전 페이지 없으면 클릭되지 않게 비활성화--%>
                <c:when test="${paging.page<=1}">
                    <li class="page-item disabled">
                        <a class="page-link">[이전]</a>
                    </li>
                </c:when>
<%--                현재 페이지에서 이전 페이지가 있으면 버튼 활성화--%>
                <c:otherwise>
                    <li class="page-item">
                        <a class="page-link" href="/board/list?page=${paging.page-1}&q=${q}&type=${type}">[이전]</a>
                    </li>
                </c:otherwise>
            </c:choose>

            <c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="i" step="1">
                <c:choose>
<%--                    현재 페이지의 경우 클릭되지 않게 비활성화 --%>
                    <c:when test="${i eq paging.page}">
                        <li class="page-item active">
                            <a class="page-link">${i}</a>
                        </li>
                    </c:when>

                    <c:otherwise>
                        <li class="page-item">
                            <a class="page-link" href="/board/list?page=${i}&q=${q}&type=${type}">${i}</a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </c:forEach>

            <c:choose>
<%--                현재 페이지에서 다음 페이지 없으면 클릭되지 않게 비활성화--%>
                <c:when test="${paging.page>=paging.maxPage}">
                    <li class="page-item disabled">
                        <a class="page-link">[다음]</a>
                    </li>
                </c:when>
<%--                현재 페이지에서 다음 페이지가 있으면 버튼 활성화--%>
                <c:otherwise>
                    <li class="page-item">
                        <a class="page-link" href="/board/list?page=${paging.page+1}&q=${q}&type=${type}">[다음]</a>
                    </li>
                </c:otherwise>
            </c:choose>
        </ul>
    </div>
</div>
<%@include file="../component/footer.jsp"%>
</body>
</html>
