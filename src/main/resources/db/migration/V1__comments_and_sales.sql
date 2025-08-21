-- Migration to add comments/ratings and sales tracking features
-- Add rating and sales fields to product table
ALTER TABLE san_pham
  ADD COLUMN rating_count INT NOT NULL DEFAULT 0,
  ADD COLUMN rating_sum   INT NOT NULL DEFAULT 0,
  ADD COLUMN sales_count  BIGINT NOT NULL DEFAULT 0;

-- Create product_comment table for comments and ratings
CREATE TABLE product_comment (
  id            BIGINT PRIMARY KEY AUTO_INCREMENT,
  product_id    BIGINT       NOT NULL,
  user_id       BIGINT       NOT NULL,
  rating        TINYINT      NOT NULL CHECK (rating BETWEEN 1 AND 5),
  content       TEXT         NOT NULL,
  is_deleted    BOOLEAN      NOT NULL DEFAULT FALSE,
  created_at    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at    DATETIME     NULL ON UPDATE CURRENT_TIMESTAMP,

  CONSTRAINT fk_pc_product  FOREIGN KEY (product_id) REFERENCES san_pham(id),
  CONSTRAINT fk_pc_user     FOREIGN KEY (user_id)    REFERENCES nguoi_dung(id)
);

-- Create indexes for product_comment
CREATE INDEX idx_pc_product_created ON product_comment(product_id, created_at DESC);
CREATE INDEX idx_pc_user_created    ON product_comment(user_id, created_at DESC);

-- Create product_sales_ledger table for idempotent sales tracking
CREATE TABLE product_sales_ledger (
  id          BIGINT PRIMARY KEY AUTO_INCREMENT,
  order_id    BIGINT    NOT NULL,
  product_id  BIGINT    NOT NULL,
  quantity    INT       NOT NULL,
  created_at  DATETIME  NOT NULL DEFAULT CURRENT_TIMESTAMP,

  CONSTRAINT uq_sales_once UNIQUE (order_id, product_id),
  CONSTRAINT fk_psl_product FOREIGN KEY (product_id) REFERENCES san_pham(id),
  CONSTRAINT fk_psl_order FOREIGN KEY (order_id) REFERENCES don_hang(id)
);

-- Create index for sales_count sorting
CREATE INDEX idx_product_sales_count ON san_pham(sales_count DESC);

