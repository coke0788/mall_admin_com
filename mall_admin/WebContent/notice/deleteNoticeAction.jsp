<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "gdu.mall.vo.*" %>
<%@ page import = "gdu.mall.dao.*" %>
<%
	//임포트 > 변수선언(no) > 삭제 deo 메서드 실행 > 이동
	request.setCharacterEncoding("utf-8");
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
	int noticeNo=Integer.parseInt(request.getParameter("noticeNo"));
	//공지글에 댓글이 있는지 확인하는 메서드를 실행시킴. (리턴값은 값타입이다.)
	int rowCnt=CommentDao.selectCommentCnt(noticeNo);
	if(rowCnt!=0){ //리턴값이 0이 아니면
		System.out.println(noticeNo+"공지글의 댓글이" +rowCnt+"개 있습니다.");
		response.sendRedirect(request.getContextPath()+"/themes/classimax-premium/noticeOne.jsp?noticeNo="+noticeNo);
		return;
	}
	//삭제 메서드 호출
	NoticeDao.deleteNotice(noticeNo);
	System.out.println("넘버:"+noticeNo+"삭제!");
	response.sendRedirect(request.getContextPath()+"/themes/classimax-premium/noticeList.jsp");
%>	