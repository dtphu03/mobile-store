package com.mobilestore.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mobilestore.entities.ChiTietDonHang;
import com.mobilestore.repository.ChiTietDonHangRepository;
import com.mobilestore.service.ChiTietDonHangService;

@Service
public class ChiTietDonHangServiceImpl implements ChiTietDonHangService {

	@Autowired
	private ChiTietDonHangRepository repo;

	@Override
	public List<ChiTietDonHang> save(List<ChiTietDonHang> list) {
		return repo.saveAll(list);
	}

	@Override
	public List<ChiTietDonHang> findByDonHang(com.mobilestore.entities.DonHang donHang) {
		return repo.findByDonHang(donHang);
	}
}
