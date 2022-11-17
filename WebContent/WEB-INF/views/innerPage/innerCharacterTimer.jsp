<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/include/commonHead.jsp" %>

<!-- chart.js -->
<script src="${pageContext.request.contextPath}/static/chart/chart.min.js" type="text/javascript"></script>

<script type="text/javascript">
$(document).ready(function () {
	const now = new Date();
	
	<c:if test="${acceVo ne null}">
		const acceCtx = $('#acceChart');
		
		const acceStartDate = new Date('${fn:substring(acceVo.timer_set_time, 0, 4)}', '${fn:substring(acceVo.timer_set_time, 5, 7)}' - 1, '${fn:substring(acceVo.timer_set_time, 8, 10)}',
									'${fn:substring(acceVo.timer_set_time, 11, 13)}', '${fn:substring(acceVo.timer_set_time, 14, 16)}', '${fn:substring(acceVo.timer_set_time, 17, 19)}');
		
		const acceEndDate = new Date('${fn:substring(acceVo.timer_value, 0, 4)}', '${fn:substring(acceVo.timer_value, 5, 7)}' - 1, '${fn:substring(acceVo.timer_value, 8, 10)}',
									'${fn:substring(acceVo.timer_value, 11, 13)}', '${fn:substring(acceVo.timer_value, 14, 16)}', '${fn:substring(acceVo.timer_value, 17, 19)}');
		
		const accePassedTime = Math.ceil((now.getTime() - acceStartDate.getTime()) / 1000 / 60);
		const acceLeftTime = (acceEndDate.getTime() - now.getTime()) / 1000 / 60 > 0 ? Math.ceil((acceEndDate.getTime() - now.getTime()) / 1000 / 60) : 0;
		
		let acceOption = {
			type: 'doughnut',
			data: {
				datasets: [{
			        data: [accePassedTime, acceLeftTime],
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
				},
				title: {
					display: true,
					position: 'top',
					text: '${acceVo.timer_desc}'
				}
			}
		};
		
		const acceChart = new Chart(acceCtx, acceOption);
	</c:if>
	
	<c:if test="${equiVo ne null}">
		const equiCtx = $('#equiChart');
		
		const equiStartDate = new Date('${fn:substring(equiVo.timer_set_time, 0, 4)}', '${fn:substring(equiVo.timer_set_time, 5, 7)}' - 1, '${fn:substring(equiVo.timer_set_time, 8, 10)}',
									'${fn:substring(equiVo.timer_set_time, 11, 13)}', '${fn:substring(equiVo.timer_set_time, 14, 16)}', '${fn:substring(equiVo.timer_set_time, 17, 19)}');
		const equiEndDate = new Date('${fn:substring(equiVo.timer_value, 0, 4)}', '${fn:substring(equiVo.timer_value, 5, 7)}' - 1, '${fn:substring(equiVo.timer_value, 8, 10)}',
									'${fn:substring(equiVo.timer_value, 11, 13)}', '${fn:substring(equiVo.timer_value, 14, 16)}', '${fn:substring(equiVo.timer_value, 17, 19)}');
		
		const equiPassedTime = Math.ceil((now.getTime() - equiStartDate.getTime()) / 1000 / 60);
		const equiLeftTime = (equiEndDate.getTime() - now.getTime()) / 1000 / 60 > 0 ? Math.ceil((equiEndDate.getTime() - now.getTime()) / 1000 / 60) : 0;
		
		let equiOption = {
			type: 'doughnut',
			data: {
				datasets: [{
			        data: [equiPassedTime, equiLeftTime],
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
				},
				title: {
					display: true,
					position: 'top',
					text: '${equiVo.timer_desc}'
				}
			}
		};
	
		const equiChart= new Chart(equiCtx, equiOption);
	</c:if>
	
	<c:if test="${alchVo ne null}">
		const alchCtx = $('#alchChart');
		
		const alchStartDate = new Date('${fn:substring(alchVo.timer_set_time, 0, 4)}', '${fn:substring(alchVo.timer_set_time, 5, 7)}' - 1, '${fn:substring(alchVo.timer_set_time, 8, 10)}',
									'${fn:substring(alchVo.timer_set_time, 11, 13)}', '${fn:substring(alchVo.timer_set_time, 14, 16)}', '${fn:substring(alchVo.timer_set_time, 17, 19)}');
		
		const alchEndDate = new Date('${fn:substring(alchVo.timer_value, 0, 4)}', '${fn:substring(alchVo.timer_value, 5, 7)}' - 1, '${fn:substring(alchVo.timer_value, 8, 10)}',
									'${fn:substring(alchVo.timer_value, 11, 13)}', '${fn:substring(alchVo.timer_value, 14, 16)}', '${fn:substring(alchVo.timer_value, 17, 19)}');
		
		const alchPassedTime = Math.ceil((now.getTime() - alchStartDate.getTime()) / 1000 / 60);
		const alchLeftTime = (alchEndDate.getTime() - now.getTime()) / 1000 / 60 > 0 ? Math.ceil((alchEndDate.getTime() - now.getTime()) / 1000 / 60) : 0;
		
		let alchOption = {
			type: 'doughnut',
			data: {
				datasets: [{
			        data: [alchPassedTime, alchLeftTime],
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
				},
				title: {
					display: true,
					position: 'top',
					text: '${alchVo.timer_desc}'
				}
			}
		};
	
		const alchChart= new Chart(alchCtx, alchOption);
	</c:if>
});

function saveManagementCharacterTimer() {
	if (saveManagementCharacterTimerValidation()) {
		$('#proc_role').val('character_save');
		
		ajaxCall4Html(ctxPath + '/timerProc', $("#formManagementCharacterTimer").serialize(), function(data) {
			var rtn = JSON.parse(data);
// 			console.log(rtn);
			
			if (rtn.result == 'YES') {
				$.confirm("저장되었습니다.", "selectCharacter('" + $('#timer_target').val() + "');");
			} else {
				$.alert("데이터 입력에 실패했습니다. 확인 후 다시 이용해주세요. <br/> <b>실패사유</b> : " + rtn.messages);
			}
		});
	}
}

function saveManagementCharacterTimerValidation() {
	if ($('#timer_target').val() == undefined || $('#timer_target').val() == "") {
		$.alert("캐릭터를 선택해주세요.");
		return false;
	}
	
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
								<td><input type="radio" name="acce" value="0" <c:if test="${acceVo eq null}">checked="checked"</c:if>></td>
								<td><input type="radio" name="equi" value="0" <c:if test="${equiVo eq null}">checked="checked"</c:if>></td>
								<td><input type="radio" name="alch" value="0" <c:if test="${alchVo eq null}">checked="checked"</c:if>></td>
							</tr>
							<tr>
								<td>장인</td>
								<td><input type="radio" name="acce" value="1" <c:if test="${fn:contains(acceVo.timer_code, '001')}">checked="checked"</c:if>></td>
								<td><input type="radio" name="equi" value="1" <c:if test="${fn:contains(equiVo.timer_code, '001')}">checked="checked"</c:if>></td>
								<td><input type="radio" name="alch" value="1" <c:if test="${fn:contains(alchVo.timer_code, '001')}">checked="checked"</c:if>></td>
							</tr>
							<tr>
								<td>명장</td>
								<td><input type="radio" name="acce" value="2" <c:if test="${fn:contains(acceVo.timer_code, '002')}">checked="checked"</c:if>></td>
								<td><input type="radio" name="equi" value="2" <c:if test="${fn:contains(equiVo.timer_code, '002')}">checked="checked"</c:if>></td>
								<td><input type="radio" name="alch" value="2" <c:if test="${fn:contains(alchVo.timer_code, '002')}">checked="checked"</c:if>></td>
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
					<c:if test="${acceVo ne null}">
						<div class="col-sm-6 col-xs-6">
							<div class="card">
								<div class="card-header text-center">${acceVo.timer_desc}</div>
								<div class="card-body">
									<canvas id="acceChart" width="250" height="250" style="margin: auto;"></canvas>
								</div>
								<div class="card-footer">
									<div class="d-grid gap-2 d-md-flex justify-content-md-end">
										<button type="button" class="btn btn-sm btn-secondary" onclick="">실제 마감 시간 변경</button>
										<button type="button" class="btn btn-sm btn-secondary" onclick="">숙련도 갱신</button>
									</div>
								</div>
							</div>
						</div>
					</c:if>
					<c:if test="${equiVo ne null}">
						<div class="col-sm-6 col-xs-6">
							<div class="card">
								<div class="card-header text-center">${equiVo.timer_desc}</div>
								<div class="card-body">
									<canvas id="equiChart" width="250" height="250" style="margin: auto;"></canvas>
								</div>
								<div class="card-footer">
									<div class="d-grid gap-2 d-md-flex justify-content-md-end">
										<button type="button" class="btn btn-sm btn-secondary" onclick="">실제 마감 시간 변경</button>
										<button type="button" class="btn btn-sm btn-secondary" onclick="">숙련도 갱신</button>
									</div>
								</div>
							</div>
						</div>
					</c:if>
					<c:if test="${alchVo ne null}">
						<div class="col-sm-6 col-xs-6">
							<div class="card">
								<div class="card-header text-center">${alchVo.timer_desc}</div>
								<div class="card-body">
									<canvas id="alchChart" width="250" height="250" style="margin: auto;"></canvas>
								</div>
								<div class="card-footer">
									<div class="d-grid gap-2 d-md-flex justify-content-md-end">
										<button type="button" class="btn btn-sm btn-secondary" onclick="">실제 마감 시간 변경</button>
										<button type="button" class="btn btn-sm btn-secondary" onclick="">숙련도 갱신</button>
									</div>
								</div>
							</div>
						</div>
					</c:if>
				</div>
			</div>
		</div>
	</div>
</div>