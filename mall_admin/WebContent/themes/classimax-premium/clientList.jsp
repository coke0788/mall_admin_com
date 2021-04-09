<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "gdu.mall.vo.*" %>
<%@ page import = "gdu.mall.dao.*" %>
<%@ page import = "java.util.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>

  <!-- SITE TITTLE -->
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>clientList</title>
  
  <!-- FAVICON -->
  <link href="img/favicon.png" rel="shortcut icon">
  <!-- PLUGINS CSS STYLE -->
  <!-- <link href="plugins/jquery-ui/jquery-ui.min.css" rel="stylesheet"> -->
  <!-- Bootstrap -->
  <link rel="stylesheet" href="plugins/bootstrap/css/bootstrap.min.css">
  <link rel="stylesheet" href="plugins/bootstrap/css/bootstrap-slider.css">
  <!-- Font Awesome -->
  <link href="plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet">
  <!-- Owl Carousel -->
  <link href="plugins/slick-carousel/slick/slick.css" rel="stylesheet">
  <link href="plugins/slick-carousel/slick/slick-theme.css" rel="stylesheet">
  <!-- Fancy Box -->
  <link href="plugins/fancybox/jquery.fancybox.pack.css" rel="stylesheet">
  <link href="plugins/jquery-nice-select/css/nice-select.css" rel="stylesheet">
  <!-- CUSTOM CSS -->
  <link href="css/style.css" rel="stylesheet">


  <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
  <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
  <!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
  <![endif]-->

</head>

<body class="body-wrapper">

<!-- 네비게이션 바 부분 -->
<section>
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<nav class="navbar navbar-expand-lg navbar-light navigation">
					<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
					 aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
						<span class="navbar-toggler-icon"></span>
					</button>
					<div class="collapse navbar-collapse" id="navbarSupportedContent">
						<ul class="navbar-nav ml-auto main-nav ">
							<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
						</ul>
					<%
						//관리자 진입 조건 설정
						Manager manager = (Manager)session.getAttribute("sessionManager"); //manager 사용하기 위해서 불러오기.
						if(manager == null || manager.getManagerLevel()<1){ //만약 session manager가 null인 경우 admin index로 이동
							response.sendRedirect(request.getContextPath()+"/themes/classimax-premium/adminIndex.jsp");
							return;
						}
						//현재 페이지
						int currentPage=1;
						if(request.getParameter("currentPage")!=null){
							currentPage = Integer.parseInt(request.getParameter("currentPage"));
						}
						//페이지 당 row
						int rowPerPage = 10;
						if(request.getParameter("rowPerPage")!=null){
							rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
						}
						//검색어 변수 선언
						String searchWord = "";
						//검색어가 넘어오면
						if(request.getParameter("searchWord")!=null){
							searchWord = request.getParameter("searchWord");
						}
						//시작 행
						int beginRow = (currentPage-1) * 10;		
						//전체 행과 마지막 페이지
						int totalRow = ClientDao.totalCount(searchWord);
						int lastPage = totalRow/rowPerPage;
						if(totalRow % rowPerPage != 0) {
							lastPage += 1; //totalrow를 rowperpage로 나눴을때 나머지가 0이 아니면 라스트 페이지에 1을 더한다.
						}
						
						//ClientDao 클래스에서 배열 받아오기
						ArrayList<Client> list = ClientDao.selectClientListByPage(rowPerPage, beginRow, searchWord);
					%>
						<ul class="navbar-nav ml-auto mt-10">
							<li class="nav-item">
								<a class="nav-link login-button" href="<%=request.getContextPath()%>/manager/logoutManagerAction.jsp">Logout</a>
							</li>
						</ul>
					</div>
				</nav>
			</div>
		</div>
	</div>
</section>
<!--==================================
=            User Profile            =
===================================-->
<section class="dashboard section">
	<!-- Container Start -->
	<div class="container text-center">
		<!-- Row Start -->
		<div class="row">
			<div class="col-md-10 offset-md-1 col-lg-8 offset-lg-2">
				<div class="sidebar">
						<!-- User Name -->
						<h5 class="text-center"><%=manager.getManagerName()%></h5>
						<p>Level : <%=manager.getManagerLevel()%></p>
					</div>
				</div>
			<div class="col-md-2 offset-md-1 col-lg-8 offset-lg-2">
				<!-- manager list -->
				<div class="widget dashboard-container">
					<h3 class="widget-header">Client List</h3>
								<!-- 페이지 개수 보기 -->
					<div class="col-md-2 offset-md-2 col-lg-5 offset-lg-0" style="width:29%">
					<form action="<%=request.getContextPath()%>/themes/classimax-premium/clientList.jsp" method="post">
						<!-- 히든값으로 searchword 넘기기 -->
						<input type= "hidden" name="searchWord" value="<%=searchWord%>">
						<select name="rowPerPage" style="width:100px;height:22px; font-size:12px;">
						<%
							for(int i=10; i<=30; i+=5){
								//rowPerPage가 i일 경우 i를 선택되도록 하는 코드
								if(rowPerPage==i){
						%>
									<option value="<%=i%>" selected="selected"><%=i%></option>
						<%
								} else{
						%>
									<option value="<%=i%>"><%=i%></option>
						<%	
							}
						}
						%>
						</select>
						<button type="submit" class="btn btn-main-sm">보기</button>
					</form>
					</div>
					<table class="table">
						<thead>
							<tr>
								<th class="text-center">Mail</th>
								<th class="text-center">Date</th>
								<th class="text-center">Action</th>
							</tr>
						</thead>
						<tbody>
						<%
							for(Client c : list) {
						%>
							<tr>
								<td class="product-category"><%=c.getClientMail()%></td>
								<td class="product-category"><%=c.getClientDate().substring(0,11)%></td>
								<td class="text-center" style="width: 8.33%">
									<div class="justify-content-center">
										<a data-toggle="tooltip" data-placement="top" title="Modify" href="<%=request.getContextPath()%>/themes/classimax-premium/updateClientForm.jsp?clientMail=<%=c.getClientMail()%>">
											<i class="fa fa-edit"></i>
										</a>
										<a data-toggle="tooltip" data-placement="top" title="Delete" class="delete" href="<%=request.getContextPath()%>/client/deleteClientAction.jsp?clientMail=<%=c.getClientMail()%>">
											<i class="fa fa-trash"></i>
										</a>
									</div>
								</td>
							</tr>
							<%
							}
							%>
						</tbody>
					</table>
				</div>
		<!-- pagination -->
		
		<div class="pagination justify-content-center">
			<nav aria-label="Page navigation example">
				<ul class="pagination">
				<%
				if(currentPage>1 && currentPage<lastPage){ //현재페이지가 1보다 크고 라스트페이지보다 작으면 처음, 이전, 현재, 다음, 끝 표시.
				%>
					<li class="page-item">
						<a class="page-link" href="<%=request.getContextPath()%>/themes/classimax-premium/clientList.jsp?currentPage=1&rowPerPage=<%=rowPerPage%>&searchWord=<%=searchWord%>" aria-label="Previous">
							<span aria-hidden="true">&laquo;</span>
							<span class="sr-only">Previous</span>
						</a>
					</li>
					<li class="page-item">
						<a class="page-link" href="<%=request.getContextPath()%>/themes/classimax-premium/clientList.jsp?currentPage=<%=currentPage-1%>&rowPerPage=<%=rowPerPage%>&searchWord=<%=searchWord%>">
						<%=currentPage-1%></a>
					</li>
					<li class="page-item active"><a class="page-link" href=""><%=currentPage%></a></li>
				<%
				} else if(currentPage==1){//현재페이지가 1이면 현재, 다음, 끝 표시
				%>
					<li class="page-item active"><a class="page-link" href=""><%=currentPage%></a></li>
				<%
				} else if(currentPage>=lastPage){ //현재페이지가 라스트페이지이면 처음, 이전, 현재 표시
				%>
					<li class="page-item">
						<a class="page-link" href="<%=request.getContextPath()%>/themes/classimax-premium/clientList.jsp?currentPage=1&rowPerPage=<%=rowPerPage%>&searchWord=<%=searchWord%>" aria-label="Previous">
							<span aria-hidden="true">&laquo;</span>
							<span class="sr-only">Previous</span>
						</a>
					</li>
					<li class="page-item">
						<a class="page-link" href="<%=request.getContextPath()%>/themes/classimax-premium/clientList.jsp?currentPage=<%=currentPage-1%>&rowPerPage=<%=rowPerPage%>&searchWord=<%=searchWord%>">
						<%=currentPage-1%></a>
					</li>
					<li class="page-item active"><a class="page-link" href=""><%=currentPage%></a></li>
				<%
				}
				if(currentPage<lastPage) {
				%>
					<li class="page-item">
					<a class="page-link" href="<%=request.getContextPath()%>/themes/classimax-premium/clientList.jsp?currentPage=<%=currentPage+1%>&rowPerPage=<%=rowPerPage%>&searchWord=<%=searchWord%>">
					<%=currentPage+1%></a>
				</li>
				<li class="page-item">
					<a class="page-link" href="<%=request.getContextPath()%>/themes/classimax-premium/clientList.jsp?currentPage=<%=lastPage%>&rowPerPage=<%=rowPerPage%>&searchWord=<%=searchWord%>" aria-label="Next">
						<span aria-hidden="true">&raquo;</span>
						<span class="sr-only">Next</span>
					</a>
				<%
				} else {
				}
				%>
				</ul>
			</nav>
		</div>
			<!-- /pagination -->
			<!-- search widget -->
		<hr>
			<div class="widget search">
			<form action="<%=request.getContextPath()%>/themes/classimax-premium/clientList.jsp" method="post">
				<!-- 히든값으로 rowperpage 넘기기. 페이지이동 시 검색어를 함께 넘겨서 연동하기 위해 -->
				<input type="hidden" name="rowPerPage" value="<%=rowPerPage%>">
					<div class="input-group">
						<input type="text" class="form-control" name="searchWord" placeholder="Search client mail">
						<span class="input-group-addon">
						<button type="submit" class="btn btn-main-sm"><i class="fa fa-search"></i></button></span>
					</div>
			</form>
			</div>
		</div>
	</div>
		<!-- Row End -->
</div>
	<!-- Container End -->
</section>
<!--============================
=            Footer            =
=============================-->

<footer class="footer section section-sm">
  <!-- Container End -->
</footer>
<!-- Footer Bottom -->
<footer class="footer-bottom">
  <!-- Container Start -->
  <div class="container">
    <div class="row">
      <div class="col-sm-6 col-12">
        <!-- Copyright -->
        <div class="copyright">
          <p>Copyright HyeyoungNK© <script>
              var CurrentYear = new Date().getFullYear()
              document.write(CurrentYear)
            </script>. All Rights Reserved, theme by <a class="text-primary" href="https://themefisher.com" target="_blank">themefisher.com</a></p>
        </div>
      </div>
      <div class="col-sm-6 col-12">
      </div>
    </div>
  </div>
  <!-- Container End -->
  <!-- To Top -->
  <div class="top-to">
    <a id="top" class="" href="#"><i class="fa fa-angle-up"></i></a>
  </div>
</footer>

<!-- JAVASCRIPTS -->
<script src="plugins/jQuery/jquery.min.js"></script>
<script src="plugins/bootstrap/js/popper.min.js"></script>
<script src="plugins/bootstrap/js/bootstrap.min.js"></script>
<script src="plugins/bootstrap/js/bootstrap-slider.js"></script>
  <!-- tether js -->
<script src="plugins/tether/js/tether.min.js"></script>
<script src="plugins/raty/jquery.raty-fa.js"></script>
<script src="plugins/slick-carousel/slick/slick.min.js"></script>
<script src="plugins/jquery-nice-select/js/jquery.nice-select.min.js"></script>
<script src="plugins/fancybox/jquery.fancybox.pack.js"></script>
<script src="plugins/smoothscroll/SmoothScroll.min.js"></script>
<!-- google map -->
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCcABaamniA6OL5YvYSpB3pFMNrXwXnLwU&libraries=places"></script>
<script src="plugins/google-map/gmap.js"></script>
<script src="js/script.js"></script>

</body>
</html>