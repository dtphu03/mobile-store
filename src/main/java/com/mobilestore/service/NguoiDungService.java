package com.mobilestore.service;

import java.util.List;
import java.util.Set;

import org.springframework.data.domain.Page;

import com.mobilestore.dto.TaiKhoanDTO;
import com.mobilestore.entities.NguoiDung;
import com.mobilestore.entities.VaiTro;

public interface NguoiDungService {

	NguoiDung findByEmail(String email);

	NguoiDung findByEmailFetchVaiTro(String email);

	NguoiDung findByConfirmationToken(String confirmationToken);

	NguoiDung saveUserForMember(NguoiDung nd);

	NguoiDung findById(long id);

	NguoiDung updateUser(NguoiDung nd);

	void changePass(NguoiDung nd, String newPass);

	Page<NguoiDung> getNguoiDungByVaiTro(Set<VaiTro> vaiTro, int page);

	List<NguoiDung> getNguoiDungByVaiTro(Set<VaiTro> vaiTro);
	
	NguoiDung saveUserForAdmin(TaiKhoanDTO dto);

	void deleteById(long id);

}
