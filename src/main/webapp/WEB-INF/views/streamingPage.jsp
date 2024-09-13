<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="icon" href="images/mlogo.png">
    <title>Streaming-Page</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
            crossorigin="anonymous"></script>
</head>
<body>
<div class="wrap">
    <c:import url="header.jsp"/>
    <div class="content">
        <link rel="stylesheet" href="css/streamingStyle.css">
        <div class="streaming">
            <div class="streaming-sub">
                <div class="streaming-title"></div>
                <div class="streaming-content">
                    <c:if test="${empty movic.p_sysname}">
                        <img class="poster" src="images/no-image.jpg">
                    </c:if>
                    <c:if test="${!empty movic.p_sysname}">
                        <a href="download?m_code=${movic.m_code}">
                            <img class="poster" src="upload/${movic.p_sysname}">
                        </a>
                    </c:if>
                </div>
            </div>
        </div>
        <div class="btn-area">
            <!-- 로그인 완료 후 if문으로 버튼 활성화,비활성화 조정 -->
            <button class="btn-streaming" id="bookmark">북마크</button>
            <img src="">
            <button class="btn-streaming" id="payment" onclick="location.href='./payment'">
                결제</button>
            <button class="btn-streaming" id="play" onclick="location.href='images/testmovie.mp4'">재생
            </button>
        </div>
        </div>
        <div class="streaming">
            <div class="streaming-sub">
                <div class="streaming-content">${movic.m_title}</div>
            </div>
            <hr>
            <div class="detail-sub">
                <div class="detail-title">감독 :</div>
                <div class="detail-content" style="display: inline-block">${movic.m_director}</div>
            </div>
            <div class="detail-sub">
                <div class="detail-title">주연 :</div>
                <div class="detail-content">${movic.m_actor}</div>
            </div>
            <div class="detail-sub">
                <div class="detail-title">국가 :</div>
                <div class="detail-content">${movic.m_nation}</div>
            </div>
            <div class="detail-sub">
                <div class="detail-title">장르 :</div>
                <div class="detail-content">${movic.m_genre}</div>
            </div>
            <div class="detail-sub">
                <div class="detail-title">개봉일 :</div>
                <div class="detail-content">${movic.m_open}</div>
            </div>
            <div class="detail-synopsis">
                <div class="synopsis-title">시놉시스 :</div>
                <div class="synopsis-content">${movic.m_synopsis}</div>
            </div>
            <c:import url="footer.jsp"/>
    </div>
</div>
</body>
<script>
    let msg = "${msg}";
    if(msg != ""){
        alert(msg);
    }

    //북마크 버튼 처리
    $("#bookmark").click(function (){
        let conf =confirm("북마크 하시겠습니까?");

        if (conf){
            //location.href=`./saveBookMark?b_uid=user01&b_mcode=${nowUser.uid}`;
            let sendObj = {"b_uid": ${nowUser.uid}, "b_mcode": ${movic.m_code}};

            $.ajax({
                url: './saveBookMark',
                type: 'get',
                data: sendObj,
                success: function (res) {
                    if(res == "ok"){
                        let move = confirm("북마크 페이지로 이동하시겠습니까?");
                        if (move){
                            location.href=`./bookmark?uid=${nowUser.uid}`;
                            //user01 고칠것!
                        }else {
                            location.href=`./streamingPage?m_code=${movic.m_code}`;
                        }
                    }
                    else {
                        alert("북마크 실패");
                    }
                },
                error: function (err) {
                    alert("전송 오류");
                    console.log(err);
                }
            })
        }


    });




</script>
</html>
