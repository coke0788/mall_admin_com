<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<%
	//매니저 등록이 안 되어 있거나 매니저레벨이 1보다 낮은 경우 진입 불가
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null || manager.getManagerLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
%>
<meta charset="UTF-8">
<title>ordersList</title>
<%	
	//현재 페이지
	int currentPage=1;
	if(request.getParameter("currentPage")!=null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}	
	//페이지당 보여줄 글 수
	int rowPerPage=5;
	if(request.getParameter("rowPerPage")!=null){
		rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
	}
	//시작 페이지
	int beginRow=(currentPage-1)*rowPerPage;
	//토탈 페이지
	int totalRow=OrdersDao.totalCnt();
	//마지막 페이지
	int lastPage=totalRow/rowPerPage;
	//배열 선언
	ArrayList<OrdersAndEbookAndClient> list = OrdersDao.selectOrdersListByPage(rowPerPage, beginRow);
%>
</head>
	<h1>ordersList</h1>
	<!-- 관리자 메뉴 네비게이션-->
	<div>
		<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
	</div>	
<body>
	<form action="<%=request.getContextPath()%>/orders/ordersList.jsp" method="post">
		<select name="rowPerPage">
	<%
			for(int i=5; i<=20; i+=5){
				if(rowPerPage==i){
	%>
				<option value="<%=i%>" selected="selected"><%=i%></option>
	<%
				}else {
	%>
					<option value="<%=i%>"><%=i%></option>
	<%
				}
			}
	%>
		</select>
		<button type="submit">보기</button>
	</form>
	<table border="1">
		<thead>
			<tr>
				<th>orderNo</th>
				<th>ebookNo</th>
				<th>ebookTitle</th>
				<th>clientNo</th>
				<th>clientMail</th>
				<th>orderDate</th>
				<th>orderState</th>
			</tr>
		</thead>
		<tbody>
	<%
		for(OrdersAndEbookAndClient oec : list) {
	%>
			<tr>
				<td><%=oec.getOrders().getOrdersNo()%></td>
				<td><%=oec.getOrders().getEbookNo()%></td>
				<td>
				<a href="<%=request.getContextPath()%>/ebook/ebookOne.jsp?ebookISBN=<%=oec.getEbook().getEbookISBN()%>"><%=oec.getEbook().getEbookTitle()%></a>
				</td>
				<td><%=oec.getOrders().getClientNo()%></td>
				<td><%=oec.getClient().getClientMail()%></td>
				<td><%=oec.getOrders().getOrdersDate().substring(0,11)%></td>
				<td><form action="<%=request.getContextPath()%>/orders/updateOrdersStateAction.jsp" method="post">
				<input type="hidden" name="ordersNo" value=<%=oec.getOrders().getOrdersNo()%>>
				<%=oec.getOrders().getOrdersState()%>
				<select name="ordersState">
					<option value="">===선택===</option>
					<option value="주문완료">주문완료</option>
					<option value="주문취소">주문취소</option>
				</select>
				<button type="submit">수정</button>
				</form>
				</td>
			</tr>
	<%
		}
	 %>
	 	</tbody>
	</table>
	<!-- 페이징 -->
	<%
		if(currentPage>1){//현재 페이지가 1보다 크면 처음, 이전 출력
	%>
		<a href="<%=request.getContextPath()%>/orders/ordersList.jsp?currentPage=1&rowPerPage=<%=rowPerPage%>"><button>&lt;&lt;처음으로</button></a>
		<a href="<%=request.getContextPath()%>/orders/ordersList.jsp?currentPage=<%=currentPage-1%>&rowPerPage=<%=rowPerPage%>"><button><%=currentPage-1%></button></a>
	<%
		}
		if(currentPage<lastPage){//현재 페이지가 마지막 페이지보다 작으면 다음, 끝으로 출력
	%>
			<button type=button><%=currentPage%></button>
			<a href="<%=request.getContextPath()%>/orders/ordersList.jsp?currentPage=<%=currentPage+1%>&rowPerPage=<%=rowPerPage%>">
			<button type = button><%=currentPage+1%></button></a>
			<a href="<%=request.getContextPath()%>/orders/ordersList.jsp?currentPage=<%=lastPage%>&rowPerPage=<%=rowPerPage%>">
			<button type = button>끝으로 &gt;&gt;</button></a>	
	<%
		//라스트페이지일 때 현재 페이지는 출력 되어야 하기 때문에 코드 추가
		} else if(currentPage==lastPage){
	%>
			<button type=button><%=currentPage%></button>
	<%
		}
	%>
</body>
</html>