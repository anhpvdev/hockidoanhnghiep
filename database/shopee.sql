-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th5 07, 2024 lúc 05:51 PM
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
-- Tạo: Th4 25, 2024 lúc 09:16 AM
--

CREATE TABLE `admins` (
  `Admin_id` int(11) NOT NULL,
  `Admin_name` varchar(255) DEFAULT NULL,
  `Password` varchar(255) DEFAULT NULL,
  `Role` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `admins`
--

INSERT INTO `admins` (`Admin_id`, `Admin_name`, `Password`, `Role`) VALUES
(0, 'Admin3', '123123', 3),
(1, 'maviess10', '123123', 1),
(2, 'Admin2', '123123', 2);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `admins_roles`
--
-- Tạo: Th4 07, 2024 lúc 09:44 AM
--

CREATE TABLE `admins_roles` (
  `Role_id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `admins_roles`
--

INSERT INTO `admins_roles` (`Role_id`, `name`) VALUES
(1, 'Admin'),
(2, 'Mod_product'),
(3, 'Mod_seler');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `buyers`
--
-- Tạo: Th5 06, 2024 lúc 03:38 AM
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
  `Created_at` datetime DEFAULT current_timestamp(),
  `role` int(11) DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `buyers`
--

INSERT INTO `buyers` (`Buyer_id`, `Name`, `Gender`, `Birth`, `Phone`, `Email`, `Avatar`, `Password`, `Address`, `Ward`, `Atm`, `Atm_name`, `Created_at`, `role`, `token`) VALUES
(1, 'Nguyễn Văn A', 1, '1990-01-01 00:00:00', '0123456789', 'maviess@gmail.com', NULL, '123123', '123 Đường A', 1, NULL, NULL, '2024-04-24 17:08:03', 3, NULL),
(2, 'Trần Thị B', 2, '1992-02-02 00:00:00', '0987654321', 'tranthib@example.com', NULL, '123123', '456 Đường B', 2, NULL, NULL, '2024-04-24 17:08:03', 3, NULL),
(3, 'Lê Văn C', 1, '1988-03-03 00:00:00', '0123456790', 'levanc@example.com', NULL, '123123', '789 Đường C', 3, NULL, NULL, '2024-04-24 17:08:03', 3, NULL),
(4, 'Phạm Thị D', 2, '1995-04-04 00:00:00', '0987654320', 'phamthid@example.com', NULL, '123123', '321 Đường D', 4, NULL, NULL, '2024-04-24 17:08:03', 2, NULL),
(5, 'Ngô Văn E', 1, '1985-05-05 00:00:00', '0123456791', 'maviess10@gmail.com', NULL, '123123', '654 Đường E', 1, NULL, NULL, '2024-04-24 17:08:03', 1, NULL),
(6, NULL, NULL, NULL, NULL, 'maviess11@gmail.com', NULL, '123123', NULL, NULL, NULL, NULL, '2024-05-06 10:46:01', 1, '849884'),
(8, NULL, NULL, NULL, NULL, 'maviess13@gmail.com', NULL, '123123', NULL, NULL, NULL, NULL, '2024-05-06 15:58:33', 1, NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `buyer_purchases`
--
-- Tạo: Th4 25, 2024 lúc 09:46 AM
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
-- Tạo: Th4 07, 2024 lúc 09:44 AM
--

CREATE TABLE `carts` (
  `user_id` int(11) NOT NULL,
  `classify_type_id` int(11) NOT NULL,
  `Quantity` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `carts`
--

INSERT INTO `carts` (`user_id`, `classify_type_id`, `Quantity`) VALUES
(1, 1, 2),
(1, 6, 10),
(1, 19, 4),
(2, 2, 3),
(2, 5, 2);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `city`
--
-- Tạo: Th4 07, 2024 lúc 09:44 AM
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
-- Tạo: Th4 07, 2024 lúc 09:44 AM
--

CREATE TABLE `classify` (
  `classify_id` int(11) NOT NULL,
  `Product_id` int(11) DEFAULT NULL,
  `Name` varchar(255) DEFAULT NULL,
  `Quantity` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `classify`
--

INSERT INTO `classify` (`classify_id`, `Product_id`, `Name`, `Quantity`) VALUES
(1, 2, 'loại tốt', 100),
(2, 2, 'loại rẻ', 80),
(4, 1, 'Tập', 50),
(6, 3, 'vitamin C', 200),
(7, 3, 'vitamin D', 120),
(8, 4, 'hũ', 30),
(9, 4, 'chiết', 15);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `classify_types`
--
-- Tạo: Th4 07, 2024 lúc 09:44 AM
--

CREATE TABLE `classify_types` (
  `Classify_type_id` int(11) NOT NULL,
  `classify_id` int(11) DEFAULT NULL,
  `Name` varchar(255) DEFAULT NULL,
  `Quantity` int(11) DEFAULT NULL,
  `Prices` decimal(10,2) DEFAULT NULL,
  `Pricess_sale` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `classify_types`
--

INSERT INTO `classify_types` (`Classify_type_id`, `classify_id`, `Name`, `Quantity`, `Prices`, `Pricess_sale`) VALUES
(1, 1, 'màu đen', 100, '3000.00', '2500.00'),
(2, 1, 'màu đỏ', 80, '5000.00', '4000.00'),
(4, 4, 'Sách Ngữ văn 10 - Tập 1', 50, '15000.00', '12000.00'),
(5, 4, 'Sách Ngữ văn 10 - Tập 2', 50, '15000.00', '12000.00'),
(6, 6, '50 viên', 200, '25000.00', '20000.00'),
(7, 6, '100 viên', 120, '15000.00', '12000.00'),
(8, 8, '200g', 30, '30000.00', '25000.00'),
(9, 8, '300g', 15, '50000.00', '40000.00'),
(16, 2, 'màu đen', 100, '5000.00', '3500.00'),
(17, 2, 'màu đỏ', 80, '5000.00', '4000.00'),
(18, 7, '50 viên', 200, '25000.00', '20000.00'),
(19, 7, '100 viên', 200, '48000.00', '36000.00'),
(20, 9, '10g', 100, '2000.00', '15000.00'),
(21, 9, '20g', 100, '3000.00', '25000.00'),
(22, 9, '50g', 100, '7000.00', '50000.00');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `district`
--
-- Tạo: Th4 07, 2024 lúc 09:44 AM
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
-- Tạo: Th4 07, 2024 lúc 09:44 AM
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
-- Tạo: Th4 07, 2024 lúc 09:44 AM
--

CREATE TABLE `evaluate_image` (
  `Evaluate_id` int(11) DEFAULT NULL,
  `image_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `payment_methods`
--
-- Tạo: Th4 07, 2024 lúc 09:44 AM
--

CREATE TABLE `payment_methods` (
  `Methods_id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
-- Tạo: Th4 07, 2024 lúc 09:44 AM
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

--
-- Đang đổ dữ liệu cho bảng `products`
--

INSERT INTO `products` (`Product_id`, `name`, `type`, `Trademark`, `Seller_id`, `info`, `Star`) VALUES
(1, 'Sách Ngữ văn 10', 1, 1, 1, 'Sách giáo khoa Ngữ văn lớp 10', 4.5),
(2, 'Bút bi Thiên Long 0.5mm', 2, 1, 1, 'Bút bi 0.5mm màu đen', 4.3),
(3, 'Viên bổ sung Vitamin', 3, 2, 3, 'Viên uống tăng cường Vitamin C', 4.7),
(4, 'Kem dưỡng da ban đêm', 4, 2, 1, 'Kem dưỡng da ban đêm Olay', 4.6);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `product_types`
--
-- Tạo: Th4 25, 2024 lúc 09:21 AM
--

CREATE TABLE `product_types` (
  `Product_Types_id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
-- Tạo: Th4 07, 2024 lúc 09:44 AM
--

CREATE TABLE `purchases_products` (
  `Purchase_id` int(11) NOT NULL,
  `classify_type_id` int(11) NOT NULL,
  `Quantity` int(11) DEFAULT NULL,
  `Price` decimal(10,2) DEFAULT NULL,
  `Pricess_sale` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `purchases_products`
--

INSERT INTO `purchases_products` (`Purchase_id`, `classify_type_id`, `Quantity`, `Price`, `Pricess_sale`) VALUES
(1, 1, 2, '50.00', '45.00'),
(1, 2, 1, '40.00', '35.00'),
(3, 4, 1, '70.00', '65.00'),
(4, 5, 2, '80.00', '75.00'),
(5, 6, 4, '90.00', '85.00');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sellers`
--
-- Tạo: Th4 07, 2024 lúc 09:44 AM
--

CREATE TABLE `sellers` (
  `Seller_id` int(11) NOT NULL,
  `Buyer_id` int(11) DEFAULT NULL,
  `Shop_name` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `Shop_Address` varchar(255) DEFAULT NULL,
  `Shop_Ward` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `sellers`
--

INSERT INTO `sellers` (`Seller_id`, `Buyer_id`, `Shop_name`, `phone`, `Shop_Address`, `Shop_Ward`) VALUES
(1, 1, 'hihi', '0123456789', '123 Đường A', 1),
(2, 2, 'Cửa hàng B', '0987654321', '456 Đường B', 10),
(3, 3, 'Cửa hàng C', '0123456790', '789 Đường C', 15);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `seller_registries`
--
-- Tạo: Th5 07, 2024 lúc 03:07 PM
--

CREATE TABLE `seller_registries` (
  `Seller_Registry_id` int(11) NOT NULL,
  `Shop_name` varchar(255) DEFAULT NULL,
  `Buyer_id` int(11) DEFAULT NULL,
  `Registed_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `seller_registries`
--

INSERT INTO `seller_registries` (`Seller_Registry_id`, `Shop_name`, `Buyer_id`, `Registed_at`) VALUES
(1, 'test thôi', 4, '2024-05-07 22:09:08'),
(2, 'omg bobby', 1, '2024-05-07 22:29:35');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `status_purchases`
--
-- Tạo: Th4 07, 2024 lúc 09:44 AM
--

CREATE TABLE `status_purchases` (
  `Status_id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
-- Tạo: Th4 07, 2024 lúc 09:44 AM
--

CREATE TABLE `trademark` (
  `Trademark_id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `info` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
-- Tạo: Th4 07, 2024 lúc 09:44 AM
--

CREATE TABLE `transports` (
  `Transports_id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
-- Tạo: Th4 07, 2024 lúc 09:44 AM
--

CREATE TABLE `types` (
  `Type_id` int(11) NOT NULL,
  `Product_type_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
-- Tạo: Th4 07, 2024 lúc 09:44 AM
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
  ADD PRIMARY KEY (`Admin_id`),
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
  ADD PRIMARY KEY (`Product_Types_id`) USING BTREE;

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
-- AUTO_INCREMENT cho bảng `admins_roles`
--
ALTER TABLE `admins_roles`
  MODIFY `Role_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT cho bảng `buyers`
--
ALTER TABLE `buyers`
  MODIFY `Buyer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT cho bảng `buyer_purchases`
--
ALTER TABLE `buyer_purchases`
  MODIFY `Purchase_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT cho bảng `city`
--
ALTER TABLE `city`
  MODIFY `City_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT cho bảng `classify`
--
ALTER TABLE `classify`
  MODIFY `classify_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT cho bảng `classify_types`
--
ALTER TABLE `classify_types`
  MODIFY `Classify_type_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

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
  MODIFY `Methods_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT cho bảng `products`
--
ALTER TABLE `products`
  MODIFY `Product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT cho bảng `product_types`
--
ALTER TABLE `product_types`
  MODIFY `Product_Types_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT cho bảng `sellers`
--
ALTER TABLE `sellers`
  MODIFY `Seller_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT cho bảng `seller_registries`
--
ALTER TABLE `seller_registries`
  MODIFY `Seller_Registry_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT cho bảng `status_purchases`
--
ALTER TABLE `status_purchases`
  MODIFY `Status_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT cho bảng `trademark`
--
ALTER TABLE `trademark`
  MODIFY `Trademark_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT cho bảng `transports`
--
ALTER TABLE `transports`
  MODIFY `Transports_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT cho bảng `types`
--
ALTER TABLE `types`
  MODIFY `Type_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

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
