package com.mobilestore.controller;

import com.mobilestore.config.VNPAYConfig;
import com.mobilestore.dto.ThanhToanDTO;
import com.mobilestore.dto.response.ResponseObject;
import com.mobilestore.entities.*;
import com.mobilestore.service.*;
import com.mobilestore.ulti.VNPayUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.view.RedirectView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.*;

@Controller
@Slf4j
public class PaymentController {
    @Autowired
    private ThanhToanService thanhToanService;

    @Autowired
    private DonHangService donHangService;

    @Autowired
    private ChiMucGioHangService chiMucGioHangService;

    @Autowired
    private GioHangService gioHangService;

    @Autowired
    private NguoiDungService nguoiDungService;

    @Autowired
    private ChiTietDonHangService chiTietDonHangService;

    @Autowired
    private VNPAYConfig vnPayConfig;

    @PostMapping("/vn-pay")
    public @ResponseBody ResponseObject<ThanhToanDTO> pay(HttpServletRequest request,
                                                          @RequestParam("amount") long amount,
                                                          @RequestParam("hoTenNguoiNhan") String hoTenNguoiNhan,
                                                          @RequestParam("sdtNhanHang") String sdtNhanHang,
                                                          @RequestParam("diaChiNhan") String diaChiNhan) {
        log.info("Bắt đầu tạo thanh toán VNPAY với số tiền: {}", amount);
        try {
            ThanhToanDTO response = thanhToanService.createVnPayPayment(request, amount, hoTenNguoiNhan, sdtNhanHang, diaChiNhan);
            log.info("Tạo thanh toán VNPAY thành công, URL thanh toán: {}", response.getPaymentUrl());
            return new ResponseObject<>(HttpStatus.OK, "Success", response);
        } catch (Exception e) {
            log.error("Lỗi khi tạo thanh toán VNPAY: {}", e.getMessage());
            return new ResponseObject<>(HttpStatus.BAD_REQUEST, e.getMessage(), null);
        }
    }

    @GetMapping("/vn-pay-return")
    public RedirectView handleVNPayReturn(HttpServletRequest request, HttpSession session) {
        log.info("Nhận kết quả trả về từ VNPAY");
        try {
            // Thu thập tất cả tham số từ VNPAY
            Map<String, String> vnpParams = new TreeMap<>();
            request.getParameterMap().forEach((key, value) -> {
                if (value != null && value.length > 0) {
                    vnpParams.put(key, value[0]);
                }
            });
            log.info("Các tham số nhận được từ VNPAY: {}", vnpParams);

            // Tách riêng secure hash để kiểm tra
            String vnp_SecureHash = vnpParams.get("vnp_SecureHash");
            vnpParams.remove("vnp_SecureHash");
            String vnp_ResponseCode = vnpParams.get("vnp_ResponseCode");
            String vnp_TxnRef = vnpParams.get("vnp_TxnRef");

            log.info("Mã phản hồi (vnp_ResponseCode): {}", vnp_ResponseCode);
            log.info("Mã giao dịch (vnp_TxnRef): {}", vnp_TxnRef);

            // Tạo chuỗi hash mới từ dữ liệu
            List<String> fieldNames = new ArrayList<>(vnpParams.keySet());
            Collections.sort(fieldNames);
            StringBuilder hashData = new StringBuilder();
            for (String fieldName : fieldNames) {
                String fieldValue = vnpParams.get(fieldName);
                if (fieldValue != null && !fieldValue.isEmpty()) {
                    hashData.append(fieldName).append("=").append(VNPayUtil.encodeURL(fieldValue)).append("&");
                }
            }
            if (hashData.length() > 0) {
                hashData.setLength(hashData.length() - 1); // Bỏ dấu & cuối cùng
            }

            String checkHash = VNPayUtil.hmacSHA512(vnPayConfig.getSecretKey(), hashData.toString());
            log.info("Chuỗi hash data: {}", hashData.toString());
            log.info("Hash tính toán: {}", checkHash);
            log.info("Hash nhận được: {}", vnp_SecureHash);

            if (!checkHash.equals(vnp_SecureHash)) {
                log.error("Kiểm tra hash thất bại!");
                session.setAttribute("error", "Dữ liệu trả về từ VNPAY không hợp lệ!");
                return new RedirectView("/mobilestore/checkout");
            }
            log.info("Kiểm tra hash thành công");

            if ("00".equals(vnp_ResponseCode)) {
                log.info("Giao dịch thành công, tìm đơn hàng với ID: {}", vnp_TxnRef);
                DonHang donHang = donHangService.findById(Long.parseLong(vnp_TxnRef));

                if (donHang != null) {
                    log.info("Tìm thấy đơn hàng: {}", donHang.getId());
                    donHang.setTrangThaiDonHang("Đang chờ giao");
                    donHangService.save(donHang);
                    log.info("Đã cập nhật trạng thái đơn hàng thành 'Đang chờ giao'");

                    NguoiDung currentUser = (NguoiDung) request.getSession().getAttribute("loggedInUser");
                    List<SanPham> listsp = new ArrayList<>();
                    Map<Long, String> quanity = new HashMap<>();

                    if (currentUser != null) {
                        log.info("Xử lý giỏ hàng cho người dùng: {}", currentUser.getEmail());
                        GioHang gioHang = gioHangService.getGioHangByNguoiDung(currentUser);
                        if (gioHang != null) {
                            List<ChiMucGioHang> cartItems = chiMucGioHangService.getChiMucGioHangByGioHang(gioHang);
                            for (ChiMucGioHang item : cartItems) {
                                listsp.add(item.getSanPham());
                                quanity.put(item.getSanPham().getId(), Integer.toString(item.getSo_luong()));
                            }
                            chiMucGioHangService.deleteAllChiMucGiohang(cartItems);
                            log.info("Đã xóa tất cả sản phẩm trong giỏ hàng");
                        }
                    }

                    session.setAttribute("donhang", donHang);
                    session.setAttribute("cart", listsp);
                    session.setAttribute("quanity", quanity);
                    log.info("Đã lưu thông tin vào session, chuyển hướng đến trang thank-you");

                    return new RedirectView("/mobilestore/thank-you");
                } else {
                    log.error("Không tìm thấy đơn hàng với ID: {}", vnp_TxnRef);
                    session.setAttribute("error", "Không tìm thấy thông tin đơn hàng!");
                    return new RedirectView("/mobilestore/checkout");
                }
            }

            log.error("Giao dịch thất bại với mã lỗi: {}", vnp_ResponseCode);
            session.setAttribute("error", "Thanh toán thất bại: " + vnp_ResponseCode);
            return new RedirectView("/mobilestore/checkout");
        } catch (Exception e) {
            log.error("Lỗi xử lý thanh toán: ", e);
            session.setAttribute("error", "Có lỗi xảy ra khi xử lý thanh toán!");
            return new RedirectView("/mobilestore/checkout");
        }
    }

    @GetMapping("/thank-you")
    public String showThankYouPage(HttpSession session, Model model) {
        log.info("Hiển thị trang thank-you");

        DonHang donHang = (DonHang) session.getAttribute("donhang");
        List<SanPham> cart = (List<SanPham>) session.getAttribute("cart");
        Map<Long, String> quanity = (Map<Long, String>) session.getAttribute("quanity");

        if (donHang == null) {
            log.warn("Không tìm thấy thông tin đơn hàng trong session");
        }

        model.addAttribute("donhang", donHang);
        model.addAttribute("cart", cart);
        model.addAttribute("quanity", quanity);

        session.removeAttribute("donhang");
        session.removeAttribute("cart");
        session.removeAttribute("quanity");
        log.info("Đã xóa thông tin đơn hàng khỏi session");

        return "client/thankYou";
    }
}
//public class PaymentController {
//    @Autowired
//    private ThanhToanService thanhToanService;
//
//    @Autowired
//    private DonHangService donHangService;
//
//    @Autowired
//    private ChiMucGioHangService chiMucGioHangService;
//
//    @Autowired
//    private GioHangService gioHangService;
//
//    @Autowired
//    private NguoiDungService nguoiDungService;
//
//    @Autowired
//    private ChiTietDonHangService chiTietDonHangService;
//
//    @Autowired
//    private VNPAYConfig vnPayConfig;
//
//    @PostMapping("/vn-pay")
//    public @ResponseBody ResponseObject<ThanhToanDTO> pay(HttpServletRequest request,
//                                                          @RequestParam("amount") long amount,
//                                                          @RequestParam("hoTenNguoiNhan") String hoTenNguoiNhan,
//                                                          @RequestParam("sdtNhanHang") String sdtNhanHang,
//                                                          @RequestParam("diaChiNhan") String diaChiNhan) {
//        try {
//            ThanhToanDTO response = thanhToanService.createVnPayPayment(request, amount, hoTenNguoiNhan, sdtNhanHang, diaChiNhan);
//            return new ResponseObject<>(HttpStatus.OK, "Success", response);
//        } catch (Exception e) {
//            return new ResponseObject<>(HttpStatus.BAD_REQUEST, e.getMessage(), null);
//        }
//    }
//
//    @GetMapping("/vn-pay-return")
//    public RedirectView handleVNPayReturn(HttpServletRequest request, HttpSession session) {
//        Map<String, String> vnpParams = new TreeMap<>();
//        for (String paramName : request.getParameterMap().keySet()) {
//            String paramValue = request.getParameter(paramName);
//            if (paramValue != null && !paramValue.isEmpty()) {
//                vnpParams.put(paramName, paramValue);
//            }
//        }
//
//        String vnp_SecureHash = vnpParams.remove("vnp_SecureHash");
//        String vnp_ResponseCode = vnpParams.get("vnp_ResponseCode");
//        String vnp_TxnRef = vnpParams.get("vnp_TxnRef");
//
//        StringBuilder hashData = new StringBuilder();
//        for (Map.Entry<String, String> entry : vnpParams.entrySet()) {
//            hashData.append(entry.getKey()).append("=").append(VNPayUtil.encodeURL(entry.getValue())).append("&");
//        }
//        hashData.setLength(hashData.length() - 1);
//        String checkHash = VNPayUtil.hmacSHA512(vnPayConfig.getSecretKey(), hashData.toString());
//
//        if (!checkHash.equals(vnp_SecureHash)) {
//            session.setAttribute("error", "Dữ liệu trả về từ VNPAY không hợp lệ!");
//            return new RedirectView("/mobilestore/checkout");
//        }
//
//        if ("00".equals(vnp_ResponseCode)) {
//            DonHang donHang = donHangService.findById(Long.parseLong(vnp_TxnRef));
//            if (donHang != null) {
//                donHang.setTrangThaiDonHang("Đang chờ giao");
//                donHangService.save(donHang);
//
//                NguoiDung currentUser = (NguoiDung) request.getSession().getAttribute("loggedInUser");
//                List<SanPham> listsp = new ArrayList<>();
//                Map<Long, String> quanity = new HashMap<>();
//
//                if (currentUser != null) {
//                    GioHang gioHang = gioHangService.getGioHangByNguoiDung(currentUser);
//                    if (gioHang != null) {
//                        List<ChiMucGioHang> cartItems = chiMucGioHangService.getChiMucGioHangByGioHang(gioHang);
//                        for (ChiMucGioHang item : cartItems) {
//                            listsp.add(item.getSanPham());
//                            quanity.put(item.getSanPham().getId(), Integer.toString(item.getSo_luong()));
//                        }
//                        chiMucGioHangService.deleteAllChiMucGiohang(cartItems);
//                    }
//                }
//
//                session.setAttribute("donhang", donHang);
//                session.setAttribute("cart", listsp);
//                session.setAttribute("quanity", quanity);
//
//                // Chuyển hướng đến /mobilestore/thank-you
//                return new RedirectView("/mobilestore/thank-you");
//            }
//        }
//
//        session.setAttribute("error", "Thanh toán thất bại: " + vnp_ResponseCode);
//        return new RedirectView("/mobilestore/checkout");
//    }
//
//    @GetMapping("/thank-you")
//    public String showThankYouPage(HttpSession session, Model model) {
//        DonHang donHang = (DonHang) session.getAttribute("donhang");
//        List<SanPham> cart = (List<SanPham>) session.getAttribute("cart");
//        Map<Long, String> quanity = (Map<Long, String>) session.getAttribute("quanity");
//
//        model.addAttribute("donhang", donHang);
//        model.addAttribute("cart", cart);
//        model.addAttribute("quanity", quanity);
//
//        session.removeAttribute("donhang");
//        session.removeAttribute("cart");
//        session.removeAttribute("quanity");
//
//        return "client/thankYou";
//    }
//}