package com.mobilestore.service;

import java.util.List;

import com.mobilestore.entities.ChiTietDonHang;
import com.mobilestore.entities.DonHang;

public interface ChiTietDonHangService {
	List<ChiTietDonHang> save(List<ChiTietDonHang> list);

	List<ChiTietDonHang> findByDonHang(DonHang donHang);
}
