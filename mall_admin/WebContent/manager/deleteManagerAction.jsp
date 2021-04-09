<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "gdu.mall.vo.*" %>
<%@ page import = "gdu.mall.dao.*" %>
<%
Manager manager = (Manager)session.getAttribute("sessionManager");
if(manager == null){ //만약 session manager가 null인 경우 admin index로 이동
	response.sendRedirect(request.getContextPath()+"/themes/classimax-premium/adminIndex.jsp");
	return;
} else if(manager.getManagerLevel() < 2){ //메니저 레벨이 2보다 낮은 경우 managerList 화면 유지
	response.sendRedirect(request.getContextPath()+"/themes/classimax-premium/managerList.jsp");
	return;
}
	
	//넘버 받아오기
	/*
	int 값타입 변수를 받아와야하는데 getParameter메소드는 String(참조) 타입으로 리턴. 그러므로 int 타입으로 변환을 시켜줘야 한다.
	Integer클래스의 parseInt메소드를 사용하면 값을 리턴받아 int 타입으로 저장할 수가 있음
	*/
	int managerNo = Integer.parseInt(request.getParameter("managerNo"));
	
	//dao 삭제 메서드 호출 코드 구현
	ManagerDao.deleteManager(managerNo);
	System.out.println("manager No :"+managerNo);
	
	//삭제완료시 매니저리스트로 이동
	response.sendRedirect(request.getContextPath()+"/themes/classimax-premium/managerList.jsp");
%>