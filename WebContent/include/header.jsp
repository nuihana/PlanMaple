<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="/include/commonHead.jsp" %>

<style>
.tooltip-nav-list{
	position: relative;
}
.tooltip-nav::before{
    content: attr(data-tooltip); /*툴팁 표시 내용은 버튼의 "data-tooltip" 속성값으로 */
    position: absolute;
    background-color: rgba(0,0,0,0.5);
    color: #fff;
    padding: 7px 7px;
    border-radius: 4px;
	width: max-content;
    left: 50%; /* 요소 좌상단위치가 컨텐츠의 절반에서 시작되도록 */
    bottom: -100%; /* 버튼 밑에서 부터 버튼 높이 -75% 높이에 툴팁 밑부분이 오게 */
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
<header class="p-3 bg-dark text-white mb-5">
	<div class="container">
		<div class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start">
			<a href="/" class="d-flex align-items-center mb-2 mb-lg-0 text-white text-decoration-none">
				PlanMaple
			</a>
		
			<ul class="nav col-12 col-lg-auto me-lg-auto mb-2 justify-content-center mb-md-0">
				<li class="tooltip-nav-list">
					<a href="/" class="tooltip-nav nav-link p-2 text-white" data-tooltip="홈">
						<i class="bi bi-house-fill"></i>
					</a>
				</li>
				<li class="tooltip-nav-list">
					<a href="/character" class="tooltip-nav nav-link p-2 text-white" data-tooltip="캐릭터">
						<i class="bi bi-people-fill"></i>
					</a>
				</li>
				<li class="tooltip-nav-list">
					<a href="/management" class="tooltip-nav nav-link p-2 text-white" data-tooltip="숙제">
						<i class="bi bi-calendar-check"></i>
					</a>
				</li>
				<li class="tooltip-nav-list">
					<a href="/timer" class="tooltip-nav nav-link p-2 text-white" data-tooltip="타이머(베타)">
						<i class="bi bi-alarm-fill"></i>
					</a>
				</li>
			</ul>
			
			<ul class="nav">
				<li class="tooltip-nav-list">
					<a href="/user" class="tooltip-nav nav-link p-2 text-white" data-tooltip="계정설정">
						<i class="bi bi-gear"></i>
					</a>
				</li>
				<li class="tooltip-nav-list">
					<a href="#" class="tooltip-nav nav-link p-2 text-white" data-tooltip="로그아웃" onclick="logout();">
						<i class="bi bi-box-arrow-right"></i>
					</a>
				</li>
<!-- 	        	<li class="nav-item"><a href="#" class="nav-link text-white px-2" style="font-size: 0.8rem;" onclick="logout();">로그아웃</a></li> -->
	     	</ul>
		</div>
	</div>
</header>