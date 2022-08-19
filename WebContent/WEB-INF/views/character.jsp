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
	$("#characterSearch_modal").modal();
}

function selectCharacter(character_seq) {
	$('.character-data').removeClass("active");
	
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
	
	$("#character_tr_" + character_seq).addClass("active");
}

function managecodeProc(val) {
	if (managecodeProcValidation(val)) {
		$('#Managecode_proc_role').val(val);
		$('#Management_proc_role').val(val);
		
		if (val == 'insert') {
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
		
		if ($('#Managecode_managecode').val() == undefined || $('#Managecode_managecode').val() == "") {
			$.alert("추가할 숙제를 선택해주세요.");
			return false;
		}
	} else if (val == 'delete') {
		if ($('#Management_character_seq').val() == undefined || $('#Management_character_seq').val() == "") {
			$.alert("숙제를 적용할 캐릭터를 선택해주세요.");
			return false;
		}
		
		if ($('#Management_management_code').val() == undefined || $('#Management_management_code').val() == "") {
			$.alert("제거할 숙제를 선택해주세요.");
			return false;
		}
	}
	
	return true;
}

function selectManagecode(managecode, complete_count) {
	$('.managecode-data').removeClass("active");
	
	$('#Managecode_managecode').val(managecode);
	$('#Managecode_complete_count').val(complete_count);
	
	if (managecode != "") {
		
	} else {
		
	}
	
	$("#managecode_tr_" + managecode).addClass("active");
}

function selectManagement(management) {
	$('.management-data').removeClass("active");
	
	$('#Management_management_code').val(management);
	
	if (management != "") {
		
	} else {
		
	}
	
	$("#management_tr_" + management).addClass("active");
}
</script>

</head>
<body>
	<div class="main-container">
		<jsp:include page="/include/header.jsp"></jsp:include>
		<div class="row main-content">
			<div class="col-sm-3 col-xs-3">
				<div class="panel panel-default">
					<div class="panel-body">
						<div style="overflow: auto; max-height: 900px;">
							<form id="formCharacterManagecode" action="" method="post">
								<input type="hidden" id="Managecode_character_seq" name="character_seq"/>
								<input type="hidden" id="Managecode_user_seq" name="user_seq"/>
								
								<input type="hidden" id="Managecode_managecode" name="management_code"/>
								<input type="hidden" id="Managecode_complete_count" name="complete_count"/>
								
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
										<th width="114px" class="text-center" style="cursor: pointer;" onclick="searchCharacter();">
											<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
										</th>
										<th width="*" class="text-center">닉네임</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="characterList" items="${characterList}" varStatus="status">
										<tr id="character_tr_${characterList.character_seq}" class="btn-fn character-data" onclick="selectCharacter('${characterList.character_seq}');">
											<td class="character-image">
												<img src="${characterList.character_img}" alt="캐릭터 이미지">
												<img class="character-image-bg" src="https://ssl.nexon.com/s2/game/maplestory/renewal/common/rank_other.png" alt="캐릭터 이미지 배경">
											</td>
											<td class="text-center text-vertical-center">${characterList.character_name}</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
			<div class="col-sm-9 col-xs-9">
				<div class="panel panel-default">
					<div class="panel-body">
						<div style="overflow: auto; height: 900px;">
							<div id="planEditer" class="row" style="height: 100%;">
								<jsp:include page="/WEB-INF/views/innerPage/innerManagecodeList.jsp"></jsp:include>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<jsp:include page="/include/footer.jsp"></jsp:include>
	</div>
	
	<jsp:include page="/include/popup/characterSearchModal.jsp" />
</body>
</html>