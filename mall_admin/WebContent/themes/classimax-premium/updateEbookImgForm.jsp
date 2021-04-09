<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "gdu.mall.vo.*" %>
<%@ page import = "gdu.mall.dao.*" %>
<%@ page import = "java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>

  <!-- SITE TITTLE -->
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>updateEbookImgForm</title>
  
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
						request.setCharacterEncoding("utf-8");
						//관리자 진입 조건 설정
						Manager manager = (Manager)session.getAttribute("sessionManager"); //manager 사용하기 위해서 불러오기.
						if(manager == null || manager.getManagerLevel() < 1){ //만약 session manager가 null인 경우 admin index로 이동
							response.sendRedirect(request.getContextPath()+"/themes/classimax-premium/adminIndex.jsp");
							return;
						} 
						String ebookISBN=request.getParameter("ebookISBN");
						Ebook ebook=EbookDao.selectEbookOne(ebookISBN);
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

<section class="user-profile section">
	<div class="container">
		<div class="row">
			<div class="col-md-10 offset-md-1 col-lg-3 offset-lg-0">
				<div class="sidebar">
					<!-- User Widget -->
					<div class="widget user">
						<!-- User Image -->
						<div class="image d-flex justify-content-center">
							<img src="images/user.png" alt="" class="">
						</div>
						<!-- User Profile -->
						<h5 class="text-center"><%=manager.getManagerName()%></h5>
						<h3 class="text-center">Level: <%=manager.getManagerLevel()%></h3>
					</div>
				</div>
			</div>
			<div class="col-md-10 offset-md-1 col-lg-9 offset-lg-0">
				<!-- Notice form 영역 -->
				<div class="widget welcome-message">
					<h2>Update E-book Image</h2>
				</div>
				<!-- Edit Personal Info -->
				<div class="row">
					<div class="col-md-12 offset-md-0 offset-lg-0">
					<div class="widget change-email mb-0">
						<form action="<%=request.getContextPath()%>/ebook/updateEbookImgAction.jsp" method="post" enctype="multipart/form-data">
						<input type="text" name="ebookISBN" value="<%=ebookISBN%>" hidden="hidden">
							<div class="form-group">
								<label class="col-md-2">PICTURE</label>
								<!-- enctype을 추가하면 데이터(이미지의..데이터?)가 넘어감-->
									<input type="hidden" name="ebookISBN" value="<%=ebookISBN%>">
									<input type="file" class="form-control" name="ebookImg"><br>
							</div>
							<!-- Submit Button -->
							<button type="submit" class="btn btn-transparent py-2">EDIT</button>
							<a href="<%=request.getContextPath()%>/themes/classimax-premium/ebookOne.jsp?ebookISBN=<%=ebook.getEbookISBN()%>"><button type="button" class="btn btn-outline-secondary py-2">CANCEL</button></a>
						</form>
					</div>
					</div>
				</div>
			</div>
		</div>
	</div>
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