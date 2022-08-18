<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${config.getValue('client.title')}</title>
<meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>

<jsp:include page="/include/resource.jsp" />

<script type="text/javascript">

</script>

</head>
<body>
	<div class="main-container">
		<jsp:include page="/include/header.jsp"></jsp:include>
		<div class="row main-content">
		</div>
		<jsp:include page="/include/footer.jsp"></jsp:include>
	</div>
</body>
</html>