<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="java.util.*" %>
<%
	//매니저 등록이 안 되어 있거나 매니저레벨이 1보다 낮은 경우 진입 불가
	Manager manager = (Manager)session.getAttribute("sessionManager");
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
	request.setCharacterEncoding("utf-8");
	//form에 있는 값 받아오게 변수 설정 > 디버깅 > dao에서 받아올 수 있도록 설정 > dao 메서드 실행 > 완료하면 리스트로 이동
	//form에서 받아온 값 넣을 변수선언
	String noticeTitle=request.getParameter("noticeTitle");
	String noticeContent=request.getParameter("noticeContent");
	String managerId=request.getParameter("managerId");
	//디버깅
	System.out.printf("타이틀:%s, 내용:%s, id:%s%n", noticeTitle, noticeContent, managerId);
	Notice notice=new Notice();
	notice.setNoticeTitle(noticeTitle);
	notice.setNoticeContent(noticeContent);
	notice.setManagerId(managerId);
	//dao 메서드 실행
	NoticeDao.insertNotice(notice);
	//완료 후 이동
	response.sendRedirect(request.getContextPath()+"/themes/classimax-premium/noticeList.jsp");
	
%>