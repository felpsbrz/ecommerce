<?php
require_once __DIR__ . '/UserController.php';
require_once __DIR__ . '/../models/Client.php';
require_once __DIR__ . '/../core/core.php';

class AuthController {
    private $user;
    private $client;

    public function __construct() {
        $this->user = new UserController();
        $this->client = new Client();

  
        if (session_status() === PHP_SESSION_NONE) {
            session_start();
        }
    }


    public function login($username, $password) {
        if (!$username || !$password) {
            Response::error("Preencha usuário e senha.");
        }

        $user = $this->user->findByUsername($username);

        if (!$user || !password_verify($password, $user['password'])) {
            Response::error("Usuário ou senha inválidos.");
        }


        $_SESSION['user'] = [
            'id' => $user['id'],
            'username' => $user['username'],
            'name' => $user['fullname'],
            'role' => $user['role']
        ];

      
        $redirect = ($user['role'] === 'admin') ? 'painel.php' : 'index.php';

        Response::success("Login realizado com sucesso!", ['redirect' => $redirect]);
    }


    public function register($username, $password, $extra = []) {
        if (!$username || !$password) {
            Response::error("Preencha usuário e senha.");
        }

        if ($this->user->findByUsername($username)) {
            Response::error("Usuário já existe.");
        }

    
        $userId = $this->user->create($username, $password, $extra);

    
        $this->client->create(
            $userId,
            $extra['phone'] ?? '',
            $extra['address_c'] ?? '',
            $extra['number_address'] ?? '',
            $extra['email'] ?? ''
        );

       
        $_SESSION['user'] = [
            'id' => $userId,
            'username' => $username,
            'name' => $extra['fullname'] ?? '',
            'role' => 'user'
        ];

        Response::success("Usuário cadastrado com sucesso!", ['redirect' => 'index.php']);
    }
}
