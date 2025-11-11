<?php
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}


header('Content-Type: application/json; charset=utf-8');


define('APP_ROOT', __DIR__);
require_once APP_ROOT . '/core/ErrorHandler.php'; 
require_once APP_ROOT . '/core/core.php';
require_once APP_ROOT . '/models/Product.php';
require_once APP_ROOT . '/models/Category.php';
require_once APP_ROOT . '/models/Order.php';

// ======= Identifica o endpoint =======
$endpoint = $_GET['endpoint'] ?? '';

try {

    switch ($endpoint) {


        case 'products':
            require APP_ROOT . '/views/json/products.php';
            break;


        case 'categories':
            require APP_ROOT . '/views/json/categories.php';
            break;


        case 'register':
            require APP_ROOT . '/views/json/register.php';
            break;


        case 'login':
            require APP_ROOT . '/views/json/login.php';
            break;


        case 'getDashboard':
            require APP_ROOT . '/views/json/getDashboard.php';
            break;


        case 'create_product':
            $product = new Product();
            $name = trim($_POST['name'] ?? '');
            $description = trim($_POST['description'] ?? '');
            $price = str_replace(',', '.', $_POST['price'] ?? '');
            $category_id = (int)($_POST['category_id'] ?? 0);
            $price_promo = isset($_POST['price_promo']) ? str_replace(',', '.', $_POST['price_promo']) : null;
            $image_path = '';

            if ($name === '' || $price === '' || $category_id <= 0)
                throw new Exception("Campos obrigatórios ausentes.");

            if (!is_numeric($price) || $price <= 0)
                throw new Exception("Preço inválido.");

            if (!empty($_FILES['image']['name'])) {
                $upload_dir = APP_ROOT . '/imgs/produtos/';
                if (!is_dir($upload_dir)) mkdir($upload_dir, 0755, true);
                $ext = strtolower(pathinfo($_FILES['image']['name'], PATHINFO_EXTENSION));
                $filename = 'produto_' . uniqid() . '.' . $ext;
                $dest = $upload_dir . $filename;
                if (!move_uploaded_file($_FILES['image']['tmp_name'], $dest))
                    throw new Exception("Falha ao enviar imagem.");
                $image_path = 'imgs/produtos/' . $filename;
            }

            $ok = $product->insert($name, $description, $price, $category_id, $image_path, $price_promo);
            echo json_encode(['success' => $ok, 'message' => $ok ? 'Produto cadastrado com sucesso!' : 'Erro ao inserir produto.']);
            break;

            
        case 'create_order':
            if (!isset($_SESSION['user']['id']))
                throw new Exception("Usuário não autenticado.");

            $pdo = Database::connect();
            $stmt = $pdo->prepare("SELECT id FROM clients WHERE user_id = ?");
            $stmt->execute([$_SESSION['user']['id']]);
            $client = $stmt->fetch(PDO::FETCH_ASSOC);
            $client_id = $client['id'] ?? null;

            if (!$client_id) throw new Exception("Cliente não encontrado.");

            $total = (float)($_POST['total'] ?? 0);
            $payment_method = trim($_POST['payment_method'] ?? '');
            $address = trim($_POST['address'] ?? '');
            $items = json_decode($_POST['items'] ?? '[]', true);

            if ($total <= 0 || empty($items))
                throw new Exception("Pedido inválido.");

            $order = new Order();
            $ok = $order->create($client_id, $total, $payment_method, $address, $items);

            echo json_encode(['success' => $ok, 'message' => 'Pedido criado com sucesso!']);
            break;


        case 'update_user':
            if (!isset($_SESSION['user'])) throw new Exception("Acesso negado.");

            $pdo = Database::connect();
            $id = (int)($_POST['id'] ?? 0);
            $fullname = trim($_POST['name'] ?? '');
            $phone = trim($_POST['phone'] ?? '');
            $address = trim($_POST['address'] ?? '');
            $password = trim($_POST['password'] ?? '');
            $role = trim($_POST['role'] ?? '');
            $sessionRole = $_SESSION['user']['role'];

            if ($id <= 0 || $fullname === '')
                throw new Exception("Dados obrigatórios ausentes.");

            $stmt = $pdo->prepare("SELECT * FROM users WHERE id = ?");
            $stmt->execute([$id]);
            $user = $stmt->fetch(PDO::FETCH_ASSOC);
            if (!$user) throw new Exception("Usuário não encontrado.");

            if ($sessionRole !== 'admin') $role = $user['role'];

            $sql = "UPDATE users SET fullname = ?, role = ?";
            $params = [$fullname, $role];
            if ($password !== '') {
                $sql .= ", password = ?";
                $params[] = password_hash($password, PASSWORD_DEFAULT);
            }
            $sql .= " WHERE id = ?";
            $params[] = $id;
            $stmt = $pdo->prepare($sql);
            $ok_user = $stmt->execute($params);

            $stmtCheck = $pdo->prepare("SELECT id FROM clients WHERE user_id = ?");
            $stmtCheck->execute([$id]);
            $client = $stmtCheck->fetch(PDO::FETCH_ASSOC);

            if ($client) {
                $stmtClient = $pdo->prepare("UPDATE clients SET phone = ?, address_c = ? WHERE user_id = ?");
                $ok_client = $stmtClient->execute([$phone, $address, $id]);
            } else {
                $stmtClient = $pdo->prepare("INSERT INTO clients (user_id, phone, address_c) VALUES (?, ?, ?)");
                $ok_client = $stmtClient->execute([$id, $phone, $address]);
            }

            echo json_encode([
                'success' => ($ok_user && $ok_client),
                'message' => ($ok_user && $ok_client) ? 'Usuário atualizado com sucesso!' : 'Erro ao atualizar usuário.'
            ]);
            break;

 

        case 'update_order':
            $pdo = Database::connect();
            $id = (int)($_POST['id'] ?? 0);
            $address = trim($_POST['address'] ?? '');
            $payment_method = trim($_POST['payment_method'] ?? '');
            $items = json_decode($_POST['items'] ?? '[]', true);

            if ($id <= 0 || $address === '' || $payment_method === '')
                throw new Exception("Dados obrigatórios ausentes.");

            $stmt = $pdo->prepare("UPDATE orders SET address = ?, payment_method = ? WHERE id = ?");
            $ok = $stmt->execute([$address, $payment_method, $id]);

            $idsMantidos = [];
            foreach ($items as $it) {
                $itemId = (int)$it['id'];
                $qty = max(1, (int)$it['qty']);
                $idsMantidos[] = $itemId;
                $stmt = $pdo->prepare("UPDATE order_items SET qty = ? WHERE id = ? AND order_id = ?");
                $stmt->execute([$qty, $itemId, $id]);
            }

            if (!empty($idsMantidos)) {
                $in = implode(',', array_map('intval', $idsMantidos));
                $pdo->exec("DELETE FROM order_items WHERE order_id = $id AND id NOT IN ($in)");
            } else {
                $pdo->exec("DELETE FROM order_items WHERE order_id = $id");
            }

            echo json_encode(['success' => true, 'message' => 'Pedido atualizado com sucesso!']);
            break;



case 'test_error':
    // Força uma exceção proposital
    throw new Exception("Erro de teste gerado propositalmente para validar o ErrorHandler.");

    
        default:
            http_response_code(404);
            echo json_encode(['success' => false, 'message' => 'Endpoint não encontrado.']);
    }

} catch (Throwable $e) {
    logError("[API] " . $e->getMessage());
    http_response_code(500);
    echo json_encode(['success' => false, 'message' => 'Erro interno na API.']);
}
