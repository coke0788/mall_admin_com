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
  <title>noticeOne</title>
  
  <!-- FAVICON -->
  <link href="img/favicon.png" rel="shortcut icon">
  <!-- PLUGINS CSS STYLE -->
  <!-- <link href="plugins/jquery-ui/jquery-ui.min.css" rel="stylesheet"> -->
  <!-- Bootstrap -->
  <link rel="stylesheet" href="plugins/bootstrap/css/bootstrap.min.css">
  <link rel="stylesheet" href="plugins/bootstrap/css/bootstrap-slider.css">
  <!-- Font Awesome -->
  <link href="plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
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
						if(manager == null || manager.getManagerLevel() < 1){ //만약 session manager 레벨이 1보다 낮은 경우 admin index로 이동
							response.sendRedirect(request.getContextPath()+"/themes/classimax-premium/adminIndex.jsp");
							return;
						}
						//NoticeNo 받아오기. NoticeDao 클래스의 selectNoticeOne 호출
						int noticeNo=Integer.parseInt(request.getParameter("noticeNo"));
						Notice notice=NoticeDao.selectNoticeOne(noticeNo);
						int rowCnt=CommentDao.selectCommentCnt(noticeNo);
						System.out.println("넘버:"+noticeNo);
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
<!--=================================
=            상세 페이지	            =
==================================-->


<section class="blog single-blog section">
	<div class="container">
		<div class="row">
			<div class="col-md-10 offset-md-2 col-lg-9 offset-lg-2">
				<article class="single-post">
					<h4><%=notice.getNoticeNo()%>.</h4> <h3>&nbsp; &nbsp; &nbsp;<i class="fa fa-bell"></i> <%=notice.getNoticeTitle()%> [<%=rowCnt%>]</h3>
					<ul class="list-inline">
						<li class="list-inline-item">by <%=manager.getManagerId()%></li>
						<li class="list-inline-item"><%=notice.getNoticeDate().substring(0,16)%></li>
					</ul>
					<img src="images/news.jpg" height="350" alt="article-01">
					<p><%=notice.getNoticeContent()%></p>
					<a href="<%=request.getContextPath()%>/notice/deleteNoticeAction.jsp?noticeNo=<%=notice.getNoticeNo()%>"><button class="btn btn-outline-secondary py-1 float-right">DELETE</button></a>
					<a href="<%=request.getContextPath()%>/themes/classimax-premium/updateNoticeForm.jsp?noticeNo=<%=notice.getNoticeNo()%>"><button class="btn btn-transparent py-1 float-right">EDIT</button></a><br>
				</article>
				<!-- 댓글 리스트 -->
				<div class="block comment">
					<h4>Comment List</h4><hr>
					<div class="form-group mb-30">
				<%
					ArrayList<Comment> commentList = CommentDao.selectCommentListByNoticeNo(noticeNo);
					for(Comment c : commentList) {
				%>
					<div class="row">
						<div class="form-group mb-30">
							<label for="message"><i class="fa fa-comment"></i> Message</label>
								<div><%=c.getCommentContent()%></div><br>
									<label for="name"><i class="fa fa-user"></i> Date/Author of Comment</label>
								<div><%=c.getCommentDate().substring(0,16)%> / <%=c.getManagerId()%>
								<a href="<%=request.getContextPath()%>/notice/deleteCommentAction.jsp?commentNo=<%=c.getCommentNo()%>&noticeNo=<%=notice.getNoticeNo()%>"><button type="button" class="btn btn-outline-secondary py-0">DELETE</button></a>
							</div><hr>
						</div>
					</div>
				<%
					}
				%>
					</div>
				</div>
				<!-- 코멘트 작성 -->
				<div class="block comment">
					<h4>Leave A Comment</h4>
					<form action="<%=request.getContextPath()%>/notice/insertCommentAction.jsp?noticeNo=<%=notice.getNoticeNo()%>" method="post">
						<input type="hidden" name="noticeNo" value="<%=notice.getNoticeNo()%>">
						<!-- Message -->
						<div class="form-group mb-30">
						    <label for="message"><i class="fa fa-comment"></i> Message</label>
						    <textarea class="form-control" name="commentContent" rows="8"></textarea>
						</div>
						<div class="row">
							<div class="col-sm-12 col-md-6">
								<!-- Name -->
								<div class="form-group mb-30">
								    <label for="name"><i class="fa fa-user"></i> Name</label>
								    <input type="text" class="form-control" name="managerId" value=<%=manager.getManagerId()%> readonly="readonly">
								</div>
							</div>
						</div>
						<button type="submit" class="btn btn-transparent float-right">Leave Comment</button><br><br>
					</form>
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

