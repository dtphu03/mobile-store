package com.mobilestore.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.mobilestore.dto.BestSellingProductDto;
import com.mobilestore.dto.CommentRequestDto;
import com.mobilestore.dto.CommentResponseDto;
import com.mobilestore.dto.ReplyRequestDto;
import com.mobilestore.entities.NguoiDung;
import com.mobilestore.entities.ProductComment;
import com.mobilestore.dto.response.ResponseObject;
import com.mobilestore.service.CommentService;
import com.mobilestore.service.NguoiDungService;
import com.mobilestore.service.SalesService;

@RestController
@RequestMapping("/api/products")
public class ProductApiController {

    @Autowired
    private CommentService commentService;

    @Autowired
    private SalesService salesService;

    @Autowired
    private NguoiDungService nguoiDungService;

    /**
     * Add a comment and rating for a product
     */
    @PostMapping("/{productId}/comments")
    public ResponseEntity<ResponseObject> addComment(
            @PathVariable Long productId,
            @Valid @RequestBody CommentRequestDto commentRequest,
            HttpServletRequest request) {
        
        try {
            // Get authenticated user
            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
            if (auth == null || !auth.isAuthenticated() || "anonymousUser".equals(auth.getName())) {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                    .body(new ResponseObject(HttpStatus.UNAUTHORIZED, "User must be logged in to add comments", null));
            }

            NguoiDung user = nguoiDungService.findByEmail(auth.getName());
            if (user == null) {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                    .body(new ResponseObject(HttpStatus.UNAUTHORIZED, "User not found", null));
            }

            // Set product ID from path variable
            commentRequest.setProductId(productId);

            ProductComment comment = commentService.addComment(commentRequest, user);
            
            return ResponseEntity.ok(new ResponseObject(HttpStatus.OK, "Comment added successfully", comment.getId()));
            
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                .body(new ResponseObject(HttpStatus.BAD_REQUEST, e.getMessage(), null));
        }
    }

    /**
     * Get comments for a product with pagination
     */
    @GetMapping("/{productId}/comments")
    public ResponseEntity<ResponseObject> getProductComments(
            @PathVariable Long productId,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size) {
        
        try {
            Page<CommentResponseDto> comments = commentService.getCommentsByProductId(productId, page, size);
            return ResponseEntity.ok(new ResponseObject(HttpStatus.OK, "Comments retrieved successfully", comments));
            
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                .body(new ResponseObject(HttpStatus.BAD_REQUEST, e.getMessage(), null));
        }
    }

    /**
     * Admin reply to a comment (one-level)
     */
    @PostMapping("/comments/{commentId}/reply")
    public ResponseEntity<ResponseObject> replyToComment(
            @PathVariable Long commentId,
            @Valid @RequestBody ReplyRequestDto replyRequest) {
        try {
            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
            if (auth == null || !auth.isAuthenticated() || "anonymousUser".equals(auth.getName())) {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                        .body(new ResponseObject(HttpStatus.UNAUTHORIZED, "User must be logged in", null));
            }

            NguoiDung user = nguoiDungService.findByEmail(auth.getName());
            if (user == null) {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                        .body(new ResponseObject(HttpStatus.UNAUTHORIZED, "User not found", null));
            }

            // Role check: must be admin
            boolean isAdmin = user.getVaiTro().stream().anyMatch(r -> "ROLE_ADMIN".equals(r.getTenVaiTro()));
            if (!isAdmin) {
                return ResponseEntity.status(HttpStatus.FORBIDDEN)
                        .body(new ResponseObject(HttpStatus.FORBIDDEN, "Only admin can reply", null));
            }

            Long replyId = commentService.replyToComment(commentId, user.getId(), replyRequest.getContent());
            return ResponseEntity.ok(new ResponseObject(HttpStatus.OK, "Reply saved", replyId));
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body(new ResponseObject(HttpStatus.BAD_REQUEST, e.getMessage(), null));
        }
    }

    /**
     * Get comment count for a product
     */
    @GetMapping("/{productId}/comments/count")
    public ResponseEntity<ResponseObject> getProductCommentCount(@PathVariable Long productId) {
        try {
            long count = commentService.getCommentCountByProductId(productId);
            return ResponseEntity.ok(new ResponseObject(HttpStatus.OK, "Comment count retrieved successfully", count));
            
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                .body(new ResponseObject(HttpStatus.BAD_REQUEST, e.getMessage(), null));
        }
    }

    /**
     * Delete a comment (soft delete)
     */
    @DeleteMapping("/comments/{commentId}")
    public ResponseEntity<ResponseObject> deleteComment(
            @PathVariable Long commentId,
            HttpServletRequest request) {
        
        try {
            // Get authenticated user
            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
            if (auth == null || !auth.isAuthenticated() || "anonymousUser".equals(auth.getName())) {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                    .body(new ResponseObject(HttpStatus.UNAUTHORIZED, "User must be logged in to delete comments", null));
            }

            NguoiDung user = nguoiDungService.findByEmail(auth.getName());
            if (user == null) {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                    .body(new ResponseObject(HttpStatus.UNAUTHORIZED, "User not found", null));
            }

            boolean deleted = commentService.deleteComment(commentId, user.getId());
            
            if (deleted) {
                return ResponseEntity.ok(new ResponseObject(HttpStatus.OK, "Comment deleted successfully", null));
            } else {
                return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body(new ResponseObject(HttpStatus.NOT_FOUND, "Comment not found", null));
            }
            
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                .body(new ResponseObject(HttpStatus.BAD_REQUEST, e.getMessage(), null));
        }
    }

    /**
     * Get user's comments with pagination
     */
    @GetMapping("/users/{userId}/comments")
    public ResponseEntity<ResponseObject> getUserComments(
            @PathVariable Long userId,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size) {
        
        try {
            Page<CommentResponseDto> comments = commentService.getCommentsByUserId(userId, page, size);
            return ResponseEntity.ok(new ResponseObject(HttpStatus.OK, "User comments retrieved successfully", comments));
            
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                .body(new ResponseObject(HttpStatus.BAD_REQUEST, e.getMessage(), null));
        }
    }

    /**
     * Get best-selling products
     */
    @GetMapping("/best-selling")
    public ResponseEntity<ResponseObject> getBestSellingProducts(
            @RequestParam(defaultValue = "10") int limit) {
        
        try {
            List<BestSellingProductDto> bestSellingProducts = salesService.getBestSellingProducts(limit);
            return ResponseEntity.ok(new ResponseObject(HttpStatus.OK, "Best-selling products retrieved successfully", bestSellingProducts));
            
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                .body(new ResponseObject(HttpStatus.BAD_REQUEST, e.getMessage(), null));
        }
    }

    /**
     * Get total sales count for a product
     */
    @GetMapping("/{productId}/sales-count")
    public ResponseEntity<ResponseObject> getProductSalesCount(@PathVariable Long productId) {
        try {
            Long salesCount = salesService.getTotalSalesCountByProductId(productId);
            return ResponseEntity.ok(new ResponseObject(HttpStatus.OK, "Sales count retrieved successfully", salesCount));
            
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                .body(new ResponseObject(HttpStatus.BAD_REQUEST, e.getMessage(), null));
        }
    }

    /**
     * Record sales for an order in an idempotent way
     */
    @PostMapping("/orders/{orderId}/record-sales")
    public ResponseEntity<ResponseObject> recordOrderSales(@PathVariable Long orderId) {
        try {
            boolean applied = salesService.recordOrderSales(orderId);
            return ResponseEntity.ok(new ResponseObject(HttpStatus.OK,
                    applied ? "Sales recorded" : "Sales already recorded", applied));
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                .body(new ResponseObject(HttpStatus.BAD_REQUEST, e.getMessage(), null));
        }
    }

    /**
     * Check if user has purchased a product
     */
    @GetMapping("/{productId}/purchased")
    public ResponseEntity<ResponseObject> hasUserPurchasedProduct(
            @PathVariable Long productId,
            HttpServletRequest request) {
        
        try {
            // Get authenticated user
            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
            if (auth == null || !auth.isAuthenticated() || "anonymousUser".equals(auth.getName())) {
                return ResponseEntity.ok(new ResponseObject(HttpStatus.OK, "Purchase status retrieved", false));
            }

            NguoiDung user = nguoiDungService.findByEmail(auth.getName());
            if (user == null) {
                return ResponseEntity.ok(new ResponseObject(HttpStatus.OK, "Purchase status retrieved", false));
            }

            boolean hasPurchased = commentService.hasUserPurchasedProduct(productId, user.getId());
            return ResponseEntity.ok(new ResponseObject(HttpStatus.OK, "Purchase status retrieved", hasPurchased));
            
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                .body(new ResponseObject(HttpStatus.BAD_REQUEST, e.getMessage(), null));
        }
    }
}