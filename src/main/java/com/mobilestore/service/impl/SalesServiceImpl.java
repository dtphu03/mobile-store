package com.mobilestore.service.impl;

import java.time.LocalDateTime;
import java.util.Date;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mobilestore.dto.BestSellingProductDto;
import com.mobilestore.entities.ChiTietDonHang;
import com.mobilestore.entities.DonHang;
import com.mobilestore.entities.ProductSalesLedger;
import com.mobilestore.entities.SanPham;
import com.mobilestore.repository.DonHangRepository;
import com.mobilestore.repository.ProductSalesLedgerRepository;
import com.mobilestore.repository.SanPhamRepository;
import com.mobilestore.service.SalesService;

@Service
@Transactional
public class SalesServiceImpl implements SalesService {

    @Autowired
    private ProductSalesLedgerRepository salesLedgerRepository;

    @Autowired
    private DonHangRepository donHangRepository;

    @Autowired
    private SanPhamRepository sanPhamRepository;

    @Override
    public boolean recordOrderSales(DonHang donHang) {
        // Check if sales for this order have already been recorded
        if (salesLedgerRepository.existsByDonHang(donHang)) {
            return false; // Already recorded
        }

        // Record sales for each product in the order
        for (ChiTietDonHang chiTiet : donHang.getDanhSachChiTiet()) {
            // Check if this specific product-order combination already exists
            Optional<ProductSalesLedger> existingRecord = salesLedgerRepository
                .findByDonHangAndSanPham(donHang, chiTiet.getSanPham());
            
            if (!existingRecord.isPresent()) {
                ProductSalesLedger salesRecord = new ProductSalesLedger();
                salesRecord.setDonHang(donHang);
                salesRecord.setSanPham(chiTiet.getSanPham());
                // Use received quantity if available (> 0), otherwise fallback to ordered quantity
                salesRecord.setQuantity(chiTiet.getSoLuongNhanHang() > 0 ?
                    chiTiet.getSoLuongNhanHang() : chiTiet.getSoLuongDat());
                salesRecord.setCreatedAt(new Date());
                
                salesLedgerRepository.save(salesRecord);
                
                // Update product sales count
                updateProductSalesCount(chiTiet.getSanPham().getId());
            }
        }

        return true;
    }

    @Override
    public boolean recordOrderSales(Long orderId) {
        Optional<DonHang> orderOpt = donHangRepository.findById(orderId);
        if (!orderOpt.isPresent()) {
            throw new RuntimeException("Order not found with ID: " + orderId);
        }
        
        return recordOrderSales(orderOpt.get());
    }

    @Override
    public void updateProductSalesCount(Long productId) {
        Optional<SanPham> productOpt = sanPhamRepository.findById(productId);
        if (!productOpt.isPresent()) {
            return;
        }

        SanPham product = productOpt.get();
        Long totalSales = salesLedgerRepository.getTotalSalesQuantityByProductId(productId);
        
        product.setSalesCount(totalSales != null ? totalSales : 0L);
        sanPhamRepository.save(product);
    }

    @Override
    @Transactional(readOnly = true)
    public List<BestSellingProductDto> getBestSellingProducts(int limit) {
        List<Object[]> topSellingData = salesLedgerRepository.getTopSellingProducts();
        List<BestSellingProductDto> result = new ArrayList<>();
        
        int count = 0;
        for (Object[] data : topSellingData) {
            if (count >= limit) {
                break;
            }
            
            Long productId = (Long) data[0];
            Long salesCount = (Long) data[1];
            
            Optional<SanPham> productOpt = sanPhamRepository.findById(productId);
            if (productOpt.isPresent()) {
                SanPham product = productOpt.get();
                
                BestSellingProductDto dto = new BestSellingProductDto();
                dto.setId(product.getId());
                dto.setTenSanPham(product.getTenSanPham());
                dto.setDonGia(String.valueOf(product.getDonGia()));
                // Image name not available on entity; set null or map appropriately if added later
                dto.setHinhAnh(null);
                dto.setDanhMucTen(product.getDanhMuc() != null ? product.getDanhMuc().getTenDanhMuc() : null);
                dto.setHangSanXuatTen(product.getHangSanXuat() != null ? product.getHangSanXuat().getTenHangSanXuat() : null);
                dto.setSalesCount(salesCount);
                dto.setRatingCount(product.getRatingCount());
                dto.setRatingSum(product.getRatingSum());
                dto.setRatingAverage(product.getRatingAverage());
                
                result.add(dto);
                count++;
            }
        }
        
        return result;
    }

    @Override
    @Transactional(readOnly = true)
    public Long getTotalSalesCountByProductId(Long productId) {
        return salesLedgerRepository.getTotalSalesQuantityByProductId(productId);
    }

    @Override
    @Transactional(readOnly = true)
    public boolean isOrderSalesRecorded(Long orderId) {
        Optional<DonHang> orderOpt = donHangRepository.findById(orderId);
        if (!orderOpt.isPresent()) {
            return false;
        }
        
        return salesLedgerRepository.existsByDonHang(orderOpt.get());
    }

    @Override
    public void recalculateAllProductSalesCounts() {
        List<SanPham> allProducts = sanPhamRepository.findAll();
        
        for (SanPham product : allProducts) {
            updateProductSalesCount(product.getId());
        }
    }
}