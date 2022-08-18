<%@ include file="/include/commonHead.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${config.getValue('client.title')}</title>
<meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>

<jsp:include page="/include/resource.jsp" />

<script type="text/javascript">
function searchCharacter() {
	$("#characterSearch_modal").modal();
}
</script>

</head>
<body>
	<div class="main-container">
		<jsp:include page="/include/header.jsp"></jsp:include>
		<div class="row main-content">
			<div class="col-sm-3 col-xs-3">
				<div class="panel panel-default">
					<div class="panel-body">
						<div style="overflow: auto; max-height: 900px;">
							<table class="table table-hover character-table" id="characterTableInfo" style="width: 100%;">
								<thead>
									<tr>
										<th width="114px" class="text-center" style="cursor: pointer;" onclick="searchCharacter();">
											<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
										</th>
										<th width="*" class="text-center">닉네임</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="characterList" items="${characterList}" varStatus="status">
										<tr id="character_tr_${characterList.character_seq}" style="cursor:pointer;" >
											<td class="character-image">
												<img src="${characterList.character_img}" alt="캐릭터 이미지">
												<img class="character-image-bg" src="https://ssl.nexon.com/s2/game/maplestory/renewal/common/rank_other.png" alt="캐릭터 이미지 배경">
											</td>
											<td class="text-center text-vertical-center">${characterList.character_name}</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
			<div class="col-sm-9 col-xs-9">
				<div class="panel panel-default">
					<div class="panel-body">
						<div style="overflow: auto; height: 900px;">
							<div id="planEditer" class="row" style="height: 100%;">
								<div class="col-sm-4 col-sm-offset-1">
									<table class="table table-hover">
										<thead>
											<tr>
												<th class="text-center">숙제목록</th>
											</tr>
										</thead>
									</table>
								</div>
								<div class="col-sm-2" style="height: 100%; display: flex; align-items: center; justify-content: center;">
									<table>
										<tr>
											<td class="btn-fn">
												<span class="glyphicon glyphicon-chevron-right pb-8" aria-hidden="true" style="font-size: 2.0em;"></span>
											</td>
										</tr>
										<tr>
											<td class="btn-fn">
												<span class="glyphicon glyphicon-chevron-left" aria-hidden="true" style="font-size: 2.0em;"></span>
											</td>
										</tr>
									</table>
								</div>
								<div class="col-sm-4">
									<table class="table table-hover">
										<thead>
											<tr>
												<th class="text-center">진행중</th>
											</tr>
										</thead>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<jsp:include page="/include/footer.jsp"></jsp:include>
	</div>
	
	<jsp:include page="/include/popup/characterSearchModal.jsp" />
</body>
</html>