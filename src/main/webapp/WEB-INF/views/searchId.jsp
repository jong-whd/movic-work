<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>MOVIC</title>
    <link rel="stylesheet" href="">
    <link rel="icon" href="img/img.png">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
</head>
<body>
<div class="">
    <c:import url="header.jsp"/>
    <div class="">
       <h3>아이디 찾기</h3>
           <input type="text" name="uname" required
                  placeholder="이름 입력" id="uname"><br>
           <input type="text" name="uphonenum" required
                  placeholder="전화 번호" id="uphonenum"><br>
           <button type="button" id="pbtn">아이디 찾기</button>
    </div>
    <c:import url="footer.jsp"/>

</div>
</body>
<script>
    $("#pbtn").click(function (){
        let inputName = $("#uname").val();
        let inputPhone = $("#uphonenum").val();
        if (inputName  === "" && inputPhone === ""){
            alert("이름 전화번호를 적으시오.");
            $("#uname").focus();
            return;
        }

        $.ajax({
           url: "idfocus",
           type: "post",
           data: {"uname": inputName, "uphonenum": inputPhone},
           success: function (uid){
               if(uid === ""){
                   alert("아이디가 존재하지 않습니다.");
               }else {
                   alert(uid);
                   //location.href=`./login?uid=\${uid}`;  //로그인 페이지로 이동.
               }
           },
            error:function (){
               alert("애러입니다.");
            }
        });
    });
</script>
</html>
