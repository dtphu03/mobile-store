package com.mobilestore.service;

import java.util.List;

import com.mobilestore.dto.BestSellingProductDto;
import com.mobilestore.entities.DonHang;

public interface SalesService {

    /**
     * Record sales for an order (idempotent operation)
     * This method should be called when an order is paid/completed
     * @param donHang the completed order
     * @return true if sales were recorded, false if already recorded
     */
    boolean recordOrderSales(DonHang donHang);

    /**
     * Record sales for an order by ID (idempotent operation)
     * @param orderId the order ID
     * @return true if sales were recorded, false if already recorded
     */
    boolean recordOrderSales(Long orderId);

    /**
     * Update product sales count after recording sales
     * @param productId the product ID
     */
    void updateProductSalesCount(Long productId);

    /**
     * Get best-selling products with pagination
     * @param limit the maximum number of products to return
     * @return list of best-selling products
     */
    List<BestSellingProductDto> getBestSellingProducts(int limit);

    /**
     * Get total sales count for a product
     * @param productId the product ID
     * @return total sales count
     */
    Long getTotalSalesCountByProductId(Long productId);

    /**
     * Check if order sales have been recorded
     * @param orderId the order ID
     * @return true if sales have been recorded
     */
    boolean isOrderSalesRecorded(Long orderId);

    /**
     * Recalculate all product sales counts from the sales ledger
     * This is a maintenance operation to ensure data consistency
     */
    void recalculateAllProductSalesCounts();
}