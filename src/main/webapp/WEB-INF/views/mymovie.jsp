<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title></title>
    <link rel="stylesheet" href="/css/movie.css">
    <link rel="icon" href="img/img.png">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
</head>
<body>
<div class="wrap">
    <c:import url="header.jsp"/>
    <div class="content">
        <h2 class="form-header"><strong>나의 영화 목록</strong></h2>
            <div class="data-area">
                <c:if test="${empty pList}">
                    <div class="movie-item">
                        <span class="none-content">결제된 영화가 없습니다.</span>
                    </div>
                </c:if>
                <c:if test="${!empty pList}">
                    <c:forEach var="mitem" items="${pList}">
                        <div class="movie-item">
                            <a href="detail?m_code=${mitem.p_payment}">
                                <c:if test="${empty mitem.p_sysname}">
                                    <img src="img/img.png" class="poster-pre">
                                </c:if>
                                <c:if test="${!empty mitem.p_sysname}">
                                    <img src="upload/${mitem.p_sysname}" class="poster-pre">
                                </c:if>
                            </a>
                            <div class="info-pre">
                                <div class="title-pre">
                                    <a href="detail?m_code=${mitem.p_payment}">
                                            ${mitem.p_code}
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:if>
            </div>

    </div>
    <div class="paging-area">
        <div class="paging">${paging1}</div>
    </div>
    <c:import url="footer.jsp"/>
</div>
</body>
<script>

</script>
</html>
