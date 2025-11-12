-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 12/11/2025 às 02:25
-- Versão do servidor: 10.4.32-MariaDB
-- Versão do PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `u174511361_pdv`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `adicionais`
--

CREATE TABLE `adicionais` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `price` decimal(10,2) NOT NULL DEFAULT 0.00,
  `active` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `adicionais`
--

INSERT INTO `adicionais` (`id`, `name`, `price`, `active`) VALUES
(1, 'Mussarela', 2.00, 1),
(2, 'Catupiry', 2.00, 1),
(3, 'Cheddar', 2.00, 1),
(4, 'Calabresa', 3.00, 1);

-- --------------------------------------------------------

--
-- Estrutura para tabela `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `icon` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `categories`
--

INSERT INTO `categories` (`id`, `name`, `created_at`, `icon`) VALUES
(1, 'Bebidas', '2025-10-27 23:12:30', ''),
(2, 'Pastéis', '2025-10-27 23:12:30', ''),
(3, 'Porções', '2025-10-27 23:12:30', '');

-- --------------------------------------------------------

--
-- Estrutura para tabela `clients`
--

CREATE TABLE `clients` (
  `id` int(11) NOT NULL,
  `phone` varchar(30) NOT NULL,
  `user_id` int(150) DEFAULT NULL,
  `address_c` varchar(255) DEFAULT NULL,
  `number_address` int(11) NOT NULL,
  `email` varchar(150) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `clients`
--

INSERT INTO `clients` (`id`, `phone`, `user_id`, `address_c`, `number_address`, `email`, `created_at`) VALUES
(1, '12312331', 3, 'cristovao colombo', 333, 'tesste@gmial.com', '2025-10-30 03:07:19'),
(2, '123123', 8, 'cristovao colombo', 2324, 'sdas@gsd.com', '2025-10-30 03:16:11'),
(3, '213213', 10, 'ffff', 2323, 'ffff@ffff', '2025-10-30 04:49:36'),
(4, '213', 11, 'abigail holts', 2231, 'dddd@dddd', '2025-10-30 04:52:33'),
(5, '21323', 12, 'asddas', 21, 'asd@asdd', '2025-10-30 05:15:26'),
(6, '1231232', 13, 'teste6', 1323, 'teste6@gmai.com', '2025-11-07 03:06:09'),
(7, '123232', 14, 'teste7', 1232, 'teste7@gmail.com', '2025-11-07 03:08:36'),
(9, '123213', 16, 'teste7', 213, 'teste7@gmail.com', '2025-11-07 03:11:27'),
(10, '12323', 17, 'asdasd', 390, 'asd@gmail.com', '2025-11-08 20:25:47'),
(12, '555556122', 4, 'olimpímario23', 0, '', '2025-11-09 01:09:08');

-- --------------------------------------------------------

--
-- Estrutura para tabela `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `client_id` int(11) DEFAULT NULL,
  `total` decimal(10,2) NOT NULL,
  `payment_method` varchar(50) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `orders`
--

INSERT INTO `orders` (`id`, `client_id`, `total`, `payment_method`, `address`, `created_at`) VALUES
(1, 4, 34.70, 'cartão (entrega)', 'abigail holts', '2025-11-08 20:58:51'),
(11, 10, 19.50, 'cartao (entrega)', 'asdasd N:390', '2025-11-08 22:01:31'),
(12, 10, 19.50, 'cartao (agora)', 'asdasd N:390', '2025-11-08 22:11:28'),
(13, 10, 11.00, 'cartao (entrega)', 'asdasd N:390', '2025-11-08 22:56:56'),
(14, 10, 152.60, 'cartao (entrega)', 'asdasd N:390', '2025-11-10 02:08:39'),
(15, 10, 152.60, 'cartao (agora)', 'asdasd N:390', '2025-11-10 02:08:46'),
(16, 12, 17.80, 'cartao (entrega)', 'olimpímario23 N:0', '2025-11-10 02:09:24'),
(17, 10, 14.80, 'cartao (agora)', 'asdasd N:390', '2025-11-11 19:24:57'),
(18, 10, 20.80, 'cartao (entrega)', 'asdasd N:390', '2025-11-11 19:30:40'),
(19, 10, 25.80, 'cartao (agora)', 'asdasd N:390', '2025-11-11 19:33:52'),
(20, 10, 25.00, 'cartao (agora)', 'asdasd N:390', '2025-11-11 19:38:46'),
(21, 10, 28.80, 'cartao (entrega)', 'asdasd N:390', '2025-11-11 19:42:39'),
(22, 10, 25.80, 'cartao (agora)', 'asdasd N:390', '2025-11-11 19:43:09'),
(23, 10, 30.80, 'cartao (entrega)', 'asdasd N:390', '2025-11-11 19:43:45');

-- --------------------------------------------------------

--
-- Estrutura para tabela `order_items`
--

CREATE TABLE `order_items` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `qty` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `order_items`
--

INSERT INTO `order_items` (`id`, `order_id`, `product_id`, `qty`, `price`) VALUES
(1, 1, 1, 4, 6.30),
(2, 1, 15, 1, 6.50),
(3, 1, 4, 1, 3.00),
(4, 11, 3, 1, 8.00),
(5, 11, 4, 1, 3.00),
(6, 11, 2, 1, 8.50),
(7, 12, 3, 1, 8.00),
(8, 12, 4, 1, 3.00),
(9, 12, 2, 1, 8.50),
(10, 13, 4, 1, 3.00),
(11, 13, 3, 1, 8.00),
(12, 14, 3, 2, 8.00),
(13, 14, 2, 4, 8.50),
(14, 14, 4, 1, 4.00),
(15, 14, 6, 2, 7.00),
(16, 14, 5, 3, 6.50),
(17, 14, 9, 3, 4.00),
(18, 14, 1, 2, 6.30),
(19, 14, 10, 1, 6.50),
(20, 14, 15, 1, 6.50),
(21, 14, 14, 1, 4.00),
(22, 14, 13, 1, 8.00),
(23, 14, 12, 1, 8.50),
(24, 14, 11, 1, 7.00),
(25, 15, 3, 2, 8.00),
(26, 15, 2, 4, 8.50),
(27, 15, 4, 1, 4.00),
(28, 15, 6, 2, 7.00),
(29, 15, 5, 3, 6.50),
(30, 15, 9, 3, 4.00),
(31, 15, 1, 2, 6.30),
(32, 15, 10, 1, 6.50),
(33, 15, 15, 1, 6.50),
(34, 15, 14, 1, 4.00),
(35, 15, 13, 1, 8.00),
(36, 15, 12, 1, 8.50),
(37, 15, 11, 1, 7.00),
(38, 16, 2, 1, 8.50),
(39, 16, 1, 1, 6.30),
(40, 16, 4, 1, 3.00),
(41, 17, 1, 1, 6.30),
(42, 17, 2, 1, 8.50),
(43, 18, 1, 1, 6.30),
(44, 18, 2, 1, 8.50),
(45, 18, 4, 2, 3.00),
(46, 19, 2, 1, 8.50),
(47, 19, 3, 1, 8.00),
(48, 19, 4, 1, 3.00),
(49, 19, 1, 1, 6.30),
(50, 20, 3, 1, 8.00),
(51, 20, 2, 1, 8.50),
(52, 20, 7, 1, 8.50),
(53, 21, 1, 1, 6.30),
(54, 21, 2, 1, 8.50),
(55, 21, 3, 1, 8.00),
(56, 21, 4, 2, 3.00),
(57, 22, 3, 1, 8.00),
(58, 22, 2, 1, 8.50),
(59, 22, 1, 1, 6.30),
(60, 22, 4, 1, 3.00),
(61, 23, 1, 1, 6.30),
(62, 23, 2, 1, 8.50),
(63, 23, 3, 2, 8.00);

-- --------------------------------------------------------

--
-- Estrutura para tabela `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL,
  `description` text DEFAULT NULL,
  `price` double NOT NULL,
  `price_promo` decimal(10,2) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `active` tinyint(1) DEFAULT 1,
  `category_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `products`
--

INSERT INTO `products` (`id`, `name`, `description`, `price`, `price_promo`, `image`, `active`, `category_id`, `created_at`) VALUES
(1, 'PASTEL de Queijo', 'Pastel crocante com recheio de queijo quentinho', 7, 6.30, 'imgs/produtos/2.png', 1, 2, '2025-10-28 18:52:26'),
(2, 'Pastel de Carne', 'Pastel grande recheado com carne temperada', 8.5, NULL, 'imgs/produtos/1.png', 1, 2, '2025-10-28 18:52:26'),
(3, 'Pastel de Frango', 'Pastel com frango desfiado', 8, NULL, 'imgs/produtos/3.png', 1, 2, '2025-10-28 18:52:26'),
(4, 'Refrigerante Lata', '350ml', 4, 3.00, 'imgs/produtos/coca.png', 1, 1, '2025-10-28 18:52:26'),
(5, 'Suco Natural', 'Copo 300ml', 6.5, NULL, 'imgs/produtos/suco.png', 1, 1, '2025-10-28 18:52:26'),
(6, 'Pastel de Queijo', 'Pastel crocante com recheio de queijo quentinho', 7, NULL, 'imgs/produtos/2.png', 1, 2, '2025-10-28 18:52:26'),
(7, 'Pastel de Carne', 'Pastel grande recheado com carne temperada', 8.5, NULL, 'imgs/produtos/1.png', 1, 2, '2025-10-28 18:52:26'),
(8, 'Pastel de Frango', 'Pastel com frango desfiado', 8, NULL, 'imgs/produtos/3.png', 1, 2, '2025-10-28 18:52:26'),
(9, 'Refrigerante Lata', '350ml', 4, NULL, 'imgs/produtos/coca.png', 1, 1, '2025-10-28 18:52:26'),
(10, 'Suco Natural', 'Copo 300ml', 6.5, NULL, 'imgs/produtos/suco.png', 1, 1, '2025-10-28 18:52:26'),
(11, 'Pastel de Queijo', 'Pastel crocante com recheio de queijo quentinho', 7, NULL, 'imgs/produtos/2.png', 1, 2, '2025-10-28 18:52:26'),
(12, 'Pastel de Carne', 'Pastel grande recheado com carne temperada', 8.5, NULL, 'imgs/produtos/1.png', 1, 2, '2025-10-28 18:52:26'),
(13, 'Pastel de Frango', 'Pastel com frango desfiado', 8, NULL, 'imgs/produtos/3.png', 1, 2, '2025-10-28 18:52:26'),
(14, 'Refrigerante Lata', '350ml', 4, NULL, 'imgs/produtos/coca.png', 1, 1, '2025-10-28 18:52:26'),
(15, 'Suco Natural3', 'Copo 300ml', 6.5, 0.00, 'imgs/produtos/suco.png', 1, 1, '2025-10-28 18:52:26'),
(16, 'admin', 'teste', 12.9, NULL, 'imgs/produtos/produto_690fab0ea9dcc.png', 1, 1, '2025-11-08 17:41:50'),
(17, 'asdadsd2', 'dsadsa', 21.23, 0.00, 'imgs/produtos/produto_690faca68c5fc.png', 1, 1, '2025-11-08 17:48:38');

-- --------------------------------------------------------

--
-- Estrutura para tabela `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `fullname` varchar(150) NOT NULL,
  `role` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `fullname`, `role`) VALUES
(1, 'admin', '$2y$10$T/6hyUtlg2564WHp4SmrW.j218T5UwzEbfrIPFaKF0B1T1TqZ/3Ja', '', 'admin'),
(2, 'teste', '$2y$10$pvwciG1YFqx0BeePdOSGL.ZJU.vi72d78B/mhF0A0JtRWdbbfwq5m', '', ''),
(3, 'teste1', '$2y$10$saWaP7R4IihTcAiJTNGkteLf.cNdps5Iyk2j93FBW.5NSJ3K6dcTO', '', ''),
(4, 'joao', '$2y$10$T/6hyUtlg2564WHp4SmrW.j218T5UwzEbfrIPFaKF0B1T1TqZ/3Ja', 'teste23232345', 'client'),
(5, 'teste123', '$2y$10$IIobSO4FjT.h3UjG2lXKFuRn.1F06kFwS.1Ir9y/o3ergLx0//jh.', 'teste   123', 'user'),
(8, 'teste333', '$2y$10$S/EyFmOZMxb0IFCnLkTHdO6X7OennUrc9xWfSHGRDrIWcHSFjlHf.', 'asdsad', 'user'),
(9, 'asdsda', '$2y$10$k5byvcgxwF8QONofAClxQeBOwAIwogeq1vncR/rdoPqt/PxFM.rVi', '', ''),
(10, 'ffff', '$2y$10$ep7mADbszeDyKsCFdj7/7u/MKpXD11DPdDg79kKkcBLqugqMeXo3C', 'ffff', 'user'),
(11, 'dddd', '$2y$10$.mDFJi6Xjbizy/DsMXnm8eSHmRN8.6B5U8wwjXV6CsXg.dL3DCrdS', 'maria duarte', 'client'),
(12, 'tete123', '$2y$10$NfTECDFpeIsFV15FaOgz.eHRthomUAzjjgV6.JncVgXmUNp2fUpVy', 'asddas', 'user'),
(13, 'teste6', '$2y$10$1.ntz0Ud0sYZGjx3Y4r2H.XCJ5duiym1A0cS5N2comlnQxTBrsKRm', 'teste6', 'user'),
(14, 'teste7', '$2y$10$ZfZYbidnMtLiGW69MXk0CeODdbslQzd96eHnwCJEUWZ2I8hcsD8oy', 'teste7', 'user'),
(15, 'teste8', '$2y$10$ASVCHx/7CtUMCBAHfLMjMOWEDrQXmK50rvWjnle.xMdcA7mvSYYiG', 'teste7', 'user'),
(16, 'teste9', '$2y$10$u4gZgYj9MZup8Wa8kUMbcOFk5ZtmvHKwwJ5qOhsKd9FoHb9p.DIkC', 'teste7', 'user'),
(17, 'tete9', '$2y$10$NhsxbCtgyC8/yWaoe05W5.lvVrUP6K8XNsqxw79eLzLcLrmn.dqAu', 'tete9', 'user');

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `clients`
--
ALTER TABLE `clients`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `phone` (`phone`);

--
-- Índices de tabela `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `client_id` (`client_id`);

--
-- Índices de tabela `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Índices de tabela `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_products_category` (`category_id`);

--
-- Índices de tabela `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `clients`
--
ALTER TABLE `clients`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de tabela `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT de tabela `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

--
-- AUTO_INCREMENT de tabela `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT de tabela `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`) ON DELETE SET NULL;

--
-- Restrições para tabelas `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Restrições para tabelas `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `fk_products_category` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
