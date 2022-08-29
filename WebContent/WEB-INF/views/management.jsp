<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/include/commonHead.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${config.getValue('Title')}</title>
<meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>

<jsp:include page="/include/resource.jsp" />

<style>
.manage{
    width: 17px;
    height: 17px;
}

.manage-tooltip{
	position: absolute;
    background-color: rgba(0,0,0,0.7);
    color: #fff;
    border-radius: 50%;
    width: 17px;
    height: 17px;
    top: -4px;
    right: 32px;
    z-index: 1;
	opacity: 0; /* 기본 상태는 안보이게 */
    transition: all 0.1s linear; /* 나타났다 사라지는 애니메이션 */
}
</style>

<script type="text/javascript">
function checkManageBox(seq, comp_count) {
	if ($('#managebox_' + seq).val() < comp_count) {
		$('#managebox_' + seq).val($('#managebox_' + seq).val() * 1 + 1);
		$('#manage_tooltip_' + seq).html($('#managebox_' + seq).val());
		$('#manage_tooltip_' + seq).css('opacity', '1');
		$('#managebox_' + seq).prop("checked", true);
	} else {
		$('#managebox_' + seq).val(0);
		$('#manage_tooltip_' + seq).html('');
		$('#manage_tooltip_' + seq).css('opacity', '0');
		$('#managebox_' + seq).prop("checked", false);
	}
	
	if ($('#managebox_' + seq).val() == comp_count) {
		$('#manage_tooltip_' + seq).html('<span class="glyphicon glyphicon-ok" aria-hidden="true" style="font-size: 0.8em;"></span>');
	}
}

function managementProc(seq, proc_count) {
	$('#management_seq').val(seq);
	$('#complete_count').val(proc_count);
	
	if (managementValidation()) {
		ajaxCall4Html(ctxPath + '/managementProc', $("#formManagementEdit").separator('separatorRemoveForm').serialize(), function(data) {
			var rtn = JSON.parse(data);
			console.log(rtn);
// 			if (rtn.result == 'YES') {
// 				$.confirm("데이터 제거가 완료되었습니다.", "selectCharacter('" + $('#Management_character_seq').val() + "');");
// 			} else {
// 				$.alert("데이터 입력에 실패했습니다. 확인 후 다시 이용해주세요. <br/> <b>실패사유</b> : " + rtn.messages);
// 			}
		});
	}
}

function managementValidation() {
	if ($('#management_seq').val() == undefined || $('#management_seq').val() == "") {
		$.alert("존재하지 않는 숙제 코드입니다.");
		return false;
	}

	if ($('#complete_count').val() == undefined || $('#complete_count').val() == "") {
		$.alert("완료 횟수가 정확히 입력되지 않았습니다.");
		return false;
	}
	
	return true;
}
</script>

</head>
<body>
	<div class="main-container">
		<jsp:include page="/include/header.jsp"></jsp:include>
		<div class="row main-content">
			<div class="col-sm-12 col-xs-12">
				<div class="panel panel-default">
					<div class="panel-body">
						<div style="overflow: auto; width: 100%; max-height: 900px;">
							<form id="formManagementEdit" action="" method="post">
								<input type="hidden" id="management_seq" name="management_seq"/>
								<input type="hidden" id="complete_count" name="complete_count"/>
							</form>
							<table class="table table-hover" style="width: auto;">
								<thead>
									<tr class="character-data">
										<th rowspan="2" width="50px;"></th>
										<c:forEach var="characterList" items="${characterList}" varStatus="status">
											<td width="114px" class="character-image character-image-table">
												<span>
													<img src="${characterList.character_img}" alt="캐릭터 이미지">
													<img class="character-image-bg character-image-table" src="https://ssl.nexon.com/s2/game/maplestory/renewal/common/rank_other.png" alt="캐릭터 이미지 배경">
												</span>
											</td>
										</c:forEach>
									</tr>
									<tr>
										<c:forEach var="characterList" items="${characterList}" varStatus="status">
											<th class="text-center" style="border-top: none;">
												<span>${characterList.character_name}</span>
											</th>
										</c:forEach>
									</tr>
								</thead>
								<tbody>
<!-- 									<tr> -->
<!-- 										<th rowspan="2" width="114px"></th> -->
<%-- 										<c:forEach var="headManagecodeList" items="${headManagecodeList}" varStatus="status"> --%>
<%-- 											<th colspan="${headManagecodeList.chid_count}" class="text-center" style="width: 50px; white-space:nowrap; border-left: 2px solid #ddd; border-right: 2px solid #ddd;"> --%>
<%-- 												${headManagecodeList.management_code_desc} --%>
<!-- 											</th> -->
<%-- 										</c:forEach> --%>
<!-- 									</tr> -->
									<c:forEach var="bodyManagecodeList" items="${bodyManagecodeList}" varStatus="status">
										<tr>
											<td style="white-space:nowrap;">
												${bodyManagecodeList.management_code_desc}
											</td>
											<c:forEach var="unique_managementlist" items="${bodyManagecodeList.unique_managementlist}" varStatus="status_">
												<td class="text-center" style="white-space:nowrap;">
													<div style="position: relative;">
														<c:if test="${unique_managementlist.complete_count ne null}">
															<input id="managebox_${unique_managementlist.management_seq}" class="manage" type="checkbox" name="management-box"
															onclick="checkManageBox('${unique_managementlist.management_seq}', '${bodyManagecodeList.complete_count}');" value="${unique_managementlist.complete_count}">
															<span id="manage_tooltip_${unique_managementlist.management_seq}" class="manage-tooltip"></span>
														</c:if>
													</div>
												</td>
											</c:forEach>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
		<jsp:include page="/include/footer.jsp"></jsp:include>
	</div>
</body>
</html>