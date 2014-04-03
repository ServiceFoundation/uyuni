<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://rhn.redhat.com/rhn" prefix="rhn" %>
<%@ taglib uri="http://rhn.redhat.com/tags/list" prefix="rl" %>

<tr>
    <td>
        <c:if test="${requestScope.addon}">
          <i class="fa fa-ellipsis-h"></i>
        </c:if>
        <c:out value="${requestScope.product.name}"></c:out>
    </td>
    <td><c:out value="${requestScope.product.arch}"></c:out></td>
    <td>
      <c:choose>
          <c:when test="${not requestScope.product.synchronizing}">
              <i class="fa fa-refresh btn-synchronize text-success synchronize-single" data-ident="${requestScope.product.ident}"></i>
          </c:when>
          <c:otherwise>
              <i class="fa fa-check text-success"></i>
          </c:otherwise>
      </c:choose>
    </td>
</tr>
