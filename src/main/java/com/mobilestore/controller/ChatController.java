package com.mobilestore.controller;

import com.mobilestore.entities.Message;
import com.mobilestore.entities.NguoiDung;
import com.mobilestore.entities.VaiTro;
import com.mobilestore.repository.MessageRepository;
import com.mobilestore.repository.NguoiDungRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.security.Principal;
import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Collectors;

@RestController
@Controller
public class ChatController {

    @Autowired
    private SimpMessagingTemplate messagingTemplate;

    @Autowired
    private MessageRepository messageRepository;

    @Autowired
    private NguoiDungRepository nguoiDungRepository;

    @GetMapping("/messages")
    public List<Message> getMessages() {
        return messageRepository.findAll();
    }

    @GetMapping("/messages/latest")
    @Transactional(readOnly = true)
    public List<Message> getLatestMessagesForAdmin(Principal principal) {
        if (principal == null) {
            System.out.println("getLatestMessagesForAdmin: Principal is null");
            return Collections.emptyList();
        }
        String adminEmail = principal.getName();
        System.out.println("getLatestMessagesForAdmin: Fetching for admin: " + adminEmail);
        List<Message> messages = messageRepository.findLatestMessagesForAdmin(adminEmail);
        System.out.println("getLatestMessagesForAdmin: Messages found: " + messages.size());
        messages.forEach(m -> System.out.println("Message: from=" + m.getFromUser() +
                ", to=" + m.getToUser() +
                ", content=" + m.getContent()));
        return messages;
    }

    @GetMapping("/messages/conversation")
    @Transactional(readOnly = true)
    public List<Message> getConversation(@RequestParam("userEmail") String userEmail,
                                         Principal principal) {
        if (principal == null) {
            System.out.println("getConversation: Principal is null");
            return Collections.emptyList();
        }
        String adminEmail = principal.getName();
        System.out.println("getConversation: Fetching for admin: " + adminEmail + ", user: " + userEmail);
        List<Message> messages = messageRepository.findConversationBetweenUserAndAdmin(userEmail, adminEmail);
        System.out.println("getConversation: Found " + messages.size() + " messages");
        return messages;
    }

    @GetMapping("/messages/user")
    @Transactional(readOnly = true)
    public List<Message> getUserMessages(Principal principal) {
        if (principal == null) {
            System.out.println("getUserMessages: Principal is null");
            return Collections.emptyList();
        }
        String userEmail = principal.getName();
        System.out.println("getUserMessages: Fetching messages for user: " + userEmail);
        
        // Lấy tất cả tin nhắn của user với admin
        List<Message> messages = messageRepository.findByFromUserOrToUserOrderByTimestampAsc(userEmail);
        System.out.println("getUserMessages: Found " + messages.size() + " messages");
        return messages;
    }

    @MessageMapping("/sendMessage")
    @Transactional
    public void sendMessage(@Payload Message message, Principal principal) {
        if (principal == null) {
            System.out.println("sendMessage: Principal is null");
            return;
        }
        System.out.println("sendMessage: principal=" + principal.getName());

        String senderEmail = principal.getName();
        message.setFromUser(senderEmail);
        message.setTimestamp(LocalDateTime.now());
        messageRepository.save(message);
        System.out.println("sendMessage: Saved message from " + senderEmail + " to " + message.getToUser());

        NguoiDung sender = nguoiDungRepository.findByEmailFetchVaiTro(senderEmail);
        if (sender == null) {
            System.err.println("sendMessage: Sender not found in DB");
            return;
        }

        boolean isAdmin = sender.getVaiTro().stream()
                .anyMatch(role -> "ROLE_ADMIN".equals(role.getTenVaiTro()));

        if (!isAdmin) {
            // Member gửi → gửi tới tất cả admin qua queue riêng
            List<NguoiDung> admins = nguoiDungRepository.findAll().stream()
                    .filter(user -> user.getVaiTro().stream()
                            .anyMatch(role -> "ROLE_ADMIN".equals(role.getTenVaiTro())))
                    .collect(Collectors.toList());

            admins.forEach(admin -> {
                System.out.println("sendMessage: Sending to admin " + admin.getEmail());
                messagingTemplate.convertAndSendToUser(
                        admin.getEmail(), "/queue/messages", message);
            });
        } else {
            // Admin gửi
            if (message.getToUser() == null || message.getToUser().isEmpty()) {
                System.out.println("sendMessage: Admin message requires a recipient");
            } else {
                System.out.println("sendMessage: Admin sending to " + message.getToUser());
                messagingTemplate.convertAndSendToUser(
                        message.getToUser(), "/queue/messages", message);
            }
        }
    }

    @MessageMapping("/register")
    @Transactional(readOnly = true)
    public void register(@Payload Message message, Principal principal) {
        if (principal == null) {
            System.err.println("register: Principal is null, skipping registration.");
            return;
        }
        System.out.println("register: principal=" + principal.getName());

        String email = principal.getName();
        NguoiDung currentUser = nguoiDungRepository.findByEmailFetchVaiTro(email);
        if (currentUser == null) {
            System.err.println("register: User not found in DB");
            return;
        }

        boolean isAdmin = currentUser.getVaiTro().stream()
                .anyMatch(role -> "ROLE_ADMIN".equals(role.getTenVaiTro()));

        if (isAdmin) {
            List<NguoiDung> allUsers = nguoiDungRepository.findAll();
            List<String> userList = allUsers.stream()
                    .filter(user -> user != null && user.getEmail() != null && user.getVaiTro() != null)
                    .map(user -> user.getEmail() + " (" + user.getVaiTro().stream()
                            .map(VaiTro::getTenVaiTro).findFirst().orElse("UNKNOWN") + ")")
                    .collect(Collectors.toList());

            Map<String, Object> payload = new HashMap<>();
            payload.put("users", userList);
            System.out.println("register: Sending user list to /topic/userList");
            messagingTemplate.convertAndSend("/topic/userList", payload);
        }
    }
}