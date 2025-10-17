package com.mobilestore.config;

import org.springframework.messaging.Message;
import org.springframework.messaging.MessageChannel;
import org.springframework.messaging.simp.stomp.StompCommand;
import org.springframework.messaging.simp.stomp.StompHeaderAccessor;
import org.springframework.messaging.support.ChannelInterceptor;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;

import javax.servlet.http.HttpSession;

public class WebSocketSecurityInterceptor implements ChannelInterceptor {

//    @Override
//    public Message<?> preSend(Message<?> message, MessageChannel channel) {
//        StompHeaderAccessor accessor = StompHeaderAccessor.wrap(message);
//        if (StompCommand.CONNECT.equals(accessor.getCommand())) {
//            // Lấy session từ handshake
//            HttpSession session = (HttpSession) accessor.getSessionAttributes().get("HTTP.SESSION");
//            if (session != null) {
//                System.out.println("WebSocketSecurityInterceptor: Session found, ID=" + session.getId());
//                // Lấy SecurityContext từ session
//                Object securityContextObj = session.getAttribute("SPRING_SECURITY_CONTEXT");
//                if (securityContextObj instanceof SecurityContext) {
//                    SecurityContext securityContext = (SecurityContext) securityContextObj;
//                    Authentication authentication = securityContext.getAuthentication();
//                    if (authentication != null) {
//                        SecurityContextHolder.getContext().setAuthentication(authentication);
//                        System.out.println("WebSocketSecurityInterceptor: Authentication set, principal=" + authentication.getName());
//                    } else {
//                        System.out.println("WebSocketSecurityInterceptor: No Authentication in SecurityContext");
//                    }
//                } else {
//                    System.out.println("WebSocketSecurityInterceptor: No SecurityContext in session");
//                }
//            } else {
//                System.out.println("WebSocketSecurityInterceptor: No session found");
//            }
//        }
//        return message;
//    }
}