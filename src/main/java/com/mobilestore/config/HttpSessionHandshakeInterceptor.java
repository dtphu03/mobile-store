//package com.mobilestore.config;
//
//import org.springframework.http.server.ServerHttpRequest;
//import org.springframework.http.server.ServletServerHttpRequest;
//import org.springframework.http.server.ServerHttpResponse;
//import org.springframework.web.socket.WebSocketHandler;
//import org.springframework.web.socket.server.HandshakeInterceptor;
//
//import javax.servlet.http.HttpSession;
//import java.util.Map;
//
//public class HttpSessionHandshakeInterceptor implements HandshakeInterceptor {
//
//    @Override
//    public boolean beforeHandshake(ServerHttpRequest request, ServerHttpResponse response, WebSocketHandler wsHandler, Map<String, Object> attributes) {
//        if (request instanceof ServletServerHttpRequest) {
//            ServletServerHttpRequest servletRequest = (ServletServerHttpRequest) request;
//            HttpSession session = servletRequest.getServletRequest().getSession(false); // Lấy session nếu có
//            if (session != null) {
//                attributes.put("HTTP.SESSION", session);
//                // Lưu SecurityContext vào session (nếu có)
//                Object securityContext = session.getAttribute("SPRING_SECURITY_CONTEXT");
//                if (securityContext != null) {
//                    System.out.println("Handshake: SecurityContext found in session, ID=" + session.getId());
//                } else {
//                    System.out.println("Handshake: No SecurityContext in session, ID=" + session.getId());
//                }
//            } else {
//                System.out.println("Handshake: No session found in request");
//            }
//        } else {
//            System.out.println("Handshake: Request is not a ServletServerHttpRequest");
//        }
//        return true;
//    }
//
//    @Override
//    public void afterHandshake(ServerHttpRequest request, ServerHttpResponse response, WebSocketHandler wsHandler, Exception exception) {
//        // Không cần xử lý
//    }
//}

package com.mobilestore.config;

import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServletServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.HandshakeInterceptor;

import javax.servlet.http.HttpSession;
import java.util.Map;

public class HttpSessionHandshakeInterceptor implements HandshakeInterceptor {

    @Override
    public boolean beforeHandshake(ServerHttpRequest request, ServerHttpResponse response,
                                   WebSocketHandler wsHandler, Map<String, Object> attributes) {
        if (request instanceof ServletServerHttpRequest) {
            ServletServerHttpRequest servletRequest = (ServletServerHttpRequest) request;
            HttpSession session = servletRequest.getServletRequest().getSession(false);
            if (session != null) {
                attributes.put("HTTP.SESSION", session);
                Object securityContext = session.getAttribute("SPRING_SECURITY_CONTEXT");
                if (securityContext != null) {
                    System.out.println("Handshake: SecurityContext found in session, ID=" + session.getId());
                } else {
                    System.out.println("Handshake: No SecurityContext in session, ID=" + session.getId());
                }
            } else {
                System.out.println("Handshake: No session found in request");
            }
        }
        return true;
    }

    @Override
    public void afterHandshake(ServerHttpRequest request, ServerHttpResponse response,
                               WebSocketHandler wsHandler, Exception exception) {
        // không cần xử lý
    }
}
