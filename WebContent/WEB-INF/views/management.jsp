<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/include/commonHead.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${config.getValue('Title')}</title>
<meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>

<jsp:include page="/include/resource.jsp" />

<script type="text/javascript">

</script>

</head>
<body>
	<div class="main-container">
		<jsp:include page="/include/header.jsp"></jsp:include>
		<div class="row main-content">
			<div class="col-sm-12 col-xs-12">
				<div class="panel panel-default">
					<div class="panel-body">
						<div style="overflow: auto; max-height: 900px;">
							<table class="table table-hover" style="width: auto;">
								<thead>
									<tr class="character-data">
										<th rowspan="2" width="50px;"></th>
										<c:forEach var="characterList" items="${characterList}" varStatus="status">
											<td width="114px" class="character-image character-image-table">
												<span>
													<img src="${characterList.character_img}" alt="캐릭터 이미지">
													<img class="character-image-bg character-image-table" src="https://ssl.nexon.com/s2/game/maplestory/renewal/common/rank_other.png" alt="캐릭터 이미지 배경">
												</span>
											</td>
										</c:forEach>
									</tr>
									<tr>
										<c:forEach var="characterList" items="${characterList}" varStatus="status">
											<th class="text-center" style="border-top: none;">
												<span>${characterList.character_name}</span>
											</th>
										</c:forEach>
									</tr>
								</thead>
								<tbody>
<!-- 									<tr> -->
<!-- 										<th rowspan="2" width="114px"></th> -->
<%-- 										<c:forEach var="headManagecodeList" items="${headManagecodeList}" varStatus="status"> --%>
<%-- 											<th colspan="${headManagecodeList.chid_count}" class="text-center" style="width: 50px; white-space:nowrap; border-left: 2px solid #ddd; border-right: 2px solid #ddd;"> --%>
<%-- 												${headManagecodeList.management_code_desc} --%>
<!-- 											</th> -->
<%-- 										</c:forEach> --%>
<!-- 									</tr> -->
									<c:forEach var="bodyManagecodeList" items="${bodyManagecodeList}" varStatus="status">
										<tr>
											<td style="white-space:nowrap;">
												${bodyManagecodeList.management_code_desc}
											</td>
											<c:forEach var="unique_managementlist" items="${bodyManagecodeList.unique_managementlist}" varStatus="status_">
												<td class="text-center" style="white-space:nowrap;">
													<c:if test="${unique_managementlist.complete_count ne null}">
														<input id="managebox_${unique_managementlist.management_seq}" type="checkbox" name="management-box" onclick="checkManageBox('${unique_managementlist.management_seq}', '${bodyManagecodeList.complete_count}');" value="${unique_managementlist.complete_count}"/>
													</c:if>
												</td>
											</c:forEach>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
		<jsp:include page="/include/footer.jsp"></jsp:include>
	</div>
</body>
</html>