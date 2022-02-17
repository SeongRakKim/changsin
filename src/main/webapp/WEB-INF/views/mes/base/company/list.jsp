<%--
  Created by IntelliJ IDEA.
  User: Mi Ra
  Date: 2022-02-09
  Time: 오후 10:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ include file="/WEB-INF/include/header.jspf" %>

<!-- Begin Page Content -->
<div class="container-fluid">
    <div class="menu-nav">
        <div>
            <!-- Page Heading -->
<%--            <span class="btn btn-pill btn-secondary">--%>
            <span class="btn btn-pill btn-sm btn-primary">
                <i class="fas fa-home"></i> > 기준정보 > 거래처정보
            </span>
        </div>

        <%@ include file="/WEB-INF/include/main-top-right.jspf"%>
    </div>

    <%@ include file="/WEB-INF/include/main-progress.jspf"%>

    <div>
        <table class="tableSearch table table-hover table-striped table-bordered mb-5">
            <colgroup>
                <col style="width: 10%">
                <col style="width: 30%">
                <col style="width: 10%">
                <col style="width: 20%">
                <col style="width: 10%">
                <col style="width: 20%">
            </colgroup>
            <thead class="thead-light">
                <tr>
                    <th scope="col">거래처구분</th>
                    <td>
                        <select id="comp_type" name="comp_type" class="custom-select w-100" required="">
                            <option value="">거래처구분선택</option>
                            <c:forEach var="item" items="${vmap.compTypeList}" varStatus="status">
                                <option value="${item.base_detail_cd}">${item.base_detail_nm}</option>
                            </c:forEach>
                        </select>
                    </td>
                    <th scope="col">거래처분류</th>
                    <td>
                        <select id="comp_group" name="comp_group" class="custom-select w-100" required="">
                            <option value="">거래처구분선택</option>
                            <c:forEach var="item" items="${vmap.compGroupList}" varStatus="status">
                                <option value="${item.base_detail_cd}">${item.base_detail_nm}</option>
                            </c:forEach>
                        </select>
                    </td>
                    <th scope="col">검색어</th>
                    <td>
                        <input type="text" class="form-control" id="search_text" name="search_text" placeholder="검색어">
                    </td>
                </tr>
            </thead>
        </table>
    </div>

</div>

<script>
    $(function()
    {

    });
</script>

<%@ include file="/WEB-INF/include/footer.jspf" %>