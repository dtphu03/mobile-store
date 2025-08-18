package com.mobilestore.dto.response;

import lombok.Data;
import org.springframework.http.HttpStatus;

@Data
public class ResponseObject<T> {
    private HttpStatus status;
    private String message;
    private T data;

    public ResponseObject(HttpStatus status, String message, T data) {
        this.status = status;
        this.message = message;
        this.data = data;
    }
}