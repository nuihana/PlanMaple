<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/include/commonHead.jsp" %>

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
							<td width="5%"><input type="checkbox" id="parantcode_cb_${readyManagecodeList.management_code}" class="cb_${readyManagecodeList.management_code}" value="${readyManagecodeList.management_code}"></td>
							<td width="*">${readyManagecodeList.management_code_desc}</td>
						</tr>
					</c:when>
					<c:otherwise>
						<tr id="managecode_tr_${readyManagecodeList.management_code}" class="text-center btn-fn tr-${readyManagecodeList.parant_code}" onclick="selectManagecode('${readyManagecodeList.management_code}');">
							<td width="5%"><input type="checkbox" id="managecode_cb_${readyManagecodeList.management_code}" class="cb_${readyManagecodeList.parant_code}" name="readyManagecodeCheckBox" value="${readyManagecodeList.management_code}"></td>
							<td width="*">${readyManagecodeList.management_code_desc}</td>
						</tr>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</tbody>
	</table>
</div>
<div class="col-sm-2" style="height: 100%; display: flex; align-items: center; justify-content: center;">
	<table>
		<tr>
			<td class="btn-fn">
				<span class="glyphicon glyphicon-chevron-right pb-8" aria-hidden="true" style="font-size: 2.0em;" onclick="managecodeProc('insert');"></span>
			</td>
		</tr>
		<tr>
			<td class="btn-fn">
				<span class="glyphicon glyphicon-chevron-left" aria-hidden="true" style="font-size: 2.0em;" onclick="managecodeProc('delete');"></span>
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
							<td width="5%"><input type="checkbox" id="parant_management_cb_${ingManagecodeList.management_code}" class="mcb_${ingManagecodeList.management_code}" value="${ingManagecodeList.management_code}"></td>
							<td width="*">${ingManagecodeList.management_code_desc}</td>
						</tr>
					</c:when>
					<c:otherwise>
						<tr id="management_tr_${ingManagecodeList.management_code}" class="text-center btn-fn mtr-${ingManagecodeList.parant_code}" onclick="selectManagement('${ingManagecodeList.management_code}');">
							<td width="5%"><input type="checkbox" id="management_cb_${ingManagecodeList.management_code}" class="mcb_${ingManagecodeList.parant_code}" name="ingManagecodeCheckBox" value="${ingManagecodeList.management_code}"></td>
							<td width="*">${ingManagecodeList.management_code_desc}</td>
						</tr>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</tbody>
	</table>
</div>