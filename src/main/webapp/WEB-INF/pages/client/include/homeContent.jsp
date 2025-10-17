<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<script src="<c:url value='/js/client/homeAjax.js'/>"></script>
		<!--start-image-slider---->
		<div class="wrap">
			<div class="image-slider">
				<!-- Slideshow 1 -->
				<ul class="rslides" id="slider1">
					<li><img src="Frontend/img/slide1.jpg" alt=""></li>
					<li><img src="Frontend/img/slide2.png" alt=""></li>
					<li><img src="Frontend/img/slide3.png" alt=""></li>
				</ul>
				<!-- Slideshow 2 -->
			</div>
			<!--End-image-slider---->
		</div>
		<div class="clear"> </div>
		<div class="wrap">
			<div class="content">
				<div class="top-3-grids">
					<div class="section group">
						<div class="grid_1_of_3 images_1_of_3">
							<img src="Frontend/img/apple-logo.png"></a>
							<h3>Thương hiệu nổi bật </h3>
						</div>
						<div class="grid_1_of_3 images_1_of_3 ">
							<img src="Frontend/img/samsung.jpg" style="background-color: white"></a>
							<h3>Thương hiệu nổi bật</h3>
						</div>
						<div class="grid_1_of_3 images_1_of_3 ">
							<img src="Frontend/img/logo-xiaomi.jpg" style="background-color: white"></a>
							<h3>Thương hiệu nổi bật</h3>
						</div>
					</div>
				</div>

				<div class="content-grids" style="margin-top:24px;">
					<h4>SẢN PHẨM BÁN CHẠY</h4>
					<div id="topSellingContainer"></div>
				</div>

				<div class="content-sidebar" style="margin-top:24px;">
					<h4>Danh mục</h4>
					<ul id="danhmuc"></ul>
				</div>

				<div class="content-grids">
					<h4>DANH SÁCH ĐIỆN THOẠI MỚI NHẤT</h4>
					<div id="latestProductsContainer"></div>
				</div>

			</div>

		</div>
		<div class="clear"> </div>
		</div>