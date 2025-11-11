<?php
class Product {
    private $pdo;

    public function __construct() {
        $this->pdo = Database::connect();
    }

    public function getAllActive() {
        $stmt = $this->pdo->query("
            SELECT p.id, p.name, p.description, p.price, p.image, p.category_id, p.price_promo, c.name AS category_name
            FROM products p
            LEFT JOIN categories c ON c.id = p.category_id
            WHERE p.active = 1
            ORDER BY p.id ASC
        ");
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function getExtras() {
        $stmt = $this->pdo->query("SELECT id, name, price FROM adicionais WHERE active = 1 ORDER BY name ASC");
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }


    public function insert($name, $description, $price, $category_id, $image_path = '', $price_promo = null) {
        $stmt = $this->pdo->prepare("
            INSERT INTO products (name, description, price, image, category_id, price_promo, active, created_at)
            VALUES (?, ?, ?, ?, ?, ?, 1, NOW())
        ");
        return $stmt->execute([
            $name,
            $description,
            $price,
            $image_path,
            $category_id,
            $price_promo
        ]);
    }

    public function update($id, $name, $description, $price, $category_id, $image_path = '', $price_promo = null) {
    $fields = "name = ?, description = ?, price = ?, category_id = ?, price_promo = ?";
    $params = [$name, $description, $price, $category_id, $price_promo, $id];

    if ($image_path !== '') {
        $fields .= ", image_path = ?";
        array_splice($params, 5, 0, [$image_path]); 
    }

    $stmt = $this->pdo->prepare("UPDATE products SET $fields WHERE id = ?");
    return $stmt->execute($params);
}
}
