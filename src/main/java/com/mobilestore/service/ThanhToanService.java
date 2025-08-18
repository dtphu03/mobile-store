package com.mobilestore.service;

import com.mobilestore.config.VNPAYConfig;
import com.mobilestore.dto.ThanhToanDTO;
import com.mobilestore.entities.*;
import com.mobilestore.ulti.VNPayUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ThanhToanService {
    private final VNPAYConfig vnPayConfig;
    private final GioHangService gioHangService;
    private final ChiMucGioHangService chiMucGioHangService;
    private final NguoiDungService nguoiDungService;
    private final DonHangService donHangService;
    private final ChiTietDonHangService chiTietDonHangService;

    public ThanhToanDTO createVnPayPayment(HttpServletRequest request, long amount,
                                           String hoTenNguoiNhan, String sdtNhanHang, String diaChiNhan)
            throws UnsupportedEncodingException {
        NguoiDung currentUser = (NguoiDung) request.getSession().getAttribute("loggedInUser");
        if (currentUser == null) {
            throw new RuntimeException("Vui lòng đăng nhập để thanh toán!");
        }

        GioHang gioHang = gioHangService.getGioHangByNguoiDung(currentUser);
        if (gioHang == null) {
            throw new RuntimeException("Giỏ hàng không tồn tại!");
        }

        List<ChiMucGioHang> cartItems = chiMucGioHangService.getChiMucGioHangByGioHang(gioHang);
        if (cartItems.isEmpty()) {
            throw new RuntimeException("Giỏ hàng trống!");
        }

        // Tạo đơn hàng
        DonHang donHang = new DonHang();
        donHang.setNguoiDat(currentUser);
        donHang.setNgayDatHang(new Date());
        donHang.setTrangThaiDonHang("Đang xử lý");
        // Lưu thông tin người nhận
        donHang.setHoTenNguoiNhan(hoTenNguoiNhan);
        donHang.setSdtNhanHang(sdtNhanHang);
        donHang.setDiaChiNhan(diaChiNhan);
        // Ghi chú có thể để trống hoặc lấy từ form nếu có
        donHang.setGhiChu(""); // Nếu có ô input ghi chú, bạn có thể thêm vào

        DonHang savedDonHang = donHangService.save(donHang);

        List<ChiTietDonHang> listDetailDH = cartItems.stream()
                .map(item -> {
                    ChiTietDonHang detail = new ChiTietDonHang();
                    detail.setSanPham(item.getSanPham());
                    detail.setSoLuongDat(item.getSo_luong());
                    detail.setDonGia(item.getSanPham().getDonGia() * item.getSo_luong());
                    detail.setDonHang(savedDonHang);
                    return detail;
                })
                .collect(Collectors.toList());
        chiTietDonHangService.save(listDetailDH);

        // Chuẩn bị tham số VNPAY
        Map<String, String> vnpParams = new TreeMap<>();
        vnpParams.put("vnp_Version", "2.1.0");
        vnpParams.put("vnp_Command", "pay");
        vnpParams.put("vnp_TmnCode", vnPayConfig.getVnpTmnCode());
        vnpParams.put("vnp_Amount", String.valueOf(amount * 100L));
        vnpParams.put("vnp_CurrCode", "VND");

        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        String vnp_CreateDate = sdf.format(new Date());
        vnpParams.put("vnp_CreateDate", vnp_CreateDate);

        long expireTime = System.currentTimeMillis() + 15 * 60 * 1000;
        String vnp_ExpireDate = sdf.format(new Date(expireTime));
        vnpParams.put("vnp_ExpireDate", vnp_ExpireDate);

        vnpParams.put("vnp_IpAddr", VNPayUtil.getIpAddress(request));
        vnpParams.put("vnp_Locale", "vn");
        vnpParams.put("vnp_OrderInfo", "Thanh toan don hang #" + savedDonHang.getId());
        vnpParams.put("vnp_OrderType", "250000");
        vnpParams.put("vnp_ReturnUrl", "http://localhost:8080" + request.getContextPath() + "/vn-pay-return");
        vnpParams.put("vnp_TxnRef", String.valueOf(savedDonHang.getId()));

        // Tạo chuỗi hash data
        StringBuilder hashData = new StringBuilder();
        for (Map.Entry<String, String> entry : vnpParams.entrySet()) {
            if (entry.getValue() != null && !entry.getValue().isEmpty()) {
                hashData.append(entry.getKey()).append("=").append(VNPayUtil.encodeURL(entry.getValue())).append("&");
            }
        }
        hashData.setLength(hashData.length() - 1);

        // Tạo vnp_SecureHash
        String vnpSecureHash = VNPayUtil.hmacSHA512(vnPayConfig.getSecretKey(), hashData.toString());
        vnpParams.put("vnp_SecureHash", vnpSecureHash);

        // Tạo paymentUrl
        StringBuilder queryUrl = new StringBuilder();
        for (Map.Entry<String, String> entry : vnpParams.entrySet()) {
            if (entry.getValue() != null && !entry.getValue().isEmpty()) {
                queryUrl.append(entry.getKey()).append("=").append(VNPayUtil.encodeURL(entry.getValue())).append("&");
            }
        }
        queryUrl.setLength(queryUrl.length() - 1);
        String paymentUrl = vnPayConfig.getVnpPayUrl() + "?" + queryUrl.toString();

        System.out.println("Generated VNPAY URL: " + paymentUrl);
        return ThanhToanDTO.builder()
                .code("ok")
                .message("success")
                .paymentUrl(paymentUrl)
                .build();
    }
}