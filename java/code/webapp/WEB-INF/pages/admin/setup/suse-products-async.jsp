<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@ taglib uri="http://rhn.redhat.com/rhn" prefix="rhn"%>
<%@ taglib uri="http://rhn.redhat.com/tags/list" prefix="rl"%>

<c:forEach var="baseProduct" items="${baseProducts}">
    <c:set var="product" value="${baseProduct.key}" scope="request" />
    <c:set var="addon" value="${false}" scope="request" />

    <jsp:include page="/WEB-INF/pages/admin/setup/suse-product-async.jsp" />

    <c:forEach var="addonProduct" items="${baseProduct.value}">
        <c:set var="product" value="${addonProduct}" scope="request" />
        <c:set var="addon" value="${true}" scope="request" />
        <jsp:include page="/WEB-INF/pages/admin/setup/suse-product-async.jsp" />
    </c:forEach>
</c:forEach>
