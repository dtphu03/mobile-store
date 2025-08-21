package com.mobilestore.service.impl;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mobilestore.dto.CommentRequestDto;
import com.mobilestore.dto.CommentResponseDto;
import com.mobilestore.entities.ProductComment;
import com.mobilestore.entities.ProductCommentReply;
import com.mobilestore.entities.SanPham;
import com.mobilestore.entities.NguoiDung;
import com.mobilestore.repository.ProductCommentRepository;
import com.mobilestore.repository.ProductCommentReplyRepository;
import com.mobilestore.repository.SanPhamRepository;
import com.mobilestore.repository.NguoiDungRepository;
import com.mobilestore.service.CommentService;

@Service
@Transactional
public class CommentServiceImpl implements CommentService {

    @Autowired
    private ProductCommentRepository commentRepository;

    @Autowired
    private SanPhamRepository sanPhamRepository;

    @Autowired
    private NguoiDungRepository nguoiDungRepository;

    @Autowired
    private ProductCommentReplyRepository replyRepository;

    @Override
    public ProductComment addComment(CommentRequestDto commentRequest, NguoiDung user) {
        // Validate product exists
        Optional<SanPham> productOpt = sanPhamRepository.findById(commentRequest.getProductId());
        if (!productOpt.isPresent()) {
            throw new RuntimeException("Product not found with ID: " + commentRequest.getProductId());
        }

        SanPham product = productOpt.get();
        
        // Create new comment
        ProductComment comment = new ProductComment();
        comment.setSanPham(product);
        comment.setNguoiDung(user);
        comment.setRating(commentRequest.getRating().byteValue());
        comment.setContent(commentRequest.getContent());
        comment.setIsDeleted(false);
        comment.setCreatedAt(new Date());
        comment.setUpdatedAt(new Date());

        // Save comment
        ProductComment savedComment = commentRepository.save(comment);

        // Update product rating statistics
        updateProductRating(commentRequest.getProductId());

        return savedComment;
    }

    @Override
    @Transactional(readOnly = true)
    public Page<CommentResponseDto> getCommentsByProductId(Long productId, int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        Page<ProductComment> comments = commentRepository.findByProductIdAndIsDeletedFalse(productId, pageable);
        
        return comments.map(this::convertToResponseDtoWithReply);
    }

    @Override
    @Transactional(readOnly = true)
    public Page<CommentResponseDto> getCommentsByUserId(Long userId, int page, int size) {
        Optional<NguoiDung> userOpt = nguoiDungRepository.findById(userId);
        if (!userOpt.isPresent()) {
            throw new RuntimeException("User not found with ID: " + userId);
        }

        Pageable pageable = PageRequest.of(page, size);
        Page<ProductComment> comments = commentRepository.findByNguoiDungAndIsDeletedFalseOrderByCreatedAtDesc(userOpt.get(), pageable);
        
        return comments.map(this::convertToResponseDto);
    }

    @Override
    public boolean deleteComment(Long commentId, Long userId) {
        Optional<ProductComment> commentOpt = commentRepository.findById(commentId);
        if (!commentOpt.isPresent()) {
            return false;
        }

        ProductComment comment = commentOpt.get();
        
        // Check if user owns the comment
        if (!(comment.getNguoiDung().getId() == userId)) {
            throw new RuntimeException("User not authorized to delete this comment");
        }

        // Soft delete
        comment.setIsDeleted(true);
        comment.setUpdatedAt(new Date());
        commentRepository.save(comment);

        // Update product rating statistics
        updateProductRating(comment.getSanPham().getId());

        return true;
    }

    @Override
    public void updateProductRating(Long productId) {
        Optional<SanPham> productOpt = sanPhamRepository.findById(productId);
        if (!productOpt.isPresent()) {
            return;
        }

        SanPham product = productOpt.get();
        List<ProductComment> comments = commentRepository.findBySanPhamAndIsDeletedFalse(product);

        if (comments.isEmpty()) {
            product.setRatingCount(0);
            product.setRatingSum(0);
        } else {
            int ratingSum = comments.stream()
                    .map(ProductComment::getRating)
                    .mapToInt(Byte::intValue)
                    .sum();
            product.setRatingCount(comments.size());
            product.setRatingSum(ratingSum);
        }

        sanPhamRepository.save(product);
    }

    @Override
    @Transactional(readOnly = true)
    public boolean hasUserPurchasedProduct(Long productId, Long userId) {
        return commentRepository.hasUserPurchasedProduct(productId, userId);
    }

    @Override
    @Transactional(readOnly = true)
    public long getCommentCountByProductId(Long productId) {
        Optional<SanPham> productOpt = sanPhamRepository.findById(productId);
        if (!productOpt.isPresent()) {
            return 0;
        }
        return commentRepository.countBySanPhamAndIsDeletedFalse(productOpt.get());
    }

    private CommentResponseDto convertToResponseDto(ProductComment comment) {
        CommentResponseDto dto = new CommentResponseDto();
        dto.setId(comment.getId());
        dto.setProductId(comment.getSanPham().getId());
        dto.setProductName(comment.getSanPham().getTenSanPham());
        dto.setUserId(comment.getNguoiDung().getId());
        dto.setUserName(comment.getNguoiDung().getHoTen());
        dto.setRating(comment.getRating() != null ? comment.getRating().intValue() : null);
        dto.setContent(comment.getContent());
        dto.setVerifiedPurchase(hasUserPurchasedProduct(comment.getSanPham().getId(), comment.getNguoiDung().getId()));
        dto.setCreatedAt(comment.getCreatedAt().toInstant().atZone(ZoneId.systemDefault()).toLocalDateTime());
        dto.setUpdatedAt(comment.getUpdatedAt() != null ? comment.getUpdatedAt().toInstant().atZone(ZoneId.systemDefault()).toLocalDateTime() : null);
        return dto;
    }

    private CommentResponseDto convertToResponseDtoWithReply(ProductComment comment) {
        CommentResponseDto dto = convertToResponseDto(comment);
        List<ProductCommentReply> replies = replyRepository.findByProductCommentAndIsDeletedFalseOrderByCreatedAtAsc(comment);
        if (!replies.isEmpty()) {
            ProductCommentReply r = replies.get(0); // one-level single reply
            dto.setReplyId(r.getId());
            dto.setReplyAdminName(r.getAdmin() != null ? r.getAdmin().getHoTen() : null);
            dto.setReplyContent(r.getContent());
            dto.setReplyCreatedAt(r.getCreatedAt() != null ? r.getCreatedAt().toInstant().atZone(ZoneId.systemDefault()).toLocalDateTime() : null);
        }
        return dto;
    }

    @Override
    public Long replyToComment(Long commentId, Long adminId, String content) {
        Optional<ProductComment> commentOpt = commentRepository.findById(commentId);
        if (!commentOpt.isPresent()) {
            throw new RuntimeException("Comment not found with ID: " + commentId);
        }

        Optional<NguoiDung> adminOpt = nguoiDungRepository.findById(adminId);
        if (!adminOpt.isPresent()) {
            throw new RuntimeException("Admin user not found with ID: " + adminId);
        }

        // Ensure only one reply; if exists, update the old one
        List<ProductCommentReply> existing = replyRepository.findByProductCommentAndIsDeletedFalseOrderByCreatedAtAsc(commentOpt.get());
        ProductCommentReply reply;
        Date now = new Date();
        if (!existing.isEmpty()) {
            reply = existing.get(0);
            reply.setContent(content);
            reply.setUpdatedAt(now);
        } else {
            reply = new ProductCommentReply();
            reply.setProductComment(commentOpt.get());
            reply.setAdmin(adminOpt.get());
            reply.setContent(content);
            reply.setIsDeleted(false);
            reply.setCreatedAt(now);
            reply.setUpdatedAt(now);
        }
        ProductCommentReply saved = replyRepository.save(reply);
        return saved.getId();
    }
}