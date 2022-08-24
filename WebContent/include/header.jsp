<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="/include/commonHead.jsp" %>

<style>
.tooltip-nav::before{
    content: attr(data-tooltip); /*툴팁 표시 내용은 버튼의 "data-tooltip" 속성값으로 */
    position: absolute;
    background-color: rgba(0,0,0,0.5);
    color: #fff;
    padding: 7px 7px;
    border-radius: 4px;
	width: max-content;
    left: 50%; /* 요소 좌상단위치가 컨텐츠의 절반에서 시작되도록 */
    bottom: -75%; /* 버튼 밑에서 부터 버튼 높이 -75% 높이에 툴팁 밑부분이 오게 */
    transform: translate(-50%, 0%); /* 요소가 자기 자신의 크기 절반만큼 왼쪽으로 이동 */
	opacity: 0; /* 기본 상태는 안보이게 */
    transition: all 0.5s linear; /* 나타났다 사라지는 애니메이션 */
    z-index: 100;
}
.tooltip-nav:hover::before {
    opacity: 1;
}
</style>
    
<script type="text/javascript">
$(document).ready(function () {
	
});

function logout() {
	$('#formLogout').submit();
}
</script>
<form id="formLogout" action="/logout" method="post"></form>
<nav class="navbar navbar-inverse navber-fixed-top">
	<div class="container-fluid">
		<div class="navbar-header">
<!-- 			<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar"> -->
<!-- 				<span class="sr-only">Toggle navigation</span> -->
<!-- 				<span class="icon-bar"></span> -->
<!-- 				<span class="icon-bar"></span> -->
<!-- 				<span class="icon-bar"></span> -->
<!-- 			</button> -->
			<a class="navbar-brand" href="/">PlanMaple</a>
		</div>
		<div id="navbar" class="navbar-collapse collapse">
			<ul class="nav navbar-nav navbar-left">
				<li>
					<a href="/" class="tooltip-nav" data-tooltip="홈">
						<span class="glyphicon glyphicon-home" aria-hidden="true"></span>
					</a>
				</li>
				<li>
					<a href="/character" class="tooltip-nav" data-tooltip="캐릭터">
						<span class="glyphicon glyphicon-user" aria-hidden="true"></span>
					</a>
				</li>
				<li>
					<a href="/management" class="tooltip-nav" data-tooltip="숙제">
						<span class="glyphicon glyphicon-list-alt" aria-hidden="true"></span>
					</a>
				</li>
			</ul>
			<ul class="nav navbar-nav navbar-right">
<!-- 				<li><a href="#">Help</a></li> -->
				<li><a href="#" onclick="logout();">로그아웃</a></li>
			</ul>
<!-- 			우측 검색공간 -->
<!-- 			<form class="navbar-form navbar-right"> -->
<!-- 				<input type="text" class="form-control" placeholder="Search..."> -->
<!-- 			</form> -->
		</div>
	</div>
</nav>