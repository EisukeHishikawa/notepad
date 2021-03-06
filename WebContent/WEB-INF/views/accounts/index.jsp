<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:import url="../layout/app.jsp">
    <c:param name="content">
        <c:if test="${flush != null}">
            <div id="flush_success">
                <c:out value="${flush}"></c:out>
            </div>
        </c:if>
        <h2>アカウント　一覧</h2>
        <table id="account_list">
            <tbody>
                <tr>
                    <th>アカウントID</th>
                    <th>アカウント名</th>
                    <th>操作</th>
                </tr>
                <c:forEach var="account" items="${accounts}" varStatus="status">
                    <tr class="row${status.count % 2}">
                        <td><c:out value="${account.code}" /></td>
                        <td><c:out value="${account.name}" /></td>
                        <td>
                            <c:choose>
                                <c:when test="${account.delete_flag == 1}">
                                    （削除済み）
                                </c:when>
                                <c:otherwise>
                                    <a href="<c:url value='/accounts/show?id=${account.id}' />">詳細を表示</a>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <div id="pagination">
            （全 ${accounts_count} 件）<br />
            <c:forEach var="i" begin="1" end="${((accounts_count - 1) / 15) + 1}" step="1">
                <c:choose>
                    <c:when test="${i == page}">
                        <c:out value="${i}" />&nbsp;
                    </c:when>
                    <c:otherwise>
                        <a href="<c:url value='/accounts/index?page=${i}' />"><c:out value="${i}" /></a>&nbsp;
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </div>
        <p><a href="<c:url value='/accounts/new' />">新規アカウントの登録</a></p>

    </c:param>
</c:import>