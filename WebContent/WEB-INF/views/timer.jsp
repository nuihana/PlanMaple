<%@ include file="/include/commonHead.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${config.getValue('Title')}</title>
<meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>

<jsp:include page="/include/resource.jsp" />

<script type="text/javascript">
$(document).ready(function () {
	$('#CharacterTimer_user_seq').val('${loginSeq}');
});

function selectCharacter(character_seq) {
	$('.character-data').removeClass("table-active");
	
	$('#CharacterTimer_character_seq').val(character_seq);
	
	if (character_seq != undefined && character_seq != "") {
		$('#characterTimerEditer').ajaxload(
			'blockLoad',
			ctxPath+'/characterTimer',
			"POST",
			"html",
			$("#formCharacterTimer").separator('separatorRemoveForm').serialize()
		);
	} else {
		
	}
	
	$("#character_tr_" + character_seq).addClass("table-active");
}

function selectFarmMonster(timer_seq) {
	$('#farmTimer_timer_seq').val(timer_seq);
	
	if (timer_seq != undefined && timer_seq != "") {
		$('#farmTimerEditer').ajaxload(
			'blockLoad',
			ctxPath+'/farmTimer',
			"POST",
			"html",
			$("#formFarmTimer").separator('separatorRemoveForm').serialize()
		);
	} else {
		
	}
}
</script>

</head>
<body>
	<div class="main-container">
		<jsp:include page="/include/header.jsp"></jsp:include>
		<div class="container">
			<div class="row">
				<div class="col-sm-12 col-xs-12">
					<div class="card">
						<div class="card-header pb-0">
							<div class="nav nav-tabs" id="timer_navs" role="tablist">
								<button class="nav-link active" id="timer_maker_nav" data-bs-toggle="tab" data-bs-target="#timer_maker_tab" type="button" role="tab" aria-controls="timer_maker_tab" aria-selected="true">제작 - 유지</button>
								<button class="nav-link" id="timer_farm_nav" data-bs-toggle="tab" data-bs-target="#timer_farm_tab" type="button" role="tab" aria-controls="timer_farm_tab" aria-selected="true">농장 - 만료</button>
							</div>
						</div>
						<div class="card-body">
							<div class="tab-content" id="timer_tabs">
								<!-- 제작 유지 단 -->
								<div class="tab-pane fade show active" id="timer_maker_tab" role="tabpanel" aria-labelledby="timer_maker_tab" tabindex="0">
									<div class="row">
										<div class="col-sm-4 col-xs-4">
											<div class="card">
												<div class="card-body">
													<div style="overflow: auto; max-height: 900px;">
														<form id="formCharacterTimer" action="" method="post">
															<input type="hidden" id="CharacterTimer_user_seq" name="user_seq"/>
															<input type="hidden" id="CharacterTimer_character_seq" name="character_seq"/>
														</form>
														<table class="table table-hover" id="" style="width: 100%;">
															<thead>
																<tr>
																	<th colspan="3" width="*" class="text-center">닉네임</th>
																</tr>
															</thead>
															<tbody>
																<c:forEach var="characterList" items="${characterList}" varStatus="status">
																	<tr id="character_tr_${characterList.character_seq}" class="btn-fn character-data">
																		<td width="2%;">
<!-- 																			<div style="position: relative; width: 24px; height: 97px;"> -->
<%-- 																				<button class="btn btn-outline-danger p-0" style="position: absolute; left: 2%; top: 20%;"><i class="bi bi-dash" onclick="deleteProcChk('${characterList.character_seq}', 'delete');"></i></button> --%>
<%-- 																				<button class="btn btn-outline-danger p-0" style="position: absolute; left: 2%; top: 20%; transform: translateY(120%);"><i class="bi bi-arrow-clockwise" onclick="updateProcChk('${characterList.character_seq}');"></i></button> --%>
<!-- 																			</div> -->
																		</td>
																		<td class="character-image" onclick="selectCharacter('${characterList.character_seq}');">
																			<img src="${characterList.character_img}" alt="캐릭터 이미지">
																		</td>
																		<td class="text-center text-vertical-center" onclick="selectCharacter('${characterList.character_seq}');">${characterList.character_name}</td>
																	</tr>
																</c:forEach>
															</tbody>
														</table>
													</div>
												</div>
											</div>
										</div>
										<div class="col-sm-8 col-xs-8">
											<div style="position: relative; overflow: auto; height: 900px;">
												<div id="characterTimerEditer" style="position: absolute; height: 100%; width: 100%;">
													<jsp:include page="/WEB-INF/views/innerPage/innerCharacterTimer.jsp"></jsp:include>
												</div>
											</div>
										</div>
									</div>
								</div>
								<!-- 농장 만료 단 -->
								<div class="tab-pane fade" id="timer_farm_tab" role="tabpanel" aria-labelledby="timer_farm_tab" tabindex="0">
									<div class="row">
										<div class="col-sm-8 col-xs-8">
											<div style="overflow: auto; max-height: 900px;">
												<div class="row mb-3">
													<div class="col-sm-4 col-xs-4">
														<div class="card text-center">
															<div class="card-header" style="background-color: rgba(0,0,0,.1);">만료</div>
															<div class="card-body">1</div>
														</div>
													</div>
													<div class="col-sm-4 col-xs-4">
														<div class="card text-center">
															<div class="card-header" style="background-color: #FFDCDC;">24시간 이내 만료</div>
															<div class="card-body">2</div>
														</div>
													</div>
													<div class="col-sm-4 col-xs-4">
														<div class="card text-center">
															<div class="card-header" style="background-color: #FFE999;">7일 이내 만료</div>
															<div class="card-body">3</div>
														</div>
													</div>
												</div>
												<div class="card">
													<div class="card-body">
														<form id="formFarmTimer" action="" method="post">
															<input type="hidden" id="farmTimer_timer_seq" name="timer_seq"/>
														</form>
														<table class="table table-hover text-center" id="" style="width: 100%;">
															<thead>
																<tr>
																	<th width="*" class="text-center">대상</th>
																	<th width="20%;" class="text-center">상태</th>
																</tr>
															</thead>
															<tbody>
																<tr class="btn-fn" onclick="selectFarmMonster('1');">
																	<td>쁘띠 시그너스</td>
																	<td><i class="bi bi-circle-fill" style="color: #FFACAC;"></i></td>
																</tr>
															</tbody>
														</table>
													</div>
												</div>
											</div>
										</div>
										<div class="col-sm-4 col-xs-4">
											<div class="card">
												<div class="card-body">
													<div style="position: relative; overflow: auto; height: 900px;">
														<div id="farmTimerEditer" style="position: absolute; height: 100%; width: 100%;">
															<jsp:include page="/WEB-INF/views/innerPage/innerFarmTimer.jsp"></jsp:include>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<jsp:include page="/include/footer.jsp"></jsp:include>
	</div>
</body>
</html>