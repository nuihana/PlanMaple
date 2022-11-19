<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/include/commonHead.jsp" %>

<!-- chart.js -->
<script src="${pageContext.request.contextPath}/static/chart/chart.min.js" type="text/javascript"></script>

<script type="text/javascript">
var htmlRenderingCnt = 0;

function renderMonsterInsertForm() {
	let varHtml = "";
	
	varHtml += "<tr id='farm-timer-tr" + htmlRenderingCnt + "'>";
	varHtml += "<td>";
	varHtml += "<i class='btn-fn bi bi-dash-square' onclick='removeFarmTimerTr(\"" + htmlRenderingCnt + "\");'></i>";
	varHtml += "</td>";
	varHtml += "<td>";
	varHtml += "<input class='farm-timer-input' type='text' name='farm_timer_list[" + htmlRenderingCnt + "].timer_desc' />";
	varHtml += "</td>";
	varHtml += "<td>";
	varHtml += "<select class='farm-timer-select' name='farm_timer_list[" + htmlRenderingCnt + "].timer_code'>";
	varHtml += "<option value=''>선택</option>";
	varHtml += "<option value='FARM_001'>수명연장</option>";
	varHtml += "<option value='FARM_002'>조합수명</option>";
	varHtml += "</select>";
	varHtml += "</td>";
	varHtml += "</tr>";
	
	$('#renderingPlusTr').before(varHtml);
	htmlRenderingCnt++;
}

function removeFarmTimerTr(seq) {
	$('#farm-timer-tr' + seq).remove();
}

function insertFarmTimer() {
	$('#farm_insert_proc_role').val('farm_save');
	
	if (insertFarmTimerValidation()) {
		ajaxCall4Html(ctxPath + '/timerProc', $("#formFarmInsert").serialize(), function(data) {
			var rtn = JSON.parse(data);
			console.log(rtn);
			
			if (rtn.result == 'YES') {
				$.confirm(rtn.messages, "renderFarmList();");
			} else {
				$.alert("데이터 입력에 실패했습니다. 확인 후 다시 이용해주세요. <br/> <b>실패사유</b> : " + rtn.messages);
			}
		});
	}
}

function insertFarmTimerValidation() {
	if ($('.farm-timer-input').length == 0) {
		$.alert("입력할 농장 데이터가 존재하지 않습니다.");
		return false;
	}
	
	let flag = true;
	
	$('.farm-timer-input').each(function (index, el) {
		$(this).attr('name', el.name.replace(/[0-9]/, index));
		
		if (el.value == undefined || el.value == "") {
			flag = false;
		}
	});
	
	if (!flag) {
		$.alert("입력 대상의 이름을 입력해주세요.");
		return flag;
	}

	$('.farm-timer-select').each(function (index, el) {
		$(this).attr('name', el.name.replace(/[0-9]/, index));
		
		if (el.value == undefined || el.value == "") {
			flag = false;
		}
	});
	
	if (!flag) {
		$.alert("입력 대상의 상태를 입력해주세요.");
		return flag;
	}
	
	return true;
}
</script>

<c:set var="expired" value="0" />
<c:set var="danger" value="0" />
<c:set var="warning" value="0" />

<c:forEach var="farmTimerList" items="${farmTimerList}" varStatus="status">
	<c:choose>
		<c:when test="${farmTimerList.getDeadlineFlag() < 0}">
			<c:set var="expired" value="${expired + 1}" />
		</c:when>
		<c:when test="${farmTimerList.getDeadlineFlag() < 3}">
			<c:set var="danger" value="${danger + 1}" />
		</c:when>
		<c:when test="${farmTimerList.getDeadlineFlag() < 7}">
			<c:set var="warning" value="${warning + 1}" />
		</c:when>
	</c:choose>
</c:forEach>

<div class="row mb-3">
	<div class="col-sm-4 col-xs-4">
		<div class="card text-center">
			<div class="card-header" style="background-color: rgba(0,0,0,.1);">만료</div>
			<div class="card-body">${expired}</div>
		</div>
	</div>
	<div class="col-sm-4 col-xs-4">
		<div class="card text-center">
			<div class="card-header" style="background-color: #FFDCDC;">72시간 이내 만료</div>
			<div class="card-body">${danger}</div>
		</div>
	</div>
	<div class="col-sm-4 col-xs-4">
		<div class="card text-center">
			<div class="card-header" style="background-color: #FFE999;">7일 이내 만료</div>
			<div class="card-body">${warning}</div>
		</div>
	</div>
</div>
<div class="card">
	<div class="card-body" style="overflow: auto; min-height: 762px; max-height: 762px;">
		<form id="formFarmInsert" action="">
			<input type="hidden" id="farm_insert_proc_role" name="proc_role"/>
			
			<table class="table table-hover text-center" id="" style="width: 100%;">
				<thead>
					<tr>
						<th width="10%"></th>
						<th width="*" class="text-center">대상</th>
						<th width="20%;" class="text-center">상태</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="farmTimerList" items="${farmTimerList}" varStatus="status">
						<tr id="farm_tr_${farmTimerList.timer_seq}" class="btn-fn farm-data" onclick="selectFarmMonster('${farmTimerList.timer_seq}');">
							<td colspan="2">${farmTimerList.timer_desc}</td>
							<td><i class="bi bi-circle-fill" 
								<c:choose>
									<c:when test="${farmTimerList.getDeadlineFlag() < 0}">
										style="color: rgba(0,0,0,.1);"
									</c:when>
									<c:when test="${farmTimerList.getDeadlineFlag() < 3}">
										style="color: #FFACAC;"
									</c:when>
									<c:when test="${farmTimerList.getDeadlineFlag() < 7}">
										style="color: #FFE999;"
									</c:when>
									<c:otherwise>
										style="color: #20C997;"
									</c:otherwise>
								</c:choose>
								></i>
							</td>
						</tr>
					</c:forEach>
					<tr id="renderingPlusTr" class="btn-fn" onclick="renderMonsterInsertForm();">
						<td colspan="3"><i class="bi bi-plus-lg"></i></td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
	<div class="card-footer text-end">
		<button type="button" class="btn btn-secondary" onclick="insertFarmTimer();">입력 몬스터 저장</button>
	</div>
</div>