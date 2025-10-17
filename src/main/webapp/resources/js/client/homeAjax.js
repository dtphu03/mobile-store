
function addToCart(id)
	{
		$.ajax({
			type: "GET",		
			url: "http://localhost:8080/mobilestore/api/gio-hang/addSanPham?id="+id,
			success: function(result){
				if(result.status == "false")
				{
					window.alert("Sản phẩm đang hết hàng, quý khách vui lòng quay lại sau");	
				}else
				{
					window.alert("Đã thêm sản phẩm vào giỏ hàng");
				}		
			},
			error : function(e){
				alert("Error: ",e);
				console.log("Error" , e );
			}
		});

		
	}


$(document).ready(function(){
	ajaxGet();
	loadTopSelling();

	function ajaxGet(){
		$.ajax({
			type: "GET",
			url: "http://localhost:8080/mobilestore/api/san-pham/latest",
			success: function(result){
				var content;
				var section = '<div class="section group">';
				var endsection = '</div>'+'<br>';
				$.each(result, function(i, sanpham){

					if(i != result.length-1)
					{
						if(i%4==0)
						{
							content = '';
							content = '<div class="grid_1_of_4 images_1_of_4 products-info"><a href="sp?id='+sanpham.id+'">' +
									'<img style="width: 300px; height: 238px" src="/mobilestore/img/'+sanpham.id+'.png">' +
									'<h3 style="font-weight: bold;">'+sanpham.tenSanPham+'</h3></a>' +
									'<h3>'+accounting.formatMoney(sanpham.donGia)+' VND</h3>'+
									'<button onClick="addToCart('+sanpham.id+')" class="btn btn-warning"><span class= "glyphicon glyphicon-shopping-cart pull-center"></span> Giỏ hàng</button>'+
									'<h3></h3>'+
									'</div>';
						}else
						{
							content = content+'<div class="grid_1_of_4 images_1_of_4 products-info"><a href="sp?id='+sanpham.id+'">' +
									'<img style="width: 300px; height: 238px" src="/mobilestore/img/'+sanpham.id+'.png">' +
									'<h3 style="font-weight: bold;">'+sanpham.tenSanPham+'</h3></a>' +
									'<h3>'+accounting.formatMoney(sanpham.donGia)+' VND</h3>'+
									'<button onClick="addToCart('+sanpham.id+')" class="btn btn-warning"><span class= "glyphicon glyphicon-shopping-cart pull-center"></span> Giỏ hàng</button>'+
									'<h3></h3>'+
									'</div>';
							if(i%4==3)
							{
								content = section + content + endsection;
								$('#latestProductsContainer').append(content);
							}
						}
					}else
					{
						if(i%4==0)
						{
							content = '';
							content = '<div class="grid_1_of_4 images_1_of_4 products-info"><a href="sp?id='+sanpham.id+'">' +
									'<img style="width: 300px; height: 238px" src="/mobilestore/img/'+sanpham.id+'.png">' +
									'<h3 style="font-weight: bold;">'+sanpham.tenSanPham+'</h3></a>' +
									'<h3>'+accounting.formatMoney(sanpham.donGia)+' VND</h3>'+
									'<button onClick="addToCart('+sanpham.id+')" class="btn btn-warning"><span class= "glyphicon glyphicon-shopping-cart pull-center"></span> Giỏ hàng</button>'+
									'<h3></h3>'+
									'</div>';
							content = section + content + endsection;
							$('#latestProductsContainer').append(content);
						}else
						{
							content = content+'<div class="grid_1_of_4 images_1_of_4 products-info"><a href="sp?id='+sanpham.id+'">' +
									'<img style="width: 300px; height: 238px" src="/mobilestore/img/'+sanpham.id+'.png">' +
									'<h3 style="font-weight: bold;">'+sanpham.tenSanPham+'</h3></a>' +
									'<h3>'+accounting.formatMoney(sanpham.donGia)+' VND</h3>'+
									'<button  onClick="addToCart('+sanpham.id+')" class="btn btn-warning"><span class= "glyphicon glyphicon-shopping-cart pull-center"></span> Giỏ hàng</button>'+
									'<h3></h3>'+
									'</div>';
							content = section + content + endsection;
							$('#latestProductsContainer').append(content);
						}
					}
				});
			},
			error : function(e){
				alert("Error: ",e);
				console.log("Error" , e );
			}
		});
	}

	function renderTopSellingCard(p){
		var ratingStars = '';
		var avg = p.ratingAverage || 0;
		var full = Math.round(avg);
		for(var i=0;i<full;i++){ ratingStars += '★'; }
		for(var j=full;j<5;j++){ ratingStars += '☆'; }
		var price = accounting.formatMoney(p.donGia) + ' VND';
		return '<div class="grid_1_of_4 images_1_of_4 products-info" style="width: 100%; margin: 0; min-height: 600px; display: flex; flex-direction: column; justify-content: space-between;">'
			+ '<a href="sp?id='+p.id+'">'
			+ '<img style="width: 100%; height: 238px; object-fit: contain; display: block; margin: 0 auto;" src="/mobilestore/img/'+p.id+'.png">'
			+ '<h3 style="font-weight: bold; color: #575757; margin-top: 0.3em; margin-bottom: 0.45em; font-size: 1.2em; font-family: \'Open Sans\', sans-serif; line-height: 1.2; height: 60px; overflow: hidden; display: -webkit-box; -webkit-line-clamp: 3; -webkit-box-orient: vertical;">'+p.tenSanPham+'</h3></a>'
			+ '<div style="color:#f39c12; font-size: 22px; margin: 5px 0;">'+ratingStars+' <span style="color:#666; font-size: 15px;">('+(p.ratingCount||0)+')</span></div>'
			+ '<h3 style="color: #575757; margin-top: 0.3em; margin-bottom: 0.45em; font-size: 1.2em; font-family: \'Open Sans\', sans-serif;">'+price+'</h3>'
			+ '<div style="font-size:16px;color:#666; margin-bottom: 8px;">Đã bán: '+(p.salesCount||0)+'</div>'
			+ '<button onClick="addToCart('+p.id+')" class="btn btn-warning" style="margin-top: auto;"><span class= "glyphicon glyphicon-shopping-cart pull-center"></span> Giỏ hàng</button>'
			+ '<h3></h3>'
			+ '</div>';
	}

	function loadTopSelling(){
		$.ajax({
			type: "GET",
			url: "/mobilestore/api/products/best-selling?limit=8",
			success: function(resp){
				if(!resp || !resp.data){ return; }
				var arr = resp.data;
				var content = '<div class="horizontal-scroll-container">';
				content += '<button class="scroll-nav prev" onclick="scrollHorizontal(\'topSelling\', -300)">‹</button>';
				content += '<button class="scroll-nav next" onclick="scrollHorizontal(\'topSelling\', 300)">›</button>';
				content += '<div class="horizontal-scroll-wrapper" id="topSellingScroll">';
				for(var i=0;i<arr.length;i++){
					content += '<div class="horizontal-scroll-item">' + renderTopSellingCard(arr[i]) + '</div>';
				}
				content += '</div>';
				content += '</div>';
				$('#topSellingContainer').html(content);
			},
			error: function(e){
				// silent
			}
		});
	}

})

// Hàm cuộn ngang cho sản phẩm bán chạy
function scrollHorizontal(containerId, direction) {
	var scrollContainer = document.getElementById(containerId + 'Scroll');
	if (scrollContainer) {
		scrollContainer.scrollBy({
			left: direction,
			behavior: 'smooth'
		});
	}
}
