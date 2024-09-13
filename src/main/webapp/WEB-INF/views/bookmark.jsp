<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>BookMark-Page</title>
    <style>
        .info-pre {
            display: flex;
        }
    </style>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
            crossorigin="anonymous"></script>
</head>
<body>
<c:import url="header.jsp"/>
<div class="bookmark-page">
    <link rel="stylesheet" href="css/bookmarkStyle.css">
    <div class="bookmark-top">
        <h2>북마크 리스트</h2>
        <hr>
    </div>
    <div class="bookmark-data">
        <c:if test="${empty bList}">
       <div class="bookmark-item">
           <span class="none-content">북마크된 영화가 없습니다.</span>
       </div>
        </c:if>
        <c:if test="${!empty bList}">
            <c:forEach var="bitem" items="${bList}">
                <div class="bookmark-item">
                    <div class="bookmark-info" href="streamingPage?m_code=${bitem.b_mcode}">
                        <c:if test="${empty bitem.p_sysname}">
                            <img src="images/no-image.jpg" class="poster-pre">
                        </c:if>
                        <c:if test="${!empty bitem.p_sysname}">
                            <img src="upload/${bitem.p_sysname}" class="poster-pre">
                        </c:if>
                    </div>
                    <div class="info-pre">
                        <input type="checkbox" name="bookmarks" value="${bitem.b_code}">
                        <div class="title-pre">
<%--                            <a href="streamingPage?m_code=${bitem.b_mcode}">${bitem.m_title}</a>--%>
                            <div>${bitem.m_title}</div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </c:if>
    </div>
    <div class="btn-area">
        <button class="btn-bookmark" id="deletn">삭제</button>
        <button class="btn-bookmark" id="backbtn">뒤로가기</button>
    </div>
    <c:import url="footer.jsp"/>
</div>
</body>
<script>
    let msg = "${msg}";
    if (msg != ""){
        alert(msg);
    }


    //삭제 버튼 처리
    $("#deletn").click(function (){
        let bs = $('input:checkbox[name="bookmarks"]:checked');
        //console.log($(bs[0]).val());

        // var len = $(".allcheck").length;


        if (bs.length == 0){
            alert("북마크에서 삭제할 영화를 선택해주세요");
            return;
        }

        // const b_mcodes = bs.map((b,i) => {
        //     return $(i).val();
        // });
        let b_mcodes = new Array();
        for(let b of bs){
            b_mcodes.push($(b).val());
        }
        console.log(b_mcodes);

        var a = confirm("북마크에서 삭제 하시겠습니까?");

        if (a) {
            location.href=`./bookmarkDelete?bcodes=\${b_mcodes}`;
            alert("삭제 완료 했습니다!");
        }

    })

    //뒤로가기 버튼 처리
    $("#backbtn").click(function (){
       location.href=`./?pageNum=${pageNum}`;
    });




</script>
</html>
