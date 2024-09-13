<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>영화 결제</title>
    <link rel="stylesheet" href="css/movie.css">
    <link rel="icon" href="img/img.png">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
</head>
<body>
<div class="">
    <c:import url="header.jsp"/>
   <div class="">
               <div class="">
                   <h2 class="">영화 목록</h2>
               </div>
               <div class="">
                   <c:if test="${empty mList}">
                       <div class="">
                           <span class="">등록된 영화가 없습니다.</span>
                       </div>
                   </c:if>
                   <c:if test="${!empty mList}">
                       <c:forEach var="mitem" items="${mList}">
                           <div class="">
                               <a href="detail?m_code=${mitem.m_code}">
                                   <c:if test="${empty mitem.p_sysname}">
                                       <img src="img/img.png" class="">
                                   </c:if>
                                   <c:if test="${!empty mitem.p_sysname}">
                                       <img src="upload/${mitem.p_sysname}" class="">
                                   </c:if>
                               </a>
                               <div class="">
                                   <div class="">
                                       <a href="detail?m_code=${mitem.m_code}">
                                               ${mitem.m_title}
                                       </a>
                                   </div>
                                   <div class="">${mitem.m_director}</div>
                                   <div class="">${mitem.m_open}</div>
                               </div>
                           </div>
                       </c:forEach>
                   </c:if>
               </div>
               <div class="">
                   <div class="">${paging}</div>
               </div>
   </div>
    <c:import url="footer.jsp"/>
</div>
</body>
<script>

</script>
</html>
