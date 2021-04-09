<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "gdu.mall.dao.*" %>
<%@ page import = "gdu.mall.vo.*" %>
<%
	//매니저 등록이 안 되어 있거나 매니저레벨이 1보다 낮은 경우 진입 불가
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null || manager.getManagerLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/themes/classimax-premium/adminIndex.jsp");
		return;
	}
	//넘버, 가중치 가져오기
	int categoryWeight = Integer.parseInt(request.getParameter("categoryWeight"));
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	//dao 수정 메소드
	CategoryDao.updateCategory(categoryWeight, categoryNo);
	System.out.println("카테고리 수정 넘버 :" + categoryNo);
	System.out.println("카테고리 수정 가중치 :" + categoryWeight);
	//수정 완료 시 리스트로 이동 요청
	response.sendRedirect(request.getContextPath()+"/themes/classimax-premium/categoryList.jsp");
%>