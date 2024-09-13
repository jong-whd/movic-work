<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>MOVIE INFO - WRITE</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="icon" href="images/mlogo.png">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
</head>
<body>
<div class="wrap">
    <c:import url="header.jsp"/>
    <div class="content">
        <form action="writeProc" method="post" enctype="multipart/form-data">
            <h2 class="form-header">영화 등록</h2>
            <div class="filebox">
                <!-- 파일 입력 처리 영역 -->
                <label for="file">포스터</label>
                <input type="file" name="files" id="file">
                <input type="text" class="upload-name" value="파일선택" readonly>
            </div>
            <input type="text" class="write-input" name="m_title"
                   autofocus placeholder="제목" required>
            <input type="text" class="write-input" name="m_director"
                   placeholder="감독" required>
            <input type="text" class="write-input" name="m_nation"
                   placeholder="국가" required>
            <input type="text" class="write-input" name="m_language"
                   placeholder="언어" required>
            <input type="text" class="write-input" name="m_genre"
                   placeholder="장르" required>
            <input type="text" class="write-input" name="m_actor"
                   placeholder="주연배우" required>
            <input type="date" class="write-input" name="m_open"
                   placeholder="개봉일" required>
            <textarea rows="10" class="write-input ta" name="m_synopsis"
                      placeholder="영화 개요"></textarea>
            <div class="btn-area">
                <input type="submit" class="btn-write" value="W">
                <input type="reset" class="btn-write" value="R">
                <input type="button" class="btn-write" value="B" id="backbtn">
            </div>
        </form>
    </div>
    <c:import url="footer.jsp"/>

</div>
</body>
<script>
    let msg = "${msg}";
    if(msg != ""){
        alert(msg);
    }
    //파일 업로드 시 선택한 파일명 출력
    $("#file").on("change", function (){
        let files = $("#file")[0].files;
        console.log(files);

        let fileName = "";

        if(files.length == 1){
            //파일을 하나 선택한 상황
            fileName = files[0].name;
        }else {
            //파일 선택창에서 취소한 상황
            fileName = "파일선택";
        }
        $(".upload-name").val(fileName);
    });

    //뒤로가기 버튼 처리
    $("#backbtn").click(function (){
        location.href=`./?pageNum=${pageNum}`;
    });
</script>
</html>

