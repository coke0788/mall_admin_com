<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="gdu.mall.dao.*"%>
<%@page import = "gdu.mall.vo.*" %>
<%
	//매니저 등록이 안 되어 있거나 매니저레벨이 1보다 낮은 경우 진입 불가
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null || manager.getManagerLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/themes/classimax-premium/adminIndex.jsp");
		return;
	}

	request.setCharacterEncoding("utf-8");
	//isbn 받아오기
	Ebook ebook = new Ebook();
	String ebookISBN=request.getParameter("ebookISBN");
	
	//ebook의 ebookISBN에 받아온 ebookISBN을 넣는다. -> 이게 없으면 ebookISBN이 null로 넘어옴.
	ebook.setEbookISBN(ebookISBN);
	//삭제 메서드
	EbookDao.deleteEbook(ebook);
	System.out.println("ISBN:"+ebookISBN);
	
	response.sendRedirect(request.getContextPath()+"/themes/classimax-premium/ebookList.jsp");
%>
