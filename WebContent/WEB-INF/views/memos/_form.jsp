<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:if test="${errors != null}">
    <div id="flush_error">
        入力内容にエラーがあります。<br />
        <c:forEach var="error" items="${errors}">
            ・<c:out value="${error}" /><br />
        </c:forEach>

    </div>
</c:if>
<label for="memo_date">日付</label><br />
<input type="date" name="memo_date" value="<fmt:formatDate value='${memo.memo_date}' pattern='yyyy-MM-dd' />" />
<br /><br />

<label for="name">アカウント名</label><br />
<c:out value="${sessionScope.login_account.name}" />
<br /><br />

<label for="title">タイトル</label><br />
<input type="text" name="title" value="${memo.title}" />
<br /><br />

<label for="content">内容</label><br />
<textarea name="content" rows="10" cols="50">${memo.content}</textarea>
<br /><br />

<input type="hidden" name="_token" value="${_token}" />
<button type="submit">投稿</button>