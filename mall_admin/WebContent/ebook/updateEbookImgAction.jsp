<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "gdu.mall.vo.*" %>
<%@ page import = "gdu.mall.dao.*" %>
<%@ page import = "com.oreilly.servlet.MultipartRequest" %>
<%@ page import = "com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%
	//매니저 등록이 안 되어 있거나 매니저레벨이 1보다 낮은 경우 진입 불가
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null || manager.getManagerLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/themes/classimax-premium/adminIndex.jsp");
		return;
	}
	//reguestgetparameter로 받으면 null로 나옴. enctype을 multipartformdata로 넘겼기 때문에
	//파일을 다운로드 받을 위치 설정
	// String path = application.getRealPath("img"); //application=톰캣, img라는 폴더를 찾아서 경로를 가져와라
	String path= application.getRealPath("img");
	System.out.println(path); //경로 확인
	
	int size=1024 * 1024 * 100;
	//enctype이 multipartformdata인 경우 멀티파트 변수를 생성. 첫번째 매개변수는 해석을 위임 받음. 두번쨰 매개변수에 경로를 받음. 세번쨰:파일 크기를 얼마나 허락할지(byte), 네번째:인코딩, 다섯번째:중복된 이름이 있으면 어떻게 할지.
	MultipartRequest multi = new MultipartRequest(request, path, size, "utf-8", new DefaultFileRenamePolicy());
	//requestgetparameter와 비슷한 용도인데 mutipartformdata를 사용할 때 받는
	String ebookISBN = multi.getParameter("ebookISBN");
	String ebookImg = multi.getFilesystemName("ebookImg");
	System.out.println(ebookISBN);
	System.out.println(ebookImg);
	
	Ebook ebook=new Ebook();
	ebook.setEbookISBN(ebookISBN);
	ebook.setEbookImg(ebookImg);
	EbookDao.updateEbookImg(ebook);
	//등록 완료 되면 상세페이지로 이동
	response.sendRedirect(request.getContextPath()+"/themes/classimax-premium/ebookOne.jsp?ebookISBN="+ebook.getEbookISBN());
%>