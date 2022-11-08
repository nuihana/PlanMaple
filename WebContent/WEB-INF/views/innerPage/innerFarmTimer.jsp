<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/include/commonHead.jsp" %>

<!-- chart.js -->
<script src="${pageContext.request.contextPath}/static/chart/chart.min.js" type="text/javascript"></script>

<script type="text/javascript">
$(document).ready(function () {
	const farmCtx = $('#farmChart');
	
	var farmOption = {
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
	
	const farmChart = new Chart(farmCtx, farmOption);
});
</script>

<div class="row">
<!-- 전문직업 선택 card area -->
	<div class="col-sm-12 col-xs-12 mb-3">
		<div class="card">
			<div class="card-body">
				<table class="table table-borderless text-center">
					<tr>
						<td><strong>대상</strong></td>
						<td>쁘띠 시그너스</td>
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