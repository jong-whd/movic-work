<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>관리자 페이지</title>
    <link rel="stylesheet" href="css/admainstyle.css">
    <link rel="icon" href="images/mlogo.png">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
</head>
<body>
<div class="mtop-nav">
    <div class="mtop-bar">
        <img alt="로고" src="images/mlogo.png" class="logo"
             onclick="location.href='/admain'">
        <h2>MOFLIX</h2>
        <ul>
            <ul><h2>관리자 페이지</h2></ul>
        </ul>
    </div>
    <div class="msecond-top-bar">
        <div class="msearch">
            <form onsubmit="return false;">
                <input id="sc-in" type="text" class ="msc-input" name="keyword" placeholder="ID, 이름" value="${keyword}">
                <input type="button" class="msc-btn" value="검색">
            </form>
        </div>
        <ul>
            <li id="logout">로그아웃</li>
        </ul>
    </div>
</div>
<div class="wrap">
    <%--    <c:import url="header.jsp"/>--%>
    <div class="mmenu">
        <ul>
            <li>
                <h2>admin</h2>
            </li>
            <li class="detail-content" value=1>
                <a>영화 등록</a>
            </li>
            <li class="detail-content" value=2>
                <a>영화 수정</a>
            </li>
            <li class="detail-content" value=3>
                <a href="detail">영화 삭제</a>
            </li>
            <li class="detail-content" value=4>
                <a>회원 관리</a>
            </li>
            <li class="detail-content" value=5>
                <a>결제 관리</a>
            </li>
        </ul>
    </div>
    <div class="member-content">
        <c:if test="${nowMenu ne null}">
            <c:import url="${nowMenu}.jsp"/>
        </c:if>
    </div>
</div>
</body>
<script>
    let msg = "${msg}";
    var dstr;
    if (msg != ""){
        alert(msg);
    }
    //1 saveForm 2 updateForm 3deleteForm 4memberForm
    $(".detail-content").click(function (){
        dstr = $(this).val();
        console.log(dstr);
        location.href="./admain?menu="+dstr;
    });
    // 파일 업로드 시 선택한 파일명 출력
    $("#file").on("change", function (){
        let files = $("#file")[0].files;
        console.log(files);

        let fileName = "";

        if (files.length == 1){
            // 파일을 한개 선택한 상황
            fileName = files[0].name;
        } else{
            // 파일 선택 창에서 취소한 상황
            fileName = "파일 선택";
        }
        $(".upload-name").val(fileName);
    });

    $("#logout").click(function (){

        if(confirm("로그아웃 하시겠습니까?")) {
            location.href = "logout";
        }
    });

    // 뒤로가기 버튼 처리
    $("#backbtn").click(function (){
        location.href=`./?pageNum=${pageNum}`;
    });
</script>
</html>







<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>--%>

<%--<html>--%>
<%--<head>--%>
<%--    <title>Movic-admin</title>--%>
<%--    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>--%>
<%--</head>--%>
<%--<body>--%>
<%--<div class="wrap">--%>
<%--    <c:import url="header.jsp"/>--%>
<%--    <div class="content">--%>
<%--        <div class="search">--%>
<%--            <form action="/">--%>
<%--                <input type="text" name="keyword" placeholder="제목, 배우">--%>
<%--                <input type="submit" class="sc-btn" value="검색">--%>
<%--            </form>--%>
<%--        </div>--%>
<%--        <div class="list-title">--%>
<%--            <h2>영화 목록</h2>--%>
<%--            <button class="wr-btn" onclick="location.href='./saveForm'">--%>
<%--                영화 등록--%>
<%--            </button>--%>
<%--        </div>--%>
<%--        <div class="data-area">--%>
<%--            <c:if test="${empty mList}">--%>
<%--                <div class="movie-item">--%>
<%--                    <span class="none-content">등록된 영화가 없습니다.</span>--%>
<%--                </div>--%>
<%--            </c:if>--%>
<%--            <c:if test="${!empty mList}">--%>
<%--                <c:forEach var="item" items="${mList}">--%>
<%--                    <a href="detail?m_code=${item.m_code}">--%>
<%--                        <div>${item.m_title}</div>--%>
<%--                    </a>--%>
<%--                </c:forEach>--%>
<%--            </c:if>--%>
<%--        </div>--%>
<%--        <div>--%>
<%--            <div>${paging}</div>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--</div>--%>
<%--</body>--%>
<%--<script>--%>
<%--    let msg = "${msg}";--%>
<%--    if (msg != ""){--%>
<%--        alert(msg);--%>
<%--    }--%>
<%--</script>--%>
<%--</html>--%>




















<%--                <select name="columName">--%>
<%--                    <option value="m_title" selected>제목</option>--%>
<%--                    <option value="로맨스">로맨스</option>--%>
<%--                </select>--%>