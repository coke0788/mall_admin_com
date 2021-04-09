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
	//넘버 받아오기
	int categoryNo= Integer.parseInt(request.getParameter("categoryNo"));
	
	//dao 삭제 메서드
	CategoryDao.deleteCategory(categoryNo);
	System.out.println("카테고리 삭제 넘버 :"+categoryNo);
	
	//삭제 완료 시 리스트로 이동
	response.sendRedirect(request.getContextPath()+"/themes/classimax-premium/categoryList.jsp");
%>