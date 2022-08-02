<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"  isELIgnored="false"%>

<script type="text/javascript">
	//actionMessage 설정
	$(document).ready(function() {
		if('${actionMessage }' != '') {
			$.alert('${actionMessage }');
		} else if ('${param.actionMessage }' != '') {
			$.alert('${param.actionMessage }');
		}
	});
</script>