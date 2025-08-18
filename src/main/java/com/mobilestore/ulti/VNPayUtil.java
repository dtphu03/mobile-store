package com.mobilestore.ulti;

import com.mobilestore.config.VNPAYConfig;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Map;
import java.util.TimeZone;
import java.util.TreeMap;

public class VNPayUtil {
    public static String hmacSHA512(String key, String data) {
        try {
            Mac mac = Mac.getInstance("HmacSHA512");
            SecretKeySpec secretKeySpec = new SecretKeySpec(key.getBytes(StandardCharsets.UTF_8), "HmacSHA512");
            mac.init(secretKeySpec);
            byte[] hash = mac.doFinal(data.getBytes(StandardCharsets.UTF_8));
            StringBuilder hexString = new StringBuilder();
            for (byte b : hash) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) hexString.append('0');
                hexString.append(hex);
            }
            return hexString.toString();
        } catch (Exception e) {
            throw new RuntimeException("Error generating HMAC SHA512", e);
        }
    }

    public static String encodeURL(String input) {
        try {
            return URLEncoder.encode(input, StandardCharsets.UTF_8.toString());
        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException("Error encoding URL", e);
        }
    }

    public static String getIpAddress(HttpServletRequest request) {
        String ipAddress = request.getHeader("X-FORWARDED-FOR");
        if (ipAddress == null || ipAddress.isEmpty()) {
            ipAddress = request.getRemoteAddr();
        }
        return ipAddress;
    }

    public static String generatePaymentUrl(Map<String, String> params, String vnpPayUrl, String secretKey) {
        TreeMap<String, String> sortedParams = new TreeMap<>(params);
        StringBuilder hashData = new StringBuilder();
        StringBuilder queryUrl = new StringBuilder();

        for (Map.Entry<String, String> entry : sortedParams.entrySet()) {
            String key = entry.getKey();
            String value = entry.getValue();
            if (value != null && !value.isEmpty()) {
                hashData.append(key).append("=").append(encodeURL(value)).append("&");
                queryUrl.append(key).append("=").append(encodeURL(value)).append("&");
            }
        }
        hashData.setLength(hashData.length() - 1); // Xóa "&" cuối
        queryUrl.setLength(queryUrl.length() - 1);

        String vnpSecureHash = hmacSHA512(secretKey, hashData.toString());
        queryUrl.append("&vnp_SecureHash=").append(vnpSecureHash);

        return vnpPayUrl + "?" + queryUrl.toString();
    }

    public static Map<String, String> createVNPayParams(String txnRef, String orderInfo, long amount, String ipAddr,
                                                        String returnUrl, VNPAYConfig config) {
        Map<String, String> vnpParams = new TreeMap<>();
        vnpParams.put("vnp_Version", config.getVnpVersion());
        vnpParams.put("vnp_Command", config.getVnpCommand());
        vnpParams.put("vnp_TmnCode", config.getVnpTmnCode());
        vnpParams.put("vnp_Amount", String.valueOf(amount * 100L));
        vnpParams.put("vnp_CurrCode", "VND");
        vnpParams.put("vnp_TxnRef", txnRef);
        vnpParams.put("vnp_OrderInfo", orderInfo);
        vnpParams.put("vnp_OrderType", config.getOrderType());
        vnpParams.put("vnp_Locale", "vn");
        vnpParams.put("vnp_ReturnUrl", returnUrl);
        vnpParams.put("vnp_IpAddr", ipAddr);

        Calendar calendar = Calendar.getInstance(TimeZone.getTimeZone("Etc/GMT+7"));
        SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
        String vnpCreateDate = formatter.format(calendar.getTime());
        vnpParams.put("vnp_CreateDate", vnpCreateDate);

        calendar.add(Calendar.MINUTE, 15);
        String vnpExpireDate = formatter.format(calendar.getTime());
        vnpParams.put("vnp_ExpireDate", vnpExpireDate);

        return vnpParams;
    }
}