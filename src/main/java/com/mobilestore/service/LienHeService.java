package com.mobilestore.service;

import java.text.ParseException;

import org.springframework.data.domain.Page;

import com.mobilestore.dto.SearchLienHeObject;
import com.mobilestore.entities.LienHe;

public interface LienHeService {

	Page<LienHe> getLienHeByFilter(SearchLienHeObject object, int page) throws ParseException;

	LienHe findById(long id);
	
	LienHe save(LienHe lh);
	
	int countByTrangThai(String trangThai);

}
