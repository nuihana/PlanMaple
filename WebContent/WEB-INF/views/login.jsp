<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${config.getValue('Title')}</title>
<meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>

<jsp:include page="/include/resource.jsp" />

<link href="${pageContext.request.contextPath}/static/login/login.css" rel="stylesheet" type="text/css" />

<script type="text/javascript">
$(document).ready(function() {
	$('.login-input').keydown(function(e) {
		if (e.keyCode == 13) {
			loginCheck();
			return;
		}
    });
});


function loginCheck() {
	if (loginValidation()) {
		ajaxCall4Html(ctxPath + '/loginCheckAjax', $("#formLogin").separator('separatorRemoveForm').serialize(), function(data) {
			var rtn = JSON.parse(data);
			console.log(rtn);
			
			location.href = ctxPath + "/" + rtn.messages;
// 			if (rtn.result == 'OK') {
// 				console.log('로그인 성공');
// 			} else {
// 				console.log('로그인 실패');
// 			}
		});
	}
}

function loginValidation() {
	if ($('#user_id').val() == undefined || $('#user_id').val() == "") {
		$.alert("ID를 입력해주세요.");
		return false;
	}

	if ($('#user_pw').val() == undefined || $('#user_pw').val() == "") {
		$.alert("암호를 입력해주세요.");
		return false;
	}
	
	return true;
}
</script>

</head>
<body>
	<div class="background">
		<div class="shape"></div>
		<div class="shape"></div>
	</div>
	<form id="formLogin" action="" method="post">
		<h3>PlanMaple</h3>

		<label for="username">ID</label>
		<input class="login-input" type="text" placeholder="Enter ID" id="user_id" name="user_id">

		<label for="password">PW</label>
		<input class="login-input" type="password" placeholder="Enter Password" id="user_pw" name="user_pw">

		<button type="button" onclick="loginCheck();">Log In</button>
<!-- 		<div class="social"> -->
<!-- 			<div class="go"><i class="fab fa-google"></i>  Google</div> -->
<!-- 			<div class="fb"><i class="fab fa-facebook"></i>  Facebook</div> -->
<!-- 		</div> -->
	</form>
	
<jsp:include page="/include/popup/alertModal.jsp" />
</body>
</html>