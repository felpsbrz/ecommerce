<?php
require_once __DIR__ . '/../../controllers/ProductController.php';

header('Content-Type: application/json; charset=utf-8');
error_reporting(0);
ini_set('display_errors', 0);

$controller = new ProductController();
$controller->createProduct();
