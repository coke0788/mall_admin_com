<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="java.util.*" %>
<%
	//매니저 등록이 안 되어 있거나 매니저레벨이 1보다 낮은 경우 진입 불가
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null || manager.getManagerLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/themes/classimax-premium/adminIndex.jsp");
		return;
	}
	//글자 인코딩
	request.setCharacterEncoding("utf-8");
	//변수 선언 > 값 받아오기 > dao 실행
	int ordersNo=Integer.parseInt(request.getParameter("ordersNo"));
	String ordersState=request.getParameter("ordersState");
	System.out.printf("ordersNo:%d, ordersState:%s%n", ordersNo, ordersState);
	
	OrdersDao.updateOrders(ordersState, ordersNo);
	//수정 완료 시 리스트로 이동
	response.sendRedirect(request.getContextPath()+"/themes/classimax-premium/ordersList.jsp");
%>