$(function() {
	
	$.alert = function(value) {
		$("#alert_modal").modal();
		$("#modal_body").html(value);
	};
	
	$.confirm = function(value, func) {
		$("#confirm_modal").modal();
		$("#confirm_modal_body").html(value);
		$("#confirm_modal_btn").attr("onclick", func);
	};
	
//	$.dialog = function(value) {
//		$("#dial_modal").modal();
//		$("#modal_body").html(value);
//	};
//	
//	$.block = function() {
//		$.blockUI({
//			message: '<h3><img src="'+ctxPath+'/static/vsc/images/progress02.gif" />&nbsp;정보 조회중</h3>'
//		});
//	};
//	
//	$.unBlock = function() {
//		$.unblockUI();
//	};
});