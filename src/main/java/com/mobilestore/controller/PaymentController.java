package com.mobilestore.controller;

import com.mobilestore.config.VNPAYConfig;
import com.mobilestore.dto.ThanhToanDTO;
import com.mobilestore.dto.response.ResponseObject;
import com.mobilestore.entities.*;
import com.mobilestore.service.*;
import com.mobilestore.ulti.VNPayUtil;
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
        try {
            ThanhToanDTO response = thanhToanService.createVnPayPayment(request, amount, hoTenNguoiNhan, sdtNhanHang, diaChiNhan);
            return new ResponseObject<>(HttpStatus.OK, "Success", response);
        } catch (Exception e) {
            return new ResponseObject<>(HttpStatus.BAD_REQUEST, e.getMessage(), null);
        }
    }

    @GetMapping("/vn-pay-return")
    public RedirectView handleVNPayReturn(HttpServletRequest request, HttpSession session) {
        Map<String, String> vnpParams = new TreeMap<>();
        for (String paramName : request.getParameterMap().keySet()) {
            String paramValue = request.getParameter(paramName);
            if (paramValue != null && !paramValue.isEmpty()) {
                vnpParams.put(paramName, paramValue);
            }
        }

        String vnp_SecureHash = vnpParams.remove("vnp_SecureHash");
        String vnp_ResponseCode = vnpParams.get("vnp_ResponseCode");
        String vnp_TxnRef = vnpParams.get("vnp_TxnRef");

        StringBuilder hashData = new StringBuilder();
        for (Map.Entry<String, String> entry : vnpParams.entrySet()) {
            hashData.append(entry.getKey()).append("=").append(VNPayUtil.encodeURL(entry.getValue())).append("&");
        }
        hashData.setLength(hashData.length() - 1);
        String checkHash = VNPayUtil.hmacSHA512(vnPayConfig.getSecretKey(), hashData.toString());

        if (!checkHash.equals(vnp_SecureHash)) {
            session.setAttribute("error", "Dữ liệu trả về từ VNPAY không hợp lệ!");
            return new RedirectView("/mobilestore/checkout");
        }

        if ("00".equals(vnp_ResponseCode)) {
            DonHang donHang = donHangService.findById(Long.parseLong(vnp_TxnRef));
            if (donHang != null) {
                donHang.setTrangThaiDonHang("Đang chờ giao");
                donHangService.save(donHang);

                NguoiDung currentUser = (NguoiDung) request.getSession().getAttribute("loggedInUser");
                List<SanPham> listsp = new ArrayList<>();
                Map<Long, String> quanity = new HashMap<>();

                if (currentUser != null) {
                    GioHang gioHang = gioHangService.getGioHangByNguoiDung(currentUser);
                    if (gioHang != null) {
                        List<ChiMucGioHang> cartItems = chiMucGioHangService.getChiMucGioHangByGioHang(gioHang);
                        for (ChiMucGioHang item : cartItems) {
                            listsp.add(item.getSanPham());
                            quanity.put(item.getSanPham().getId(), Integer.toString(item.getSo_luong()));
                        }
                        chiMucGioHangService.deleteAllChiMucGiohang(cartItems);
                    }
                }

                session.setAttribute("donhang", donHang);
                session.setAttribute("cart", listsp);
                session.setAttribute("quanity", quanity);

                // Chuyển hướng đến /mobilestore/thank-you
                return new RedirectView("/mobilestore/thank-you");
            }
        }

        session.setAttribute("error", "Thanh toán thất bại: " + vnp_ResponseCode);
        return new RedirectView("/mobilestore/checkout");
    }

    @GetMapping("/thank-you")
    public String showThankYouPage(HttpSession session, Model model) {
        DonHang donHang = (DonHang) session.getAttribute("donhang");
        List<SanPham> cart = (List<SanPham>) session.getAttribute("cart");
        Map<Long, String> quanity = (Map<Long, String>) session.getAttribute("quanity");

        model.addAttribute("donhang", donHang);
        model.addAttribute("cart", cart);
        model.addAttribute("quanity", quanity);

        session.removeAttribute("donhang");
        session.removeAttribute("cart");
        session.removeAttribute("quanity");

        return "client/thankYou";
    }
}