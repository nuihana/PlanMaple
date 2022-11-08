<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/include/commonHead.jsp" %>

<!-- chart.js -->
<script src="${pageContext.request.contextPath}/static/chart/chart.min.js" type="text/javascript"></script>

<script type="text/javascript">
$(document).ready(function () {
	const frontCtx = $('#frontChart');
	const backCtx = $('#backChart');
	
	var frontOption = {
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
	
	var backOption = {
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
</script>

<div class="row">
<!-- 전문직업 선택 card area -->
	<div class="col-sm-12 col-xs-12 mb-3">
		<div class="card">
			<div class="card-body">
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
							<td><input type="radio" name="ACCE" value="0"></td>
							<td><input type="radio" name="EQUI" value="0"></td>
							<td><input type="radio" name="ALCH" value="0"></td>
						</tr>
						<tr>
							<td>명장</td>
							<td><input type="radio" name="ACCE" value="1"></td>
							<td><input type="radio" name="EQUI" value="1"></td>
							<td><input type="radio" name="ALCH" value="1"></td>
						</tr>
						<tr>
							<td>장인</td>
							<td><input type="radio" name="ACCE" value="2"></td>
							<td><input type="radio" name="EQUI" value="2"></td>
							<td><input type="radio" name="ALCH" value="2"></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
<!-- 그래프 표현 card area -->
	<div class="col-sm-12 col-xs-12">
		<div class="card">
			<div class="card-body">
				<div class="row justify-content-center">
					<div class="col-sm-5 col-xs-5">
						<canvas id="frontChart" width="300" height="300"></canvas>
						<canvas id="backChart" width="300" height="300"></canvas>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>