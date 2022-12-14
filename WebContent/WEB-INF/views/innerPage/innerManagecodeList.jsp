<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/include/commonHead.jsp" %>

<script type="text/javascript">
$(document).ready(function () {
	$('.cha_cb').on('click', function(e) {
		if (this.checked) {
			$("#" + this.id).prop("checked", false);
		} else {
			$("#" + this.id).prop("checked", true);
		}
	});
});
</script>

<div class="col-sm-5">
	<table class="table table-hover">
		<thead>
			<tr>
				<th colspan="3" class="text-center">
					<button class="btn btn-secondary p-0" style="width: 50px; position: absolute; left: 5%;" onclick="addManagement();"><i class="bi bi-calendar-plus-fill"></i></button>
					숙제목록
				</th>
			</tr>
		</thead>
		<tbody id="manageCodeTbl">
			<c:forEach var="readyManagecodeList" items="${readyManagecodeList}" varStatus="status">
				<c:choose>
					<c:when test="${readyManagecodeList.parant_code eq ''}">
						<tr id="parantcode_tr_${readyManagecodeList.management_code}" class="text-center btn-fn" style="background-color: #bbb;" onclick="selectParantcode('${readyManagecodeList.management_code}');">
							<td width="5%"><input type="checkbox" id="parantcode_cb_${readyManagecodeList.management_code}" class="cb_${readyManagecodeList.management_code} cha_cb" value="${readyManagecodeList.management_code}"></td>
							<td colspan="2" width="*">${readyManagecodeList.management_code_desc}</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:choose>
							<c:when test="${fn:contains(readyManagecodeList.management_code, 'ZYX')}">
								<tr id="managecode_tr_${readyManagecodeList.management_code}" class="text-center btn-fn tr-${readyManagecodeList.parant_code}">
									<td width="5%" onclick="selectManagecode('${readyManagecodeList.management_code}');"><input type="checkbox" id="managecode_cb_${readyManagecodeList.management_code}" class="cb_${readyManagecodeList.parant_code} cha_cb" name="readyManagecodeCheckBox" value="${readyManagecodeList.management_code}"></td>
									<td width="*" class="text-ellipsis-character-td" onclick="selectManagecode('${readyManagecodeList.management_code}');">${readyManagecodeList.management_code_desc}</td>
									<td width="5%">
										<div style="position: relative; width: 29px;">
											<button class="btn btn-outline-danger p-0" style="position: absolute; right: 5%; transform: translateX(-120%);"><i class="bi bi-dash" onclick="customManagecodeProcChk('${readyManagecodeList.management_code}', 'delete');"></i></button>
											<button class="btn btn-outline-danger p-0" style="position: absolute; right: 5%;"><i class="bi bi-pencil-square" onclick="customManagecodeProcChk('${readyManagecodeList.management_code}', 'update');"></i></button>
										</div>
									</td>
								</tr>
							</c:when>
							<c:otherwise>
								<tr id="managecode_tr_${readyManagecodeList.management_code}" class="text-center btn-fn tr-${readyManagecodeList.parant_code}" onclick="selectManagecode('${readyManagecodeList.management_code}');">
									<td width="5%"><input type="checkbox" id="managecode_cb_${readyManagecodeList.management_code}" class="cb_${readyManagecodeList.parant_code} cha_cb" name="readyManagecodeCheckBox" value="${readyManagecodeList.management_code}"></td>
									<td colspan="2" width="*">${readyManagecodeList.management_code_desc}</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</tbody>
	</table>
</div>
<div class="col-sm-2" style="display: flex; align-items: center; justify-content: center;">
	<table style="position: sticky; top: 350px; align-self: flex-start;">
		<tr>
			<td class="btn-fn">
				<i class="bi bi-arrow-right-circle-fill" style="font-size: 2.0em;" onclick="managecodeProc('insert');"></i>
			</td>
		</tr>
		<tr>
			<td class="btn-fn">
				<i class="bi bi-arrow-left-circle-fill" style="font-size: 2.0em;" onclick="managecodeProc('delete');"></i>
			</td>
		</tr>
		<tr style="height: 40px;"></tr>
		<tr>
			<td class="btn-fn">
				<i class="bi bi-bell-slash-fill" style="font-size: 1.8em;" onclick="alarmOffProc('alarmoff');"></i>
			</td>
		</tr>
		<tr>
			<td class="btn-fn">
				<i class="bi bi-bell-fill" style="font-size: 1.8em;" onclick="alarmOffProc('alarmon');"></i>
			</td>
		</tr>
	</table>
</div>
<div class="col-sm-5">
	<table class="table table-hover">
		<thead>
			<tr>
				<th colspan="3" class="text-center">진행중</th>
			</tr>
		</thead>
		<tbody id="managementTbl">
			<c:forEach var="ingManagecodeList" items="${ingManagecodeList}" varStatus="status">
				<c:choose>
					<c:when test="${ingManagecodeList.parant_code eq ''}">
						<tr id="parantmanagement_tr_${ingManagecodeList.management_code}" class="text-center btn-fn" style="background-color: #bbb;" onclick="selectParantManagement('${ingManagecodeList.management_code}');">
							<td width="5%"><input type="checkbox" id="parant_management_cb_${ingManagecodeList.management_code}" class="mcb_${ingManagecodeList.management_code} cha_cb" value="${ingManagecodeList.management_code}"></td>
							<td colspan="2" width="*">${ingManagecodeList.management_code_desc}</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:choose>
							<c:when test="${fn:contains(ingManagecodeList.management_code, 'ZYX')}">
								<tr id="management_tr_${ingManagecodeList.management_code}" class="text-center btn-fn mtr-${ingManagecodeList.parant_code}">
									<td width="5%" onclick="selectManagement('${ingManagecodeList.management_code}');"><input type="checkbox" id="management_cb_${ingManagecodeList.management_code}" class="mcb_${ingManagecodeList.parant_code} cha_cb" name="ingManagecodeCheckBox" value="${ingManagecodeList.management_code}"></td>
									<td width="*" class="text-ellipsis-character-td" onclick="selectManagement('${ingManagecodeList.management_code}');">
										<c:choose>
											<c:when test="${ingManagecodeList.use_yn eq 'Y'}">
												${ingManagecodeList.management_code_desc}
												<i class="bi bi-bell-fill"></i>
											</c:when>
											<c:otherwise>
												${ingManagecodeList.management_code_desc}
												<i class="bi bi-bell-slash"></i>
											</c:otherwise>
										</c:choose>
									</td>
									<td width="1%">
										<div style="position: relative; width: 29px;">
											<button class="btn btn-outline-danger p-0" style="position: absolute; right: 5%; transform: translateX(-120%);"><i class="bi bi-dash" onclick="customManagecodeProcChk('${ingManagecodeList.management_code}', 'delete');"></i></button>
											<button class="btn btn-outline-danger p-0" style="position: absolute; right: 5%;"><i class="bi bi-pencil-square" onclick="customManagecodeProcChk('${ingManagecodeList.management_code}', 'update');"></i></button>
										</div>
									</td>
								</tr>
							</c:when>
							<c:otherwise>
								<tr id="management_tr_${ingManagecodeList.management_code}" class="text-center btn-fn mtr-${ingManagecodeList.parant_code}" onclick="selectManagement('${ingManagecodeList.management_code}');">
									<td width="5%"><input type="checkbox" id="management_cb_${ingManagecodeList.management_code}" class="mcb_${ingManagecodeList.parant_code} cha_cb" name="ingManagecodeCheckBox" value="${ingManagecodeList.management_code}"></td>
									<td colspan="2" width="*">
										<c:choose>
											<c:when test="${ingManagecodeList.use_yn eq 'Y'}">
												${ingManagecodeList.management_code_desc}
												<i class="bi bi-bell-fill"></i>
											</c:when>
											<c:otherwise>
												${ingManagecodeList.management_code_desc}
												<i class="bi bi-bell-slash"></i>
											</c:otherwise>
										</c:choose>
									</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</tbody>
	</table>
</div>