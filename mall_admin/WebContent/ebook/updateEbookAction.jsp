<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="gdu.mall.dao.*"%>
<%@page import="gdu.mall.vo.*"%>
<%@page import="java.util.*" %>
<%

	//매니저 등록이 안 되어 있거나 매니저레벨이 1보다 낮은 경우 진입 불가
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null || manager.getManagerLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/themes/classimax-premium/adminIndex.jsp");
		return;
	}
	request.setCharacterEncoding("utf-8");
	String ebookState=request.getParameter("ebookState");
	String ebookISBN=request.getParameter("ebookISBN");
	String categoryName=request.getParameter("categoryName");
	String ebookTitle=request.getParameter("ebookTitle");
	String ebookAuthor=request.getParameter("ebookAuthor");
	String ebookCompany=request.getParameter("ebookCompany");
	int ebookPageCount=Integer.parseInt(request.getParameter("ebookPageCount"));
	int ebookPrice=Integer.parseInt(request.getParameter("ebookPrice"));
	String ebookSummary=request.getParameter("ebookSummary");
	//디버깅
	System.out.printf("상태:%s 카테고리이름:%s ISBN:%s 타이틀:%s 저자:%s 출판사:%s 페이지수:%d 가격:%d%n 요약:%s%n", ebookState, categoryName,ebookISBN,ebookTitle,ebookAuthor,ebookCompany,ebookPageCount,ebookPrice,ebookSummary);
	
	Ebook ebook=new Ebook();
	ebook.setEbookState(ebookState);
	ebook.setCategoryName(categoryName);
	ebook.setEbookISBN(ebookISBN);
	ebook.setEbookTitle(ebookTitle);
	ebook.setEbookAuthor(ebookAuthor);
	ebook.setEbookCompany(ebookCompany);
	ebook.setEbookPageCount(ebookPageCount);
	ebook.setEbookPrice(ebookPrice);
	ebook.setEbookSummary(ebookSummary);
	
	//미선택 시 오류 메세지 뜨는거 방지
	if(ebookState.equals("") || categoryName.equals("")){
		System.out.println("상태 또는 카테고리 미선택");
		response.sendRedirect(request.getContextPath()+"/themes/classimax-premium/updateEbookForm.jsp?ebookISBN="+ebook.getEbookISBN());
		return;
	}
	
	//수정 메서드
	EbookDao.updateEbook(ebook);

	//수정 완료 시 ebookOne으로 이동
	response.sendRedirect(request.getContextPath()+"/themes/classimax-premium/ebookOne.jsp?ebookISBN="+ebook.getEbookISBN());
	
%>