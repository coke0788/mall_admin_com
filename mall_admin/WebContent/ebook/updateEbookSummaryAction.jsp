<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="gdu.mall.dao.EbookDao"%>
<%@ page import = "gdu.mall.vo.*" %>
<!DOCTYPE html>
<%
	//매니저 등록이 안 되어 있거나 매니저레벨이 1보다 낮은 경우 진입 불가
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null || manager.getManagerLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/themes/classimax-premium/adminIndex.jsp");
		return;
	}
	request.setCharacterEncoding("utf-8");
	String ebookISBN=request.getParameter("ebookISBN");
	String ebookSummary=request.getParameter("ebookSummary");
	System.out.printf("ISBN:%s 요약:%s%n", ebookISBN, ebookSummary);
	
	Ebook ebook=new Ebook();
	ebook.setEbookISBN(ebookISBN);
	ebook.setEbookSummary(ebookSummary);
	EbookDao.updateEbookSummary(ebook);
	response.sendRedirect(request.getContextPath()+"/themes/classimax-premium/ebookOne.jsp?ebookISBN="+ebook.getEbookISBN());
%>