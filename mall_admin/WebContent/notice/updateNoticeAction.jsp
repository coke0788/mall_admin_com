<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="gdu.mall.vo.*" %>
<%
	Manager manager = (Manager)session.getAttribute("sessionManager");
	//매니저 등록이 안 되어 있거나 매니저레벨이 1보다 낮은 경우 진입 불가
	if(manager == null || manager.getManagerLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/themes/classimax-premium/adminIndex.jsp");
		System.out.println("레벨이 1보다 낮습니다.");
		return;
	}
	//매니저 레벨이 1인 경우 리스트로 재이동
	if(manager.getManagerLevel()==1){
		response.sendRedirect(request.getContextPath()+"/themes/classimax-premium/noticeList.jsp");
		System.out.println("레벨이 1입니다.");
		return;
	}
	//임포트 > 변수선언 및 form에서 가져오기 > dao로 보내기 > dao 실행
	request.setCharacterEncoding("utf-8");
	String noticeTitle=request.getParameter("noticeTitle");
	String noticeContent=request.getParameter("noticeContent");
	int noticeNo=Integer.parseInt(request.getParameter("noticeNo"));
	
	Notice notice=new Notice();
	notice.setNoticeTitle(noticeTitle);
	notice.setNoticeContent(noticeContent);
	notice.setNoticeNo(noticeNo);
	NoticeDao.updateNotice(notice);
	System.out.printf("title=%s, content=%s", noticeTitle, noticeContent);
	
	response.sendRedirect(request.getContextPath()+"/themes/classimax-premium/noticeOne.jsp?noticeNo="+noticeNo);
	
%>