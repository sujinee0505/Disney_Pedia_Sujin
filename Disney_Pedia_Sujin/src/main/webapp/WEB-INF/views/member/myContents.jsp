<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/scroll.js"></script>
<style>
* {
	font-family: 'SUIT-Medium';
}
</style>
<section class="css-18gwkcr">
	<section class="css-le8j8b" style="min-height: 950px;">
		<div class="css-1jehmiq"
			style="background: transparent; border-bottom: 1px solid #e3e3e3;">
			<div class="css-10zg79x-pageMarginStyle pageTitle"
				style="font-weight: 700; font-size: 22px; color: black;">
				<c:if test="${!empty param.contents_type  && param.contents_type eq 'movie'}">영화</c:if>
				<c:if test="${!empty param.contents_type  && param.contents_type eq 'tv'}">TV</c:if>
			</div>
		</div>
		<div class="css-15qcwbn-StyledTabBarContainer e1szkzar1 css-1ue9xs6">
			<h2 class="css-1gwdxtz-VisualUl-StyledTabBarUl e1szkzar2 css-1wtjsst">
				평가</h2>
			<span class="css-wzn7fp">${fn:length(starList) }</span>
		</div>
		<div class="css-ipmqep-StyledTabContentContainer e1szkzar3">
			<div class="css-12hxjcc-StyledHideableBlock e1pww8ij0">
				<section class="css-9ebwyf-pageMarginStyle">
					<section class="css-1s4ow07">
						<div class="css-usdi1z">
							<div class="css-9dnzub scroll">
								<div class="css-174lxc3">
									<ul class="css-1bk3hui-VisualUl">
										<c:forEach var="starList" items="${starList}">
											<li class="css-8y23cj"><a title=""
												href="${pageContext.request.contextPath}/contents/detail.do?contents_type=${starList.contents_type }&contents_num=${starList.contents_num}"><div
														class="css-1qmeemv">
														<div class=" css-1rdb949-StyledLazyLoadingImage ezcopuc0">
															<img src="${starList.poster_path }"
																class="css-qhzw1o-StyledImg ezcopuc1">
														</div>
													</div>
													<div class="css-ixy093">
														<div class="css-niy0za">${starList.title }</div>
														<div class="css-1kcd80z">평가함 ★ ${starList.star}</div>
													</div></a></li>
										</c:forEach>
										<div class="css-ml096x"></div>
									</ul>
								</div>
							</div>
							<div class="arrow_button css-1b9dnd0 left" style="display: none;">
								<button type="button" class="css-vp7uyl"
									style="margin-bottom: 60px;">
									<img
										src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxMiIgaGVpZ2h0PSIxNiIgdmlld0JveD0iMCAwIDEyIDE2Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZD0iTTAgMEgxMlYxNkgweiIgdHJhbnNmb3JtPSJyb3RhdGUoMTgwIDYgOCkiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjMjkyQTMyIiBzdHJva2U9IiMyOTJBMzIiIHN0cm9rZS13aWR0aD0iLjM1IiBkPSJNMy40MjkgMTMuNDA5TDQuMzU0IDE0LjI1OCAxMC42OCA4LjQ2IDExLjE0MyA4LjAzNiA0LjM1NCAxLjgxMyAzLjQyOSAyLjY2MiA5LjI5MSA4LjAzNnoiIHRyYW5zZm9ybT0icm90YXRlKDE4MCA2IDgpIi8+CiAgICA8L2c+Cjwvc3ZnPgo="
										alt="forward">
								</button>
							</div>
							<div class="arrow_button css-pf83cl right">
								<button type="button" class="css-vp7uyl"
									style="margin-bottom: 60px;">
									<img
										src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxMiIgaGVpZ2h0PSIxNiIgdmlld0JveD0iMCAwIDEyIDE2Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZD0iTTAgMEgxMlYxNkgweiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiMyOTJBMzIiIHN0cm9rZT0iIzI5MkEzMiIgc3Ryb2tlLXdpZHRoPSIuMzUiIGQ9Ik0zLjQyOSAxMy40MDlMNC4zNTQgMTQuMjU4IDEwLjY4IDguNDYgMTEuMTQzIDguMDM2IDQuMzU0IDEuODEzIDMuNDI5IDIuNjYyIDkuMjkxIDguMDM2eiIvPgogICAgPC9nPgo8L3N2Zz4K"
										alt="forward">
								</button>
							</div>
						</div>
					</section>
				</section>
			</div>
		</div>
		<div class="css-15qcwbn-StyledTabBarContainer e1szkzar1 css-1ue9xs6"
			style="margin-top: 20px;">
			<h2 class="css-1gwdxtz-VisualUl-StyledTabBarUl e1szkzar2 css-1wtjsst">
				보고싶어요</h2>
			<span class="css-wzn7fp">${fn:length(likeList) }</span>
		</div>
		<div class="css-ipmqep-StyledTabContentContainer e1szkzar3">
			<div class="css-12hxjcc-StyledHideableBlock e1pww8ij0">
				<section class="css-9ebwyf-pageMarginStyle">
					<section class="css-1s4ow07">
						<div class="css-usdi1z">
							<div class="css-9dnzub scroll">
								<div class="css-174lxc3">
									<ul class="css-1bk3hui-VisualUl">
										<c:forEach var="likeList" items="${likeList}">
											<li class="css-8y23cj"><a title=""
												href="${pageContext.request.contextPath}/contents/detail.do?contents_type=${likeList.contents_type }&contents_num=${likeList.contents_num}"><div
														class="css-1qmeemv">
														<div class=" css-1rdb949-StyledLazyLoadingImage ezcopuc0">
															<img src="${likeList.poster_path }"
																class="css-qhzw1o-StyledImg ezcopuc1">
														</div>
													</div>
													<div class="css-ixy093">
														<div class="css-niy0za">${likeList.title }</div>
														<div class="css-1kcd80z" style="color: #555765;">평균 ★
															${Math.ceil((likeList.vote_average)/2*10)/10}</div>
													</div></a></li>
										</c:forEach>
										<div class="css-ml096x"></div>
									</ul>
								</div>
							</div>
							<div class="arrow_button css-1b9dnd0 left" style="display: none;">
								<button type="button" class="css-vp7uyl"
									style="margin-bottom: 60px;">
									<img
										src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxMiIgaGVpZ2h0PSIxNiIgdmlld0JveD0iMCAwIDEyIDE2Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZD0iTTAgMEgxMlYxNkgweiIgdHJhbnNmb3JtPSJyb3RhdGUoMTgwIDYgOCkiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjMjkyQTMyIiBzdHJva2U9IiMyOTJBMzIiIHN0cm9rZS13aWR0aD0iLjM1IiBkPSJNMy40MjkgMTMuNDA5TDQuMzU0IDE0LjI1OCAxMC42OCA4LjQ2IDExLjE0MyA4LjAzNiA0LjM1NCAxLjgxMyAzLjQyOSAyLjY2MiA5LjI5MSA4LjAzNnoiIHRyYW5zZm9ybT0icm90YXRlKDE4MCA2IDgpIi8+CiAgICA8L2c+Cjwvc3ZnPgo="
										alt="forward">
								</button>
							</div>
							<div class="arrow_button css-pf83cl right">
								<button type="button" class="css-vp7uyl"
									style="margin-bottom: 60px;">
									<img
										src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxMiIgaGVpZ2h0PSIxNiIgdmlld0JveD0iMCAwIDEyIDE2Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZD0iTTAgMEgxMlYxNkgweiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiMyOTJBMzIiIHN0cm9rZT0iIzI5MkEzMiIgc3Ryb2tlLXdpZHRoPSIuMzUiIGQ9Ik0zLjQyOSAxMy40MDlMNC4zNTQgMTQuMjU4IDEwLjY4IDguNDYgMTEuMTQzIDguMDM2IDQuMzU0IDEuODEzIDMuNDI5IDIuNjYyIDkuMjkxIDguMDM2eiIvPgogICAgPC9nPgo8L3N2Zz4K"
										alt="forward">
								</button>
							</div>
						</div>
					</section>
				</section>
			</div>
		</div>
	</section>
</section>