<?php
require_once __DIR__ . '/../core/core.php';

class Order {
    private $pdo;

    public function __construct() {
        $this->pdo = Database::connect();
    }

    public function create($client_id, $total, $payment_method, $address, $items) {
        try {
            $this->pdo->beginTransaction();

            $stmt = $this->pdo->prepare("INSERT INTO orders (client_id, total, payment_method, address, created_at)
                                         VALUES (?, ?, ?, ?, NOW())");
            $stmt->execute([$client_id, $total, $payment_method, $address]);
            $order_id = $this->pdo->lastInsertId();

            $itemStmt = $this->pdo->prepare("INSERT INTO order_items (order_id, product_id, qty, price)
                                             VALUES (?, ?, ?, ?)");
            foreach ($items as $item) {
                $itemStmt->execute([$order_id, $item['id'], $item['qtd'], $item['price_promo'] ?: $item['price']]);
            }

            $this->pdo->commit();
            return true;
        } catch (Exception $e) {
            $this->pdo->rollBack();
            error_log($e->getMessage());
            return false;
        }
    }
}
