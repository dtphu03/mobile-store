-- Migration to support admin replies to product comments

-- Create product_comment_reply table
CREATE TABLE IF NOT EXISTS product_comment_reply (
  id          BIGINT PRIMARY KEY AUTO_INCREMENT,
  comment_id  BIGINT    NOT NULL,
  admin_id    BIGINT    NOT NULL,
  content     TEXT      NOT NULL,
  is_deleted  BOOLEAN   NOT NULL DEFAULT FALSE,
  created_at  DATETIME  NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at  DATETIME  NULL ON UPDATE CURRENT_TIMESTAMP,

  CONSTRAINT fk_pcr_comment FOREIGN KEY (comment_id) REFERENCES product_comment(id),
  CONSTRAINT fk_pcr_admin   FOREIGN KEY (admin_id)   REFERENCES nguoi_dung(id)
);

-- Indexes for efficient lookups
CREATE INDEX idx_pcr_comment_created ON product_comment_reply(comment_id, created_at);

