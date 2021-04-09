<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "gdu.mall.vo.*" %>
<%@ page import = "gdu.mall.dao.*" %>
<%@ page import ="java.util.*" %>
<%
	request.setCharacterEncoding("utf-8");

	//매니저 등록이 안 되어 있거나 매니저레벨이 1보다 낮은 경우 진입 불가
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null || manager.getManagerLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"themes/classimax-premium/adminIndex.jsp");
		return;
	}
	
	String categoryName=request.getParameter("categoryName");
	String ebookISBN=request.getParameter("ebookISBN");
	String ebookTitle=request.getParameter("ebookTitle");
	String ebookAuthor=request.getParameter("ebookAuthor");
	String ebookCompany=request.getParameter("ebookCompany");
	int ebookPageCount=Integer.parseInt(request.getParameter("ebookPageCount"));
	int ebookPrice=Integer.parseInt(request.getParameter("ebookPrice"));
	String ebookSummary=request.getParameter("ebookSummary");
	//디버깅
	System.out.printf("카테고리이름:%s ISBN:%s 타이틀:%s 저자:%s 출판사:%s 페이지수:%d 가격:%d%n 요약:%s%n", categoryName,ebookISBN,ebookTitle,ebookAuthor,ebookCompany,ebookPageCount,ebookPrice,ebookSummary);
	
	//전처리 (디버깅 하기 편하기 위해 바로 받지 않고 받은 다음 전처리)
	Ebook ebook = new Ebook();
	ebook.setCategoryName(categoryName);
	ebook.setEbookISBN(ebookISBN);
	ebook.setEbookTitle(ebookTitle);
	ebook.setEbookAuthor(ebookAuthor);
	ebook.setEbookCompany(ebookCompany);
	ebook.setEbookPageCount(ebookPageCount);
	ebook.setEbookPrice(ebookPrice);
	ebook.setEbookSummary(ebookSummary);
	
	//중복 ISBN 거르기
	//메서드 변수 선언
	String returnEbookISBN=EbookDao.selectEbookISBN(ebookISBN);
	if(returnEbookISBN!=null){//이미 isbn이 있다면
		System.out.println("존재하는 ISBN");
		response.sendRedirect(request.getContextPath()+"/themes/classimax-premium/ebookList.jsp");
		return;
	}
	//카테고리 미선택 시 오류 메세지 뜨는거 방지
	if(categoryName.equals("")){
		System.out.println("카테고리 미선택");
		response.sendRedirect(request.getContextPath()+"/themes/classimax-premium/insertEbookForm.jsp");
		return;
	}
	EbookDao.insertEbook(ebook);
	
	response.sendRedirect(request.getContextPath()+"/themes/classimax-premium/ebookList.jsp");
	
%>