<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>

<script type="text/javascript">
$(document).ready(function() {
	$('input[type="number"]').keydown(function(e) {
		if(!((e.keyCode > 95 && e.keyCode < 106)
	      || (e.keyCode > 47 && e.keyCode < 58) 
	      || e.keyCode == 8)) {
	        return false;
	    }
    });
	
	$("#timer_set_year").bind('keyup input', function(){
		if ($(this).val() < 2020) {
			$(this).val(2020);
		}
	});
	
	$("#timer_set_month").bind('keyup input', function(){
		if($(this).val() > 12) {
			$(this).val(12);
		} else if ($(this).val() < 1) {
			$(this).val(1);
		}
	});
	
	$("#timer_set_day").bind('keyup input', function(){
		if($(this).val() > 31) {
			$(this).val(31);
		} else if ($(this).val() < 1) {
			$(this).val(1);
		}
	});
	
	$("#timer_set_hour").bind('keyup input', function(){
		if($(this).val() > 23) {
			$(this).val(23);
		} else if ($(this).val() < 0) {
			$(this).val(0);
		}
	});
	
	$("#timer_set_munite").bind('keyup input', function(){
		if($(this).val() > 59) {
			$(this).val(59);
		} else if ($(this).val() < 0) {
			$(this).val(0);
		}
	});
	
	$("#timer_set_second").bind('keyup input', function(){
		if($(this).val() > 59) {
			$(this).val(59);
		} else if ($(this).val() < 0) {
			$(this).val(0);
		}
	});
});
</script>

<div class="modal fade" id="timer_set_modal" tabindex="-1" aria-labelledby="timerSetModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<!-- header -->
			<div class="modal-header bg-secondary text-white">
				<!-- header title -->
				<h5 class="modal-title">시간 변경</h5>
			</div>
			<!-- body -->
			<div class="modal-body">
				<div class="row g-3 my-3">
					<div class="row col-sm-12 col-xs-12 mb-2">
						<div class="col-sm-4 col-xs-4">
							<input class="form-control" type="number" min="2020" id="timer_set_year">
						</div>
						/
						<div class="col-sm-3 col-xs-3">
							<input class="form-control" type="number" min="1" max="12" id="timer_set_month">
						</div>
						/
						<div class="col-sm-3 col-xs-3">
							<input class="form-control" type="number" min="1" max="31" id="timer_set_day">
						</div>
					</div>
					<div class="row justify-content-md-end col-sm-12 col-xs-12">
						<div class="col-sm-3 col-xs-3">
							<input class="form-control" type="number" min="0" max="23" id="timer_set_hour">
						</div>
						:
						<div class="col-sm-3 col-xs-3">
							<input class="form-control" type="number" min="0" max="59" id="timer_set_munite">
						</div>
						:
						<div class="col-sm-3 col-xs-3">
							<input class="form-control" type="number" min="0" max="59" id="timer_set_second">
						</div>
					</div>
				</div>
			</div>
			<!-- Footer -->
			<div class="modal-footer">
				<button id="timer_set_btn" type="button" class="btn btn-secondary" data-bs-dismiss="modal">변경</button>
				<button type="button" class="btn" data-bs-dismiss="modal">취소</button>
			</div>
		</div>
	</div>
</div>