<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/include/commonHead.jsp" %>

<!-- chart.js -->
<script src="${pageContext.request.contextPath}/static/chart/chart.min.js" type="text/javascript"></script>

<script type="text/javascript">
$(document).ready(function () {
	const frontCtx = $('#frontChart');
	const backCtx = $('#backChart');
	
	let frontOption = {
		type: 'doughnut',
		data: {
			datasets: [{
		        data: [10, 20],
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
		        '만료 시간',
		        '남은 시간'
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
	
	const frontChart = new Chart(frontCtx, frontOption);
	
	let backOption = {
		type: 'doughnut',
		data: {
			datasets: [{
		        data: [10, 20],
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
		        '만료 시간',
		        '남은 시간'
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

	const backChart= new Chart(backCtx, backOption);
});

function saveManagementCharacterTimer() {
	if (saveManagementCharacterTimerValidation()) {
		$('#proc_role').val('character_save');
		
		ajaxCall4Html(ctxPath + '/timerProc', $("#formManagementCharacterTimer").serialize(), function(data) {
			var rtn = JSON.parse(data);
			console.log(rtn);
		});
	}
}

function saveManagementCharacterTimerValidation() {
	let valCnt = 0;
	
	if ($('input:radio[name=acce]:checked').val() > 0) {
		valCnt++;
	}
	
	if ($('input:radio[name=equi]:checked').val() > 0) {
		valCnt++;
	}
	
	if ($('input:radio[name=alch]:checked').val() > 0) {
		valCnt++;
	}
	
	if (valCnt > 2) {
		$.alert("한 번에 등록 가능한 전문기술은 2개로 제한되어 있습니다.");
		return false;
	}
	
	return true;
}
</script>

<div class="row">
<!-- 전문직업 선택 card area -->
	<div class="col-sm-12 col-xs-12 mb-3">
		<div class="card">
			<div class="card-header text-center"><strong>전문기술 선택</strong></div>
			<div class="card-body">
				<form id="formManagementCharacterTimer" action="" method="post">
					<input type="hidden" id="timer_target" name="timer_target"/>
					<input type="hidden" id="timer_target_type" name="timer_target_type" value="C"/>
				
					<input type="hidden" id="proc_role" name="proc_role"/>
					
					<table class="table text-center">
						<thead>
							<tr>
								<th>분류</th>
								<th>장신구제작</th>
								<th>장비제작</th>
								<th>연금술</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>해당없음</td>
								<td><input type="radio" name="acce" value="0"></td>
								<td><input type="radio" name="equi" value="0"></td>
								<td><input type="radio" name="alch" value="0"></td>
							</tr>
							<tr>
								<td>장인</td>
								<td><input type="radio" name="acce" value="1"></td>
								<td><input type="radio" name="equi" value="1"></td>
								<td><input type="radio" name="alch" value="1"></td>
							</tr>
							<tr>
								<td>명장</td>
								<td><input type="radio" name="acce" value="2"></td>
								<td><input type="radio" name="equi" value="2"></td>
								<td><input type="radio" name="alch" value="2"></td>
							</tr>
						</tbody>
					</table>
				</form>
			</div>
			<div class="card-footer">
				<div class="d-grid gap-2 d-md-flex justify-content-md-end">
					<button type="button" class="btn btn-sm btn-secondary" onclick="saveManagementCharacterTimer();">변경사항 저장</button>
				</div>
			</div>
		</div>
	</div>
<!-- 그래프 표현 card area -->
	<div class="col-sm-12 col-xs-12">
		<div class="card">
			<div class="card-body">
				<div class="row justify-content-center">
					<div class="col-sm-5 col-xs-5">
						<canvas id="frontChart" width="250" height="250"></canvas>
						<canvas id="backChart" width="250" height="250"></canvas>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>