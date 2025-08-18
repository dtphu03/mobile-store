package com.mobilestore.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.mobilestore.entities.VaiTro;

public interface VaiTroRepository extends JpaRepository<VaiTro, Long> {

	VaiTro findByTenVaiTro(String tenVaiTro);
}
