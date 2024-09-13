<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>MOVIE INFO - DETAIL</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="icon" href="images/mlogo.png">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
</head>
<body>
<div class="wrap">
    <c:import url="header.jsp"/>
    <div class="content">
        <h2 class="form-header">상세 보기</h2>
        <div class="detail">
            <div class="detail-sub">
                <div class="detail-title">포스터</div>
                <div class="detail-content">
                    <c:if test="${empty movic.p_sysname}">
                        <img class="poster" src="images/no_image.jpg">
                    </c:if>
                    <c:if test="${!empty movie.p_sysname}">
                        <a href="download?m_code=${movic.m_code}">
                            <img class="poster" src="upload/${movic.p_sysname}">
                        </a>
                    </c:if>
                </div>
            </div>
        </div>
        <div class="detail">
            <div class="detail-sub">
                <div class="detail-title">제목</div>
                <div class="detail-content">${movic.m_title}</div>
            </div>
            <div class="detail-sub">
                <div class="detail-title">감독</div>
                <div class="detail-content">${movic.m_director}</div>
            </div>
            <div class="detail-sub">
                <div class="detail-title">주연</div>
                <div class="detail-content">${movic.m_actor}</div>
            </div>
            <div class="detail-sub">
                <div class="detail-title">국가</div>
                <div class="detail-content">${movic.m_nation}</div>
            </div>
            <div class="detail-sub">
                <div class="detail-title">장르</div>
                <div class="detail-content">${movic.m_genre}</div>
            </div>
            <div class="detail-sub">
                <div class="detail-title">개봉일</div>
                <div class="detail-content">${movic.m_open}</div>
            </div>
            <div class="detail-sub">
                <div class="synopsis-title">시놉시스</div>
                <div class="synopsis-content">${movic.m_synopsis}</div>
            </div>
        </div>
        <div class="btn-area">
            <button class="btn-write" id="upbtn">U</button>
            <button class="btn-write" id="delbtn">D</button>
            <button class="btn-sub" id="backbtn">B</button>
        </div>
    </div>
    <c:import url="footer.jsp"/>
</div>
</body>
<script>
    let msg = "${msg}";
    if(msg != ""){
        alert(msg);
    }
    //뒤로가기 버튼 처리
    $("#backbtn").click(function () {
        location.href=`./?pageNum=${pageNum}`;
    });

    //수정 버튼 처리
    $("#upbtn").click(function () {
        location.href=`./updateForm?m_code=${movic.m_code}`;
    });

    // 삭제 버튼 처리
    $("#delbtn").click(function (){
        let conf = confirm("삭제할까요?");
        if (conf){
            location.href=`./delete?m_code=${movic.m_code}`;
        }
    });
</script>
</html>