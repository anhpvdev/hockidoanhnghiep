-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th4 25, 2024 lúc 11:56 AM
-- Phiên bản máy phục vụ: 10.4.27-MariaDB
-- Phiên bản PHP: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `shopee`
--
CREATE DATABASE IF NOT EXISTS `shopee` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `shopee`;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `admins`
--

DROP TABLE IF EXISTS `admins`;
CREATE TABLE IF NOT EXISTS `admins` (
  `Admin_id` int(11) NOT NULL,
  `Admin_name` varchar(255) DEFAULT NULL,
  `Password` varchar(255) DEFAULT NULL,
  `Role` int(11) DEFAULT NULL,
  PRIMARY KEY (`Admin_id`),
  KEY `Role` (`Role`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `admins`
--

INSERT INTO `admins` (`Admin_id`, `Admin_name`, `Password`, `Role`) VALUES
(1, 'Admin1', 'adminpassword', 1),
(2, 'Admin2', 'moderatorpassword', 2);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `admins_roles`
--

DROP TABLE IF EXISTS `admins_roles`;
CREATE TABLE IF NOT EXISTS `admins_roles` (
  `Role_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `admins_roles`
--

INSERT INTO `admins_roles` (`Role_id`, `name`) VALUES
(1, 'Admin'),
(2, 'Moderator');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `buyers`
--

DROP TABLE IF EXISTS `buyers`;
CREATE TABLE IF NOT EXISTS `buyers` (
  `Buyer_id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) DEFAULT NULL,
  `Gender` int(11) DEFAULT NULL,
  `Birth` datetime DEFAULT NULL,
  `Phone` varchar(255) DEFAULT NULL,
  `Email` varchar(255) DEFAULT NULL,
  `Avatar` varchar(255) DEFAULT NULL,
  `Password` varchar(255) DEFAULT NULL,
  `Address` varchar(255) DEFAULT NULL,
  `Ward` int(11) DEFAULT NULL,
  `Atm` varchar(255) DEFAULT NULL,
  `Atm_name` varchar(255) DEFAULT NULL,
  `Created_at` datetime DEFAULT current_timestamp(),
  `role` int(11) DEFAULT NULL,
  PRIMARY KEY (`Buyer_id`),
  UNIQUE KEY `Phone` (`Phone`),
  UNIQUE KEY `Email` (`Email`),
  KEY `Atm` (`Atm`),
  KEY `Ward` (`Ward`),
  KEY `Atm_2` (`Atm`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `buyers`
--

INSERT INTO `buyers` (`Buyer_id`, `Name`, `Gender`, `Birth`, `Phone`, `Email`, `Avatar`, `Password`, `Address`, `Ward`, `Atm`, `Atm_name`, `Created_at`, `role`) VALUES
(1, 'Nguyễn Văn A', 1, '1990-01-01 00:00:00', '0123456789', 'nguyenvana@example.com', NULL, '123123', '123 Đường A', 1, NULL, NULL, '2024-04-24 17:08:03', 1),
(2, 'Trần Thị B', 2, '1992-02-02 00:00:00', '0987654321', 'tranthib@example.com', NULL, '123123', '456 Đường B', 2, NULL, NULL, '2024-04-24 17:08:03', 1),
(3, 'Lê Văn C', 1, '1988-03-03 00:00:00', '0123456790', 'levanc@example.com', NULL, '123123', '789 Đường C', 3, NULL, NULL, '2024-04-24 17:08:03', 1),
(4, 'Phạm Thị D', 2, '1995-04-04 00:00:00', '0987654320', 'phamthid@example.com', NULL, '123123', '321 Đường D', 4, NULL, NULL, '2024-04-24 17:08:03', 1),
(5, 'Ngô Văn E', 1, '1985-05-05 00:00:00', '0123456791', 'ngovane@example.com', NULL, '123123', '654 Đường E', 1, NULL, NULL, '2024-04-24 17:08:03', 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `buyer_purchases`
--

DROP TABLE IF EXISTS `buyer_purchases`;
CREATE TABLE IF NOT EXISTS `buyer_purchases` (
  `Purchase_id` int(11) NOT NULL AUTO_INCREMENT,
  `Buyer_id` int(11) DEFAULT NULL,
  `Price` decimal(10,2) DEFAULT NULL,
  `Last_Price` decimal(10,2) DEFAULT NULL,
  `notes` varchar(255) DEFAULT NULL,
  `Created_at` datetime DEFAULT NULL,
  `Transport_fee` decimal(10,2) DEFAULT NULL,
  `Transport_voucher` decimal(10,2) DEFAULT NULL,
  `Voucher_shop` decimal(10,2) DEFAULT NULL,
  `Voucher` decimal(10,2) DEFAULT NULL,
  `Transport` int(11) DEFAULT NULL,
  `payment` int(11) DEFAULT NULL,
  `Status` int(11) DEFAULT NULL,
  `Last_Update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`Purchase_id`),
  KEY `Buyer_id` (`Buyer_id`),
  KEY `Transport` (`Transport`),
  KEY `payment` (`payment`),
  KEY `Status` (`Status`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `buyer_purchases`
--

INSERT INTO `buyer_purchases` (`Purchase_id`, `Buyer_id`, `Price`, `Last_Price`, `notes`, `Created_at`, `Transport_fee`, `Transport_voucher`, `Voucher_shop`, `Voucher`, `Transport`, `payment`, `Status`, `Last_Update`) VALUES
(1, 1, '100.00', '90.00', 'Đơn hàng 1 của người dùng 1', '2024-04-25 16:52:17', '5.00', '2.00', '10.00', '5.00', 1, 1, 1, '2024-04-25 09:52:17'),
(2, 1, '150.00', '130.00', 'Đơn hàng 2 của người dùng 1', '2024-04-25 16:52:17', '7.00', '2.00', '15.00', '7.00', 2, 1, 1, '2024-04-25 09:52:17'),
(3, 2, '200.00', '180.00', 'Đơn hàng 1 của người dùng 2', '2024-04-25 16:52:17', '5.00', '3.00', '20.00', '10.00', 1, 1, 2, '2024-04-25 09:52:17'),
(4, 2, '250.00', '220.00', 'Đơn hàng 2 của người dùng 2', '2024-04-25 16:52:17', '10.00', '5.00', '25.00', '15.00', 2, 1, 1, '2024-04-25 09:52:17'),
(5, 1, '300.00', '270.00', 'Đơn hàng 3 của người dùng 1', '2024-04-25 16:52:17', '12.00', '6.00', '30.00', '20.00', 1, 1, 1, '2024-04-25 09:52:17');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `carts`
--

DROP TABLE IF EXISTS `carts`;
CREATE TABLE IF NOT EXISTS `carts` (
  `user_id` int(11) NOT NULL,
  `classify_type_id` int(11) NOT NULL,
  `Quantity` int(11) DEFAULT NULL,
  PRIMARY KEY (`user_id`,`classify_type_id`),
  KEY `Product_Category_type_id` (`classify_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `carts`
--

INSERT INTO `carts` (`user_id`, `classify_type_id`, `Quantity`) VALUES
(1, 1, 2),
(1, 6, 1),
(1, 12, 1),
(2, 2, 3),
(2, 5, 2),
(2, 14, 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `city`
--

DROP TABLE IF EXISTS `city`;
CREATE TABLE IF NOT EXISTS `city` (
  `City_id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`City_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `city`
--

INSERT INTO `city` (`City_id`, `Name`) VALUES
(1, 'Đà Nẵng'),
(2, 'Hà Nội'),
(3, 'TP Hồ Chí Minh'),
(4, 'Nha Trang');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `classify`
--

DROP TABLE IF EXISTS `classify`;
CREATE TABLE IF NOT EXISTS `classify` (
  `classify_id` int(11) NOT NULL AUTO_INCREMENT,
  `Product_id` int(11) DEFAULT NULL,
  `Name` varchar(255) DEFAULT NULL,
  `Quantity` int(11) DEFAULT NULL,
  PRIMARY KEY (`classify_id`),
  KEY `Product_id` (`Product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `classify`
--

INSERT INTO `classify` (`classify_id`, `Product_id`, `Name`, `Quantity`) VALUES
(1, 2, 'Màu đen', 100),
(2, 2, 'Màu đỏ', 80),
(3, 2, 'Màu xanh', 60),
(4, 1, 'Tập 1', 50),
(5, 1, 'Tập 2', 50),
(6, 3, '100 viên', 200),
(7, 3, '50 viên', 120),
(8, 4, '50ml', 30),
(9, 4, '100ml', 15),
(10, 5, 'Công suất 600W', 40),
(11, 6, 'Dung tích 1.8L', 25),
(12, 7, 'Dung lượng 256GB', 15),
(13, 8, 'Dung lượng 64GB', 10),
(14, 9, 'Size M', 30),
(15, 10, 'Bộ cảnh sát', 20);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `classify_types`
--

DROP TABLE IF EXISTS `classify_types`;
CREATE TABLE IF NOT EXISTS `classify_types` (
  `Classify_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `classify_id` int(11) DEFAULT NULL,
  `Name` varchar(255) DEFAULT NULL,
  `Quantity` int(11) DEFAULT NULL,
  `Prices` decimal(10,2) DEFAULT NULL,
  `Pricess_sale` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`Classify_type_id`),
  KEY `Product_Category_id` (`classify_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `classify_types`
--

INSERT INTO `classify_types` (`Classify_type_id`, `classify_id`, `Name`, `Quantity`, `Prices`, `Pricess_sale`) VALUES
(1, 1, 'Bút bi màu đen', 100, '5.00', '3.50'),
(2, 2, 'Bút bi màu đỏ', 80, '5.00', '4.00'),
(3, 3, 'Bút bi màu xanh', 60, '5.00', '4.00'),
(4, 4, 'Sách Ngữ văn 10 - Tập 1', 50, '15.00', '12.00'),
(5, 5, 'Sách Ngữ văn 10 - Tập 2', 50, '15.00', '12.00'),
(6, 6, 'Viên bổ sung Vitamin C - 100 viên', 200, '25.00', '20.00'),
(7, 7, 'Viên bổ sung Vitamin C - 50 viên', 120, '15.00', '12.00'),
(8, 8, 'Kem dưỡng da ban đêm - 50ml', 30, '30.00', '25.00'),
(9, 9, 'Kem dưỡng da ban đêm - 100ml', 15, '50.00', '40.00'),
(10, 10, 'Máy xay sinh tố - Công suất 600W', 40, '100.00', '80.00'),
(11, 11, 'Nồi cơm điện - Dung tích 1.8L', 25, '70.00', '55.00'),
(12, 12, 'iPhone 13 Pro - 256GB', 15, '1200.00', '1100.00'),
(13, 13, 'iPad Air - 64GB', 10, '800.00', '750.00'),
(14, 14, 'Áo thun Adidas - Size M', 30, '25.00', '20.00'),
(15, 15, 'LEGO City Police', 20, '50.00', '45.00');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `district`
--

DROP TABLE IF EXISTS `district`;
CREATE TABLE IF NOT EXISTS `district` (
  `District_id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) DEFAULT NULL,
  `City` int(11) DEFAULT NULL,
  PRIMARY KEY (`District_id`),
  KEY `City` (`City`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `district`
--

INSERT INTO `district` (`District_id`, `Name`, `City`) VALUES
(1, 'Hải Châu', 1),
(2, 'Cẩm Lệ', 1),
(3, 'Ba Đình', 2),
(4, 'Đống Đa', 2),
(5, 'Quận 1', 3),
(6, 'Quận 3', 3),
(7, 'Vĩnh Hải', 4),
(8, 'Vĩnh Ngọc', 4);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `evaluate`
--

DROP TABLE IF EXISTS `evaluate`;
CREATE TABLE IF NOT EXISTS `evaluate` (
  `Evaluate_id` int(11) NOT NULL AUTO_INCREMENT,
  `Buyer_id` int(11) DEFAULT NULL,
  `Product_Category_type_id` int(11) DEFAULT NULL,
  `Content` varchar(255) DEFAULT NULL,
  `Star` int(11) DEFAULT NULL,
  `Time` datetime DEFAULT NULL,
  PRIMARY KEY (`Evaluate_id`),
  KEY `Buyer_id` (`Buyer_id`),
  KEY `Product_Category_type_id` (`Product_Category_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `evaluate_image`
--

DROP TABLE IF EXISTS `evaluate_image`;
CREATE TABLE IF NOT EXISTS `evaluate_image` (
  `Evaluate_id` int(11) DEFAULT NULL,
  `image_id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`image_id`),
  KEY `Evaluate_id` (`Evaluate_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `payment_methods`
--

DROP TABLE IF EXISTS `payment_methods`;
CREATE TABLE IF NOT EXISTS `payment_methods` (
  `Methods_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Methods_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `payment_methods`
--

INSERT INTO `payment_methods` (`Methods_id`, `name`) VALUES
(1, 'Tiền mặt khi nhận hàng'),
(2, 'Thẻ tín dụng'),
(3, 'Thẻ ghi nợ'),
(4, 'Ví điện tử Momo'),
(5, 'Ví ZaloPay'),
(6, 'Chuyển khoản ngân hàng');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `products`
--

DROP TABLE IF EXISTS `products`;
CREATE TABLE IF NOT EXISTS `products` (
  `Product_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `Trademark` int(11) DEFAULT NULL,
  `Seller_id` int(11) DEFAULT NULL,
  `info` varchar(255) DEFAULT NULL,
  `Star` float DEFAULT NULL,
  PRIMARY KEY (`Product_id`),
  KEY `Seller_id` (`Seller_id`),
  KEY `Trademark` (`Trademark`),
  KEY `type` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `products`
--

INSERT INTO `products` (`Product_id`, `name`, `type`, `Trademark`, `Seller_id`, `info`, `Star`) VALUES
(1, 'Sách Ngữ văn 10', 1, 1, 1, 'Sách giáo khoa Ngữ văn lớp 10', 4.5),
(2, 'Bút bi Thiên Long 0.5mm', 2, 1, 1, 'Bút bi 0.5mm màu đen', 4.3),
(3, 'Viên bổ sung Vitamin C', 3, 2, 3, 'Viên uống tăng cường Vitamin C', 4.7),
(4, 'Kem dưỡng da ban đêm', 4, 2, 1, 'Kem dưỡng da ban đêm Olay', 4.6),
(5, 'Máy xay sinh tố Philips HR2118', 5, 3, 2, 'Máy xay sinh tố đa năng', 4.2),
(6, 'Nồi cơm điện Sharp 1.8L', 6, 3, 3, 'Nồi cơm điện dung tích 1.8L', 4.4),
(7, 'iPhone 13 Pro Max 256GB', 7, 4, 1, 'Điện thoại thông minh', 4.8),
(8, 'iPad Air 4th Gen 64GB', 8, 4, 2, 'Máy tính bảng 10.9 inch', 4.7),
(9, 'Áo thun Adidas nam', 9, 5, 3, 'Áo thun thời trang nam Adidas', 4.5),
(10, 'LEGO City Police', 10, 6, 3, 'Bộ đồ chơi LEGO chủ đề cảnh sát', 4.6);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `product_types`
--

DROP TABLE IF EXISTS `product_types`;
CREATE TABLE IF NOT EXISTS `product_types` (
  `Product_Types_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Product_Types_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `product_types`
--

INSERT INTO `product_types` (`Product_Types_id`, `name`) VALUES
(1, 'Sách và Văn phòng phẩm'),
(2, 'Sức khỏe và Làm đẹp'),
(3, 'Nhà cửa và Đồ gia dụng'),
(4, 'Điện tử và Công nghệ'),
(5, 'Thời trang và Phụ kiện'),
(6, 'Đồ chơi');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `purchases_products`
--

DROP TABLE IF EXISTS `purchases_products`;
CREATE TABLE IF NOT EXISTS `purchases_products` (
  `Purchase_id` int(11) NOT NULL,
  `classify_type_id` int(11) NOT NULL,
  `Quantity` int(11) DEFAULT NULL,
  `Price` decimal(10,2) DEFAULT NULL,
  `Pricess_sale` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`Purchase_id`,`classify_type_id`),
  KEY `Product_Category_type_id` (`classify_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `purchases_products`
--

INSERT INTO `purchases_products` (`Purchase_id`, `classify_type_id`, `Quantity`, `Price`, `Pricess_sale`) VALUES
(1, 1, 2, '50.00', '45.00'),
(1, 2, 1, '40.00', '35.00'),
(2, 3, 3, '60.00', '55.00'),
(3, 4, 1, '70.00', '65.00'),
(4, 5, 2, '80.00', '75.00'),
(5, 6, 4, '90.00', '85.00');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sellers`
--

DROP TABLE IF EXISTS `sellers`;
CREATE TABLE IF NOT EXISTS `sellers` (
  `Seller_id` int(11) NOT NULL AUTO_INCREMENT,
  `Buyer_id` int(11) DEFAULT NULL,
  `Shop_name` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `Shop_Address` varchar(255) DEFAULT NULL,
  `Shop_Ward` int(11) DEFAULT NULL,
  PRIMARY KEY (`Seller_id`),
  UNIQUE KEY `phone` (`phone`),
  KEY `Shop_Ward` (`Shop_Ward`),
  KEY `Buyer_id` (`Buyer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `sellers`
--

INSERT INTO `sellers` (`Seller_id`, `Buyer_id`, `Shop_name`, `phone`, `Shop_Address`, `Shop_Ward`) VALUES
(1, 1, 'Cửa hàng A', '0123456789', '123 Đường A', 1),
(2, 2, 'Cửa hàng B', '0987654321', '456 Đường B', 10),
(3, 3, 'Cửa hàng C', '0123456790', '789 Đường C', 15);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `seller_registries`
--

DROP TABLE IF EXISTS `seller_registries`;
CREATE TABLE IF NOT EXISTS `seller_registries` (
  `Seller_Registry_id` int(11) NOT NULL AUTO_INCREMENT,
  `Shop_name` varchar(255) DEFAULT NULL,
  `Buyer_id` int(11) DEFAULT NULL,
  `Registed_at` datetime DEFAULT NULL,
  PRIMARY KEY (`Seller_Registry_id`),
  KEY `Buyer_id` (`Buyer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `status_purchases`
--

DROP TABLE IF EXISTS `status_purchases`;
CREATE TABLE IF NOT EXISTS `status_purchases` (
  `Status_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Status_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `status_purchases`
--

INSERT INTO `status_purchases` (`Status_id`, `name`) VALUES
(1, 'Chưa giao'),
(2, 'Đang vận chuyển'),
(3, 'Đã giao'),
(4, 'Đã hủy'),
(5, 'Đang chờ xác nhận');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `trademark`
--

DROP TABLE IF EXISTS `trademark`;
CREATE TABLE IF NOT EXISTS `trademark` (
  `Trademark_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `info` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Trademark_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `trademark`
--

INSERT INTO `trademark` (`Trademark_id`, `name`, `info`) VALUES
(1, 'Thiên Long', 'Nhãn hiệu bút và văn phòng phẩm nổi tiếng'),
(2, 'Olay', 'Thương hiệu mỹ phẩm nổi tiếng'),
(3, 'Philips', 'Nhãn hiệu điện gia dụng từ Hà Lan'),
(4, 'Apple', 'Nhãn hiệu điện tử và công nghệ'),
(5, 'Adidas', 'Thương hiệu thời trang và phụ kiện nổi tiếng'),
(6, 'LEGO', 'Thương hiệu đồ chơi nổi tiếng của Đan Mạch');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `transports`
--

DROP TABLE IF EXISTS `transports`;
CREATE TABLE IF NOT EXISTS `transports` (
  `Transports_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Transports_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `transports`
--

INSERT INTO `transports` (`Transports_id`, `name`) VALUES
(1, 'Giao hàng nhanh'),
(2, 'Giao hàng tiết kiệm'),
(3, 'Viettel Post'),
(4, 'Vietnam Post'),
(5, 'J&T Express');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `types`
--

DROP TABLE IF EXISTS `types`;
CREATE TABLE IF NOT EXISTS `types` (
  `Type_id` int(11) NOT NULL AUTO_INCREMENT,
  `Product_type_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Type_id`),
  KEY `Product_id` (`Product_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `types`
--

INSERT INTO `types` (`Type_id`, `Product_type_id`, `name`) VALUES
(1, 1, 'Sách giáo khoa'),
(2, 1, 'Bút'),
(3, 2, 'Son môi'),
(4, 2, 'Nước hoa'),
(5, 3, 'Dụng cụ nhà bếp'),
(6, 3, 'Bàn ghế'),
(7, 4, 'Điện thoại di động'),
(8, 4, 'Máy tính bảng'),
(9, 5, 'Quần áo thời trang'),
(10, 5, 'Giày dép thời trang'),
(11, 6, 'Đồ chơi trẻ em'),
(12, 6, 'Đồ chơi mô hình'),
(13, 1, 'Truyện tranh');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `ward`
--

DROP TABLE IF EXISTS `ward`;
CREATE TABLE IF NOT EXISTS `ward` (
  `Ward_id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) DEFAULT NULL,
  `District` int(11) DEFAULT NULL,
  PRIMARY KEY (`Ward_id`),
  KEY `District` (`District`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `ward`
--

INSERT INTO `ward` (`Ward_id`, `Name`, `District`) VALUES
(1, 'Hải Châu 1', 1),
(2, 'Hải Châu 2', 1),
(3, 'Thanh Bình', 1),
(4, 'Thuận Phước', 1),
(5, 'Hòa Thuận Hiên', 1),
(6, 'Hòa Cường Bắc', 1),
(7, 'Hòa Cường Nam', 1),
(8, 'Khuê Trung', 2),
(9, 'Hòa Phát', 2),
(10, 'Hòa An', 2),
(11, 'Hòa Thọ Tây', 2),
(12, 'Hòa Thọ Đông', 2),
(13, 'Hòa Xuân', 2),
(14, 'Cống Vị', 3),
(15, 'Điện Biên', 3),
(16, 'Đội Cấn', 3),
(17, 'Giảng Võ', 3),
(18, 'Kim Mã', 3),
(19, 'Liễu Giai', 3),
(20, 'Văn Miếu', 4),
(21, 'Trung Tự', 4),
(22, 'Thịnh Quang', 4),
(23, 'Trung Phụng', 4),
(24, 'Khương Thượng', 4),
(25, 'Văn Chương', 4),
(26, 'Bến Nghé', 5),
(27, 'Cô Giang', 5),
(28, 'Cầu Ông Lãnh', 5),
(29, 'Cầu Kho', 5),
(30, 'Đa Kao', 5),
(31, 'Nguyễn Cư Trinh', 5),
(32, 'Võ Thị Sáu', 6),
(33, '1', 6),
(34, '2', 6),
(35, '3', 6),
(36, '4', 6),
(37, '5', 6),
(38, 'Ngọc Hiệp', 7),
(39, 'Lộc Thọ', 7),
(40, 'Phước Hải', 7),
(41, 'Phước Long', 7),
(42, 'Phước Tân', 7),
(43, 'Phước Tiến', 7),
(44, 'Vĩnh Trường', 8),
(45, 'Vĩnh Nguyên', 8),
(46, 'Vĩnh Hòa', 8),
(47, 'Vĩnh Hải', 8),
(48, 'Vĩnh Thọ', 8),
(49, 'Vĩnh Phước', 8);

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `admins`
--
ALTER TABLE `admins`
  ADD CONSTRAINT `admins_ibfk_1` FOREIGN KEY (`Role`) REFERENCES `admins_roles` (`Role_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `buyers`
--
ALTER TABLE `buyers`
  ADD CONSTRAINT `buyers_ibfk_1` FOREIGN KEY (`Ward`) REFERENCES `ward` (`Ward_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `buyer_purchases`
--
ALTER TABLE `buyer_purchases`
  ADD CONSTRAINT `buyer_purchases_ibfk_1` FOREIGN KEY (`Buyer_id`) REFERENCES `buyers` (`Buyer_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `buyer_purchases_ibfk_2` FOREIGN KEY (`Transport`) REFERENCES `transports` (`Transports_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `buyer_purchases_ibfk_3` FOREIGN KEY (`payment`) REFERENCES `payment_methods` (`Methods_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `buyer_purchases_ibfk_4` FOREIGN KEY (`Status`) REFERENCES `status_purchases` (`Status_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `carts`
--
ALTER TABLE `carts`
  ADD CONSTRAINT `carts_ibfk_1` FOREIGN KEY (`classify_type_id`) REFERENCES `classify_types` (`Classify_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `carts_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `buyers` (`Buyer_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `classify`
--
ALTER TABLE `classify`
  ADD CONSTRAINT `classify_ibfk_1` FOREIGN KEY (`Product_id`) REFERENCES `products` (`Product_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `classify_types`
--
ALTER TABLE `classify_types`
  ADD CONSTRAINT `classify_types_ibfk_1` FOREIGN KEY (`classify_id`) REFERENCES `classify` (`classify_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `district`
--
ALTER TABLE `district`
  ADD CONSTRAINT `district_ibfk_1` FOREIGN KEY (`City`) REFERENCES `city` (`City_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `evaluate`
--
ALTER TABLE `evaluate`
  ADD CONSTRAINT `evaluate_ibfk_1` FOREIGN KEY (`Buyer_id`) REFERENCES `buyers` (`Buyer_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `evaluate_image`
--
ALTER TABLE `evaluate_image`
  ADD CONSTRAINT `evaluate_image_ibfk_1` FOREIGN KEY (`Evaluate_id`) REFERENCES `evaluate` (`Evaluate_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`Seller_id`) REFERENCES `sellers` (`Seller_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `products_ibfk_2` FOREIGN KEY (`Trademark`) REFERENCES `trademark` (`Trademark_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `products_ibfk_3` FOREIGN KEY (`type`) REFERENCES `types` (`Type_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `purchases_products`
--
ALTER TABLE `purchases_products`
  ADD CONSTRAINT `purchases_products_ibfk_1` FOREIGN KEY (`Purchase_id`) REFERENCES `buyer_purchases` (`Purchase_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `purchases_products_ibfk_2` FOREIGN KEY (`classify_type_id`) REFERENCES `classify_types` (`Classify_type_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `sellers`
--
ALTER TABLE `sellers`
  ADD CONSTRAINT `sellers_ibfk_1` FOREIGN KEY (`Shop_Ward`) REFERENCES `ward` (`Ward_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `sellers_ibfk_2` FOREIGN KEY (`Buyer_id`) REFERENCES `buyers` (`Buyer_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `seller_registries`
--
ALTER TABLE `seller_registries`
  ADD CONSTRAINT `seller_registries_ibfk_1` FOREIGN KEY (`Buyer_id`) REFERENCES `buyers` (`Buyer_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `types`
--
ALTER TABLE `types`
  ADD CONSTRAINT `types_ibfk_1` FOREIGN KEY (`Product_type_id`) REFERENCES `product_types` (`Product_Types_id`);

--
-- Các ràng buộc cho bảng `ward`
--
ALTER TABLE `ward`
  ADD CONSTRAINT `ward_ibfk_1` FOREIGN KEY (`District`) REFERENCES `district` (`District_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
