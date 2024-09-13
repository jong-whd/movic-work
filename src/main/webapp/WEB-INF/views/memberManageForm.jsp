<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="member-content">
    <div class="list-title">
        <h2>회원 목록</h2>
    </div>
    <div class="data-area">
        <c:if test="${empty uList}">
            <table>
                <tr>
                    <th>ID</th>
                    <th>이름</th>
                </tr>
                <tr>
                    <td colspan="2" class="none-content">
                        <a>회원이 없습니다</a>
                    </td>
                </tr>
            </table>
            <%--                <div class="user-item">--%>
            <%--                    <span class="none-content">회원이 없습니다</span>--%>
            <%--                </div>--%>
        </c:if>
        <c:if test="${!empty uList}">
            <table cellspacing="0">
                <tr>
                    <th>번호</th>
                    <th>ID</th>
                    <th>이름</th>
                    <th>주소</th>
                    <th>성별</th>
                    <th>삭제</th>
                </tr>
                <c:forEach var="list" items="${uList}">
                    <tr>
                        <td class="memlist" id ="memnum">
                            <a id="viewnum"></a>
                        </td>
                        <td class="memlist">
                            <a>${list.uid}</a>
                        </td>
                        <td class="memList">
                            <a>${list.uname}</a>
                        </td>
                        <td class="memList">
                            <a>${list.uaddr}</a>
                        </td>
                        <td class="memlist">
                            <a>${list.ugender}</a>
                        </td>
                        <td class="memList">
                            <img alt="삭제" src="images/delete.png" class="deletebtn"/>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </c:if>
    </div>
    <div class="paging-area">
        <div class="paging">${paging}</div>
    </div>
</div>
