<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

		<head>
			<link rel="stylesheet" href="Frontend/css/detailsp.css">
		</head>
		<script type="text/javascript">
			$(document).ready(function () {
				var priceConvert = accounting.formatMoney("${sp.getDonGia()}") + ' VND';
				document.getElementById("priceConvert").innerHTML = priceConvert;

			});
		</script>

		<body>
			<div class="container">
				<div class="card">
					<div class="container-fliud">
						<div class="wrapper row">
							<div class="preview col-md-6">

								<div class="preview-pic tab-content">
									<div class="tab-pane active" id="pic-1"><img
											src="/mobilestore/img/${sp.getId()}.png" /></div>
								</div>
							</div>
							<div class="details col-md-6">
								<p style="display:none" id="spid">${sp.getId()}</p>
								<h2 class="product-title">${sp.getTenSanPham()}</h2>
								<h4 class="price">Mô tả sản phẩm</h4>
								<c:if test="${sp.getCpu().length() > 0}">
									<p class="product-description">CPU: ${sp.getCpu()}</p>
								</c:if>
								<c:if test="${sp.getRam().length() > 0}">
									<p class="product-description">RAM: ${sp.getRam()}</p>
								</c:if>
								<c:if test="${sp.getThietKe().length() > 0}">
									<p class="product-description">Thiết kế: ${sp.getThietKe()}</p>
								</c:if>
								<c:if test="${sp.getHeDieuHanh().length() > 0}">
									<p class="product-description">Hệ điều hành: ${sp.getHeDieuHanh()}</p>
								</c:if>
								<c:if test="${sp.getManHinh().length() > 0}">
									<p class="product-description">Màn hình: ${sp.getManHinh()}</p>
								</c:if>
								<c:if test="${sp.getDungLuongPin().length() > 0}">
									<p class="product-description">Dung lượng pin: ${sp.getDungLuongPin()}</p>
								</c:if>
								<p class="product-description">Hãng sản xuất: ${sp.hangSanXuat.tenHangSanXuat}</p>
								<p class="product-description"><span class="important">THÔNG TIN CHUNG:</span>
									${sp.getThongTinChung()}</p>
								<p class="product-description"><span class="important">BẢO HÀNH:</span>
									${sp.getThongTinBaoHanh()}</p>
								<h4 class="price" id="blabla">Giá bán: <span id="priceConvert"></span></h4>
								<div class="action">
									<button class="add-to-cart btn btn-warning" type="button">
										<span class="glyphicon glyphicon-shopping-cart pull-center"></span> Giỏ
										hàng</button>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="card">
					<div class="container-fliud">
						<div class="wrapper row">
							<div class="col-md-12">
								<h3>Đánh giá & Nhận xét</h3>
								<c:if test="${not empty loggedInUser}">
									<c:set var="isAdmin" value="${pageContext.request.isUserInRole('ROLE_ADMIN')}" />
									<p id="isAdminFlag" style="display:none;">${isAdmin}</p>
								</c:if>
								<div id="rating-summary" style="margin:8px 0;">
									<span><b>Điểm trung bình:</b> <span id="avgRating">${sp.ratingAverage}</span> (<span
											id="ratingCount">${sp.ratingCount}</span> đánh giá)</span>
								</div>
								<div id="comment-form" style="margin:12px 0;">
									<label for="starRating">Chọn số sao:</label>
									<select id="starRating" class="form-control"
										style="width:120px; display:inline-block;">
										<option value="5">5 ★</option>
										<option value="4">4 ★</option>
										<option value="3">3 ★</option>
										<option value="2">2 ★</option>
										<option value="1">1 ★</option>
									</select>
									<textarea id="commentContent" class="form-control" rows="3"
										placeholder="Chia sẻ cảm nhận của bạn..."></textarea>
									<br>
									<button id="submitComment" class="btn btn-primary">Gửi đánh giá</button>
								</div>
								<div id="commentsList"></div>
								<div id="commentsPager" style="margin-top:8px;"></div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</body>

		<script src="<c:url value='/js/client/detailspAjax.js'/>"></script>
		<script src="<c:url value='/js/client/productComments.js'/>"></script>