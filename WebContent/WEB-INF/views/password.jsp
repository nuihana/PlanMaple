<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${config.getValue('Title')}</title>
<meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>

<jsp:include page="/include/resource.jsp" />

<script type="text/javascript">
var pwSameFlag = false;

$(document).ready(function () {
	$('#pwedit_user_id').val('${userVo.user_id}');
	
	$('#check_pw').keydown(function(e) {
		if (e.keyCode == 13) {
			chkPassword();
			return;
		}
    });
	
	$('.form-password').keyup(function(e) {
		if ($('#input_pw').val() == $('#input_pw_rp').val()) {
			pwSameFlag = true;
			$('.form-password').removeClass('is-invalid');
			$('.form-password').addClass('is-valid');
		} else {
			pwSameFlag = false;
			$('.form-password').removeClass('is-valid');
			$('.form-password').addClass('is-invalid');
		}
		if (e.keyCode == 13) {
			editPassword();
			return;
		}
    });
});

function chkPassword() {
	if (chkPasswordValidation()) {
		$('#pwedit_user_pw').val($('#check_pw').val());
		
		ajaxCall4Html(ctxPath + '/passwordChkAjax', $("#formPasswordEdit").separator('separatorRemoveForm').serialize(), function(data) {
			var rtn = JSON.parse(data);
// 			console.log(rtn);
			if (rtn.result == 'YES') {
				$('#check_pw').removeClass('is-invalid');
				$('#check_pw').addClass('is-valid');
				
				//변경 버튼 활성화
				$('#pwedit_button').attr("disabled", false);
				$('#input_pw').attr("disabled", false);
				$('#input_pw_rp').attr("disabled", false);
				
				$.alert("변경할 비밀번호를 입력해주세요.");
			} else {
				$('#check_pw').addClass('is-invalid');
				$.alert("비밀번호가 일치하지 않습니다.");
			}
		});
	}
}

function chkPasswordValidation() {
	if ($('#check_pw').val() == undefined || $('#check_pw').val() == "") {
		$.alert("현재 비밀번호를 입력해주세요.");
		return false;
	}
	
	return true;
}

function editPassword() {
	if (editPasswordValidation()) {
		$('#pwedit_user_pw').val($('#input_pw').val());
		
		ajaxCall4Html(ctxPath + '/passwordProc', $("#formPasswordEdit").separator('separatorRemoveForm').serialize(), function(data) {
			var rtn = JSON.parse(data);
// 			console.log(rtn);
			if (rtn.result == 'YES') {
				$.confirm("비밀번호가 변경되었습니다. <br/>변경된 비밀번호로 다시 로그인해주세요.", "location.href = ctxPath + '/login';");
			} else {
				$.alert("오류가 발생하였습니다. 새로고침 후 다시 이용해주세요.");
			}
		});
	}
}

function editPasswordValidation() {
	if (!pwSameFlag) {
		$.alert("입력된 두 비밀번호가 서로 일치하지 않습니다.");
		return false;
	}
	
	return true;
}
</script>

</head>
<body>
	<div class="main-container">
		<jsp:include page="/include/header.jsp"></jsp:include>
		<div class="container">
			<div class="row g-3 justify-content-center">
				<div class="col-sm-5 col-xs-5">
					<form id="formPasswordEdit" class="form-login form-horizontal" action="" method="post">
						<input type="hidden" id="pwedit_user_id" name="user_id"/>
						<input type="hidden" id="pwedit_user_pw" name="user_pw"/>
					
						<div class="form-group">
							<div class="input-group mb-3 has-validation">
								<input class="form-control" type="password" placeholder="현재 비밀번호" id="check_pw">
								<button class="btn btn-outline-secondary" type="button" onclick="chkPassword();">비밀번호 확인</button>
								<div id="invalidIDFeedback" class="invalid-feedback">
									비밀번호가 일치하지 않습니다.
								</div>
							</div>
							
							<input class="form-control form-password" type="password" placeholder="비밀번호 입력" id="input_pw" disabled>
							<input class="form-control form-password" type="password" placeholder="비밀번호 재입력" id="input_pw_rp" disabled>
							<div id="invalidPWFeedback" class="invalid-feedback">
								입력한 비밀번호가 일치하지 않습니다.
							</div>
						</div>
				
						<div class="d-grid gap-2 d-md-flex justify-content-md-end mt-3">
							<button id="pwedit_button" type="button" class="btn btn-secondary" disabled onclick="editPassword();">변경</button>
						</div>
					</form>
				</div>
			</div>
		</div>
		<jsp:include page="/include/footer.jsp"></jsp:include>
	</div>
</body>
</html>