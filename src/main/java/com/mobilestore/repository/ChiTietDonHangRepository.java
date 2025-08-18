package com.mobilestore.repository;

import com.mobilestore.entities.DonHang;
import org.springframework.data.jpa.repository.JpaRepository;

import com.mobilestore.entities.ChiTietDonHang;

import java.util.List;

public interface ChiTietDonHangRepository extends JpaRepository<ChiTietDonHang, Long>{
    List<ChiTietDonHang> findByDonHang(DonHang donHang);
}
