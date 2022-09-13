<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>

<script type="text/javascript">
$(document).ready(function() {
	
});

function CharacterInfoEditProc() {
	if (characterEditValidation()) {
		ajaxCall4Html(ctxPath + '/characterEditProc', $("#formCharacterEdit").separator('separatorRemoveForm').serialize(), function(data) {
			var rtn = JSON.parse(data);
// 			console.log(rtn);
			if (rtn.result == 'YES') {
				$.confirm("수정 되었습니다.", "window.location.reload();");
			} else {
				$.alert("데이터 입력에 실패했습니다. 확인 후 다시 이용해주세요. <br/> <b>실패사유</b> : " + rtn.messages);
			}
		});
	}
}

function characterEditValidation() {
	if ($('#edit_character_seq').val() == undefined || $('#edit_character_seq').val() == "") {
		$.alert("[캐릭터]정보에 접근할 수 없습니다. 새로고침 후 다시 이용해주세요.");
		return false;
	}
	if ($('#edit_character_name').val() == undefined || $('#edit_character_name').val() == "") {
		$.alert("[닉네임]정보를 입력해주세요.");
		return false;
	}
	if ($('#edit_character_server_code').val() == undefined || $('#edit_character_server_code').val() == "") {
		$.alert("[서버]정보를 입력해주세요.");
		return false;
	}
	if ($('#edit_character_level').val() == undefined || $('#edit_character_level').val() == "") {
		$.alert("[레벨]정보를 입력해주세요.");
		return false;
	}
	
	return true;
}
</script>

<div class="modal fade" id="characterEdit_modal" tabindex="-1" aria-labelledby="characterEditModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<!-- header -->
			<div class="modal-header bg-secondary text-white">
				<!-- header title -->
<!-- 				<h5 class="modal-title"><i class="fa fa-exclamation-triangle"></i> 확인</h5> -->
				<h5 class="modal-title">캐릭터</h5>
			</div>
			<!-- body -->
			<div class="modal-body">
				<!-- 캐릭터 정보 display -->
				<div class="row justify-content-center">
					<div class="col-sm-4 py-3">
						<img id="characterEdit_Profile_img" src="${pageContext.request.contextPath}/static/common_files/question-mark.png" class="img-fluid" alt="캐릭터 이미지">
					</div>
					<div class="col-sm-8 py-1">
						<!-- 캐릭터 검색 결과 저장 form -->
						<form id="formCharacterEdit" class="form-horizontal" action="" method="post">
							<input type="hidden" id="edit_character_seq" name="character_seq"/>
							
							<input type="hidden" name="proc_role" value="update"/>
							
							<div class="row justify-content-center mt-3">
								<div class="col-sm-3">
									<label for="edit_character_name" class="col-form-label">닉네임</label>
								</div>
								<div class="col-sm-7">
									<input type="text" class="form-control" id="edit_character_name" name="character_name"/>
								</div>
							</div>
							
							<div class="row justify-content-center mt-2">
								<div class="col-sm-3">
									<label for="edit_character_server_code" class="col-form-label">서버</label>
								</div>
								<div class="col-sm-7">
									<select class="form-control" id="edit_character_server_code" name="character_server_code">
										<option value="2">리부트2</option>
										<option value="3">리부트</option>
										<option value="4">오로라</option>
										<option value="5">레드</option>
										<option value="6">이노시스</option>
										<option value="7">유니온</option>
										<option value="8">스카니아</option>
										<option value="9">루나</option>
										<option value="10">제니스</option>
										<option value="11">크로아</option>
										<option value="12">베라</option>
										<option value="13">엘리시움</option>
										<option value="14">아케인</option>
										<option value="15">노바</option>
										<option value="16">버닝</option>
									</select>
								</div>
							</div>
							
							<div class="row justify-content-center mt-2">
								<div class="col-sm-3">
									<label for="edit_character_level" class="col-form-label">레벨</label>
								</div>
								<div class="col-sm-7">
									<input type="text" class="form-control" id="edit_character_level" name="character_level"/>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
			<!-- Footer -->
			<div class="modal-footer">
				<button id="btn_save" type="button" class="btn btn-secondary" onclick="CharacterInfoEditProc('update');">저장</button>
				<button type="button" class="btn" data-bs-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>