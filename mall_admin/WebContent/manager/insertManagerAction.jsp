<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "gdu.mall.dao.ManagerDao" %>
<%@ page import = "gdu.mall.vo.Manager" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<title>Insert title here</title>
</head>
<body>
<%
	//1. 수집, 전처리
	request.setCharacterEncoding("utf-8");
	String managerId = request.getParameter("managerId");
	String managerPw = request.getParameter("managerPw");
	String managerName = request.getParameter("managerName");
	//디버깅
	System.out.println("managerId="+managerId);
	System.out.println("managerPw="+managerPw);
	System.out.println("managerName="+managerName);
	
	//2-1. 중복된 아이디 있는지 확인. 중복된 아이디가 있다면 : 다시 입력폼으로 이동
	String returnManagerId = ManagerDao.selectManagerId(managerId);
	if(returnManagerId != null){ //이미 아이디가 존재함
		System.out.println("사용중인 아이디");
		response.sendRedirect(request.getContextPath()+"/themes/classimax-premium/insertManagerForm.jsp");
		return; //if문에 조건이 해당 되면 jsp파일 재요청 이후 return을 이용해 이 코드를 끝낸다.
	}
	//2-2. 중복된 아이디가 없으면(else) 입력
	ManagerDao.insertManager(managerId, managerPw, managerName);
	//3. 출력
%>
<body class="body-wrapper">

<section class="login py-5 border-top-1">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-5 col-md-8 align-item-center">
                    <div class="border border">
                        <h2 class="bg-gray p-4">Register Complete!</h2>
                        <h4 class="p-4"> You can use the page after applying. please wait for time.</h4>
                            <fieldset class="p-4">
                                <a href="<%=request.getContextPath()%>/themes/classimax-premium/adminIndex.jsp"><button type="button" class="d-block py-3 px-4 bg-primary text-white border-0 rounded font-weight-bold">Home</button></a>
                            </fieldset>
                    </div>
                </div>
            </div>
        </div>
    </section>
</body>
</html>