package com.mobilestore.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.mobilestore.entities.ProductComment;
import com.mobilestore.entities.SanPham;
import com.mobilestore.entities.NguoiDung;

public interface ProductCommentRepository extends JpaRepository<ProductComment, Long> {

    // Find comments by product with pagination, excluding deleted comments
    Page<ProductComment> findBySanPhamAndIsDeletedFalseOrderByCreatedAtDesc(SanPham sanPham, Pageable pageable);
    
    // Find comments by product ID with pagination, excluding deleted comments
    @Query("SELECT pc FROM ProductComment pc WHERE pc.sanPham.id = :productId AND pc.isDeleted = false ORDER BY pc.createdAt DESC")
    Page<ProductComment> findByProductIdAndIsDeletedFalse(@Param("productId") Long productId, Pageable pageable);
    
    // Find comments by user with pagination, excluding deleted comments
    Page<ProductComment> findByNguoiDungAndIsDeletedFalseOrderByCreatedAtDesc(NguoiDung nguoiDung, Pageable pageable);
    
    // Count comments for a product, excluding deleted comments
    long countBySanPhamAndIsDeletedFalse(SanPham sanPham);
    
    // Check if user has purchased the product (for verified purchase badge)
    @Query("SELECT CASE WHEN COUNT(ctdh) > 0 THEN true ELSE false END " +
           "FROM ChiTietDonHang ctdh " +
           "JOIN ctdh.donHang dh " +
           "WHERE ctdh.sanPham.id = :productId " +
           "AND dh.nguoiDat.id = :userId " +
           "AND (dh.trangThaiDonHang = 'Hoàn thành' OR dh.trangThaiDonHang = 'Đang giao')")
    boolean hasUserPurchasedProduct(@Param("productId") Long productId, @Param("userId") Long userId);
    
    // Find all comments by product for rating calculation (including deleted for consistency)
    List<ProductComment> findBySanPhamAndIsDeletedFalse(SanPham sanPham);
}