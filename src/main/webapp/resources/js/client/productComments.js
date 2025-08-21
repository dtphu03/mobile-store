$(document).ready(function(){
    var productId = parseInt($("#spid").text());
    if(!productId){
        return;
    }

    var page = 0;
    var size = 5;
    var isAdmin = ($("#isAdminFlag").text()||"").trim() === 'true';

    function renderStars(avg){
        var rounded = Math.round((avg + Number.EPSILON) * 10) / 10;
        return rounded.toFixed(1);
    }

    function loadSummary(){
        // We can compute average from list payload or query product if available.
        // Here we rely on comments page payload fields if present. Otherwise keep as-is.
        $.ajax({
            type: "GET",
            url: "/mobilestore/api/products/"+productId+"/comments?page=0&size=1",
            success: function(resp){
                if(resp && resp.data){
                    // Not all APIs include summary; fallback to sales-count and keep 0
                }
            }
        });
    }

    function renderReplySection(comment){
        var html = '';
        if(comment.replyId){
            var replyCreated = comment.replyCreatedAt ? (''+comment.replyCreatedAt).replace('T',' ') : '';
            html += '<div class="comment-reply" style="margin:8px 0 0 16px; padding:8px; background:#f9f9f9; border-left:3px solid #0d6efd;">'
                 + '<div style="font-weight:600;">Phản hồi từ Admin'+(comment.replyAdminName? (': '+comment.replyAdminName):'')+'</div>'
                 + '<div style="white-space:pre-wrap;">'+$('<div>').text(comment.replyContent||'').html()+'</div>'
                 + '<div style="font-size:12px;color:#888;">'+replyCreated+'</div>'
                 + '</div>';
        } else if (isAdmin) {
            html += '<div class="reply-box" style="margin:8px 0 0 16px;">'
                 + '<textarea class="form-control reply-content" rows="2" placeholder="Trả lời với tư cách Admin..."></textarea>'
                 + '<button class="btn btn-link p-0 mt-1 do-reply" data-comment-id="'+comment.id+'">Gửi phản hồi</button>'
                 + '</div>';
        }
        return html;
    }

    function loadComments(){
        $.ajax({
            type: "GET",
            url: "/mobilestore/api/products/"+productId+"/comments?page="+page+"&size="+size,
            success: function(resp){
                if(!resp || !resp.data){
                    $("#commentsList").html("<p>Chưa có nhận xét nào.</p>");
                    return;
                }
                var pageData = resp.data;
                var content = pageData.content || [];
                if(content.length === 0){
                    $("#commentsList").html("<p>Chưa có nhận xét nào.</p>");
                } else {
                    var html = '';
                    content.forEach(function(c){
                        var stars = '';
                        for(var i=0;i< (c.rating||0); i++){ stars += '★'; }
                        for(var j=(c.rating||0); j<5; j++){ stars += '☆'; }
                        var created = c.createdAt ? (''+c.createdAt).replace('T',' ') : '';
                        html += '<div class="comment-item" style="padding:8px 0;border-bottom:1px solid #eee;">'
                             + '<div style="color:#f39c12;font-size:14px;">'+stars+'</div>'
                             + '<div style="white-space:pre-wrap;">'+$('<div>').text(c.content||'').html()+'</div>'
                             + '<div style="font-size:12px;color:#888;">'+(c.userName||'Ẩn danh')+' • '+created
                             + (c.verifiedPurchase? ' • Đã mua hàng' : '')
                             + '</div>'
                             + renderReplySection(c)
                             + '</div>';
                    });
                    $("#commentsList").html(html);
                    $(".do-reply").off('click').on('click', function(){
                        var cid = $(this).data('comment-id');
                        var box = $(this).closest('.reply-box');
                        var content = box.find('.reply-content').val();
                        if(!content || content.trim().length === 0){
                            alert('Vui lòng nhập nội dung phản hồi');
                            return;
                        }
                        $.ajax({
                            type: 'POST',
                            url: '/mobilestore/api/products/comments/'+cid+'/reply',
                            contentType: 'application/json',
                            data: JSON.stringify({ content: content }),
                            success: function(){
                                loadComments();
                            },
                            error: function(xhr){
                                if(xhr && xhr.status === 401){
                                    alert('Vui lòng đăng nhập.');
                                } else if (xhr && xhr.status === 403){
                                    alert('Chỉ Admin mới có thể phản hồi.');
                                } else {
                                    alert('Không thể gửi phản hồi');
                                }
                            }
                        });
                    });
                }

                // pager
                var totalPages = pageData.totalPages || 1;
                var pagerHtml = '';
                if(totalPages > 1){
                    pagerHtml += '<button class="btn btn-default" id="prevPage" '+(page<=0?'disabled':'')+'>Trước</button> ';
                    pagerHtml += '<span> Trang ' + (page+1) + ' / ' + totalPages + ' </span>'; 
                    pagerHtml += ' <button class="btn btn-default" id="nextPage" '+(page>=totalPages-1?'disabled':'')+'>Sau</button>';
                }
                $("#commentsPager").html(pagerHtml);

                $("#prevPage").off('click').on('click', function(){ if(page>0){ page--; loadComments(); }});
                $("#nextPage").off('click').on('click', function(){ page++; loadComments(); });

                // Try to update summary from server if page content has ratings
                var totalElements = pageData.totalElements || 0;
                if(totalElements > 0){
                    // naive approximation using current page average if no dedicated field
                    var sum = 0;
                    content.forEach(function(c){ sum += (c.rating||0); });
                    var avg = sum / content.length;
                    $("#avgRating").text(renderStars(avg));
                    $("#ratingCount").text(totalElements);
                }
            },
            error: function(){
                $("#commentsList").html("<p>Lỗi tải nhận xét.</p>");
            }
        });
    }

    $("#submitComment").on('click', function(){
        var rating = parseInt($("#starRating").val());
        var content = $("#commentContent").val();
        if(!rating || rating < 1 || rating > 5){
            alert('Vui lòng chọn số sao từ 1 đến 5');
            return;
        }
        if(!content || content.trim().length === 0){
            alert('Vui lòng nhập nội dung nhận xét');
            return;
        }
        $.ajax({
            type: "POST",
            url: "/mobilestore/api/products/"+productId+"/comments",
            contentType: "application/json",
            data: JSON.stringify({ productId: productId, rating: rating, content: content }),
            success: function(resp){
                $("#commentContent").val('');
                page = 0;
                loadComments();
                alert('Đã gửi đánh giá');
            },
            error: function(xhr){
                if(xhr && xhr.status === 401){
                    alert('Vui lòng đăng nhập để nhận xét.');
                } else {
                    alert('Không thể gửi đánh giá');
                }
            }
        });
    });

    loadSummary();
    loadComments();
});


