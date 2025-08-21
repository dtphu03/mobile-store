package com.mobilestore.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.mobilestore.entities.ProductComment;
import com.mobilestore.entities.ProductCommentReply;

public interface ProductCommentReplyRepository extends JpaRepository<ProductCommentReply, Long> {

	List<ProductCommentReply> findByProductCommentAndIsDeletedFalseOrderByCreatedAtAsc(ProductComment productComment);
}


