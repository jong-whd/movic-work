<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>MOVIE INFO</title>
    <link rel="stylesheet" href="/css/login.css">
    <link rel="icon" href="images/mlogo.png">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Gugi&display=swap" rel="stylesheet">
</head>
<body>
<div class="layout">

    <div class="copy">
        <a href="/">
            <img id="logo" src="images/mlogo.png" alt="">
        </a>
        <p> 환영합니다</p>

    </div>
    <div class="iab">
        <input class="acc" type="text" id="uid" placeholder="아이디">
        <input class="acc" type="text" id="upass" placeholder="비밀번호">
        <div>
            <a href="/searchId">아이디 찾기</a>
            <a href="">/ 비밀번호 찾기</a>
        </div>
    </div>
        <button class="sub" id="login">로그인</button>
        <div class="wrap">
            <hr class="bar">
            <span class="txt">아이디가 없으신가요? </span>
            <hr class="bar">
        </div>
        <button class="signup">회원가입</button><br>



</div>
</body>

<script>

    $(".signup").click(function (){
            location.href="join2";
    });

    $("#login").click(function (){
        let inputid = $("#uid").val();
        let inputpass = $("#upass").val();
        if (inputid === ""){
            alert("아이디를 입력해주세요")
            $("#uid").focus();
            // alert("비밀번호를 입력해주세요")
            // $("#upass").focus();
            return;
        }
        if (inputpass === ""){
            alert("비밀번호를 입력해주세요")
            $("#upass").focus();
            return;
        }
        $.ajax({
            url:"loginProc",
            type: "post",
            data:{
                "uid": inputid,
                "upass":inputpass
            },
            success:function (res){
                switch (res){
                    case "아이디가 존재하지 않습니다.":
                        alert(res);
                        $("#uid").focus();
                        break;
                    case "비밀번호가 일치하지 않습니다.":
                        alert(res);
                        $("#upass").focus();
                        break;
                    case "admin":
                        location.href = "/admain";
                        break;
                    case "ok":
                        location.href = "/home";
                        break;
                }
                // if (res == "ok"){
                //     alert("로그인 성공.");
                // } else {
                //     alert(res);
                //     if (res === "비밀번호가 일치하지 않습니다."){
                //         $("#upass").focus();
                //     }else{
                //         $("#uid").focus();
                //     }
                // }
            },
            error: function (error){
                alert("로그인 중 오류가 발생했습니다:"+ error)
            }
        });
    });
</script>
</html>
