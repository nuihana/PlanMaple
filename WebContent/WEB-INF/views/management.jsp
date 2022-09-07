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

.deadline-box{
	border-color: #FFDCDC;
	box-shadow: 0 0 0 0.25rem rgb(220 53 69 / 25%);
    transition: all 0.25s linear;
}
</style>

<script type="text/javascript">
function checkManageBoxProc(seq, comp_count, managecode, condition, server) {
	if (condition == 'W') {
		checkManageBoxWorldGroup(seq, comp_count, managecode, condition, server);
	} else if (condition == 'I') {
		checkManageBoxIDGroup(seq, comp_count, managecode, condition);
	} else {
		checkManageBox(seq, comp_count);
	}
}

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
		$('#manage_tooltip_' + seq).html('<i class="bi bi-check-lg"></i>');
		$('#managebox_' + seq).removeClass('deadline-box');
	} else {
		$('#managebox_' + seq).addClass('deadline-box');
	}
	
	managementProc(seq, $('#managebox_' + seq).val());
}

function checkManageBoxIDGroup(seq, comp_count, managecode, condition) {
	if ($('#managebox_' + seq).val() < comp_count) {
		$('.' + managecode).val($('#managebox_' + seq).val() * 1 + 1);
		$('.tooltip-' + managecode).html($('#managebox_' + seq).val());
		$('.tooltip-' + managecode).css('opacity', '1');
		$('.' + managecode).prop("checked", true);
	} else {
		$('.' + managecode).val(0);
		$('.tooltip-' + managecode).html('');
		$('.tooltip-' + managecode).css('opacity', '0');
		$('.' + managecode).prop("checked", false);
	}
	
	if ($('#managebox_' + seq).val() == comp_count) {
		$('.tooltip-' + managecode).html('<i class="bi bi-check-lg"></i>');
		$('.' + managecode).removeClass('deadline-box');
	} else {
		$('.' + managecode).addClass('deadline-box');
	}
	
	managementGroupProc(seq, managecode, $('#managebox_' + seq).val(), condition);
}

function checkManageBoxWorldGroup(seq, comp_count, managecode, condition, server) {
	if ($('#managebox_' + seq).val() < comp_count) {
		$('.' + managecode + '-' + server).val($('#managebox_' + seq).val() * 1 + 1);
		$('.tooltip-' + managecode + '-' + server).html($('#managebox_' + seq).val());
		$('.tooltip-' + managecode + '-' + server).css('opacity', '1');
		$('.' + managecode + '-' + server).prop("checked", true);
	} else {
		$('.' + managecode + '-' + server).val(0);
		$('.tooltip-' + managecode + '-' + server).html('');
		$('.tooltip-' + managecode + '-' + server).css('opacity', '0');
		$('.' + managecode + '-' + server).prop("checked", false);
	}
	
	if ($('#managebox_' + seq).val() == comp_count) {
		$('.tooltip-' + managecode + '-' + server).html('<i class="bi bi-check-lg"></i>');
		$('.' + managecode + '-' + server).removeClass('deadline-box');
	} else {
		$('.' + managecode + '-' + server).addClass('deadline-box');
	}
	
	managementGroupProc(seq, managecode, $('#managebox_' + seq).val(), condition);
}

function managementProc(seq, proc_count) {
	$('#management_seq').val(seq);
	$('#complete_count').val(proc_count);
	$('#proc_role').val('update_seq');
	
	if (managementValidation()) {
		ajaxCall4Html(ctxPath + '/managementProc', $("#formManagementEdit").separator('separatorRemoveForm').serialize(), function(data) {
			var rtn = JSON.parse(data);
// 			console.log(rtn);
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

function managementGroupProc(seq, managecode, proc_count, condition) {
	$('#management_seq').val(seq);
	$('#management_code').val(managecode);
	$('#complete_count').val(proc_count);
	$('#belong_condition').val(condition);
	$('#proc_role').val('update_code');
	
	if (managementGroupValidation()) {
		ajaxCall4Html(ctxPath + '/managementProc', $("#formManagementEdit").separator('separatorRemoveForm').serialize(), function(data) {
			var rtn = JSON.parse(data);
// 			console.log(rtn);
		});
	}
}

function managementGroupValidation() {
	if ($('#management_seq').val() == undefined || $('#management_seq').val() == "") {
		$.alert("존재하지 않는 숙제 코드입니다.");
		return false;
	}
	
	if ($('#management_code').val() == undefined || $('#management_code').val() == "") {
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
		<div class="container">
			<div class="row">
				<div class="col-sm-12 col-xs-12">
					<div class="card">
						<div class="card-body">
							<div style="overflow: auto; width: 100%; max-height: 900px;">
								<form id="formManagementEdit" action="" method="post">
									<input type="hidden" id="management_seq" name="management_seq"/>
									<input type="hidden" id="management_code" name="management_code"/>
									<input type="hidden" id="complete_count" name="complete_count"/>
									<input type="hidden" id="belong_condition" name="belong_condition"/>
									
									<input type="hidden" id="proc_role" name="proc_role"/>
								</form>
								<table class="table table-hover" style="width: auto;">
									<thead>
										<tr>
											<th rowspan="2" width="50px;" style="border-bottom: none;"></th>
											<c:forEach var="characterList" items="${characterList}" varStatus="status">
												<th width="114px" class="character-image" style="border-bottom: none;">
													<span>
														<img src="${characterList.character_img}" alt="캐릭터 이미지">
														<img class="character-image-bg" src="https://ssl.nexon.com/s2/game/maplestory/renewal/common/rank_other.png" alt="캐릭터 이미지 배경">
													</span>
												</th>
											</c:forEach>
										</tr>
										<tr>
											<c:forEach var="characterList" items="${characterList}" varStatus="status">
												<th class="text-center" style="border-bottom: none;">
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
													<td class="text-center" style="white-space:nowrap;" onclick="checkManageBoxProc('${unique_managementlist.management_seq}', '${bodyManagecodeList.complete_count}', '${unique_managementlist.management_code}', '${unique_managementlist.belong_condition}', '${unique_managementlist.server_code}');">
														<div style="position: relative;">
															<c:if test="${unique_managementlist.complete_count ne null}">
																<c:choose>
																	<c:when test="${unique_managementlist.complete_count eq bodyManagecodeList.complete_count}">
																		<input id="managebox_${unique_managementlist.management_seq}"
																			class="manage <c:if test="${unique_managementlist.belong_condition eq 'W'}">${unique_managementlist.management_code}-${unique_managementlist.server_code}</c:if> <c:if test="${unique_managementlist.belong_condition eq 'I'}">${unique_managementlist.management_code}</c:if>"
																			type="checkbox" name="management-box" value="${unique_managementlist.complete_count}" checked="checked">
																		<span id="manage_tooltip_${unique_managementlist.management_seq}"
																			class="manage-tooltip <c:if test="${unique_managementlist.belong_condition eq 'W'}">tooltip-${unique_managementlist.management_code}-${unique_managementlist.server_code}</c:if> <c:if test="${unique_managementlist.belong_condition eq 'I'}">tooltip-${unique_managementlist.management_code}</c:if>"
																			style="opacity: 1;"><i class="bi bi-check-lg"></i></span>
																	</c:when>
																	<c:when test="${unique_managementlist.complete_count gt 0 and unique_managementlist.complete_count lt bodyManagecodeList.complete_count}">
																		<input id="managebox_${unique_managementlist.management_seq}"
																			class="manage <c:if test="${unique_managementlist.deadline_flag eq 'Y'}">deadline-box</c:if> <c:if test="${unique_managementlist.belong_condition eq 'W'}">${unique_managementlist.management_code}-${unique_managementlist.server_code}</c:if> <c:if test="${unique_managementlist.belong_condition eq 'I'}">${unique_managementlist.management_code}</c:if>"
																			type="checkbox" name="management-box" value="${unique_managementlist.complete_count}" checked="checked">
																		<span id="manage_tooltip_${unique_managementlist.management_seq}"
																			class="manage-tooltip <c:if test="${unique_managementlist.belong_condition eq 'W'}">tooltip-${unique_managementlist.management_code}-${unique_managementlist.server_code}</c:if> <c:if test="${unique_managementlist.belong_condition eq 'I'}">tooltip-${unique_managementlist.management_code}</c:if>"
																			style="opacity: 1;">${unique_managementlist.complete_count}</span>
																	</c:when>
																	<c:otherwise>
																		<input id="managebox_${unique_managementlist.management_seq}"
																			class="manage <c:if test="${unique_managementlist.deadline_flag eq 'Y'}">deadline-box</c:if> <c:if test="${unique_managementlist.belong_condition eq 'W'}">${unique_managementlist.management_code}-${unique_managementlist.server_code}</c:if> <c:if test="${unique_managementlist.belong_condition eq 'I'}">${unique_managementlist.management_code}</c:if>"
																			type="checkbox" name="management-box" value="${unique_managementlist.complete_count}">
																		<span id="manage_tooltip_${unique_managementlist.management_seq}"
																			class="manage-tooltip <c:if test="${unique_managementlist.belong_condition eq 'W'}">tooltip-${unique_managementlist.management_code}-${unique_managementlist.server_code}</c:if> <c:if test="${unique_managementlist.belong_condition eq 'I'}">tooltip-${unique_managementlist.management_code}</c:if>"
																			></span>
																	</c:otherwise>
																</c:choose>
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
		</div>
		<jsp:include page="/include/footer.jsp"></jsp:include>
	</div>
</body>
</html>