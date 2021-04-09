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
	request.setCharacterEncoding("utf-8");
	//수집
	String categoryName=request.getParameter("categoryName");
	int categoryWeight=Integer.parseInt(request.getParameter("categoryWeight"));
	
	System.out.println("입력 카테고리 이름 : "+categoryName);
	System.out.println("입력 카테고리 가중치 : "+categoryWeight);
	//중복된 이름 확인
	String returnCategoryName = CategoryDao.selectCategoryName(categoryName);
	if(returnCategoryName!=null){ //아이디가 존재한 경우 바로 리스트로
		System.out.println("사용중인 이름");
		response.sendRedirect(request.getContextPath()+"/themes/classimax-premium/categoryList.jsp");
		return;
	}
	//위에서 중복검사에 걸리지 않은 경우 dao 입력 메서드 호출
	CategoryDao.insertCategory(categoryName, categoryWeight);
	//등록 완료 시 매니저리스트로 바로 이동
	response.sendRedirect(request.getContextPath()+"/themes/classimax-premium/categoryList.jsp");
	
%>