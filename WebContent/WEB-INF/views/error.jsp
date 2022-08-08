<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${config.getValue('Title')}</title>
<meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>

<jsp:include page="/include/resource.jsp" />

<script type="text/javascript">

</script>

</head>
<body class="d-flex flex-column min-vh-100">
	<jsp:include page="/include/header.jsp"></jsp:include>
	<div class="container">
		<div class="row">
			<div class="col-lg-12 text-center">
				<img src="${pageContext.request.contextPath}/static/common_files/mark.gif" >
				<h3>요청하신 웹 페이지에서 오류가 발생하였습니다.</h3>
				<p>
					<b>오류코드 : ${errCode}</b><br />
					해당 웹 페이지를 불러오는 과정에 오류가 발생하였습니다.<br />
					동일한 문제가 반복적으로 일어나거나, 해결이 시급한 문제의 경우 prixia@naver.com 으로 메일 남겨주세요.<br />
				</p>
				<h3>
					<a href="${pageContext.request.contextPath}/index">Go to the main page.</a>
				</h3>
				
			</div>
		</div>
	</div>
	<jsp:include page="/include/footer.jsp"></jsp:include>
</body>
</html>