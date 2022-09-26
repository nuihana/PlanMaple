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
	$('#pwedit_user_seq').val('${userVo.user_seq}');
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
			if (rtn.result == 'YES') {
				$('#check_pw').removeClass('is-invalid');
				$('#check_pw').addClass('is-valid');
				
				$.alert("계정 정보가 확인되었습니다.");
				
				$('#userValidationArea').hide();
				$('#userEditArea').show();
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

function deleteUser() {
	$.feedback("정말 계정을 삭제하시겠습니까?<br/><small>계정에 등록된 모든 정보는 함께 삭제됩니다.</small>", "deleteUserProc();");
}

function deleteUserProc() {
	$('#pwedit_proc_role').val('delete');
	
	ajaxCall4Html(ctxPath + '/userProc', $("#formPasswordEdit").separator('separatorRemoveForm').serialize(), function(data) {
		var rtn = JSON.parse(data);
// 		console.log(rtn);
		if (rtn.result == 'YES') {
			$.confirm("계정이 삭제되었습니다.", "location.href = ctxPath + '/login';");
		} else {
			$.alert("오류가 발생하였습니다. 새로고침 후 다시 이용해주세요.");
		}
	});
}
</script>

</head>
<body>
	<div class="main-container">
		<jsp:include page="/include/header.jsp"></jsp:include>
		<div class="container">
			<div id="userEditArea" class="row g-3 justify-content-center" style="display: none;">
				<div class="col-sm-5 col-xs-5">
					<div class="card">
						<form id="formPasswordEdit" class="form-horizontal" action="" method="post">
							<input type="hidden" id="pwedit_user_seq" name="user_seq"/>
							<input type="hidden" id="pwedit_user_id" name="user_id"/>
							<input type="hidden" id="pwedit_user_pw" name="user_pw"/>
							
							<input type="hidden" id="pwedit_proc_role" name="proc_role"/>
						
							<div class="card-header text-center">비밀번호 변경</div>
							<div class="card-body row justify-content-center">
								<div class="form-group col-sm-9 col-xs-9">
									<input class="form-control form-password" type="password" placeholder="비밀번호 입력" id="input_pw">
									<input class="form-control form-password" type="password" placeholder="비밀번호 재입력" id="input_pw_rp">
									<div id="invalidPWFeedback" class="invalid-feedback">
										입력한 비밀번호가 일치하지 않습니다.
									</div>
								</div>
							</div>
							<div class="card-footer">
								<div class="d-grid gap-2 d-md-flex justify-content-md-end">
									<button id="pwedit_button" type="button" class="btn btn-secondary" onclick="editPassword();">변경</button>
								</div>
							</div>
						</form>
					</div>
					<div class="card mt-3">
						<div class="card-header text-center">계정 삭제</div>
						<div class="card-body">
							<div class="d-grid gap-2 d-md-flex justify-content-center">
								<button id="userdel_button" type="button" class="btn btn-secondary" onclick="deleteUser();">계정 삭제</button>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div id="userValidationArea" class="row g-3 justify-content-center">
				<div class="col-sm-5 col-xs-5">
					<div class="card-header text-center">비밀번호 확인</div>
					<div class="card-body row justify-content-center">
						<div class="form-group col-sm-9 col-xs-9">
							<div class="input-group mb-3 has-validation">
								<input class="form-control" type="password" placeholder="현재 비밀번호" id="check_pw">
								<button class="btn btn-outline-secondary" type="button" onclick="chkPassword();">비밀번호 확인</button>
								<div id="invalidIDFeedback" class="invalid-feedback">
									비밀번호가 일치하지 않습니다.
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<jsp:include page="/include/popup/feedbackModal.jsp" />
		<jsp:include page="/include/footer.jsp"></jsp:include>
	</div>
</body>
</html>