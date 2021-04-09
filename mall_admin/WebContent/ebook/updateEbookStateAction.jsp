<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="gdu.mall.dao.EbookDao"%>
<%@page import = "gdu.mall.vo.*" %>
<%

	//매니저 등록이 안 되어 있거나 매니저레벨이 1보다 낮은 경우 진입 불가
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null || manager.getManagerLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/themes/classimax-premium/adminIndex.jsp");
		return;
	}

	request.setCharacterEncoding("utf-8");
	String ebookISBN=request.getParameter("ebookISBN");
	String ebookState=request.getParameter("ebookState");
	System.out.printf("ISBN:%s 상태:%s%n", ebookISBN, ebookState);
	
	Ebook ebook=new Ebook();
	ebook.setEbookISBN(ebookISBN);
	ebook.setEbookState(ebookState);
	
	//미선택 시 오류 메세지 뜨는거 방지
	if(ebookState.equals("")){
		System.out.println("상태 미선택");
		response.sendRedirect(request.getContextPath()+"/themes/classimax-premium/updateEbookStateForm.jsp?ebookISBN="+ebook.getEbookISBN());
		return;
	}
	
	//updateebookstate 메서드 호출
	EbookDao.updateEbookState(ebook);
	
	response.sendRedirect(request.getContextPath()+"/themes/classimax-premium/ebookOne.jsp?ebookISBN="+ebook.getEbookISBN());
%>
