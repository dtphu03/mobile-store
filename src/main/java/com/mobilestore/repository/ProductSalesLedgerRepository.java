package com.mobilestore.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.mobilestore.entities.ProductSalesLedger;
import com.mobilestore.entities.DonHang;
import com.mobilestore.entities.SanPham;

public interface ProductSalesLedgerRepository extends JpaRepository<ProductSalesLedger, Long> {

    // Check if sales for a specific order and product have already been recorded
    Optional<ProductSalesLedger> findByDonHangAndSanPham(DonHang donHang, SanPham sanPham);
    
    // Check if sales for a specific order ID and product ID have already been recorded
    @Query("SELECT psl FROM ProductSalesLedger psl WHERE psl.donHang.id = :orderId AND psl.sanPham.id = :productId")
    Optional<ProductSalesLedger> findByOrderIdAndProductId(@Param("orderId") Long orderId, @Param("productId") Long productId);
    
    // Get all sales records for a specific product
    List<ProductSalesLedger> findBySanPham(SanPham sanPham);
    
    // Get all sales records for a specific order
    List<ProductSalesLedger> findByDonHang(DonHang donHang);
    
    // Calculate total sales quantity for a product
    @Query("SELECT COALESCE(SUM(psl.quantity), 0) FROM ProductSalesLedger psl WHERE psl.sanPham.id = :productId")
    Long getTotalSalesQuantityByProductId(@Param("productId") Long productId);
    
    // Get top selling products with their sales quantities
    @Query("SELECT psl.sanPham.id, SUM(psl.quantity) as totalSales " +
           "FROM ProductSalesLedger psl " +
           "GROUP BY psl.sanPham.id " +
           "ORDER BY totalSales DESC")
    List<Object[]> getTopSellingProducts();
    
    // Check if order has been processed for sales tracking
    boolean existsByDonHang(DonHang donHang);
}