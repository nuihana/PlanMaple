<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>

<script type="text/javascript">
$(document).ready(function() {
	$('#character_name').keydown(function(e) {
		if (e.keyCode == 13) {
			searchCharacterInfo();
			return;
		}
    });
	
	$('#save_user_seq').val('${loginSeq}');
});

function searchCharacterInfo() {
	if (characterSearchValidation()) {
		ajaxCall4Html(ctxPath + '/characterSearchAjax', $("#formCharacterSearch").separator('separatorRemoveForm').serialize(), function(data) {
			var rtn = JSON.parse(data);
			console.log(rtn);
			
			if (rtn.result == "OK") {
				//검색 결과 표현
				$('#characterProfile_name').text(rtn.data.character_name);
				$('#characterProfile_server').text(rtn.data.character_server);
				$('#characterProfile_level').text(rtn.data.character_level);
				$('#characterProfile_class').text(rtn.data.character_class);
				
				$('#characterProfile_img').attr("src", rtn.data.character_img);
				
				//검색 결과 저장form에 set
				$('#save_character_name').val(rtn.data.character_name);
				$('#save_character_server_code').val(rtn.data.character_server_code);
				$('#save_character_server').val(rtn.data.character_server);
				$('#save_character_level').val(rtn.data.character_level);
				$('#save_character_class').val(rtn.data.character_class);
				$('#save_character_img').val(rtn.data.character_img);
				
				//저장 버튼 활성화
				$('#btn_save').attr("disabled", false);
			} else {
				//검색 결과 초기화
				$('#characterProfile_name').text("");
				$('#characterProfile_server').text("");
				$('#characterProfile_level').text("");
				$('#characterProfile_class').text("");
				
				$('#characterProfile_img').attr("src", "${pageContext.request.contextPath}/static/common_files/question-mark.png");
				
				$.alert("캐릭터를 검색할 수 없습니다.");
				
				//검색 결과 저장form 초기화
				$('#save_character_name').val("");
				$('#save_character_server_code').val("");
				$('#save_character_server').val("");
				$('#save_character_level').val("");
				$('#save_character_class').val("");
				$('#save_character_img').val("");
				
				//저장 버튼 활성화
				$('#btn_save').attr("disabled", true);
			}
		});
	}
}

function characterSearchValidation() {
	if ($('#character_name').val() == undefined || $('#character_name').val() == "") {
		$.alert("닉네임을 입력해주세요.");
		return false;
	}
	
	return true;
}

function CharacterInfoSaveProc() {
	if (characterSaveValidation()) {
		ajaxCall4Html(ctxPath + '/characterEditProc', $("#formCharacterSave").separator('separatorRemoveForm').serialize(), function(data) {
			var rtn = JSON.parse(data);
// 			console.log(rtn);
			if (rtn.result == 'YES') {
				$.confirm("데이터 입력이 완료되었습니다.", "window.location.reload();");
			} else {
				$.alert("데이터 입력에 실패했습니다. 확인 후 다시 이용해주세요. <br/> <b>실패사유</b> : " + rtn.messages);
			}
		});
	}
}

function characterSaveValidation() {
	if ($('#save_character_name').val() == undefined || $('#save_character_name').val() == "") {
		$.alert("[닉네임]정보를 입력해주세요.");
		return false;
	}
	if ($('#save_character_level').val() == undefined || $('#save_character_level').val() == "") {
		$.alert("[레벨]정보를 입력해주세요.");
		return false;
	}
	if ($('#save_user_seq').val() == undefined || $('#save_user_seq').val() == "") {
		$.alert("[계정]정보에 접근할 수 없습니다. 로그아웃 후 다시 서비스에 접속해주세요.");
		return false;
	}
	
	return true;
}
</script>

<style>
dl.profile {
	padding-left: 15px;
	margin-top: 8px;
	margin-bottom: 0px;
}
dl.profile dt{
	padding: 0;
	line-height: 18px;
	height: 18px;
	text-align: right;
	width: 46px;
	font-size: 13px;
	margin-bottom: 10px;
}
dl.profile dd{
	height: auto;
	margin-left: 66px;
}
</style>

<div class="modal fade" id="characterSearch_modal" >
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
				<!-- 캐릭터 검색 form -->
				<form id="formCharacterSearch" class="form-horizontal" action="" method="post">
					<input hidden="hidden"/> <!-- form에 input 1개만 단일 존재시 enter 입력했을 때 자동으로 summit되는 기능 방지 -->
					<div class="form-group">
						<label for="character_name" class="col-sm-4 control-label">검색</label>
						<div class="col-sm-6">
							<input type="text" class="form-control-plaintext" id="character_name" name="character_name"/>
							<a href="#" style="color: #333; padding-left: 15px;" onclick="searchCharacterInfo();">
								<span class="glyphicon glyphicon-search" aria-hidden="true"></span>
							</a>
						</div>
					</div>
				</form>
				
				<!-- 캐릭터 정보 display -->
				<div class="row">
					<div class="col-sm-3 col-sm-offset-2">
						<img id="characterProfile_img" src="${pageContext.request.contextPath}/static/common_files/question-mark.png" class="center-block img-responsive img-circle" alt="캐릭터 이미지">
					</div>
					<div class="col-sm-5">
						<!-- 캐릭터 검색 결과 저장 form -->
						<form id="formCharacterSave" class="form-horizontal" action="" method="post">
							<input type="hidden" id="save_character_name" name="character_name" />
							<input type="hidden" id="save_character_server_code" name="character_server_code" />
							<input type="hidden" id="save_character_server" name="character_server" />
							<input type="hidden" id="save_character_level" name="character_level" />
							<input type="hidden" id="save_character_class" name="character_class" />
							
							<input type="hidden" id="save_character_img" name="character_img"/>
							
							<input type="hidden" id="save_user_seq" name="user_seq"/>
							
							<input type="hidden" name="proc_role" value="insert"/>
						</form>
						<dl class="dl-horizontal profile">
							<dt>닉네임</dt>
							<dd id="characterProfile_name"></dd>
							<dt>월드</dt>
							<dd id="characterProfile_server"></dd>
							<dt>레벨</dt>
							<dd id="characterProfile_level"></dd>
							<dt>직업</dt>
							<dd id="characterProfile_class"></dd>
						</dl>
					</div>
				</div>
			</div>
			<!-- Footer -->
			<div class="modal-footer">
				<button id="btn_save" type="button" class="btn btn-secondary" disabled onclick="CharacterInfoSaveProc('insert');">저장</button>
				<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>