<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>MOVIE INFO</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="icon" href="images/mlogo.png">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
</head>
<body>
<div class="wrap">
<%--    <c:import url="header.jsp"/>--%>
    <div class="content">
        <form action="signUpProc" method="post" enctype="multipart/form-data">
            <table>
                <th>회원가입</th>
                <tr>
                    <th width="100">아이디</th>
                    <td width="200">
                        <input type="text" name="uid" required
                               placeholder="아이디 입력" id="uid">
                    </td>
                </tr>
                <tr>
                    <th colspan="2">
                        <button type="button" id="idbtn">ID중복체크</button>
                    </th>
                </tr>
                <tr>
                    <th>비밀번호</th>
                    <td>
                        <input type="password" name="upass" required
                               placeholder="비밀번호 입력">
                    </td>
                </tr>
                <tr>
                    <th>이름</th>
                    <td>
                        <input type="text" name="uname" required
                               placeholder="이름 입력">
                    </td>
                </tr>
                <tr>
                    <th>나이</th>
                    <td>
                        <input type="number" name="uage" required
                               placeholder="나이 입력">
                    </td>
                </tr>
                <tr>
                    <th>주소</th>
                    <td>
                        <input type="text" name="uaddr" required
                               placeholder="주소 입력">
                    </td>
                </tr>
                <tr>
                    <th>성별</th>
                    <td>
                        <input type="radio" value="f" name="ugender" required>여성
                        <input type="radio" value="m" name="ugender" required>남성
                    </td>
                </tr>
                <tr>
                    <th>주민번호</th>
                    <td>
                        <input type="text" name="uregnum" required
                               placeholder="주민번호 (-를 써주세요.)">
                    </td>
                </tr>
                <tr>
                    <th>전화번호</th>
                    <td>
                        <input type="text" name="uphonenum" required
                               placeholder="전화 번효 (- 를 써주세요.)">
                    </td>
                </tr>
                <tr>
                    <th colspan="2">
                        <input type="submit" value="가입">
                    </th>
                </tr>
            </table>
            <a href="searchId">아이디 찾기</a>
            <a href="movic">결제시스템</a>
        </form>
    </div>
    <c:import url="footer.jsp"/>
</div>
</body>
<script>
    let ckok = false;//false일 경우 가입 처리 안됨.

    $("#idbtn").click(function () {
        //입력한 id값 가져오기
        let inputId = $("#uid").val();
        if (inputId === ""){
            alert("아이디를 입력하세요");
            $("#uid").focus();
            return;//클릭 상황(함수) 종료
        }
        //전송형식에 맞게 id 값을 작성
        let sendObj = {"uid": inputId};

        $.ajax({
            url: "idCheck",
            type: "post",
            data: sendObj,
            success: function (res){
                if(res == "ok"){
                    alert("사용 가능한 아이디 입니다.");
                    ckok = true;//이후 가입 진행이 처리되도록.
                }else {
                    alert("중복된 아이디입니다.")
                    $("#uid").val("").focus();//입력한 아이디 지우기, 아이디 칸에 포커스 주기
                    // $("#uid").focus();//아이디 칸에 포커스 주기
                    ckok = false;
                }//else end
            },//success end
            error:function (err) {
                alert("전송 실패");
                console.log(err);
            }
        });//ajax end
    });//idbtn end

    function check(){
        if(ckok == false){
            alert("아이디 중복 체크를 해주세요.");
            return false;
        }else {
            return true;
        }

    }
</script>
</html>