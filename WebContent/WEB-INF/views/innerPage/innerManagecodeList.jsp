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
				<th colspan="2" class="text-center">숙제목록</th>
			</tr>
		</thead>
		<tbody id="manageCodeTbl">
			<c:forEach var="readyManagecodeList" items="${readyManagecodeList}" varStatus="status">
				<c:choose>
					<c:when test="${readyManagecodeList.parant_code eq ''}">
						<tr id="parantcode_tr_${readyManagecodeList.management_code}" class="text-center btn-fn" style="background-color: #bbb;" onclick="selectParantcode('${readyManagecodeList.management_code}');">
							<td width="5%"><input type="checkbox" id="parantcode_cb_${readyManagecodeList.management_code}" class="cb_${readyManagecodeList.management_code} cha_cb" value="${readyManagecodeList.management_code}"></td>
							<td width="*">${readyManagecodeList.management_code_desc}</td>
						</tr>
					</c:when>
					<c:otherwise>
						<tr id="managecode_tr_${readyManagecodeList.management_code}" class="text-center btn-fn tr-${readyManagecodeList.parant_code}" onclick="selectManagecode('${readyManagecodeList.management_code}');">
							<td width="5%"><input type="checkbox" id="managecode_cb_${readyManagecodeList.management_code}" class="cb_${readyManagecodeList.parant_code} cha_cb" name="readyManagecodeCheckBox" value="${readyManagecodeList.management_code}"></td>
							<td width="*">${readyManagecodeList.management_code_desc}</td>
						</tr>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</tbody>
	</table>
</div>
<div class="col-sm-2" style="display: flex; align-items: center; justify-content: center;">
	<table style="position: sticky; top: 400px; align-self: flex-start;">
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
	</table>
</div>
<div class="col-sm-5">
	<table class="table table-hover">
		<thead>
			<tr>
				<th colspan="2" class="text-center">진행중</th>
			</tr>
		</thead>
		<tbody id="managementTbl">
			<c:forEach var="ingManagecodeList" items="${ingManagecodeList}" varStatus="status">
				<c:choose>
					<c:when test="${ingManagecodeList.parant_code eq ''}">
						<tr id="parantmanagement_tr_${ingManagecodeList.management_code}" class="text-center btn-fn" style="background-color: #bbb;" onclick="selectParantManagement('${ingManagecodeList.management_code}');">
							<td width="5%"><input type="checkbox" id="parant_management_cb_${ingManagecodeList.management_code}" class="mcb_${ingManagecodeList.management_code} cha_cb" value="${ingManagecodeList.management_code}"></td>
							<td width="*">${ingManagecodeList.management_code_desc}</td>
						</tr>
					</c:when>
					<c:otherwise>
						<tr id="management_tr_${ingManagecodeList.management_code}" class="text-center btn-fn mtr-${ingManagecodeList.parant_code}" onclick="selectManagement('${ingManagecodeList.management_code}');">
							<td width="5%"><input type="checkbox" id="management_cb_${ingManagecodeList.management_code}" class="mcb_${ingManagecodeList.parant_code} cha_cb" name="ingManagecodeCheckBox" value="${ingManagecodeList.management_code}"></td>
							<td width="*">${ingManagecodeList.management_code_desc}</td>
						</tr>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</tbody>
	</table>
</div>