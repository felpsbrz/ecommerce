<?php
require_once __DIR__ . '/../models/Category.php';
require_once __DIR__ . '/../models/Product.php';
require_once __DIR__ . '/../core/core.php';

class ProductController {
    private $category;
    private $product;
        private $pdo;


    public function __construct() {
        $this->category = new Category();
        $this->product = new Product();
                $this->pdo = Database::connect();
    }

    public function getDashboardData() {
        try {
            $categories = $this->category->getAll();
            $products = $this->product->getAllActive();
            $extras = $this->product->getExtras();

            Response::success("Dados carregados com sucesso", [
                "timestamp" => date("Y-m-d H:i:s"),
                "total_products" => count($products),
                "categories" => $categories,
                "products" => $products,
                "extras" => $extras
            ]);
        } catch (Exception $e) {
            Response::error("Erro interno no servidor", 500);
        }
    }

    public function getCategoriesOnly() {
        try {
            $categories = $this->category->getAll();
            Response::success("Categorias carregadas", ["categories" => $categories]);
        } catch (Exception $e) {
            Response::error("Erro ao buscar categorias", 500);
        }
    }

    public function countAll() {
        $stmt = $this->pdo->query("SELECT COUNT(*) FROM products");
        return $stmt->fetchColumn();
    }

    public function createProduct() {
    try {
   
        if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
            Response::error("Método não permitido", 405);
        }

        $name = trim($_POST['name'] ?? '');
        $description = trim($_POST['description'] ?? '');
        $price = str_replace(['.', ','], ['', '.'], $_POST['price'] ?? '');
        $category_id = $_POST['category_id'] ?? '';

        if ($name === '' || $price === '' || $category_id === '') {
            Response::error("Preencha todos os campos obrigatórios!", 400);
        }


        $image_path = '';
        if (!empty($_FILES['image']['name'])) {
            $allowed_types = ['image/jpeg', 'image/png', 'image/jpg', 'image/gif'];
            if (!in_array($_FILES['image']['type'], $allowed_types)) {
                Response::error("Tipo de arquivo não permitido.", 400);
            }

            $upload_dir = __DIR__ . '/../../imgs/produtos/';
            if (!is_dir($upload_dir)) mkdir($upload_dir, 0755, true);

            $ext = strtolower(pathinfo($_FILES['image']['name'], PATHINFO_EXTENSION));
            $file_name = 'produto_' . uniqid() . '.' . $ext;
            $path = $upload_dir . $file_name;

            if (!move_uploaded_file($_FILES['image']['tmp_name'], $path)) {
                Response::error("Erro ao salvar imagem.", 500);
            }

            $image_path = 'imgs/produtos/' . $file_name;
        }


        $ok = $this->product->insert([
            'name' => $name,
            'description' => $description,
            'price' => $price,
            'image' => $image_path,
            'category_id' => $category_id
        ]);

        if ($ok) {
            Response::success("Produto cadastrado com sucesso!", []);
        } else {
            Response::error("Erro ao cadastrar produto.", 500);
        }

    } catch (Exception $e) {
        Response::error("Erro interno: " . $e->getMessage(), 500);
    }
}
}
