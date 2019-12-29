DROP TABLE CART_CONTAINS;
DROP TABLE CART;
DROP TABLE CUSTOMER_BILLED_TO;
DROP TABLE ORDER_CONTAINS;
DROP TABLE ORDERS;
DROP TABLE CUSTOMER_HAS_CARD;
DROP TABLE CUSTOMER_LIVES;
DROP TABLE CUSTOMER;
DROP TABLE LOG_IN_DETAILS;
DROP TABLE SUPPLIER_SELLS;
DROP TABLE SUPPLIER;
DROP TABLE STOCK_IN_WAREHOUSE;
DROP TABLE WAREHOUSE;
DROP TABLE PRODUCT_PRICE;
DROP TABLE PRODUCT;
DROP TABLE CREDIT_CARD;
DROP TABLE STAFF;
DROP TABLE ADDRESS;

CREATE TABLE ADDRESS
(
  ADDR_ID INT NOT NULL,
  STREET VARCHAR(400) NOT NULL,
  STREET_NAME VARCHAR(400) NOT NULL,
  APT_NUM VARCHAR(40) NOT NULL,
  CITY VARCHAR(200) NOT NULL,
  STATE_NAME VARCHAR(100) NOT NULL,
  ZIPCODE INT NOT NULL,
  PRIMARY KEY (ADDR_ID)
);

CREATE TABLE STAFF
(
  STAFF_ID INT NOT NULL,
  STAFF_NAME VARCHAR(400) NOT NULL,
  SALARY NUMERIC(18,3) NOT NULL,
  JOB_TITLE VARCHAR(400) NOT NULL,
  ADDR_ID INT NOT NULL,
  STAFF_PASSWORD CLOB NOT NULL,
  PRIMARY KEY (STAFF_ID),
  FOREIGN KEY (ADDR_ID) REFERENCES ADDRESS(ADDR_ID)
);

CREATE TABLE CREDIT_CARD
(
  CARD_ID INT NOT NULL,
  EXP_MONTH INT NOT NULL,
  OWNER_NAME VARCHAR(400) NOT NULL,
  CVV INT NOT NULL,
  EXP_YEAR INT NOT NULL,
  CARD_NUM VARCHAR(19) NOT NULL,
  PRIMARY KEY (CARD_ID)
);

CREATE TABLE PRODUCT
(
  PRODUCT_ID INT NOT NULL,
  PRODUCT_NAME VARCHAR(400) NOT NULL,
  PRODUCT_CATEGORY VARCHAR(100) NOT NULL,
  PRODUCT_SIZE INT NOT NULL,
  ADDITIONAL_INFO VARCHAR(4000) NOT NULL,
  IMAGE_LOCATION VARCHAR(1000) NOT NULL,
  PRIMARY KEY (PRODUCT_ID)
);

CREATE TABLE PRODUCT_PRICE
(
  STATE_NAME VARCHAR(200) NOT NULL,
  PRICE NUMERIC(18,3) NOT NULL,
  PRICE_UNIT VARCHAR(40) NOT NULL,
  PRODUCT_ID INT NOT NULL,
  PRIMARY KEY (STATE_NAME, PRODUCT_ID),
  FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCT(PRODUCT_ID)
);

CREATE TABLE WAREHOUSE
(
  WAREHOUSE_ID INT NOT NULL,
  STORAGE_CAPACITY INT NOT NULL,
  ADDR_ID INT NOT NULL,
  PRIMARY KEY (WAREHOUSE_ID),
  FOREIGN KEY (ADDR_ID) REFERENCES ADDRESS(ADDR_ID)
);

CREATE TABLE STOCK_IN_WAREHOUSE
(
  NUMBER_OF_ITEMS INT NOT NULL,
  WAREHOUSE_ID INT NOT NULL,
  PRODUCT_ID INT NOT NULL,
  PRIMARY KEY (WAREHOUSE_ID, PRODUCT_ID),
  FOREIGN KEY (WAREHOUSE_ID) REFERENCES WAREHOUSE(WAREHOUSE_ID),
  FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCT(PRODUCT_ID)
);

CREATE TABLE SUPPLIER
(
  SUPPLIER_ID INT NOT NULL,
  SUPPLIER_NAME VARCHAR(400) NOT NULL,
  ADDR_ID INT NOT NULL,
  PRIMARY KEY (SUPPLIER_ID),
  FOREIGN KEY (ADDR_ID) REFERENCES ADDRESS(ADDR_ID)
);

CREATE TABLE SUPPLIER_SELLS
(
  PRICE NUMERIC(18,3) NOT NULL,
  PRODUCT_ID INT NOT NULL,
  SUPPLIER_ID INT NOT NULL,
  PRIMARY KEY (PRODUCT_ID, SUPPLIER_ID),
  FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCT(PRODUCT_ID),
  FOREIGN KEY (SUPPLIER_ID) REFERENCES SUPPLIER(SUPPLIER_ID)
);

CREATE TABLE LOG_IN_DETAILS
(
  EMAIL VARCHAR(400) NOT NULL,
  LOG_IN_PASSWORD CLOB NOT NULL,
  PRIMARY KEY (EMAIL)
);

CREATE TABLE CUSTOMER
(
  CUSTOMER_ID INT NOT NULL,
  CUSTOMER_NAME VARCHAR(400) NOT NULL,
  BALANCE NUMERIC(18,3) NOT NULL,
  EMAIL VARCHAR(400) NOT NULL,
  PRIMARY KEY (CUSTOMER_ID),
  FOREIGN KEY (EMAIL) REFERENCES LOG_IN_DETAILS(EMAIL)
);

CREATE TABLE CUSTOMER_LIVES
(
  IS_DEFAULT CHAR(1) NOT NULL,
  CUSTOMER_ID INT NOT NULL,
  ADDR_ID INT NOT NULL,
  PRIMARY KEY (CUSTOMER_ID, ADDR_ID),
  FOREIGN KEY (CUSTOMER_ID) REFERENCES CUSTOMER(CUSTOMER_ID),
  FOREIGN KEY (ADDR_ID) REFERENCES ADDRESS(ADDR_ID)
);

CREATE TABLE CUSTOMER_HAS_CARD
(
  CUSTOMER_ID INT NOT NULL,
  CARD_ID INT NOT NULL,
  PRIMARY KEY (CUSTOMER_ID, CARD_ID),
  FOREIGN KEY (CUSTOMER_ID) REFERENCES CUSTOMER(CUSTOMER_ID),
  FOREIGN KEY (CARD_ID) REFERENCES CREDIT_CARD(CARD_ID)
);

CREATE TABLE ORDERS
(
  ORDER_ID INT NOT NULL,
  STATUS INT NOT NULL,
  ISSUED_DATE CHAR(10) NOT NULL,
  CARD_ID INT NOT NULL,
  CUSTOMER_ID INT NOT NULL,
  PRIMARY KEY (ORDER_ID),
  FOREIGN KEY (CARD_ID) REFERENCES CREDIT_CARD(CARD_ID),
  FOREIGN KEY (CUSTOMER_ID) REFERENCES CUSTOMER(CUSTOMER_ID)
);

CREATE TABLE ORDER_CONTAINS
(
  QUANTITY INT NOT NULL,
  ORDER_ID INT NOT NULL,
  PRODUCT_ID INT NOT NULL,
  BILL_ADDR_ID VARCHAR(50) NOT NULL,
  PRIMARY KEY (ORDER_ID, PRODUCT_ID),
  FOREIGN KEY (ORDER_ID) REFERENCES ORDERS(ORDER_ID),
  FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCT(PRODUCT_ID)
);

CREATE TABLE CUSTOMER_BILLED_TO
(
  IS_DEFAULT CHAR(1) NOT NULL,
  CUSTOMER_ID INT NOT NULL,
  ADDR_ID INT NOT NULL,
  PRIMARY KEY (CUSTOMER_ID, ADDR_ID),
  FOREIGN KEY (CUSTOMER_ID) REFERENCES CUSTOMER(CUSTOMER_ID),
  FOREIGN KEY (ADDR_ID) REFERENCES ADDRESS(ADDR_ID)
);

CREATE TABLE CART
(
  CART_ID INT NOT NULL,
  CUSTOMER_ID INT NOT NULL,
  PRIMARY KEY (CART_ID),
  FOREIGN KEY (CUSTOMER_ID) REFERENCES CUSTOMER(CUSTOMER_ID)
);

CREATE TABLE CART_CONTAINS
(
  QUANTITY INT NOT NULL,
  CART_ID INT NOT NULL,
  PRODUCT_ID INT NOT NULL,
  PRIMARY KEY (CART_ID, PRODUCT_ID),
  FOREIGN KEY (CART_ID) REFERENCES CART(CART_ID),
  FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCT(PRODUCT_ID)
);

CREATE SEQUENCE ADDR_SEQ;
CREATE SEQUENCE CARD_SEQ;
CREATE SQUENECE CART_SEQ;
CREATE SEQUENCE CUST_SEQ;
CREATE SEQUENCE ORDERS_SEQ;
CREATE SEQUENCE PRODUCT_SEQ;
CREATE SEQUENCE STAFF_SEQ MAXVALUE 9999 CYCLE;
CREATE SEQUENCE WHOUSE_SEQ;
