<?php
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

require_once __DIR__ . '/../../core/core.php';
require_once __DIR__ . '/../../controllers/UserController.php';
require_once __DIR__ . '/../../controllers/ProductController.php';


if (!isset($_SESSION['user']) || $_SESSION['user']['role'] !== 'admin') {
    echo json_encode(['success' => false, 'message' => 'Acesso negado']);
    exit;
}

$userCtrl = new UserController();
$productCtrl = new ProductController();
$pdo = Database::connect();


$clients  = $userCtrl->countByRole('client');
$users    = $userCtrl->countAll();
$products = $productCtrl->countAll();


$stmtOrders = $pdo->query("SELECT COUNT(*) FROM orders");
$orders = (int)$stmtOrders->fetchColumn();


$stmtRecent = $pdo->query("
    SELECT o.id, o.total, o.payment_method, o.created_at, u.fullname AS cliente
    FROM orders o
    LEFT JOIN clients c ON c.id = o.client_id
    LEFT JOIN users u ON u.id = c.user_id
    ORDER BY o.id DESC
    LIMIT 5
");
$recentOrders = $stmtRecent->fetchAll(PDO::FETCH_ASSOC);

echo json_encode([
    'success' => true,
    'dashboard' => [
        'clients'  => $clients,
        'products' => $products,
        'users'    => $users,
        'orders'   => $orders,
        'recentOrders' => $recentOrders
    ]
]);
