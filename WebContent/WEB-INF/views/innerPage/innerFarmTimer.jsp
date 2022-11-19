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
</script>

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
				<button type="button" class="btn btn-secondary">조합 갱신</button>
				<button type="button" class="btn btn-secondary">일반 갱신</button>
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