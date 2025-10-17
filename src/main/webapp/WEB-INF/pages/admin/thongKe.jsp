<%@page contentType="text/html" pageEncoding="UTF-8" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

			<!DOCTYPE html>
			<html>

			<head>
				<meta charset="ISO-8859-1">
				<title>Quản lý nhãn hiệu</title>
				<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

				<script>
					window.onload = function () {
						var rawData = [];
						$.ajax({
							async: false,
							type: "GET",
							contentType: "application/json",
							url: "http://localhost:8080/mobilestore/api/don-hang/report",
							success: function (data) {
								rawData = data || [];
							},
							error: function (e) {
								alert("Error: " + e);
								console.log("Error", e);
							}
						});

						function getUniqueYears(data) {
							var map = {};
							for (var i = 0; i < data.length; i++) {
								var year = data[i][1];
								map[year] = true;
							}
							return Object.keys(map).sort();
						}

						function buildMonthlyDataForYear(data, year) {
							var labels = ["01","02","03","04","05","06","07","08","09","10","11","12"];
							var totals = new Array(12).fill(0);
							for (var i = 0; i < data.length; i++) {
								var m = data[i][0];
								var y = data[i][1];
								var total = (data[i][2] || 0) / 1000000;
								if (y == year) {
									var idx = parseInt(m, 10) - 1;
									if (idx >= 0 && idx < 12) {
										totals[idx] += total;
									}
								}
							}
							return { labels: labels, data: totals };
						}

						function buildYearlyTotals(data) {
							var yearly = {};
							for (var i = 0; i < data.length; i++) {
								var y = data[i][1];
								var total = (data[i][2] || 0) / 1000000;
								yearly[y] = (yearly[y] || 0) + total;
							}
							var labels = Object.keys(yearly).sort();
							var totals = [];
							for (var j = 0; j < labels.length; j++) {
								totals.push(yearly[labels[j]]);
							}
							return { labels: labels, data: totals };
						}

						var years = getUniqueYears(rawData);
						var yearSelect = document.getElementById('yearSelect');
						if (yearSelect && years.length > 0) {
							for (var i = 0; i < years.length; i++) {
								var opt = document.createElement('option');
								opt.value = years[i];
								opt.text = years[i];
								yearSelect.appendChild(opt);
							}
							yearSelect.value = years[years.length - 1];
						}

						var monthlyCtx = document.getElementById('myChartMonthly');
						var yearlyCtx = document.getElementById('myChartYearly');
						var monthlyGradient = monthlyCtx.getContext('2d').createLinearGradient(0, 0, 0, monthlyCtx.height);
						monthlyGradient.addColorStop(0, 'rgba(0, 99, 255, 0.6)');
						monthlyGradient.addColorStop(1, 'rgba(0, 99, 255, 0.1)');
						var yearlyGradient = yearlyCtx.getContext('2d').createLinearGradient(0, 0, 0, yearlyCtx.height);
						yearlyGradient.addColorStop(0, 'rgba(40, 167, 69, 0.6)');
						yearlyGradient.addColorStop(1, 'rgba(40, 167, 69, 0.1)');
						var monthlyChart = null;
						var yearlyChart = null;

						function renderMonthly(year) {
							var m = buildMonthlyDataForYear(rawData, year);
							var ds = {
								label: "Doanh thu theo tháng (Triệu đồng)",
								backgroundColor: monthlyGradient,
								borderColor: "#0063ff",
								borderWidth: 2,
								hoverBackgroundColor: "#0043ff",
								hoverBorderColor: "#0043ff",
								data: m.data
							};
							var option = {
								scales: {
									yAxes: [{
										stacked: false,
										gridLines: { display: true, color: "rgba(0,0,0,0.06)" },
										ticks: {
											callback: function(value){ return value.toLocaleString('vi-VN') + ' tr'; }
										}
									}],
									xAxes: [{
										barPercentage: 0.55,
										gridLines: { display: false },
										categoryPercentage: 0.7
									}]
								},
								maintainAspectRatio: false,
								legend: { position: 'top', labels: { fontSize: 16 } },
								title: { display: true, text: 'Doanh thu theo tháng - ' + year, fontSize: 20 },
								tooltips: {
									bodyFontSize: 16,
									titleFontSize: 18,
									callbacks: { label: function(tooltipItem){ return ' ' + Number(tooltipItem.yLabel).toLocaleString('vi-VN') + ' triệu'; } }
								},
								animation: { duration: 700, easing: 'easeOutQuart' }
							};
							if (monthlyChart) { monthlyChart.destroy(); }
							monthlyChart = new Chart(monthlyCtx, { type: 'bar', data: { labels: m.labels, datasets: [ds] }, options: option });
						}

						function renderYearly() {
							var y = buildYearlyTotals(rawData);
							var ds = {
								label: "Tổng doanh thu theo năm (Triệu đồng)",
								backgroundColor: yearlyGradient,
								borderColor: "#28a745",
								borderWidth: 2,
								hoverBackgroundColor: "#2ecc71",
								hoverBorderColor: "#2ecc71",
								data: y.data
							};
							var option = {
								scales: {
									yAxes: [{ gridLines: { display: true, color: "rgba(0,0,0,0.06)" }, ticks: { fontSize: 16, callback: function(value){ return value.toLocaleString('vi-VN') + ' tr'; } } }],
									xAxes: [{ gridLines: { display: false }, ticks: { fontSize: 16 } }]
								},
								maintainAspectRatio: false,
								legend: { position: 'top', labels: { fontSize: 16 } },
								title: { display: true, text: 'Tổng doanh thu theo năm', fontSize: 20 },
								tooltips: { bodyFontSize: 16, titleFontSize: 18, callbacks: { label: function(tooltipItem){ return ' ' + Number(tooltipItem.yLabel).toLocaleString('vi-VN') + ' triệu'; } } },
								animation: { duration: 700, easing: 'easeOutQuart' }
							};
							if (yearlyChart) { yearlyChart.destroy(); }
							yearlyChart = new Chart(yearlyCtx, { type: 'bar', data: { labels: y.labels, datasets: [ds] }, options: option });
						}

						if (years.length > 0) {
							renderMonthly(years[years.length - 1]);
						}
						renderYearly();

						if (yearSelect) {
							yearSelect.addEventListener('change', function () {
								renderMonthly(this.value);
							});
						}
					}
				</script>

			</head>

			<body>
				<jsp:include page="template/header.jsp"></jsp:include>
				<jsp:include page="template/sidebar.jsp"></jsp:include>

				<div class="col-md-9 animated bounce">
					<h3 class="page-header">Thống kê</h3>
					<div style="margin-bottom: 15px;">
						<label for="yearSelect" style="margin-right: 10px;">Chọn năm:</label>
						<select id="yearSelect"></select>
					</div>
					<canvas id="myChartMonthly" width="600px" height="400px"></canvas>
					<h4 style="text-align: center; padding-right: 10%">Biểu đồ doanh thu theo tháng (đơn hàng hoàn thành)</h4>
					<hr/>
					<canvas id="myChartYearly" width="600px" height="400px"></canvas>
					<h4 style="text-align: center; padding-right: 10%">Tổng doanh thu theo năm</h4>
				</div>


				<jsp:include page="template/footer.jsp"></jsp:include>

				<script type="text/javascript"
					src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.1.3/Chart.min.js"></script>
			</body>

			</html>