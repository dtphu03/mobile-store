<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<title>Thanh toán</title>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<div class="container">
	<form method="POST" action="<%=request.getContextPath()%>/thankyou">
		<div class="row">
			<br><br>
			<c:if test="${pageContext.request.userPrincipal.name != null}">
				<div class="col-md-3">
					<br>
					<p class="border-p" style="line-height:1.5;"><b>Thông tin khách hàng</b></p>
					<p style="line-height:2;">Họ tên Quý khách </p>
					<input size="27" value="${user.hoTen}" disabled>
					<p style="line-height:2;">Địa chỉ Email </p>
					<input size="27" value="${user.email}" disabled>
					<p style="line-height:2;"> Số điện thoại </p>
					<input size="27" value="${user.soDienThoai}" disabled>
					<p style="line-height:2;">Địa chỉ(số nhà, đường, tỉnh thành) </p>
					<textarea rows="5" cols="29" disabled>${user.diaChi}</textarea>
					<br><br>
				</div>
			</c:if>
			<div class="col-md-3">
				<br>
				<p class="border-p" style="line-height:1.5;"><b>Thông tin nhận hàng</b></p>
				<p style="line-height:2;">Họ tên người nhận hàng *</p>
				<input size="27" name="hoTenNguoiNhan" required>
				<p style="line-height:2;">Số điện thoại *</p>
				<input size="27" name="sdtNhanHang" required>
				<p style="line-height:2;">Địa chỉ(số nhà, đường, tỉnh thành) *</p>
				<textarea rows="5" cols="29" name="diaChiNhan" required></textarea>
				<br><br>
				<input type="hidden" id="tongGiaTri" name="tongGiaTri">
			</div>
			<div class="col-md-6">
				<br>
				<p class="border-p" style="line-height:1.5;"><b>Giỏ hàng</b></p>
				<br>
				<table class="table-cart-checkout mytable">
					<tr>
						<th>Ảnh</th>
						<th>Tên sản phẩm</th>
						<th>Đơn giá</th>
						<th>Tổng</th>
					</tr>
					<c:forEach items="${cart}" var="sanpham">
						<tr style="text-align: center;">
							<td style="justify-content: center; align-items: center; display: flex;">
								<img src="/mobilestore/img/${sanpham.id}.png" alt="not found img" class="img-responsive fix-size-img" style="width: 50%; height: auto;  object-fit: contain;">
							</td>
							<td style="color:green">${sanpham.tenSanPham}</td>
							<td class="donGia">
								<div class="check" style="display: inline-block;">${sanpham.donGia}</div>
								<div style="display: inline-block;"> x ${quanity[sanpham.id]}</div>
							</td>
							<td>
								<div class="total">${sanpham.donGia * quanity[sanpham.id]}</div>
							</td>
						</tr>
					</c:forEach>
				</table>
				<br>
				<p>Tổng giá trị đơn hàng: <b id="ordertotal"></b></p>
				<br>
				<a href="<%=request.getContextPath()%>/cart" class="btn btn-primary">Quay lại giỏ hàng</a>
				<button class="btn btn-danger pull-center" type="submit" id="submit">Thanh toán khi nhận hàng</button>
				<button class="btn btn-success pull-center" type="button" id="vnpayButton">Thanh toán qua VNPay</button>
				<br><br>
			</div>
		</div>
	</form>
</div>

<script type="text/javascript">
	$(document).ready(function () {
		$(".mytable .donGia .check").each(function () {
			// Lấy giá trị số nguyên
			var value = parseInt($(this).text());
			// Định dạng số với dấu phẩy hàng nghìn
			var formattedValue = value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
			$(this).html(formattedValue + ' VND');
		});

		$(".mytable .total").each(function () {
			// Lấy giá trị số nguyên
			var value = parseInt($(this).text());
			// Định dạng số với dấu phẩy hàng nghìn
			var formattedValue = value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
			$(this).html(formattedValue + ' VND');
		});

		var totalOrder = 0;
		$(".mytable .total").each(function () {
			var value = parseFloat($(this).text().replace(/[^0-9.-]+/g, ""));
			totalOrder += value;
		});
		// Định dạng tổng giá trị đơn hàng
		var formattedTotal = parseInt(totalOrder).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		$("#ordertotal").html(formattedTotal + ' VND');
		$("#tongGiaTri").val(totalOrder);

		$("#vnpayButton").click(function (e) {
			e.preventDefault();
			var totalAmount = $("#tongGiaTri").val();
			var hoTenNguoiNhan = $("input[name='hoTenNguoiNhan']").val();
			var sdtNhanHang = $("input[name='sdtNhanHang']").val();
			var diaChiNhan = $("textarea[name='diaChiNhan']").val();

			console.log("Tổng tiền gửi sang VNPAY:", totalAmount);
			console.log("Họ tên người nhận:", hoTenNguoiNhan);
			console.log("Số điện thoại:", sdtNhanHang);
			console.log("Địa chỉ nhận:", diaChiNhan);

			$.ajax({
				url: '<%=request.getContextPath()%>/vn-pay',
				type: 'POST',
				data: {
					amount: totalAmount,
					hoTenNguoiNhan: hoTenNguoiNhan,
					sdtNhanHang: sdtNhanHang,
					diaChiNhan: diaChiNhan
				},
				success: function (response) {
					console.log("API Response:", response);
					if (response.status === 'OK' && response.data && response.data.paymentUrl) {
						console.log("Chuyển hướng đến:", response.data.paymentUrl);
						window.location.href = response.data.paymentUrl;
					} else {
						alert("Lỗi: " + (response.message || "Không nhận được URL thanh toán"));
					}
				},
				error: function (xhr, status, error) {
					console.error("Lỗi khi gọi API:", xhr.status, xhr.responseText);
					alert('Lỗi khi gọi API thanh toán: ' + xhr.status + ' - ' + xhr.responseText);
				}
			});
		});
	});
</script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/accounting.js/0.4.1/accounting.min.js"></script>
<script src="<c:url value='/js/client/checkoutAjax.js'/>"></script>
</body>
</html>