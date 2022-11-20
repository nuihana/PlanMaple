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
	$('#memo_user_seq').val('${loginSeq}');
	
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
			if (result.result == 'YES') {
				result.data.forEach(function(value, index, arry) {
//	 				console.log(value);
					opt_label[index] = serverList[value.server_code];
					opt_data[index] = value.complete_count;
				})
			}
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

function characterMemoSave() {
	ajaxCall4Html(ctxPath + '/userMemoProc', $("#formUserMemo").separator('separatorRemoveForm').serialize(), function(data) {
		var rtn = JSON.parse(data);
// 		console.log(rtn);
		if (rtn.result == 'YES') {
			$.alert("저장되었습니다.");
		} else {
			$.alert("데이터 입력에 실패했습니다. 확인 후 다시 이용해주세요. <br/> <b>실패사유</b> : " + rtn.messages);
		}
	});
}
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
					<div class="card btn-fn text-center" onclick="location.href = ctxPath + '/management';">
						<div class="card-header" style="background-color: #FFDCDC;">오늘이 마감인 숙제 / 남은 숙제</div>
						<div class="card-body">${card_data.get('deadlineManagementCnt')} / ${card_data.get('leftManagementCnt')}</div>
					</div>
				</div>
				<div class="col-sm-4 col-xs-4">
					<div class="card btn-fn text-center" onclick="location.href = ctxPath + '/timer';">
						<div class="card-header" style="background-color: #FFE999;">마감인 전문기술(6시간) / 농장 몬스터(24시간)</div>
						<div class="card-body">${card_data.get('deadlineCraftCnt')} / ${card_data.get('deadlineFarmCnt')}</div>
					</div>
				</div>
			</div>
			<div class="row mt-3">
				<div class="col-sm-8 col-xs-8">
					<div class="card">
						<div class="card-header">메모사항</div>
						<div class="card-body">
							<form id="formUserMemo" action="" method="post">
								<input type="hidden" id="memo_user_seq" name="user_seq"/>
							
								<textarea rows="7" style="width: 100%;" name="memo">${myInfo.memo}</textarea>
							</form>
						</div>
						<div class="card-footer">
							<div class="d-grid gap-2 d-md-flex justify-content-md-end">
								<button type="button" class="btn btn-sm btn-secondary" onclick="characterMemoSave();">저장</button>
							</div>
						</div>
					</div>
					<div class="accordion mt-3" id="accordionNotice">
						<div class="accordion-item">
							<h2 class="accordion-header" id="headingOne">
								<button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
								문의사항
								</button>
							</h2>
							<div id="collapseOne" class="accordion-collapse collapse show" aria-labelledby="headingOne" data-bs-parent="accordionNotice">
								<div class="accordion-body">
									버그 제보, 문의사항, 기능건의는 <strong>prixia@naver.com</strong> 으로 메일 주세요.<br/><br/>
									현재 <strong>전문기술 명장 / 장인 유지</strong> 및 <strong>몬스터 라이프 수명 확인</strong> 기능을 위한 타이머 기능을 시범적 운영중입니다.<br/>
									이용중 오류, 버그 발견 시 제보 부탁드립니다. 감사합니다.
								</div>
							</div>
						</div>
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