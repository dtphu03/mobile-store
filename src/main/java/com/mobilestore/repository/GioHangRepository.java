package com.mobilestore.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.mobilestore.entities.GioHang;
import com.mobilestore.entities.NguoiDung;

public interface GioHangRepository extends JpaRepository<GioHang, Long>{
	
	GioHang findByNguoiDung(NguoiDung n);
	
}
