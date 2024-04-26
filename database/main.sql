-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th4 24, 2024 lúc 12:01 PM
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

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `admins`
--

CREATE TABLE `admins` (
  `Admin_d` int(11) NOT NULL,
  `Admin_name` varchar(255) DEFAULT NULL,
  `Password` varchar(255) DEFAULT NULL,
  `Role` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `admins_roles`
--

CREATE TABLE `admins_roles` (
  `Role_id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `buyers`
--

CREATE TABLE `buyers` (
  `Buyer_id` int(11) NOT NULL,
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
  `Created_at` datetime DEFAULT NULL,
  `role` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `buyer_purchases`
--

CREATE TABLE `buyer_purchases` (
  `Purchase_id` int(11) NOT NULL,
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
  `Last_Update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `carts`
--

CREATE TABLE `carts` (
  `user_id` int(11) NOT NULL,
  `classify_type_id` int(11) NOT NULL,
  `Quantity` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `city`
--

CREATE TABLE `city` (
  `City_id` int(11) NOT NULL,
  `Name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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

CREATE TABLE `classify` (
  `classify_id` int(11) NOT NULL,
  `Product_id` int(11) DEFAULT NULL,
  `Name` varchar(255) DEFAULT NULL,
  `Quantity` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `classify_types`
--carts

CREATE TABLE `classify_types` (
  `Classify_type_id` int(11) NOT NULL,
  `classify_id` int(11) DEFAULT NULL,
  `Name` varchar(255) DEFAULT NULL,
  `Quantity` int(11) DEFAULT NULL,
  `Prices` decimal(10,2) DEFAULT NULL,
  `Pricess_sale` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `district`
--

CREATE TABLE `district` (
  `District_id` int(11) NOT NULL,
  `Name` varchar(255) DEFAULT NULL,
  `City` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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

CREATE TABLE `evaluate` (
  `Evaluate_id` int(11) NOT NULL,
  `Buyer_id` int(11) DEFAULT NULL,
  `Product_Category_type_id` int(11) DEFAULT NULL,
  `Content` varchar(255) DEFAULT NULL,
  `Star` int(11) DEFAULT NULL,
  `Time` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `evaluate_image`
--

CREATE TABLE `evaluate_image` (
  `Evaluate_id` int(11) DEFAULT NULL,
  `image_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `payment_methods`
--

CREATE TABLE `payment_methods` (
  `Methods_id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `products`
--

CREATE TABLE `products` (
  `Product_id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `Trademark` int(11) DEFAULT NULL,
  `Seller_id` int(11) DEFAULT NULL,
  `info` varchar(255) DEFAULT NULL,
  `Star` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `product_types`
--

CREATE TABLE `product_types` (
  `Product_Types_id` int(11) NOT NULL,
  `Type_id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `purchases_products`
--

CREATE TABLE `purchases_products` (
  `Purchase_id` int(11) NOT NULL,
  `classify_type_id` int(11) NOT NULL,
  `Quantity` int(11) DEFAULT NULL,
  `Price` decimal(10,2) DEFAULT NULL,
  `Pricess_sale` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sellers`
--

CREATE TABLE `sellers` (
  `Seller_id` int(11) NOT NULL,
  `Buyer_id` int(11) DEFAULT NULL,
  `Shop_name` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `Shop_Address` varchar(255) DEFAULT NULL,
  `Shop_Ward` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `seller_registries`
--

CREATE TABLE `seller_registries` (
  `Seller_Registry_id` int(11) NOT NULL,
  `Shop_name` varchar(255) DEFAULT NULL,
  `Buyer_id` int(11) DEFAULT NULL,
  `Registed_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `status_purchases`
--

CREATE TABLE `status_purchases` (
  `Status_id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `trademark`
--

CREATE TABLE `trademark` (
  `Trademark_id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `info` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `transports`
--

CREATE TABLE `transports` (
  `Transports_id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `types`
--

CREATE TABLE `types` (
  `Type_id` int(11) NOT NULL,
  `Product_type_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `ward`
--

CREATE TABLE `ward` (
  `Ward_id` int(11) NOT NULL,
  `Name` varchar(255) DEFAULT NULL,
  `District` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`Admin_d`),
  ADD KEY `Role` (`Role`);

--
-- Chỉ mục cho bảng `admins_roles`
--
ALTER TABLE `admins_roles`
  ADD PRIMARY KEY (`Role_id`);

--
-- Chỉ mục cho bảng `buyers`
--
ALTER TABLE `buyers`
  ADD PRIMARY KEY (`Buyer_id`),
  ADD UNIQUE KEY `Phone` (`Phone`),
  ADD UNIQUE KEY `Email` (`Email`),
  ADD KEY `Atm` (`Atm`),
  ADD KEY `Ward` (`Ward`),
  ADD KEY `Atm_2` (`Atm`);

--
-- Chỉ mục cho bảng `buyer_purchases`
--
ALTER TABLE `buyer_purchases`
  ADD PRIMARY KEY (`Purchase_id`),
  ADD KEY `Buyer_id` (`Buyer_id`),
  ADD KEY `Transport` (`Transport`),
  ADD KEY `payment` (`payment`),
  ADD KEY `Status` (`Status`);

--
-- Chỉ mục cho bảng `carts`
--
ALTER TABLE `carts`
  ADD PRIMARY KEY (`user_id`,`classify_type_id`),
  ADD KEY `Product_Category_type_id` (`classify_type_id`);

--
-- Chỉ mục cho bảng `city`
--
ALTER TABLE `city`
  ADD PRIMARY KEY (`City_id`);

--
-- Chỉ mục cho bảng `classify`
--
ALTER TABLE `classify`
  ADD PRIMARY KEY (`classify_id`),
  ADD KEY `Product_id` (`Product_id`);

--
-- Chỉ mục cho bảng `classify_types`
--
ALTER TABLE `classify_types`
  ADD PRIMARY KEY (`Classify_type_id`),
  ADD KEY `Product_Category_id` (`classify_id`);

--
-- Chỉ mục cho bảng `district`
--
ALTER TABLE `district`
  ADD PRIMARY KEY (`District_id`),
  ADD KEY `City` (`City`);

--
-- Chỉ mục cho bảng `evaluate`
--
ALTER TABLE `evaluate`
  ADD PRIMARY KEY (`Evaluate_id`),
  ADD KEY `Buyer_id` (`Buyer_id`),
  ADD KEY `Product_Category_type_id` (`Product_Category_type_id`);

--
-- Chỉ mục cho bảng `evaluate_image`
--
ALTER TABLE `evaluate_image`
  ADD PRIMARY KEY (`image_id`),
  ADD KEY `Evaluate_id` (`Evaluate_id`);

--
-- Chỉ mục cho bảng `payment_methods`
--
ALTER TABLE `payment_methods`
  ADD PRIMARY KEY (`Methods_id`);

--
-- Chỉ mục cho bảng `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`Product_id`),
  ADD KEY `Seller_id` (`Seller_id`),
  ADD KEY `Trademark` (`Trademark`),
  ADD KEY `type` (`type`);

--
-- Chỉ mục cho bảng `product_types`
--
ALTER TABLE `product_types`
  ADD PRIMARY KEY (`Product_Types_id`) USING BTREE,
  ADD KEY `Type_id` (`Type_id`);

--
-- Chỉ mục cho bảng `purchases_products`
--
ALTER TABLE `purchases_products`
  ADD PRIMARY KEY (`Purchase_id`,`classify_type_id`),
  ADD KEY `Product_Category_type_id` (`classify_type_id`);

--
-- Chỉ mục cho bảng `sellers`
--
ALTER TABLE `sellers`
  ADD PRIMARY KEY (`Seller_id`),
  ADD UNIQUE KEY `phone` (`phone`),
  ADD KEY `Shop_Ward` (`Shop_Ward`),
  ADD KEY `Buyer_id` (`Buyer_id`);

--
-- Chỉ mục cho bảng `seller_registries`
--
ALTER TABLE `seller_registries`
  ADD PRIMARY KEY (`Seller_Registry_id`),
  ADD KEY `Buyer_id` (`Buyer_id`);

--
-- Chỉ mục cho bảng `status_purchases`
--
ALTER TABLE `status_purchases`
  ADD PRIMARY KEY (`Status_id`);

--
-- Chỉ mục cho bảng `trademark`
--
ALTER TABLE `trademark`
  ADD PRIMARY KEY (`Trademark_id`);

--
-- Chỉ mục cho bảng `transports`
--
ALTER TABLE `transports`
  ADD PRIMARY KEY (`Transports_id`);

--
-- Chỉ mục cho bảng `types`
--
ALTER TABLE `types`
  ADD PRIMARY KEY (`Type_id`),
  ADD KEY `Product_id` (`Product_type_id`);

--
-- Chỉ mục cho bảng `ward`
--
ALTER TABLE `ward`
  ADD PRIMARY KEY (`Ward_id`),
  ADD KEY `District` (`District`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `admins`
--
ALTER TABLE `admins`
  MODIFY `Admin_d` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `admins_roles`
--
ALTER TABLE `admins_roles`
  MODIFY `Role_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `buyers`
--
ALTER TABLE `buyers`
  MODIFY `Buyer_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `buyer_purchases`
--
ALTER TABLE `buyer_purchases`
  MODIFY `Purchase_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `city`
--
ALTER TABLE `city`
  MODIFY `City_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT cho bảng `classify`
--
ALTER TABLE `classify`
  MODIFY `classify_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `classify_types`
--
ALTER TABLE `classify_types`
  MODIFY `Classify_type_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `district`
--
ALTER TABLE `district`
  MODIFY `District_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT cho bảng `evaluate`
--
ALTER TABLE `evaluate`
  MODIFY `Evaluate_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `evaluate_image`
--
ALTER TABLE `evaluate_image`
  MODIFY `image_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `payment_methods`
--
ALTER TABLE `payment_methods`
  MODIFY `Methods_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `products`
--
ALTER TABLE `products`
  MODIFY `Product_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `product_types`
--
ALTER TABLE `product_types`
  MODIFY `Product_Types_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `sellers`
--
ALTER TABLE `sellers`
  MODIFY `Seller_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `seller_registries`
--
ALTER TABLE `seller_registries`
  MODIFY `Seller_Registry_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `status_purchases`
--
ALTER TABLE `status_purchases`
  MODIFY `Status_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `trademark`
--
ALTER TABLE `trademark`
  MODIFY `Trademark_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `transports`
--
ALTER TABLE `transports`
  MODIFY `Transports_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `types`
--
ALTER TABLE `types`
  MODIFY `Type_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `ward`
--
ALTER TABLE `ward`
  MODIFY `Ward_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

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
