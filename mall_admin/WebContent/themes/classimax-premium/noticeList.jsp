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
  <title>noticeList</title>
  
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
						if(manager == null || manager.getManagerLevel() < 1){ //만약 session manager 레벨이 1보다 낮은 경우 admin index로 이동
							response.sendRedirect(request.getContextPath()+"/themes/classimax-premium/adminIndex.jsp");
							return;
						}
						//현재 페이지
						int currentPage=1;
						//if 문으로 String 값을 int값으로 변환해주는 이유 : 검색어 때문에 rowPerPage가 String 값으로 넘어옴. Int값으로 바꿔줘야 함. 그냥 헷갈릴까봐 관련된거 다 해놓음.
						if(request.getParameter("currentPage")!=null){
							currentPage = Integer.parseInt(request.getParameter("currentPage"));
						}
						//페이지 당 row
						int rowPerPage = 5;
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
						int beginRow = (currentPage-1) * rowPerPage;		
						//전체 행과 마지막 페이지
						int totalRow = NoticeDao.totalCount(searchWord);
						int lastPage = totalRow/rowPerPage;
						if(totalRow % rowPerPage != 0) {
							lastPage += 1; //totalrow를 rowperpage로 나눴을때 나머지가 0이 아니면 라스트 페이지에 1을 더한다.
						}
						
						//NoticeDao 클래스에서 목록 메소드 호출. 배열(참조타입) 변수 list에 저장.
						ArrayList<Notice> list = NoticeDao.selectNoticeList(rowPerPage, beginRow, searchWord);
						
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

<!--================================
=            Page Title            =
=================================-->
<section class="page-title">
	<!-- Container Start -->
	<div class="container">
		<div class="row">
			<div class="col-md-8 offset-md-2 text-center">
				<!-- Title text -->
				<h3>Notice</h3>
			</div>
		</div>
	</div>
	<!-- Container End -->
</section>
<!--==================================
=            Blog Section            =
===================================-->

<section class="blog section">
	<div class="container">
		<div class="row">
			<div class="col-md-10 offset-md-1 col-lg-9 offset-lg-0">
			<a href="<%=request.getContextPath()%>/themes/classimax-premium/insertNoticeForm.jsp?managerId=<%=manager.getManagerId()%>"><button type="button" class="btn btn-outline-primary py-1 float-right">POST</button></a>
			<!-- 페이지갯수 설정 -->
			<form action="<%=request.getContextPath()%>/themes/classimax-premium/noticeList.jsp" method="post">
				<!-- 히든값으로 searchword 넘기기 -->
				<input type= "hidden" name="searchword" value="<%=searchWord%>">
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
				<button type="submit" class="btn btn-main-sm">보기</button>
			</form>
				<!-- notice 샘플 -->
				<article>
					<!-- Post Title -->
					<%
						for(Notice n : list) {
							//댓글의 개수가 몇 개 있는지 알려주기 위해 list의 noticeNo를 받아오고 댓글 개수 확인 메서드를 호출.
							int noticeNo = n.getNoticeNo();
							int rowCnt=CommentDao.selectCommentCnt(noticeNo);
								%>
								<div class="image">
									<img src="images/news.jpg" height="350" alt="article-01">
								</div>
								<h3>No. <%=n.getNoticeNo()%>&nbsp; &nbsp;│<i class="fa fa-bell"></i> <%=n.getNoticeTitle()%> [<%=rowCnt%>]</h3>
								<ul class="list-inline">
									<li class="list-inline-item">by <%=manager.getManagerId()%></li>
									<li class="list-inline-item"><%=n.getNoticeDate().substring(0,10)%></li>
								</ul>
								<%
									/* 공지 리스트 화면에서는 50글자만 보여주고 싶음. 
									if문으로 51글자 보다 작으면 전체 content를 보여주고(String.length() 메소드가 글자 수를 세어 준다고 함. 배열의 개수만 세어주는 건 아닌가봄.)
									그 외에는 substring 메소드로 50글자까지 자를 것임. -> if 문 없이 substring 메소드 호출하면 50글자 이하인 글이 있을 경우 오류가 남.
									*/
									if(n.getNoticeContent().length()<51) {
								%>
									<p class=""><%=n.getNoticeContent()%></p>
								<%
									} else {
								%>
								<p class=""><%=n.getNoticeContent().substring(0,50)%></p>
								<%
									}
								 %>
								<!-- Read more button -->
								<a href="<%=request.getContextPath()%>/themes/classimax-premium/noticeOne.jsp?noticeNo=<%=n.getNoticeNo()%>" class="btn btn-transparent py-1">Read More</a><br>
								<hr>
							<%
						}
					%>
				</article>
				<!-- Article 01 -->
				<!-- Pagination -->
		<!-- pagination -->
		
		<div class="pagination justify-content-center">
			<nav aria-label="Page navigation example">
				<ul class="pagination">
				<%
				if(currentPage>1 && currentPage<lastPage){ //현재페이지가 1보다 크고 라스트페이지보다 작으면 처음, 이전, 현재, 다음, 끝 표시.
				%>
					<li class="page-item">
						<a class="page-link" href="<%=request.getContextPath()%>/themes/classimax-premium/noticeList.jsp?currentPage=1&rowPerPage=<%=rowPerPage%>&searchWord=<%=searchWord%>" aria-label="Previous">
							<span aria-hidden="true">&laquo;</span>
							<span class="sr-only">Previous</span>
						</a>
					</li>
					<li class="page-item">
						<a class="page-link" href="<%=request.getContextPath()%>/themes/classimax-premium/noticeList.jsp?currentPage=<%=currentPage-1%>&rowPerPage=<%=rowPerPage%>&searchWord=<%=searchWord%>">
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
						<a class="page-link" href="<%=request.getContextPath()%>/themes/classimax-premium/noticeList.jsp?currentPage=1&rowPerPage=<%=rowPerPage%>&searchWord=<%=searchWord%>" aria-label="Previous">
							<span aria-hidden="true">&laquo;</span>
							<span class="sr-only">Previous</span>
						</a>
					</li>
					<li class="page-item">
						<a class="page-link" href="<%=request.getContextPath()%>/themes/classimax-premium/noticeList.jsp?currentPage=<%=currentPage-1%>&rowPerPage=<%=rowPerPage%>&searchWord=<%=searchWord%>">
						<%=currentPage-1%></a>
					</li>
					<li class="page-item active"><a class="page-link" href=""><%=currentPage%></a></li>
				<%
				}
				if(currentPage<lastPage) {
				%>
					<li class="page-item">
					<a class="page-link" href="<%=request.getContextPath()%>/themes/classimax-premium/noticeList.jsp?currentPage=<%=currentPage+1%>&rowPerPage=<%=rowPerPage%>&searchWord=<%=searchWord%>">
					<%=currentPage+1%></a>
				</li>
				<li class="page-item">
					<a class="page-link" href="<%=request.getContextPath()%>/themes/classimax-premium/noticeList.jsp?currentPage=<%=lastPage%>&rowPerPage=<%=rowPerPage%>&searchWord=<%=searchWord%>" aria-label="Next">
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
			</div>
			<div class="col-md-10 offset-md-1 col-lg-3 offset-lg-0">
				<div class="sidebar">
					<!-- Search Widget -->
					<form action="<%=request.getContextPath()%>/themes/classimax-premium/noticeList.jsp" method="post">
					<div class="widget search p-0">
						<div class="input-group">
						   <input type="text" class="form-control" name="searchWord" placeholder="Search...">
						   <span class="input-group-addon"> <button type="submit" class="btn btn-main-sm"><i class="fa fa-search"></i></button></span>
					    </div>
					</div>
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

