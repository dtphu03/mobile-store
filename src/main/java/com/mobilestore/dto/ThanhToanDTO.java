package com.mobilestore.dto;

import lombok.Builder;
import lombok.Data;
import org.springframework.web.bind.annotation.ResponseStatus;

@Data
@Builder
public class ThanhToanDTO {

        private String code;
        private String message;
        private String paymentUrl;

    }