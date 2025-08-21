package com.mobilestore.service;

import org.springframework.data.domain.Page;

import com.mobilestore.dto.CommentRequestDto;
import com.mobilestore.dto.CommentResponseDto;
import com.mobilestore.entities.ProductComment;
import com.mobilestore.entities.NguoiDung;

public interface CommentService {

    /**
     * Add a new comment and rating for a product
     * @param commentRequest the comment request data
     * @param user the user adding the comment
     * @return the created comment
     */
    ProductComment addComment(CommentRequestDto commentRequest, NguoiDung user);

    /**
     * Get comments for a product with pagination
     * @param productId the product ID
     * @param page the page number (0-based)
     * @param size the page size
     * @return paginated comments
     */
    Page<CommentResponseDto> getCommentsByProductId(Long productId, int page, int size);

    /**
     * Get comments by a user with pagination
     * @param userId the user ID
     * @param page the page number (0-based)
     * @param size the page size
     * @return paginated comments
     */
    Page<CommentResponseDto> getCommentsByUserId(Long userId, int page, int size);

    /**
     * Delete a comment (soft delete)
     * @param commentId the comment ID
     * @param userId the user ID (must be the comment owner)
     * @return true if deleted successfully
     */
    boolean deleteComment(Long commentId, Long userId);

    /**
     * Update product rating statistics after a comment is added
     * @param productId the product ID
     */
    void updateProductRating(Long productId);

    /**
     * Check if user has purchased the product
     * @param productId the product ID
     * @param userId the user ID
     * @return true if user has purchased the product
     */
    boolean hasUserPurchasedProduct(Long productId, Long userId);

    /**
     * Get comment count for a product
     * @param productId the product ID
     * @return comment count
     */
    long getCommentCountByProductId(Long productId);

    /**
     * Admin replies to a comment (one-level)
     * @param commentId the original comment id
     * @param adminId the admin user id
     * @param content reply content
     * @return reply id
     */
    Long replyToComment(Long commentId, Long adminId, String content);
}