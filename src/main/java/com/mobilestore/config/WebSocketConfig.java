//package com.mobilestore.config;
//
//import org.springframework.context.annotation.Configuration;
//import org.springframework.messaging.Message;
//import org.springframework.messaging.MessageChannel;
//import org.springframework.messaging.simp.config.ChannelRegistration;
//import org.springframework.messaging.simp.config.MessageBrokerRegistry;
//import org.springframework.messaging.simp.stomp.StompCommand;
//import org.springframework.messaging.simp.stomp.StompHeaderAccessor;
//import org.springframework.messaging.support.ChannelInterceptor;
//import org.springframework.security.core.Authentication;
//import org.springframework.security.core.context.SecurityContext;
//import org.springframework.security.core.context.SecurityContextHolder;
//import org.springframework.security.messaging.context.SecurityContextChannelInterceptor;
//import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
//import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
//import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;
//
//import javax.servlet.http.HttpSession;
//
//@Configuration
//@EnableWebSocketMessageBroker
//public class WebSocketConfig implements WebSocketMessageBrokerConfigurer {
//    @Override
//    public void configureMessageBroker(MessageBrokerRegistry config) {
//        config.enableSimpleBroker("/topic", "/user");
//        config.setApplicationDestinationPrefixes("/app");
//        config.setUserDestinationPrefix("/user");
//    }
//
//    @Override
//    public void registerStompEndpoints(StompEndpointRegistry registry) {
//        registry.addEndpoint("/chat").setAllowedOrigins("*").addInterceptors(new HttpSessionHandshakeInterceptor()).withSockJS();
//
//    }
//
//    @Override
//    public void configureClientInboundChannel(ChannelRegistration registration) {
//        registration.setInterceptors(new ChannelInterceptor() {
//            @Override
//            public Message<?> preSend(Message<?> message, MessageChannel channel) {
//                StompHeaderAccessor accessor = StompHeaderAccessor.wrap(message);
//                if (StompCommand.CONNECT.equals(accessor.getCommand()) || StompCommand.SUBSCRIBE.equals(accessor.getCommand()) || StompCommand.SEND.equals(accessor.getCommand())) {
//                    HttpSession session = (HttpSession) accessor.getSessionAttributes().get("HTTP.SESSION");
//                    if (session != null) {
//                        System.out.println("ChannelInterceptor: Session found, ID=" + session.getId());
//                        Object securityContextObj = session.getAttribute("SPRING_SECURITY_CONTEXT");
//                        if (securityContextObj instanceof SecurityContext) {
//                            SecurityContext securityContext = (SecurityContext) securityContextObj;
//                            Authentication authentication = securityContext.getAuthentication();
//                            if (authentication != null) {
//                                SecurityContextHolder.getContext().setAuthentication(authentication);
//                                System.out.println("ChannelInterceptor: Authentication set, principal=" + authentication.getName());
//                            } else {
//                                System.out.println("ChannelInterceptor: No Authentication in SecurityContext");
//                            }
//                        } else {
//                            System.out.println("ChannelInterceptor: No SecurityContext in session");
//                        }
//                    } else {
//                        System.out.println("ChannelInterceptor: No session found");
//                    }
//                }
//                return message;
//            }
//        });
//    }
//}
//
package com.mobilestore.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.messaging.simp.config.ChannelRegistration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;
import org.springframework.web.socket.server.support.DefaultHandshakeHandler;

import java.security.Principal;
import java.util.Map;

@Configuration
@EnableWebSocketMessageBroker
public class WebSocketConfig implements WebSocketMessageBrokerConfigurer {

    @Override
    public void configureMessageBroker(MessageBrokerRegistry config) {
        config.enableSimpleBroker("/topic", "/user");
        config.setApplicationDestinationPrefixes("/app");
        config.setUserDestinationPrefix("/user");
    }

    @Override
    public void registerStompEndpoints(StompEndpointRegistry registry) {
        registry.addEndpoint("/chat")
                .setHandshakeHandler(new DefaultHandshakeHandler() {
                    @Override
                    protected Principal determineUser(ServerHttpRequest request,
                                                      WebSocketHandler wsHandler,
                                                      Map<String, Object> attributes) {
                        Principal principal = request.getPrincipal();
                        return principal != null ? principal : super.determineUser(request, wsHandler, attributes);
                    }
                })
                .addInterceptors(new HttpSessionHandshakeInterceptor())
                .setAllowedOrigins("*")   // 👈 dùng cái này nếu Spring < 5.3
                .withSockJS();
    }
}


