<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<ul class="navbar-nav ml-auto main-nav ">
<li class="nav-item active">
	<a class="nav-link" href="<%=request.getContextPath()%>/themes/classimax-premium/adminIndex.jsp">MANAGERMENT HOME</a>
</li>
<li class="nav-item">
	<a class="nav-link" href="<%=request.getContextPath()%>/themes/classimax-premium/managerList.jsp">Managers</a>
</li>
<li class="nav-item">
	<a class="nav-link" href="<%=request.getContextPath()%>/themes/classimax-premium/clientList.jsp">Clients</a>
</li>
<li class="nav-item dropdown dropdown-slide">
	<a class="nav-link dropdown-toggle" href="#" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		Products <span><i class="fa fa-angle-down"></i></span>
	</a>
	<!-- Dropdown list -->
	<div class="dropdown-menu">
		<a class="dropdown-item" href="<%=request.getContextPath()%>/themes/classimax-premium/categoryList.jsp">Category</a>
		<a class="dropdown-item" href="<%=request.getContextPath()%>/themes/classimax-premium/ebookList.jsp">E-book</a>
		<a class="dropdown-item" href="<%=request.getContextPath()%>/themes/classimax-premium/ordersList.jsp">Order</a>
	</div>
</li>
<li class="nav-item">
	<a class="nav-link" href="<%=request.getContextPath()%>/themes/classimax-premium/noticeList.jsp">Notice</a>
</li>
</ul>