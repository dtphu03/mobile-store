package com.mobilestore.service;

import com.mobilestore.entities.GioHang;
import com.mobilestore.entities.NguoiDung;

public interface GioHangService {
	
	GioHang getGioHangByNguoiDung(NguoiDung n);
	
	GioHang save(GioHang g);
}
