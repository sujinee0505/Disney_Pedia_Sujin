<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/calendar.css">

<style>
*{
	font-family: 'SUIT-Medium';
}
.dropdown-menu.show {
	display: flex;
}

.dropdown:hover>.dropdown-menu {
	display: flex;
}

.dropdown-menu {
	min-width: 0 !important;
}

.btn:focus, .btn:hover {
	box-shadow: 0 0 0 0.25rem rgb(13, 110, 253);
}
.btn:focus>span, .btn:hover>span {
	color: rgb(13, 110, 253) !important;
}
</style>
<body>
	<form name="calendarFrm" id="calendarFrm" action="" method="GET">
		<input type="hidden" name="year" value="${today_info.search_year}" />
		<input type="hidden" name="month" value="${today_info.search_month-1}" />
		<div class="calendar">

			<!--날짜 네비게이션  -->
			<div class="navigation">
				<a class="before_after_year"
					href="myCalendar.do?mem_num${user_num }&year=${today_info.search_year-1}&month=${today_info.search_month-1}">
					&lt;&lt; <!-- 이전해 -->
				</a> <a class="before_after_month"
					href="myCalendar.do?mem_num${user_num }&year=${today_info.before_year}&month=${today_info.before_month}">
					&lt; <!-- 이전달 -->
				</a> <span class="this_month"> &nbsp;${today_info.search_year}. <c:if
						test="${today_info.search_month<10}">0</c:if>${today_info.search_month}
				</span> <a class="before_after_month"
					href="myCalendar.do?mem_num${user_num }&year=${today_info.after_year}&month=${today_info.after_month}">
					<!-- 다음달 --> &gt;
				</a> <a class="before_after_year"
					href="myCalendar.do?mem_num${user_num }&year=${today_info.search_year+1}&month=${today_info.search_month-1}">
					<!-- 다음해 --> &gt;&gt;
				</a>
			</div>

			<table class="calendar_body">
				<thead>
					<tr bgcolor="white">
						<td class="day sun">일</td>
						<td class="day">월</td>
						<td class="day">화</td>
						<td class="day">수</td>
						<td class="day">목</td>
						<td class="day">금</td>
						<td class="day sat">토</td>
					</tr>
				</thead>
				<tbody>
					<tr>
						<c:forEach var="dateList" items="${dateList}"
							varStatus="date_status">
							<c:choose>
								<c:when test="${dateList.value=='today'}">
									<c:if test="${date_status.index%7==0}">
										<tr>
									</c:if>
									<td class="today">
										<div class="date">
								</c:when>
								<c:when test="${date_status.index%7==6}">
									<td class="sat_day">
										<div class="sat">
								</c:when>
								<c:when test="${date_status.index%7==0}">
					</tr>
					<tr>
						<td class="sun_day">
							<div class="sun">
								</c:when>
								<c:otherwise>
									<td class="normal_day">
										<div class="date">
								</c:otherwise>
								</c:choose>
								${dateList.date}
								<div style="display: flex; justify-content: center;">
									<c:forEach var="contents_list"
										items="${dateList.contents_data_arr}" varStatus="status"
										begin="0" end="0">
										<c:if test="${!empty contents_list.poster_path }">
											<a
												href="${pageContext.request.contextPath}/contents/detail.do?contents_type=${contents_list.contents_type }&contents_num=${contents_list.contents_num}">
												<div style="width: 100px; position: relative;">
													<img src="${contents_list.poster_path }"
														style="width: 100%; max-height: 140px;">
												</div>
											</a>
										</c:if>
									</c:forEach>
									<c:forEach var="contents_list"
										items="${dateList.contents_data_arr}" varStatus="status"
										begin="1" end="1">
										<c:if test="${!empty contents_list.poster_path }">
											<div class="dropdown" data-hover="dropdown"
												style="position: absolute; transform: translate(125%, 370%);">
												<a class="btn dropdown-toggle" href="#" role="button"
													id="dropdownMenuLink" data-bs-toggle="dropdown"
													aria-expanded="false"
													style="border-radius: 100%; background: white; padding: 3px 8px; opacity: .7;"><span
													style="font-size: 14px; color: #74747b;">+</span></a>
										</c:if>
										<ul class="dropdown-menu" aria-labelledby="dropdownMenuLink">
											<c:forEach var="contents_list"
												items="${dateList.contents_data_arr}" varStatus="status"
												begin="1" end="3">
												<c:if test="${!empty contents_list.poster_path }">
													<li><a class="dropdown-item"
														href="${pageContext.request.contextPath}/contents/detail.do?contents_type=${contents_list.contents_type }&contents_num=${contents_list.contents_num}">
															<div style="width: 100px; position: relative;">
																<img src="${contents_list.poster_path }"
																	style="width: 100%; max-height: 140px;">
															</div>
													</a></li>

												</c:if>
											</c:forEach>
									</c:forEach>
									</ul>
								</div>

							</div>
						</td>
						</c:forEach>
				</tbody>
			</table>
	</form>
</body>
