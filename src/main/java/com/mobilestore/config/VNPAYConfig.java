package com.mobilestore.config;

import lombok.Getter;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;

@Configuration
@Getter
public class VNPAYConfig {
    @Value("${payment.vnPay.url}")
    private String vnpPayUrl;

    @Value("${payment.vnPay.returnUrl}")
    private String vnpReturnUrl;

    @Value("${payment.vnPay.tmnCode}")
    private String vnpTmnCode;

    @Value("${payment.vnPay.secretKey}")
    private String secretKey;

    @Value("${payment.vnPay.version}")
    private String vnpVersion;

    @Value("${payment.vnPay.command}")
    private String vnpCommand;

    @Value("${payment.vnPay.orderType}")
    private String orderType;
}