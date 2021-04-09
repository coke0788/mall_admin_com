<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "gdu.mall.dao.*" %>
<%@ page import = "gdu.mall.vo.*" %>
<%
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null){ //만약 session manager가 null인 경우 admin index로 이동
		response.sendRedirect(request.getContextPath()+"/themes/classimax-premium/adminIndex.jsp");
		return;
	} else if(manager.getManagerLevel() < 2){ //메니저 레벨이 2보다 낮은 경우에도 clientList로 이동하도록.
		response.sendRedirect(request.getContextPath()+"/themes/classimax-premium/clientList.jsp");
		return;
	}
	//클라이언트메일 받아오기
	String clientMail = request.getParameter("clientMail");
	
	ClientDao.deleteClient(clientMail);
	System.out.println("client mail : " +clientMail);
	
	//다 끝나면 클ㄹ라이언트 리스트로
	response.sendRedirect(request.getContextPath()+"/themes/classimax-premium/clientList.jsp");

%>