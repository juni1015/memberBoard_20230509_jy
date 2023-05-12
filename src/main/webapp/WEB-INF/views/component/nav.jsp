<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="nav">
    <ul>
        <li>
            <a href="/">
                <i class="bi bi-house"></i>
            </a>
        </li>
<%--        <li>--%>
<%--            <a href="/member/save">회원가입</a>--%>
<%--        </li>--%>
<%--        <li>--%>
<%--            <a href="/member/login">로그인</a>--%>
<%--        </li>--%>
        <li class="menu-name" id="menu-area">

        </li>
        <li class="login-name" id="login-area">

        </li>
    </ul>
</div>

<script>
    const loginArea = document.getElementById("login-area");
    const menuArea = document.getElementById("menu-area");
    const loginEmail = '${sessionScope.loginEmail}';

    if (loginEmail.length != 0) {
        if (loginEmail == "admin") {
            menuArea.innerHTML = "<a href='/board/save'>글작성</a>" +
                                    "<a href='/board/list'>글목록</a>" +
                                    "<a href='/member/list'>관리자</a>";
            loginArea.innerHTML = "<a href='/member/mypage' style='color: black;'>"+loginEmail +"님 환영해요!</a>"+
                "<a href='/member/logout'>logout</a>";
        } else {
            menuArea.innerHTML = "<a href='/board/save'>글작성</a>" +
                                    "<a href='/board/list'>글목록</a>";
            loginArea.innerHTML = "<a href='/member/mypage' style='color: black;'>"+loginEmail +"님 환영해요!</a>"+
                "<a href='/member/logout'>logout</a>";
        }
    } else {
        menuArea.innerHTML = "<a href='/board/list'>글목록</a>";
        loginArea.innerHTML = "<a href='/member/login'>login</a>" +
                                "<a href='/member/save'>join</a>";
    }
</script>