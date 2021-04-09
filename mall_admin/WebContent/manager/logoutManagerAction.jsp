<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	session.invalidate(); //기존 세션을 초기화하는 메서드 
	response.sendRedirect(request.getContextPath()+"/themes/classimax-premium/adminIndex.jsp"); //adminindex로 이동요청
%>