<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <title>Movic - HOME</title>
</head>
<body>
<div class="main">
    <c:import url="header.jsp"/>
    <div class="content">
        <div class="list-title">
            <link rel="stylesheet" href="css/mainstyle.css">
            <button class="book-mark" onclick="location.href='bookmark?uid=${nowUser.uid}'">북마크</button>
            <div class="search">
                <form action="/">
                    <input type="text" name="keyword" placeholder="제목, 배우">
                    <input type="submit" class="sc-btn" value="검색">
                </form>
            </div>
            <ul class="top-menu">
                <li id="category"><a href="#" ><img src="images/categorylogo.png"></a>
                    <ul>
                        <li>카테고리 목록넣기</li>
                    </ul>
                </li>
                <li id="mypage"><a href="#">마이페이지 <span>▼</span></a>
                    <ul>
                        <li>로그아웃</li>
                    </ul>
                </li>
            </ul>

            <button class="saveFrom" onclick="location.href='./saveForm'">
                (관리자용) 영화데이터 삽입</button>
        </div>
        <hr>
        <div class="data-area">
        <c:if test="${empty mlist}">
            <div class="movic-item">
                <span class="none-content">등록된 영화가 없습니다.</span>
            </div>
        </c:if>
            <c:if test="${!empty mlist}">
                <c:forEach var="mitem" items="${mlist}">

                    <div class="movie-item">
                        <a href="streamingPage?m_code=${mitem.m_code}">
                            <c:if test="${empty mitem.p_sysname}">
                                <img src="images/no-image.jpg" class="poster-pre">
                            </c:if>
                            <c:if test="${!empty mitem.p_sysname}">
                                <img src="upload/${mitem.p_sysname}" class="poster-pre">
                            </c:if>
                        </a>
                        <div class="info-pre">
                            <div class="title-pre">
                                <a href="streamingPage?m_code=${mitem.m_code}"></a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:if>
        </div>
        <div class="paging-area">
        <div class="paging">${paging}</div>
    </div>
    </div>
    <c:import url="footer.jsp"/>
</div>
</body>
<script>
    let msg = "${msg}";
    if (msg != ""){
        alert(msg);
    }

</script>
</html>
