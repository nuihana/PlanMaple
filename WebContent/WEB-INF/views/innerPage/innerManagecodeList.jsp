<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/include/commonHead.jsp" %>

<div class="col-sm-4 col-sm-offset-1">
	<form id="formManagecodeSave" class="form-horizontal" action="" method="post">
		
	</form>
	<table class="table table-hover">
		<thead>
			<tr>
				<th class="text-center">숙제목록</th>
			</tr>
		</thead>
		<tbody id="manageCodeTbl">
			<c:forEach var="managecodeList" items="${managecodeList}" varStatus="status">
				<tr>
					<td id="managecode_tr_${managecodeList.management_code}" class="text-center btn-fn managecode-data" onclick="selectManagecode('${managecodeList.management_code}', '${managecodeList.complete_count}');">${managecodeList.management_code_desc}</td>
				</tr>
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
<div class="col-sm-4">
	<table class="table table-hover">
		<thead>
			<tr>
				<th class="text-center">진행중</th>
			</tr>
		</thead>
	</table>
</div>