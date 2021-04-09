<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="java.util.*" %>
<%
	request.setCharacterEncoding("utf-8");
	//매니저 등록이 안 되어 있거나 매니저레벨이 1보다 낮은 경우 진입 불가
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null || manager.getManagerLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/themes/classimax-premium/adminIndex.jsp");
		System.out.println("레벨이 1보다 낮습니다.");
		return;
	}
	int commentNo=Integer.parseInt(request.getParameter("commentNo"));
	int noticeNo=Integer.parseInt(request.getParameter("noticeNo"));
	String managerId=manager.getManagerId();
	
	if(manager.getManagerLevel()>1){
		CommentDao.deleteComment(commentNo);
	} else if(manager.getManagerLevel()>0){//comment no와 manager id 받아오기
		CommentDao.deleteComment(commentNo, managerId);
	}
	System.out.printf("commentNo:%d, managerid:%s, noticeNo:%d%n", commentNo, managerId, noticeNo);
	response.sendRedirect(request.getContextPath()+"/themes/classimax-premium/noticeOne.jsp?noticeNo="+noticeNo);
%>