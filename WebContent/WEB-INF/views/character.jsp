<%@ include file="/include/commonHead.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${config.getValue('client.title')}</title>
<meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>

<jsp:include page="/include/resource.jsp" />

<script type="text/javascript">
$(document).ready(function () {
	$('#Managecode_user_seq').val('${loginSeq}');
});

function searchCharacter() {
	let options = {
		backdrop: true,
		keyboard: true,
		focus: true
	};
	
	let myModal = new bootstrap.Modal(document.getElementById('characterSearch_modal'), options);
	myModal.show();
}

function selectCharacter(character_seq) {
	$('.character-data').removeClass("table-active");
	
	$('#Managecode_character_seq').val(character_seq);
	$('#Management_character_seq').val(character_seq);
	
	if (character_seq != undefined && character_seq != "") {
		$('#planEditer').ajaxload(
			'blockLoad',
			ctxPath+'/managecodeList',
			"POST",
			"html",
			$("#formCharacterManagecode").separator('separatorRemoveForm').serialize()
		);
	} else {
		
	}
	
	$("#character_tr_" + character_seq).addClass("table-active");
}

function managecodeProc(val) {
	if (managecodeProcValidation(val)) {
		$('#Managecode_proc_role').val(val);
		$('#Management_proc_role').val(val);
		
		if (val == 'insert') {
			var codeList = "";
			
	 		$("input:checkbox[name='readyManagecodeCheckBox']:checked").each(function(i, ival) {
	 			codeList += ival.value + ",";
	 		});
	 		
	 		$('#Managecode_managecode').val(codeList);
			
			ajaxCall4Html(ctxPath + '/managecodeEditProc', $("#formCharacterManagecode").separator('separatorRemoveForm').serialize(), function(data) {
				var rtn = JSON.parse(data);
//	 			console.log(rtn);
				if (rtn.result == 'YES') {
					$.confirm("데이터 입력이 완료되었습니다.", "selectCharacter('" + $('#Managecode_character_seq').val() + "');");
				} else {
					$.alert("데이터 입력에 실패했습니다. 확인 후 다시 이용해주세요. <br/> <b>실패사유</b> : " + rtn.messages);
				}
			});
		} else if (val == 'delete') {
			var codeList = "";
			
	 		$("input:checkbox[name='ingManagecodeCheckBox']:checked").each(function(i, ival) {
	 			codeList += ival.value + ",";
	 		});
	 		
	 		$('#Management_management_code').val(codeList);
	 		
			ajaxCall4Html(ctxPath + '/managecodeEditProc', $("#formCharacterManagement").separator('separatorRemoveForm').serialize(), function(data) {
				var rtn = JSON.parse(data);
//	 			console.log(rtn);
				if (rtn.result == 'YES') {
					$.confirm("데이터 제거가 완료되었습니다.", "selectCharacter('" + $('#Management_character_seq').val() + "');");
				} else {
					$.alert("데이터 입력에 실패했습니다. 확인 후 다시 이용해주세요. <br/> <b>실패사유</b> : " + rtn.messages);
				}
			});
		}
	}
}

function managecodeProcValidation(val) {
	if (val == 'insert') {
		if ($('#Managecode_character_seq').val() == undefined || $('#Managecode_character_seq').val() == "") {
			$.alert("숙제를 적용할 캐릭터를 선택해주세요.");
			return false;
		}
		
		if ($("input:checkbox[name='readyManagecodeCheckBox']:checked").length < 1) {
			$.alert("추가할 숙제를 선택해주세요.");
			return false;
		}
	} else if (val == 'delete') {
		if ($('#Management_character_seq').val() == undefined || $('#Management_character_seq').val() == "") {
			$.alert("숙제를 적용할 캐릭터를 선택해주세요.");
			return false;
		}
		
		if ($("input:checkbox[name='ingManagecodeCheckBox']:checked").length < 1) {
			$.alert("제거할 숙제를 선택해주세요.");
			return false;
		}
	}
	
	return true;
}

function selectManagecode(managecode, complete_count) {
	if ($("#managecode_cb_" + managecode).prop("checked")) {
		$("#managecode_cb_" + managecode).prop("checked", false);
		$("#managecode_tr_" + managecode).removeClass("table-active");
	} else {
		$("#managecode_cb_" + managecode).prop("checked", true);
		$("#managecode_tr_" + managecode).addClass("table-active");
	}
}

function selectParantcode(managecode) {
	if ($("#parantcode_cb_" + managecode).prop("checked")) {
		$("#parantcode_cb_" + managecode).prop("checked", false);
		$(".cb_" + managecode).prop("checked", false);
		$(".tr-" + managecode).removeClass("table-active");
	} else {
		$("#parantcode_cb_" + managecode).prop("checked", true);
		$(".cb_" + managecode).prop("checked", true);
		$(".tr-" + managecode).addClass("table-active");
	}
}

function selectManagement(management) {
	if ($("#management_cb_" + management).prop("checked")) {
		$("#management_cb_" + management).prop("checked", false);
		$("#management_tr_" + management).removeClass("table-active");
	} else {
		$("#management_cb_" + management).prop("checked", true);
		$("#management_tr_" + management).addClass("table-active");
	}
}

function selectParantManagement(managecode) {
	if ($("#parant_management_cb_" + managecode).prop("checked")) {
		$("#parant_management_cb_" + managecode).prop("checked", false);
		$(".mcb_" + managecode).prop("checked", false);
		$(".mtr-" + managecode).removeClass("table-active");
	} else {
		$("#parant_management_cb_" + managecode).prop("checked", true);
		$(".mcb_" + managecode).prop("checked", true);
		$(".mtr-" + managecode).addClass("table-active");
	}
}

function addManagement() {
	$('#own_management_code_desc').val('');
	$('#own_belong_condition').val('');
	$('#own_cycle_condition').val('');
	$('#own_complete_count').val('');

		$("#btn_managecodeAdd_modal").attr("onclick", "managecodeAddProc('insert');");
			
	let options = {
			backdrop: true,
			keyboard: true,
			focus: true
		};
		
	let myModal = new bootstrap.Modal(document.getElementById('managecodeAdd_modal'), options);
	myModal.show();
}

function deleteProcChk(character_seq, mode) {
	$.feedback("정말 삭제하시겠습니까?", "characterProc('" + character_seq + "', '" + mode + "');");
}

function characterProc(character_seq, mode) {
	$('#Management_character_seq').val(character_seq);
	$('#Management_proc_role').val(mode);
	
	if (characterProcValidation()) {
		ajaxCall4Html(ctxPath + '/characterEditProc', $("#formCharacterManagement").separator('separatorRemoveForm').serialize(), function(data) {
			var rtn = JSON.parse(data);
// 			console.log(rtn);
			if (rtn.result == 'YES') {
				$.confirm("삭제되었습니다.", "window.location.reload();");
			} else {
				$.alert("삭제에 실패했습니다. 확인 후 다시 이용해주세요. <br/> <b>실패사유</b> : " + rtn.messages);
			}
		});
	}
}

function characterProcValidation() {
	if ($('#Management_character_seq').val() == undefined || $('#Management_character_seq').val() == "") {
		$.alert("삭제할 캐릭터의 정보가 완전하지 않습니다. 새로고침 후 다시 실행해주세요.");
		return false;
	}
	
	return true;
}

function customManagecodeProcChk(managecode, mode) {
	if (mode == 'delete') {
		$.feedback("정말 삭제하시겠습니까?", "customManagecodeProc('" + managecode + "', '" + mode + "');");
	} else if (mode == 'update') {
		$.ajax({
			url : ctxPath+'/managecodePreview',
			type : 'post',
			dataType : "json",
			async : false,
			data : {management_code : managecode},
			success : function(rtn) {
// 	 			console.log(rtn);
	 			$('#manageAdd_management_code').val(rtn.data.management_code);
	 			$('#own_management_code_desc').val(rtn.data.management_code_desc);
	 			$('#own_belong_condition').val(rtn.data.belong_condition);
	 			$('#own_cycle_condition').val(rtn.data.cycle_condition);
	 			$('#own_complete_count').val(rtn.data.complete_count);

	 			$("#btn_managecodeAdd_modal").attr("onclick", "managecodeAddProc('update');");
	 			
	 			let options = {
	 					backdrop: true,
	 					keyboard: true,
	 					focus: true
	 				};
	 				
	 			let myModal = new bootstrap.Modal(document.getElementById('managecodeAdd_modal'), options);
	 			myModal.show();
			},
			error:function(request,status,error){
				console.log(error);
			}
		});
	}
}

function customManagecodeProc(managecode, mode) {
	$('#Managecode_managecode').val(managecode);
	$('#Managecode_proc_role').val(mode);
	
	if (customManagecodeProcValidation()) {
		ajaxCall4Html(ctxPath + '/managecodeProc', $("#formCharacterManagecode").separator('separatorRemoveForm').serialize(), function(data) {
			var rtn = JSON.parse(data);
			console.log(rtn);
			if (rtn.result == 'YES') {
				$.confirm("삭제되었습니다.", "window.location.reload();");
			} else {
				$.alert("삭제에 실패했습니다. 확인 후 다시 이용해주세요. <br/> <b>실패사유</b> : " + rtn.messages);
			}
		});
	}
}

function customManagecodeProcValidation() {
	if ($('#Managecode_managecode').val() == undefined || $('#Managecode_managecode').val() == "") {
		$.alert("삭제할 커스텀숙제의 정보가 완전하지 않습니다. 새로고침 후 다시 실행해주세요.");
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
			<div class="row">
				<div class="col-sm-3 col-xs-3">
					<div class="card">
						<div class="card-body">
							<div style="overflow: auto; max-height: 900px;">
								<form id="formCharacterManagecode" action="" method="post">
									<input type="hidden" id="Managecode_character_seq" name="character_seq"/>
									<input type="hidden" id="Managecode_user_seq" name="user_seq"/>
									
									<input type="hidden" id="Managecode_managecode" name="management_code"/>
									
									<input type="hidden" id="Managecode_proc_role" name="proc_role"/>
								</form>
								<form id="formCharacterManagement" action="" method="post">
									<input type="hidden" id="Management_character_seq" name="character_seq"/>
									<input type="hidden" id="Management_management_code" name="management_code"/>
									
									<input type="hidden" id="Management_proc_role" name="proc_role"/>
								</form>
								<table class="table table-hover character-table" id="characterTableInfo" style="width: 100%;">
									<thead>
										<tr>
											<th colspan="2" width="114px" class="text-center" style="cursor: pointer;" onclick="searchCharacter();">
												<button class="btn btn-secondary p-0" style="width: 50px;"><i class="bi bi-person-plus-fill"></i></button>
											</th>
											<th width="*" class="text-center">닉네임</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="characterList" items="${characterList}" varStatus="status">
											<tr id="character_tr_${characterList.character_seq}" class="btn-fn character-data">
												<td width="5%;" style="padding-top: 36px;">
													<button class="btn btn-outline-danger p-0"><i class="bi bi-person-dash-fill" onclick="deleteProcChk('${characterList.character_seq}', 'delete');"></i></button>
												</td>
												<td class="character-image" onclick="selectCharacter('${characterList.character_seq}');">
													<img src="${characterList.character_img}" alt="캐릭터 이미지">
<!-- 													<img class="character-image-bg" src="https://ssl.nexon.com/s2/game/maplestory/renewal/common/rank_other.png" alt="캐릭터 이미지 배경"> -->
												</td>
												<td class="text-center text-vertical-center" onclick="selectCharacter('${characterList.character_seq}');">${characterList.character_name}</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
				<div class="col-sm-9 col-xs-9">
					<div class="card">
						<div class="card-body">
							<div style="position: relative; overflow: auto; height: 900px;">
								<div id="planEditer" class="row" style="position: absolute; height: 100%; width: 100%;">
									<jsp:include page="/WEB-INF/views/innerPage/innerManagecodeList.jsp"></jsp:include>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<jsp:include page="/include/popup/characterSearchModal.jsp" />
		<jsp:include page="/include/popup/managecodeAddModal.jsp" />
		<jsp:include page="/include/popup/feedbackModal.jsp" />
		<jsp:include page="/include/footer.jsp"></jsp:include>
	</div>
</body>
</html>