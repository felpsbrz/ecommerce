<?php
require_once __DIR__ . '/../core/core.php';

class Client {
    private $pdo;

    public function __construct() {
        $this->pdo = Database::connect();
    }

    public function create($userId, $phone, $address, $number, $email) {
        $stmt = $this->pdo->prepare("
            INSERT INTO clients (user_id, phone, address_c, number_address, email, created_at)
            VALUES (?, ?, ?, ?, ?, NOW())
        ");
        return $stmt->execute([$userId, $phone, $address, $number, $email]);
    }
}
