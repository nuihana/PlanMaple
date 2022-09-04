<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>

<script type="text/javascript">
$(document).ready(function() {
	$('#manageAdd_public_flag').val('${loginSeq}');

	$('#own_complete_count').change(function() {
		if ($(this).val() > 9999) {
			$(this).val(9999);
		} else if ($(this).val() < 1) {
			$(this).val(1);
		}
	});
});

function managecodeAddProc(mode) {
	if (managecodeAddValidation()) {
		ajaxCall4Html(ctxPath + '/managecodeProc', $("#formManagecodeAdd").separator('separatorRemoveForm').serialize(), function(data) {
			var rtn = JSON.parse(data);
			console.log(rtn);
			if (rtn.result == 'YES') {
				$.confirm("데이터 입력이 완료되었습니다.", "window.location.reload();");
			} else {
				$.alert("데이터 입력에 실패했습니다. 확인 후 다시 이용해주세요. <br/> <b>실패사유</b> : " + rtn.messages);
			}
		});
	}
}

function managecodeAddValidation() {
	if ($('#own_management_code_desc').val() == undefined || $('#own_management_code_desc').val() == "") {
		$.alert("[숙제명]정보를 입력해주세요.");
		return false;
	}
	if ($('#own_belong_condition').val() == undefined || $('#own_belong_condition').val() == "") {
		$.alert("[숙제 귀속]정보를 입력해주세요.");
		return false;
	}
	if ($('#own_cycle_condition').val() == undefined || $('#own_cycle_condition').val() == "") {
		$.alert("[초기화 주기]정보를 입력해주세요.");
		return false;
	}
	if ($('#own_complete_count').val() == undefined || $('#own_complete_count').val() == "") {
		$.alert("[완료 횟수]정보를 입력해주세요.");
		return false;
	}
	return true;
}
</script>

<style>

</style>

<div class="modal fade" id="managecodeAdd_modal" tabindex="-1" aria-labelledby="managecodeAddModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<!-- header -->
			<div class="modal-header bg-secondary text-white">
				<!-- header title -->
<!-- 				<h5 class="modal-title"><i class="fa fa-exclamation-triangle"></i> 확인</h5> -->
				<h5 class="modal-title">커스텀 숙제 생성</h5>
			</div>
			<!-- body -->
			<div class="modal-body">
				<form id="formManagecodeAdd" action="" method="post">
					<input type="hidden" id="manageAdd_public_flag" name="public_flag"/>
							
					<input type="hidden" name="proc_role" value="insert"/>
					
					<div class="row justify-content-center">
						<div class="col-sm-3">
							<label for="own_management_code_desc" class="col-form-label">숙제명</label>
						</div>
						<div class="col-sm-7">
							<input type="text" class="form-control" id="own_management_code_desc" name="management_code_desc"/>
						</div>
					</div>
					<div class="row justify-content-center mt-2">
						<div class="col-sm-3">
							<label for="own_belong_condition" class="col-form-label">숙제 귀속</label>
						</div>
						<div class="col-sm-7">
							<select id="own_belong_condition" name="belong_condition" class="form-control">
								<option value="">선택</option>
								<option value="C">캐릭터 귀속</option>
								<option value="W">월드 귀속</option>
								<option value="I">메이플스토리 계정 귀속</option>
							</select>
						</div>
					</div>
					<div class="row justify-content-center mt-2">
						<div class="col-sm-3">
							<label for="own_cycle_condition" class="col-form-label">초기화 주기</label>
						</div>
						<div class="col-sm-7">
							<select id="own_cycle_condition" name="cycle_condition" class="form-control">
								<option value="">선택</option>
								<option value="D">일일 초기화</option>
								<option value="T">목요일 초기화</option>
								<option value="S">월요일 초기화</option>
								<option value="M">월간 초기화</option>
							</select>
						</div>
					</div>
					<div class="row justify-content-center mt-2">
						<div class="col-sm-3">
							<label for="own_management_code_desc" class="col-form-label">완료 횟수</label>
						</div>
						<div class="col-sm-7">
							<input type="number" class="form-control" id="own_complete_count" name="complete_count" min="1" max="9999"/>
						</div>
					</div>
				</form>
			</div>
			<!-- Footer -->
			<div class="modal-footer">
				<button id="btn_save" type="button" class="btn btn-secondary" onclick="managecodeAddProc('insert');">저장</button>
				<button type="button" class="btn" data-bs-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>