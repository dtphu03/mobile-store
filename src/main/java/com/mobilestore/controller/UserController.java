package com.mobilestore.controller;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

@RestController
public class UserController {

    @GetMapping("/api/current-user")
    public Map<String, String> getCurrentUser(Authentication authentication) {
        Map<String, String> user = new HashMap<>();
        if (authentication != null && authentication.isAuthenticated()) {
            user.put("username", authentication.getName()); // Lấy email
            // Lấy role đầu tiên từ danh sách authorities
            String role = authentication.getAuthorities().stream()
                    .map(GrantedAuthority::getAuthority)
                    .findFirst()
                    .orElse("ROLE_USER"); // Mặc định ROLE_USER nếu không tìm thấy
            user.put("role", role);
        } else {
            user.put("username", "anonymous");
            user.put("role", "ROLE_ANONYMOUS");
        }
        return user;
    }
}