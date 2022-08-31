<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/include/commonHead.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PlanMaple Login</title>
<meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>

<jsp:include page="/include/resource.jsp" />

<c:import url="/include/commonModalHead.jsp" />

<script type="text/javascript">
var idDuplicateFlag = false;
var pwSaneFlag = false;

$(document).ready(function() {
	$('.login-input').keydown(function(e) {
		if (e.keyCode == 13) {
			loginCheck();
			return;
		}
    });
	
	$('#user_id').keydown(function(e) {
		if (e.keyCode == 9) {
			return;
		}
		idDuplicateFlag = false;
		$('#user_id').addClass('is-invalid');
		if (e.keyCode == 13) {
			userDuplChk();
			return;
		}
    });
	
	$('.form-password').keyup(function(e) {
		if ($('#user_pw').val() == $('#user_pw_rp').val()) {
			pwSaneFlag = true;
			$('.form-password').removeClass('is-invalid');
			$('.form-password').addClass('is-valid');
		} else {
			pwSaneFlag = false;
			$('.form-password').removeClass('is-valid');
			$('.form-password').addClass('is-invalid');
		}
		if (e.keyCode == 13) {
			signup();
			return;
		}
    });
});


function signup() {
	if (signupValidation()) {
		ajaxCall4Html(ctxPath + '/signupAjax', $("#formLogin").separator('separatorRemoveForm').serialize(), function(data) {
			var rtn = JSON.parse(data);
// 			console.log(rtn);
			
			if (rtn.result == 'OK') {
				$.confirm("데이터 입력이 완료되었습니다. 등록한 계정으로 로그인 후 이용해주세요.", "location.href = ctxPath + '/login';");
			} else {
				$.alert("데이터 입력에 실패했습니다. 확인 후 다시 이용해주세요");
			}
		});
	}
}

function signupValidation() {
	if ($('#user_id').val() == undefined || $('#user_id').val() == "") {
		$.alert("ID를 입력해주세요.");
		return false;
	}
	if (!idDuplicateFlag) {
		$.alert("ID중복체크를 진행해주세요.");
		return false;
	}

	if ($('#user_pw').val() == undefined || $('#user_pw').val() == "") {
		$.alert("암호를 입력해주세요.");
		return false;
	}
	if (!pwSaneFlag) {
		$.alert("입력된 두 비밀번호가 서로 일치하지 않습니다.");
		return false;
	}
	
	return true;
}

function userDuplChk() {
	if (duplChkValidation()) {
		ajaxCall4Html(ctxPath + '/loginUserDuplChkAjax', $("#formLogin").separator('separatorRemoveForm').serialize(), function(data) {
			var rtn = JSON.parse(data);
// 			console.log(rtn);
			if (rtn.result == 'OK') {
				idDuplicateFlag = true;
				$('#user_id').removeClass('is-invalid');
				$('#user_id').addClass('is-valid');
			} else {
				$.alert("이미 존재하는 ID입니다.");
			}
		});
	}
}

function duplChkValidation() {
	if ($('#user_id').val() == undefined || $('#user_id').val() == "") {
		$.alert("ID를 입력해주세요.");
		return false;
	}
	
	return true;
}
</script>

</head>
<body>
	<div class="container">
		<form id="formLogin" class="form-login form-horizontal" action="" method="post">
			<h3 class="form-login-heading text-center">계정등록</h3>
			
			<div class="form-group">
				<label for="username" class="control-label">ID</label>
				<div class="input-group mb-3 has-validation">
					<input class="form-control" type="text" placeholder="ID 입력" id="user_id" name="user_id">
					<button class="btn btn-outline-secondary" type="button" id="duplChkButton" onclick="userDuplChk();">중복확인</button>
					<div id="invalidIDFeedback" class="invalid-feedback">
						중복검사를 진행해주세요.
					</div>
				</div>
		
				<label for="password" class="control-label">PW</label>
				<input class="form-control mb-2 form-password" type="password" placeholder="PW 입력" id="user_pw" name="user_pw">
				<input class="form-control form-password" type="password" placeholder="PW 재입력" id="user_pw_rp" name="user_pw_rp">
				<div id="invalidPWFeedback" class="invalid-feedback">
					입력한 비밀번호가 일치하지 않습니다.
				</div>
			</div>
			
			<div class="d-grid gap-2 d-md-flex justify-content-md-end mt-3">
				<button type="button" class="btn btn-secondary" onclick="signup();">등록</button>
				<button type="button" class="btn btn-light" onclick="location.href = ctxPath + '/login';">취소</button>
			</div>
		</form>
	</div>
<jsp:include page="/include/popup/alertModal.jsp" />
<jsp:include page="/include/popup/confirmModal.jsp" />
</body>
</html>