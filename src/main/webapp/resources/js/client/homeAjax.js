
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
									'<h3 style="font-weight: bold;">'+sanpham.tenSanPham+'</h3><a/>' +
									'<h3>'+accounting.formatMoney(sanpham.donGia)+' VND</h3>'+
									'<button onClick="addToCart('+sanpham.id+')" class="btn btn-warning"><span class= "glyphicon glyphicon-shopping-cart pull-center"></span> Giỏ hàng</button>'+
									'<h3></h3>'+
									'</div>';
							if(i%4==3)
							{
								content = section + content + endsection;
								$('.content-grids').append(content);
							}				
						}
					}else
					{
						if(i%4==0)
						{
							content = '';
							content = '<div class="grid_1_of_4 images_1_of_4 products-info"><a href="sp?id='+sanpham.id+'">' +
									'<img style="width: 300px; height: 238px" src="/mobilestore/img/'+sanpham.id+'.png">' +
									'<h3 style="font-weight: bold;">'+sanpham.tenSanPham+'</h3>></a>' +
									'<h3>'+accounting.formatMoney(sanpham.donGia)+' VND</h3>'+
									'<button onClick="addToCart('+sanpham.id+')" class="btn btn-warning"><span class= "glyphicon glyphicon-shopping-cart pull-center"></span> Giỏ hàng</button>'+
									'<h3></h3>'+
									'</div>';
							content = section + content + endsection;
							$('.content-grids').append(content);
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
							$('.content-grids').append(content);
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
		var price = accounting.formatMoney(parseInt(p.donGia||0)) + ' VND';
		return '<div class="grid_1_of_4 images_1_of_4 products-info">'
			+ '<a href="sp?id='+p.id+'">'
			+ '<img style="width: 300px; height: 238px" src="/mobilestore/img/'+p.id+'.png">'
			+ '<h3 style="font-weight: bold;">'+p.tenSanPham+'</h3></a>'
			+ '<div style="color:#f39c12;">'+ratingStars+' <span style="color:#666; font-size:12px;">('+(p.ratingCount||0)+')</span></div>'
			+ '<h3>'+price+'</h3>'
			+ '<div style="font-size:12px;color:#666;">Đã bán: '+(p.salesCount||0)+'</div>'
			+ '<button onClick="addToCart('+p.id+')" class="btn btn-warning"><span class= "glyphicon glyphicon-shopping-cart pull-center"></span> Giỏ hàng</button>'
			+ '<h3></h3>'
			+ '</div>';
	}

	function loadTopSelling(){
		$.ajax({
			type: "GET",
			url: "/mobilestore/api/products/best-selling?limit=6",
			success: function(resp){
				if(!resp || !resp.data){ return; }
				var arr = resp.data;
				var section = '<div class="section group">';
				var endsection = '</div>'+'<br>';
				var content = '';
				for(var i=0;i<arr.length;i++){
					if(i%4===0){ content = ''; }
					content += renderTopSellingCard(arr[i]);
					if(i%4===3 || i === arr.length-1){
						$('#topSellingContainer').append(section + content + endsection);
					}
				}
			},
			error: function(e){
				// silent
			}
		});
	}

})
