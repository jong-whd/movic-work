<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>MOVIE INFO</title>
    <link rel="stylesheet" href="/css/signup.css">
    <link rel="icon" href="img/img.png">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Gugi&display=swap" rel="stylesheet">
    <script src="js/jquery-3.7.1.min.js"></script>
</head>
<body>
<div class="layout">
    <div class="copy">
        <a href="main.html">
            <img id="logo" src="img/img.png" alt="">
        </a>
        <p> 회원가입</p>

    </div>
    <div class="iab">
        <form action="signup" method="post" enctype="multipart/form-data">
        <div class="fst">
            <div style="width: 50%;">
                아이디
                <div id="idck">
                    <input class="acc" type="text" placeholder="아이디" name="uid" id="uid">
                    <button type="button" id="idbtn">ID중복체크</button>
                </div>
            </div>
            <div style="width: 50%;">
                비밀번호
                <input class="acc" type="text" placeholder="비밀번호" name="upass">
            </div>
        </div>
        <div class="fst">
            <div style="width: 50%;">
                이름
                <input class="acc" type="text" placeholder="이름" name="uname">
            </div>
            <div style="width: 50%;">
                나이
                <input class="acc" type="text" placeholder="나이" name="uage">
            </div>
        </div>
        <div class="fst">
            <div style="width: 50%;">
                주민번호
                <input class="acc" type="text" placeholder="주민번호" name="uregnum">
            </div>
            <div style="width: 50%;">
                전화번호
                <input class="acc" type="text" placeholder="전화번호" name="uphonenum">
            </div>
        </div>
        <div class="divtext">
            주소
            <input class="acc2" type="text" placeholder="주소" name="uaddr">
        </div>
        <div class="divtext" style="position: relative">
            성별
            <div style="position: absolute; right: 0px;">
                <input type="radio" value="f" name="ugender" required>여성
                <input type="radio" value="m" name="ugender" required>남성
            </div>
        </div>
            <button class="sub" type="submit" value="가입">회원가입</button>
        <div id="div1"></div>

        </form>

    </div>


</div>
</body>
<script>
    let ckok = false;

    $("#idbtn").click(function (){
        //입력한 id값 가져오기
        let inputId = $("#uid").val();
        if(inputId === ""){
            alert("아이디를 입력하세요");
            $("#uid").focus();
            return;
        }
        let sendObj = {"uid": inputId};

        $.ajax({
            url: "idCheck",
            type: "post",
            data: sendObj,
            success: function (res){
                if(res == "ok"){
                    alert("사용 가능한 아이디 입니다.");
                    ckok = true
                }else {
                    alert("중복된 아이디입니다.");
                    $("#uid").val("").focus();
                    ckok = false;
                }
            },
            error: function (err){
                alert("전송 실패");
                console.log(err);
            }
        });
    });

    function check(){
        if(ckok == false){
            alert("아이디 중복 체크 해주세요.");
            return false;
        }else {
            return true;
        }
    }
</script>
</html>