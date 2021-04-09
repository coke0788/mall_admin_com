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
  <title>adminIndex</title>
  
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
<section>
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<nav class="navbar navbar-expand-lg navbar-light navigation">
					<a class="navbar-brand" href="">
						<img src="images/booklogo.png" width="100" height="80">
					</a>
					<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
					 aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
						<span class="navbar-toggler-icon"></span>
					</button>
					<div class="collapse navbar-collapse" id="navbarSupportedContent">
						<ul class="navbar-nav ml-auto main-nav ">
							<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
						</ul>
					<%
						// getParameter : String 타입 리턴, getAttribute : Object 타입을 리턴
						// loginManagerAction.jsp에서 session에 저장한 매니저 값을 얻어서 object 타입으로 리턴. 리턴 값을 Manager로 형변환 
						Manager manager = (Manager)session.getAttribute("sessionManager"); //manager 사용하기 위해서 불러오기.
						if(session.getAttribute("sessionManager")==null){
					%>
						<ul class="navbar-nav ml-auto mt-10">
							<li class="nav-item">
							</li>
						</ul>
					<%
						} else {
					%>
						<ul class="navbar-nav ml-auto mt-10">
							<li class="nav-item">
								<a class="nav-link login-button" href="<%=request.getContextPath()%>/manager/logoutManagerAction.jsp">Logout</a>
							</li>
						</ul>
					<%
						}
					 %>
					</div>
				</nav>
			</div>
		</div>
	</div>
</section>

<!--===============================
=            Hero Area          
=		여기에 로그인 메뉴를 넣을거임		
================================-->

<section class="hero-area bg-1 text-center overly">
	<!-- Container Start -->
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<!-- Header Contetnt -->
				<div class="content-block">
					<h1>HYBOOKS MANAGEMENT SERVICE PAGE</h1>
					<p>Welcome to come into our management page. <br> if you didn't login or register as manager, <br> look at below! </p>
					<div class="short-popular-category-list text-center">
						<h2>▼ NOW WAITING APPLYING ▼</h2>
						<table class="col-lg-12 col-md-12 align-content-center text-white">
							<thead>
								<tr>
									<th>Manager ID</th>
									<th>Registered Date</th>
								</tr>
							</thead>
							<tbody>
<%
								//ArrayList타입(참조타입) list 선언, 값은 ManagerDao의 selectManagerList... 메소드를 저장.
								ArrayList<Manager> list = ManagerDao.selectManagerListByZero();
								for(Manager m : list){ //for each문. 읽기 전용. list의 값들을 반복해서 m에 저장.
%>
								<tr>
									<!-- 위에서 list의 값들을 m에 다 저장했으므로 m의 ManagerId..를 불러온다. -->
									<td><%=m.getManagerId()%></td>
									<!-- substring은 괄호 안의 첫번째 값부터 두번째 값의 수만큼 출력함. 두번째 값의 수보다 적은 글자가 존재하면 오류 발생. -->
									<td><%=m.getManagerDate().substring(0,11)%></td>
								</tr>
<%
								}
%>
			</tbody>
						</table>
					</div>
				</div>
				<!-- Advance Search -->
				<div class="advance-search">
					<div class="container">
						<div class="row justify-content-center">
							<div class="col-lg-12 col-md-12 align-content-center">
							<%
								//로그인 폼
								if(session.getAttribute("sessionManager")==null) {
							%>
									<form action="<%=request.getContextPath()%>/manager/loginManagerAction.jsp" method="post">
										<div class="form-row">
											<div class="form-group col-md-4">
												<input type="text" class="form-control my-2 my-lg-1" name="managerId" placeholder="input your id" required pattern="^[A-Za-z0-9]+$">
											</div>
											<div class="form-group col-md-4">
												<input type="password" class="form-control my-2 my-lg-1" name="managerPw" placeholder="input your password" required pattern="^[A-Za-z0-9]{4,16}$">
											</div>
											<div class="form-group col-md-3 align-self-center">
												<button type="submit" class="btn btn-primary">Login</button>
											</div>
											<div class="form-group align-self-center">
												<a href="<%=request.getContextPath()%>/themes/classimax-premium/insertManagerForm.jsp"><button type="button" class="btn btn-secondary"> ▶REGISTER</button></a>
											</div>
										</div>
									</form>
							<%
								} else {
							%>
									<div>
										<h2>Welcome, <%=manager.getManagerName()%>! </h2>
										<h4>management level : <%=manager.getManagerLevel() %></h4>
									</div>
<%
									}
%>
								</div>
							</div>
					</div>
				</div>
				
			</div>
		</div>
	</div>
	<!-- Container End -->
</section>

<!--==========================================
=            All Category Section
 			여기에 관리자 메뉴 미리보기		         =
===========================================-->
<%
if(session.getAttribute("sessionManager")==null || manager.getManagerLevel()==0){
} else {
	ArrayList<Notice> noticeList = NoticeDao.selectNoticeList(4, 0, "");
	ArrayList<Manager> managerList = ManagerDao.selectManagerList(4, 0);
	ArrayList<Client> clientList = ClientDao.selectClientListByPage(3, 0, "");
	ArrayList<Ebook> ebookList = EbookDao.selectEbookList(4, 0, "");
	ArrayList<OrdersAndEbookAndClient> oecList = OrdersDao.selectOrdersListByPage(4, 0);
		
%>
<section class=" section">
	<!-- Container Start -->
	<div class="container">
		<div class="row">
			<div class="col-12">
				<!-- Section title -->
				<div class="section-title">
					<h2>All Menu</h2>
					<p>Showing All menu of management services. if you want to look at detail, please click the 'more'!</p>
				</div>
				<div class="row">
					<!-- 공지 -->
					<div class="col-lg-3 offset-lg-1 col-md-5 offset-md-1 col-sm-5 col-5">
						<div class="category-block">
							<div class="header">
								<i class="fa fa-bell icon-bg-1"></i> 
								<h4>NOTICE&nbsp;</h4>
							</div>
							<ul class="category-list" >
							<%
								for(Notice n : noticeList) {
							%>
									<li><a href="<%=request.getContextPath()%>/themes/classimax-premium/noticeOne.jsp?noticeNo=<%=n.getNoticeNo()%>"><%=n.getNoticeTitle()%></a></li>
							<%
								}
							%>
								<li><a class="text-right" href="<%=request.getContextPath()%>/themes/classimax-premium/noticeList.jsp"><i class="fa fa-caret-right"></i>more</a></li>
							</ul>
						</div><!-- /공지 -->
					</div> <!-- 관리자 -->
					<!-- Category list -->
					<div class="col-lg-3 offset-lg-0 col-md-5 offset-md-1 col-sm-6 col-6">
						<div class="category-block">
							<div class="header">
								<i class="fa fa-laptop icon-bg-2"></i> 
								<h4>MANAGERS</h4>
							</div>
							<ul class="category-list" >
							<%
								for(Manager m : managerList) {
							%>
									<li><%=m.getManagerLevel()%> l <%=m.getManagerId()%></li>
							<%
								}
							%>
								<li><a class="text-right" href="<%=request.getContextPath()%>/themes/classimax-premium/managerList.jsp"><i class="fa fa-caret-right"></i>more</a></li>
							</ul>
						</div> <!-- /관리자 -->
					</div> <!-- 고객 -->
					<div class="col-lg-4 offset-lg-0 col-md-5 offset-md-2 col-sm-6 col-6">
						<div class="category-block">
							<div class="header">
								<i class="fa fa-briefcase icon-bg-3"></i> 
								<h4>Clients</h4>
							</div>
							<ul class="category-list" >
							<%
								for(Client c : clientList) {
							%>
									<li><%=c.getClientMail()%> <br> l <%=c.getClientDate().substring(0,11)%></li>
							<%
								}
							%>
								<li><a class="text-right" href="<%=request.getContextPath()%>/themes/classimax-premium/clientList.jsp"><i class="fa fa-caret-right"></i>more</a></li>
							</ul>
						</div><!-- /고객 -->
					</div> <!-- 상품 -->
					<div class="col-lg-4 offset-lg-1 col-md-5 offset-md-1 col-sm-6 col-6">
						<div class="category-block">
							<div class="header">
								<i class="fa fa-book icon-bg-4"></i> 
								<h4>E-BOOK</h4>
							</div>
							<ul class="category-list" >
							<%
								for(Ebook e : ebookList) {
							%>
									<li><a href="<%=request.getContextPath()%>/themes/classimax-premium/ebookOne.jsp?ebookISBN=<%=e.getEbookISBN()%>"><%=e.getEbookTitle()%></a> l <%=e.getEbookPrice()%>원</li>
							<%
								}
							%>
								<li><a class="text-right" href="<%=request.getContextPath()%>/themes/classimax-premium/ebookList.jsp"><i class="fa fa-caret-right"></i>more</a></li>
							</ul>
						</div><!-- /상품 -->
					</div> <!-- 주문 -->
					<div class="col-lg-4 offset-lg-0 col-md-5 offset-md-1 col-sm-6 col-6">
						<div class="category-block">
							<div class="header">
								<i class="fa fa-shopping-basket icon-bg-5"></i> 
								<h4>ORDERS</h4>
							</div>
							<ul class="category-list" >
							<%
								for(OrdersAndEbookAndClient o : oecList) {
							%>
									<li><%=o.getEbook().getEbookTitle()%><br> l <%=o.getOrders().getOrdersState()%></li>
							<%
								}
							%>
								<li><a class="text-right" href="<%=request.getContextPath()%>/themes/classimax-premium/ordersList.jsp"><i class="fa fa-caret-right"></i>more</a></li>
							</ul>
						</div><!-- /주문 -->
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Container End -->
</section>
<%
	}
%>
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



