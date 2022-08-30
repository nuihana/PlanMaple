<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/include/commonHead.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PlanMaple Login</title>
<meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>

<jsp:include page="/include/resource.jsp" />

<link href="${pageContext.request.contextPath}/static/login/login.css" rel="stylesheet" type="text/css" />

<c:import url="/include/commonModalHead.jsp" />

<script type="text/javascript">
$(document).ready(function() {
	//redirect 시 login 입력 정보 주소창에서 제거
	history.replaceState({}, null, location.pathname);
	
	//로그인 실패시 알림
	if (${userVo.user_id ne null and userVo.user_id != ""}) {
		$.alert('계정정보가 일치하지 않습니다.');
	}
	
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
		<input class="login-input" type="text" placeholder="Enter ID" id="user_id" name="user_id" value="${userVo.user_id}">

		<label for="password">PW</label>
		<input class="login-input" type="password" placeholder="Enter Password" id="user_pw" name="user_pw" value="${userVo.user_pw}">

		<button type="button" onclick="loginCheck();">로그인</button>
	</form>
	
<jsp:include page="/include/popup/alertModal.jsp" />
</body>
</html>