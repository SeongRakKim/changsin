<%--
  Created by IntelliJ IDEA.
  User: Mi Ra
  Date: 2022-02-09
  Time: 오후 10:51
  To change this template use File | Settings | File Templates.
--%>

<%@ include file="/WEB-INF/include/header.jspf" %>
    <body>
        <h2>Hello! ${name}</h2>
        <div>JSP List Test</div>
        <c:forEach var="item" items="${list}" varStatus="idx">
            ${idx.index}, ${item} <br/>
        </c:forEach>
    </body>

<script>
    alert(1)
    console.log("aaaaaa");
</script>

<%@ include file="/WEB-INF/include/footer.jspf" %>