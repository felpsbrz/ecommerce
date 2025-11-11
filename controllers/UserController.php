<?php
require_once __DIR__ . '/../core/core.php';

class UserController {
    private $pdo;

    public function __construct() {
        $this->pdo = Database::connect();
    }


    public function findByUsername($username) {
        $stmt = $this->pdo->prepare("SELECT * FROM users WHERE username = ?");
        $stmt->execute([$username]);
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }


public function create($username, $password, $extra = []) {
    $hash = password_hash($password, PASSWORD_BCRYPT);
    $stmt = $this->pdo->prepare("
        INSERT INTO users (username, password, fullname, role)
        VALUES (?, ?, ?, 'user')
    ");
    $stmt->execute([$username, $hash, $extra['fullname'] ?? '']);
    return $this->pdo->lastInsertId(); 
}
public function countByRole($role) {
    $stmt = $this->pdo->prepare("SELECT COUNT(*) FROM users WHERE role = ?");
    $stmt->execute([$role]);
    return $stmt->fetchColumn();
}

public function countAll() {
    $stmt = $this->pdo->query("SELECT COUNT(*) FROM users");
    return $stmt->fetchColumn();
}
}
