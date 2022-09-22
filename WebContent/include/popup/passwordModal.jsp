<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>

<script type="text/javascript">
var pwSameFlag = false;

$(document).ready(function() {
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

<div class="modal fade" id="password_modal" tabindex="-1" aria-labelledby="passwordModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<!-- header -->
			<div class="modal-header bg-secondary text-white">
				<!-- header title -->
				<h5 class="modal-title"><i class="fa fa-exclamation-triangle"></i> 확인</h5>
			</div>
			<!-- body -->
			<div class="modal-body" id="password_modal_body">
				<div class="row g-3 justify-content-center">
					<div class="col-sm-8 col-xs-8">
						<form id="formPasswordEdit" class="form-login form-horizontal" action="" method="post">
							<input type="hidden" id="pwedit_user_id" name="user_id"/>
							<input type="hidden" id="pwedit_user_pw" name="user_pw"/>
						
							<div class="form-group">
								<input class="form-control form-password" type="password" placeholder="비밀번호 입력" id="input_pw">
								<input class="form-control form-password" type="password" placeholder="비밀번호 재입력" id="input_pw_rp">
								<div id="invalidPWFeedback" class="invalid-feedback">
									입력한 비밀번호가 일치하지 않습니다.
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
			<!-- Footer -->
			<div class="modal-footer">
				<button id="password_modal_btn" type="button" class="btn btn-secondary" onclick="editPassword();">변경</button>
				<button type="button" class="btn" data-bs-dismiss="modal">취소</button>
			</div>
		</div>
	</div>
</div>