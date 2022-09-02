<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${config.getValue('client.title')}</title>
<meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>

<jsp:include page="/include/resource.jsp" />

<!-- chart.js -->
<script src="${pageContext.request.contextPath}/static/chart/chart.min.js" type="text/javascript"></script>

<script type="text/javascript">
$(document).ready(function () {
	const ctx = $('#myChart');
	const serverList = ["미상", "미상", "리부트", "리부트", "오로라", "레드", "이노시스", "유니온", "스카니아", "루나", "제니스", "크로아", "베라", "엘리시움", "아케인", "노바", "버닝", "버닝", "버닝", "버닝"];
	var opt_label = [];
	var opt_data = [];
	
	$.ajax({
		url : ctxPath+'/homeDataAjax',
		type : 'post',
		dataType : "json",
		async : false,
		success : function(result) {
// 			console.log(result);
			result.data.forEach(function(value, index, arry) {
				console.log(value);
				opt_label[index] = serverList[value.server_code];
				opt_data[index] = value.complete_count;
			})
		},
		error:function(request,status,error){
			console.log(error);
		}
	});
	
	var option = {
	    type: 'bar',
	    data: {
// 	        labels: ['Red', 'Blue', 'Yellow', 'Green', 'Purple', 'Orange'],
	        labels: opt_label,
	        datasets: [{
	            label: '서버별 남은 숙제',
	            data: opt_data,
	            backgroundColor: [
	                'rgba(255, 99, 132, 0.2)',
	                'rgba(54, 162, 235, 0.2)',
	                'rgba(255, 206, 86, 0.2)',
	                'rgba(75, 192, 192, 0.2)',
	                'rgba(153, 102, 255, 0.2)',
	                'rgba(255, 159, 64, 0.2)'
	            ],
	            borderColor: [
	                'rgba(255, 99, 132, 1)',
	                'rgba(54, 162, 235, 1)',
	                'rgba(255, 206, 86, 1)',
	                'rgba(75, 192, 192, 1)',
	                'rgba(153, 102, 255, 1)',
	                'rgba(255, 159, 64, 1)'
	            ],
	            borderWidth: 1
	        }]
	    },
	    options: {
	    	responsive: false,
	        scales: {
	            y: {
	                beginAtZero: true
	            }
	        }
	    }
	}
	
	const  myChart = new Chart(ctx, option);
});
</script>

</head>
<body>
	<div class="main-container">
		<jsp:include page="/include/header.jsp"></jsp:include>
		<div class="container">
			<div class="row">
				<div class="col-sm-4 col-xs-4">
					<div class="card btn-fn text-center" onclick="location.href = ctxPath + '/character';">
						<div class="card-header">관리중인 캐릭터</div>
						<div class="card-body">${card_data.get('characterCnt')}</div>
					</div>
				</div>
				<div class="col-sm-4 col-xs-4">
					<div class="card btn-fn text-center" onclick="location.href = ctxPath + '/character';">
						<div class="card-header">?</div>
						<div class="card-body">몸통</div>
					</div>
				</div>
				<div class="col-sm-4 col-xs-4">
					<div class="card btn-fn text-center" onclick="location.href = ctxPath + '/management';">
						<div class="card-header">남아있는 숙제</div>
						<div class="card-body">${card_data.get('leftManagementCnt')}</div>
					</div>
				</div>
			</div>
			<div class="row mt-3">
				<div class="col-sm-8 col-xs-8">
					<div class="accordion" id="accordionExample">
						<div class="accordion-item">
							<h2 class="accordion-header" id="headingOne">
								<button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
								사용법
								</button>
							</h2>
							<div id="collapseOne" class="accordion-collapse collapse show" aria-labelledby="headingOne" data-bs-parent="#accordionExample">
								<div class="accordion-body">
									<strong>캐릭터</strong>화면에서 <i class="bi bi-person-plus-fill"></i> 버튼을 클릭 후, 캐릭터 닉네임을 검색하여 관리 캐릭터로 등록한다.<br/>
									이후 해당 캐릭터로 진행중인 숙제들을 진행중 목록으로 등록하면, <strong>숙제</strong>화면에서 관리가 가능해진다.
								</div>
							</div>
						</div>
<!-- 						<div class="accordion-item"> -->
<!-- 							<h2 class="accordion-header" id="headingTwo"> -->
<!-- 								<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo"> -->
<!-- 								Accordion Item #2 -->
<!-- 								</button> -->
<!-- 							</h2> -->
<!-- 							<div id="collapseTwo" class="accordion-collapse collapse" aria-labelledby="headingTwo" data-bs-parent="#accordionExample"> -->
<!-- 								<div class="accordion-body"> -->
<!-- 									<strong>This is the second item's accordion body.</strong> It is hidden by default, until the collapse plugin adds the appropriate classes that we use to style each element. These classes control the overall appearance, as well as the showing and hiding via CSS transitions. You can modify any of this with custom CSS or overriding our default variables. It's also worth noting that just about any HTML can go within the <code>.accordion-body</code>, though the transition does limit overflow. -->
<!-- 								</div> -->
<!-- 							</div> -->
<!-- 						</div> -->
					</div>
				</div>
				<div class="col-sm-4 col-xs-4">
					<canvas id="myChart" width="400" height="600"></canvas>
				</div>
			</div>
		</div>
		<jsp:include page="/include/footer.jsp"></jsp:include>
	</div>
</body>
</html>