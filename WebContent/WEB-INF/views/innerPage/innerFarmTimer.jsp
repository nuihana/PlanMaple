<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/include/commonHead.jsp" %>

<!-- chart.js -->
<script src="${pageContext.request.contextPath}/static/chart/chart.min.js" type="text/javascript"></script>

<script type="text/javascript">
$(document).ready(function () {
	const now = new Date();
	
	<c:if test="${farmVo ne null}">
		const farmCtx = $('#farmChart');
		
		const farmStartDate = new Date('${fn:substring(farmVo.timer_set_time, 0, 4)}', '${fn:substring(farmVo.timer_set_time, 5, 7)}' - 1, '${fn:substring(farmVo.timer_set_time, 8, 10)}',
									'${fn:substring(farmVo.timer_set_time, 11, 13)}', '${fn:substring(farmVo.timer_set_time, 14, 16)}', '${fn:substring(farmVo.timer_set_time, 17, 19)}');
		
		const farmEndDate = new Date('${fn:substring(farmVo.timer_value, 0, 4)}', '${fn:substring(farmVo.timer_value, 5, 7)}' - 1, '${fn:substring(farmVo.timer_value, 8, 10)}',
									'${fn:substring(farmVo.timer_value, 11, 13)}', '${fn:substring(farmVo.timer_value, 14, 16)}', '${fn:substring(farmVo.timer_value, 17, 19)}');
		
		const farmPassedTime = Math.ceil((now.getTime() - farmStartDate.getTime()) / 1000 / 60 / 60);
		const farmLeftTime = (farmEndDate.getTime() - now.getTime()) / 1000 / 60 / 60 > 0 ? Math.ceil((farmEndDate.getTime() - now.getTime()) / 1000 / 60 / 60) : 0;
		
		var farmOption = {
			type: 'doughnut',
			data: {
				datasets: [{
			        data: [farmPassedTime, farmLeftTime],
			        backgroundColor: [
			        	'rgba(255, 99, 132, 0.2)',
			        	'rgba(54, 162, 235, 0.2)'
			        ],
			        borderColor: [
			        	'rgba(255, 99, 132, 1)',
			        	'rgba(54, 162, 235, 1)'
			        ],
			        borderWidth: 1
			    }],
			    labels: [
			        '만료 시간(시간)',
			        '남은 시간(시간)'
			    ]
			},
			options : {
			    responsive: false,
				tooltips: {
					enable: false
				},
			    legend: {
			    	display: false
				}
			}
		};
		
		const farmChart = new Chart(farmCtx, farmOption);
	</c:if>
});

function refreshFarmTimer(timer_seq, timer_code) {
	if (timer_seq == undefined || timer_seq == '') {
		$.alert("대상 몬스터를 선택해주세요.");
		return;
	}
	
	$('#farm_proc_role').val('farm-refresh');
	
	$('#farm_timer_seq').val(timer_seq);
	$('#farm_timer_code').val(timer_code);
	
	ajaxCall4Html(ctxPath + '/timerProc', $("#formManagementFarmTimer").serialize(), function(data) {
		var rtn = JSON.parse(data);
//			console.log(rtn);
		
		if (rtn.result == 'YES') {
			$.confirm(rtn.messages, "renderingAfterRefresh('" + timer_seq + "');");
		} else {
			$.alert("데이터 입력에 실패했습니다. 확인 후 다시 이용해주세요. <br/> <b>실패사유</b> : " + rtn.messages);
		}
	});
}

function renderingAfterRefresh(timer_seq) {
	renderFarmList();
	selectFarmMonster(timer_seq);
}

function updateFarmTimer() {
	let afterSetTime = $('#timer_set_year').val() + '-' + $('#timer_set_month').val() + '-' + $('#timer_set_day').val()
						+ ' ' + $('#timer_set_hour').val() + ':' + $('#timer_set_munite').val() + ':' + $('#timer_set_second').val();
	
	$('#farm_timer_value').val(afterSetTime);
	
	ajaxCall4Html(ctxPath + '/timerProc', $("#formManagementFarmTimer").serialize(), function(data) {
		var rtn = JSON.parse(data);
// 			console.log(rtn);
		
		if (rtn.result == 'YES') {
			$.confirm(rtn.messages, "renderingAfterRefresh('" + $('#farm_timer_seq').val() + "');");
		} else {
			$.alert("데이터 입력에 실패했습니다. 확인 후 다시 이용해주세요. <br/> <b>실패사유</b> : " + rtn.messages);
		}
	});
}
</script>

<form id="formManagementFarmTimer" action="" method="post">
	<input type="hidden" id="farm_timer_seq" name="timer_seq"/>
	<input type="hidden" id="farm_timer_code" name="timer_code"/>
	<input type="hidden" id="farm_timer_value" name="timer_value"/>
	
	<input type="hidden" id="farm_proc_role" name="proc_role"/>
</form>

<div class="row">
<!-- 전문직업 선택 card area -->
	<div class="col-sm-12 col-xs-12 mb-3">
		<div class="card">
			<div class="card-body">
				<table class="table table-borderless text-center">
					<colgroup>
						<col width="30%" />
						<col width="*" />
					</colgroup>
					<tr>
						<td><strong>대상</strong></td>
						<td>${farmVo.timer_desc}</td>
					</tr>
				</table>
			</div>
			<div class="card-footer text-end">
				<button type="button" class="btn btn-sm btn-secondary mb-1" onclick="editTimerValue('${farmVo.timer_seq}', '${farmVo.timer_value}', 'farm');">마감 시간 변경</button>
				<button type="button" class="btn btn-sm btn-secondary mb-1" onclick="refreshFarmTimer('${farmVo.timer_seq}', 'FARM_001');">수명 연장</button>
				<button type="button" class="btn btn-sm btn-secondary mb-1" onclick="refreshFarmTimer('${farmVo.timer_seq}', 'FARM_002');">신규 조합</button>
			</div>
		</div>
	</div>
<!-- 그래프 표현 card area -->
	<div class="col-sm-12 col-xs-12">
		<div class="row align-items-center justify-content-center" style="height: 500px;">
			<canvas id="farmChart" width="300" height="300"></canvas>
		</div>
	</div>
</div>