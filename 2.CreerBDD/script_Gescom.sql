drop database if exists monGescom;

create database monGescom default character set utf8;

use monGescom;

create table subcategories(
   subcat_id int not null AUTO_INCREMENT PRIMARY key,
   subcat_name VARCHAR(20) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE categories(
   cat_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
   cat_name VARCHAR(20) NOT NULL,
   subcat_id int,
   FOREIGN KEY(subcat_id) REFERENCES subcategories(subcat_id)
) ENGINE=InnoDB;

CREATE TABLE suppliers(
   sup_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
   sup_name VARCHAR(50) NOT NULL,
   sup_address VARCHAR(150) NOT NULL,
   sup_phone VARCHAR(10) NOT NULL,
   sup_mail VARCHAR(20) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE customers(
   cus_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
   cus_name VARCHAR(50) NOT NULL,
   cus_lastname VARCHAR(50) NOT NULL,
   cus_address VARCHAR(150) NOT NULL,
   cus_phone VARCHAR(10) NOT NULL,
   cus_mail VARCHAR(50) NOT NULL,
   cus_password VARCHAR(50) NOT NULL,
   cus_add_date DATETIME NOT NULL,
   cus_update_date DATETIME
) ENGINE=InnoDB;

CREATE TABLE posts(
   post_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
   post_name VARCHAR(50) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE shops(
   shop_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
   shop_name VARCHAR(50) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE departments(
   dep_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
   dep_name VARCHAR(50) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE products(
   pro_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
   pro_name VARCHAR(50) NOT NULL,
   pro_price DECIMAL(7,2) NOT NULL,
   pro_ref VARCHAR(50),
   pro_ean VARCHAR(20) NOT NULL,
   pro_stock_ph INT NOT NULL,
   pro_stock_alert INT NOT NULL,
   pro_color VARCHAR(20),
   pro_desc VARCHAR(150),
   pro_add_date DATETIME,
   pro_update_date DATETIME,
   pro_photo VARCHAR(30),
   pro_sale char(2) NOT NULL,
   cat_id INT,
   sup_id INT,
   FOREIGN KEY(cat_id) REFERENCES categories(cat_id),
   FOREIGN KEY(sup_id) REFERENCES suppliers(sup_id)
) ENGINE=InnoDB;

CREATE TABLE employees(
   emp_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
   emp_name VARCHAR(50) NOT NULL,
   emp_address VARCHAR(150) not null,
   emp_phone VARCHAR(10) NOT NULL,
   emp_lastname VARCHAR(50) NOT NULL,
   emp_number_child INT,
   emp_salary DECIMAL(8,2) NOT NULL,
   emp_gender VARCHAR(10) not null,
   emp_enter_date DATE not null,
   dep_id INT,
   shop_id INT,
   post_id INT,
   FOREIGN KEY(dep_id) REFERENCES departments(dep_id),
   FOREIGN KEY(shop_id) REFERENCES shops(shop_id),
   FOREIGN KEY(post_id) REFERENCES posts(post_id)
) ENGINE=InnoDB;

CREATE TABLE orders(
   ord_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
   ord_date DATETIME NOT NULL,
   ord_pay_date DATETIME NOT NULL,
   ord_ship_date DATETIME not null,
   emp_id INT,
   cus_id INT,
   FOREIGN KEY(emp_id) REFERENCES employees(emp_id),
   FOREIGN KEY(cus_id) REFERENCES customers(cus_id)
) ENGINE=InnoDB;

CREATE TABLE orders_details(
   pro_id INT,
   ord_id INT,
   unit_price DECIMAL(7,2) NOT NULL,
   discount DECIMAL(2,2),
   order_price DECIMAL(7,2) NOT NULL,
   quantity INT NOT NULL,
   PRIMARY KEY(pro_id, ord_id),
   FOREIGN KEY(pro_id) REFERENCES products(pro_id),
   FOREIGN KEY(ord_id) REFERENCES orders(ord_id)
) ENGINE=InnoDB;

CREATE INDEX orderDate
ON orders (ord_date);
