package com.mobilestore.repository;

import com.mobilestore.entities.Message;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface MessageRepository extends JpaRepository<Message, Long> {

    @Query("SELECT DISTINCT m FROM Message m " +
            "WHERE m.id IN (" +
            "    SELECT MAX(m2.id) FROM Message m2 " +
            "    WHERE m2.fromUser != :adminEmail " +  // Chỉ lấy tin nhắn từ member
            "    GROUP BY m2.fromUser" +
            ") " +
            "ORDER BY m.timestamp DESC")
    List<Message> findLatestMessagesForAdmin(@Param("adminEmail") String adminEmail);
    @Query("SELECT m FROM Message m " +
            "WHERE (m.fromUser = :userEmail AND (m.toUser = '' OR m.toUser = :adminEmail)) " +
            "   OR (m.fromUser = :adminEmail AND m.toUser = :userEmail) " +
            "ORDER BY m.timestamp ASC")
    List<Message> findConversationBetweenUserAndAdmin(
            @Param("userEmail") String userEmail,
            @Param("adminEmail") String adminEmail
    );

    @Query("SELECT m FROM Message m " +
            "WHERE m.fromUser = :userEmail OR m.toUser = :userEmail " +
            "ORDER BY m.timestamp ASC")
    List<Message> findByFromUserOrToUserOrderByTimestampAsc(@Param("userEmail") String userEmail);
}