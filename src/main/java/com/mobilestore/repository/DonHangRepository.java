package com.mobilestore.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.querydsl.QuerydslPredicateExecutor;

import com.mobilestore.entities.DonHang;
import com.mobilestore.entities.NguoiDung;

public interface DonHangRepository extends JpaRepository<DonHang, Long>, QuerydslPredicateExecutor<DonHang> {

	public List<DonHang> findByTrangThaiDonHangAndShipper(String trangThai, NguoiDung shipper);

    @Query(value = "select MONTH(dh.ngay_nhan_hang) as month, "
            + " YEAR(dh.ngay_nhan_hang) as year, sum(ct.so_luong_nhan_hang * ct.don_gia) as total "
            + " from don_hang dh join chi_tiet_don_hang ct on ct.ma_don_hang = dh.id "
            + " where dh.trang_thai_don_hang = 'Hoàn thành' and dh.ngay_nhan_hang is not null "
            + " group by YEAR(dh.ngay_nhan_hang), MONTH(dh.ngay_nhan_hang)"
            + " order by year asc, month asc" , nativeQuery = true)
	public List<Object> layDonHangTheoThangVaNam();
	
	public List<DonHang> findByNguoiDat(NguoiDung ng);
	
	public int countByTrangThaiDonHang(String trangThaiDonHang);
	
}
