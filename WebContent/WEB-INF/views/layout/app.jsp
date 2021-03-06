<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ja">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,user-scalable=yes">
        <title>アカウント管理</title>
        <link rel="stylesheet" href="<c:url value='/css/reset.css' />">
        <link rel="stylesheet" href="<c:url value='/css/style.css' />">
    </head>
    <body>
        <div id="wrapper">
            <div id="header">
                <div id="header_menu">
                    <h1><a href="<c:url value='/' />">メモ帳</a></h1>&nbsp;&nbsp;&nbsp;
                    <c:if test="${sessionScope.login_account.admin_flag == 1}">
                            <a href="<c:url value='/accounts/index' />">アカウント管理</a>&nbsp;
                        	<a href="<c:url value='/memos/index' />">メモ一覧</a>&nbsp;
                    </c:if>
                </div>
                <c:if test="${sessionScope.login_account != null}">
                    <div id="account_name">
                        <c:out value="${sessionScope.login_account.name}" />&nbsp;さん&nbsp;&nbsp;&nbsp;
                        <a href="<c:url value='/logout' />">ログアウト</a>
                    </div>
                </c:if>
            </div>
            <div id="content">
                ${param.content}
            </div>
            <div id="footer">
                by Eisuke Hishikawa.
            </div>
        </div>
    </body>
</html>