<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/include/commonHead.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PlanMaple Login</title>
<meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>

<jsp:include page="/include/resource.jsp" />

<c:import url="/include/commonModalHead.jsp" />

<script type="text/javascript">
$(document).ready(function() {
	
	$('#input_character_name').keydown(function(e) {
		if (e.keyCode == 13) {
			userSearch('ID');
			return;
		}
    });
	
	$('.pw-search-form').keydown(function(e) {
		if (e.keyCode == 13) {
			userSearch('PW');
			return;
		}
    });

});

function userSearch(val) {
	$('#search_proc_role').val(val);
	
	if (userSearchValidation(val)) {
		if (val == 'ID') {
			$('#search_character_name').val($('#input_character_name').val());
			
			ajaxCall4Html(ctxPath + '/findUserAjax', $("#formUserIDSearch").separator('separatorRemoveForm').serialize(), function(data) {
				var rtn = JSON.parse(data);
//	 			console.log(rtn);
				
				if (rtn.result == 'YES') {
					let userList = "";
					
					userList += "<ul class='list-group text-center my-1'>";
					rtn.data.forEach(function(item){
						userList += "<li class='list-group-item'>";
						userList += item.user_id;
						userList += "</li>";
					});
					userList += "</ul>";
					
					$.confirm("해당 캐릭터가 등록된 계정은 다음과 같습니다.<br/>" + userList + "확인 후 로그인 해 주세요.", "location.href = ctxPath + '/login';");
				} else {
					$.alert("해당 캐릭터가 등록된 계정이 존재하지 않습니다.<br/> 확인 후 다시 이용해주세요.");
				}
			});
		} else if (val == 'PW') {
			$('#search_user_id').val($('#pwinput_user_id').val());
			$('#search_character_name').val($('#pwinput_character_name').val());
			
			ajaxCall4Html(ctxPath + '/findUserAjax', $("#formUserIDSearch").separator('separatorRemoveForm').serialize(), function(data) {
				var rtn = JSON.parse(data);
	 			console.log(rtn);
				
				if (rtn.result == 'YES') {
					$('#pwedit_user_id').val(rtn.data[0].user_id);
					$.feedback("일치하는 계정이 검색되었습니다.<br/> 비밀번호 변경화면을 불러옵니다.", "$.pwedit();");
				} else {
					$.alert("일치하는 계정이 존재하지 않습니다.<br/> 확인 후 다시 이용해주세요.");
				}
			});
		}
	}
}

function userSearchValidation(val) {
	if (val == 'ID') {
		if ($('#input_character_name').val() == undefined || $('#input_character_name').val() == "") {
			$.alert("캐릭터 닉네임을 입력해주세요.");
			return false;
		}
	} else if (val == 'PW') {
		if ($('#pwinput_user_id').val() == undefined || $('#pwinput_user_id').val() == "") {
			$.alert("ID를 입력해주세요.");
			return false;
		}

		if ($('#pwinput_character_name').val() == undefined || $('#pwinput_character_name').val() == "") {
			$.alert("캐릭터 닉네임을 입력해주세요.");
			return false;
		}
	}
	
	return true;
}
</script>

</head>
<body>
	<div class="container">
		<form id="formUserIDSearch" action="" method="post">
			<input type="hidden" id="search_user_id" name="user_id"/>
			<input type="hidden" id="search_character_name" name="character_name"/>
			<input type="hidden" id="search_proc_role" name="proc_role"/>
			
			<div class="row g-3 mt-3 justify-content-center">
				<h3 class="text-center">ID/PW 찾기</h3>
				<div class="col-sm-5 col-xs-5">
					<div class="card">
						<div class="card-header text-center">캐릭터 정보로 ID 찾기</div>
						<div class="card-body text-center">
							계정에 등록된 캐릭터 <b>닉네임</b>으로 ID를 검색합니다.<br/>
							캐릭터 닉네임을 입력하고 ID 검색을 진행해 주세요.
							<div class="row g-3 justify-content-center mt-2">
								<div class="col-auto">
									<input type="text" class="form-control" placeholder="닉네임 입력" id="input_character_name"/>
								</div>
								<div class="col-auto py-1">
									<a href="#" class="" style="color: #333; font-size: 1.1rem;" onclick="userSearch('ID');">
										<i class="bi bi-search"></i>
									</a>
								</div>
							</div>
						</div>
					</div>
					
					<div class="card mt-5">
						<div class="card-header text-center">ID/닉네임으로 PW 변경</div>
						<div class="card-body text-center">
							<b>ID</b>와 해당 계정에 등록된 <b>닉네임</b>으로 계정을 확인합니다.<br/>
							일치 시, 해당 계정의 비밀번호를 변경할 수 있습니다.
							<div class="row g-3 justify-content-center mt-2">
								<div class="col-auto">
									<input type="text" class="form-control pw-search-form" placeholder="ID 입력" id="pwinput_user_id"/>
								</div>
							</div>
							<div class="row g-3 justify-content-center mt-2">
								<div class="col-auto mt-0">
									<input type="text" class="form-control pw-search-form" placeholder="닉네임 입력" id="pwinput_character_name"/>
								</div>
							</div>
							<div class="d-grid gap-2 d-md-flex justify-content-md-end mt-1" style="padding-right: 110px;">
								<button type="button" class="btn btn-secondary" onclick="userSearch('PW');">확인</button>
							</div>
						</div>
					</div>
				</div>
			</div>
			
			<div class="row g-3 justify-content-center">
				<div class="col-sm-5 col-xs-5">
					<div class="d-grid gap-2 d-md-flex justify-content-md-end mt-3">
						<button type="button" class="btn btn-secondary" onclick="location.href = ctxPath + '/login';">돌아가기</button>
					</div>
				</div>
			</div>
		</form>
	</div>
<jsp:include page="/include/popup/feedbackModal.jsp" />
<jsp:include page="/include/popup/passwordModal.jsp" />
<jsp:include page="/include/popup/alertModal.jsp" />
<jsp:include page="/include/popup/confirmModal.jsp" />
</body>
</html>