$(function() {
	
	$.alert = function(value) {
		let options = {
			backdrop: true,
			keyboard: true,
			focus: true
		};
		
		let myModal = new bootstrap.Modal(document.getElementById('alert_modal'), options);
//		$("#alert_modal").modal();
		$("#modal_body").html(value);
		myModal.show();
	};
	
	$.confirm = function(value, func) {
		let options = {
				backdrop: true,
				keyboard: true,
				focus: true
			};
		
		let myModal = new bootstrap.Modal(document.getElementById('confirm_modal'), options);
//		$("#confirm_modal").modal();
		$("#confirm_modal_body").html(value);
		$("#confirm_modal_btn").attr("onclick", func);
		myModal.show();
	};
	
	$.feedback = function(value, func) {
		let options = {
				backdrop: true,
				keyboard: true,
				focus: true
			};
		
		let myModal = new bootstrap.Modal(document.getElementById('feedback_modal'), options);
//		$("#confirm_modal").modal();
		$("#feedback_modal_body").html(value);
		$("#feedback_modal_btn").attr("onclick", func);
		myModal.show();
	};
	
	$.pwedit = function() {
		let options = {
			backdrop: true,
			keyboard: true,
			focus: true
		};
		
		let myModal = new bootstrap.Modal(document.getElementById('password_modal'), options);
		myModal.show();
	};
	
	$.block = function() {
		$.blockUI({
			message: '<div class="spinner-border m-5" role="status"><span class="visually-hidden">Loading...</span></div>'
		});
	};
	
	$.unBlock = function() {
		$.unblockUI();
	};
	
	$.timerSet = function(func) {
		let options = {
			backdrop: true,
			keyboard: true,
			focus: true
		};
		
		let myModal = new bootstrap.Modal(document.getElementById('timer_set_modal'), options);
		$("#timer_set_btn").attr("onclick", func);
		myModal.show();
	};
	
//	$.dialog = function(value) {
//		$("#dial_modal").modal();
//		$("#modal_body").html(value);
//	};
});