<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:import url="/WEB-INF/views/layout/app.jsp">
    <c:param name="content">
        <c:if test="${flush != null}">
            <div id="flush_success">
                <c:out value="${flush}"></c:out>
            </div>
        </c:if>
        <h2>メモ帳</h2>
        <table id="memo_list">
            <tbody>
                <tr>
                    <th class="memo_name">アカウント名</th>
                    <th class="memo_date">日付</th>
                    <th class="memo_title">タイトル</th>
                    <th class="memo_action">操作</th>
                </tr>
                <c:forEach var="memo" items="${memos}" varStatus="status">
                    <tr class="row${status.count % 2}">
                        <td class="memo_name"><c:out value="${memo.account.name}" /></td>
                        <td class="memo_date"><fmt:formatDate value='${memo.memo_date}' pattern='yyyy-MM-dd' /></td>
                        <td class="memo_title">${memo.title}</td>
                        <td class="memo_action"><a href="<c:url value='/memos/show?id=${memo.id}' />">詳細を見る</a></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <div id="pagination">
            （全 ${memos_count} 件）<br />
            <c:forEach var="i" begin="1" end="${((memos_count - 1) / 15) + 1}" step="1">
                <c:choose>
                    <c:when test="${i == page}">
                        <c:out value="${i}" />&nbsp;
                    </c:when>
                    <c:otherwise>
                        <a href="<c:url value='/memos/index?page=${i}' />"><c:out value="${i}" /></a>&nbsp;
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </div>
        <p><a href="<c:url value='/memos/new' />">新規メモの作成</a></p>

    </c:param>
</c:import>