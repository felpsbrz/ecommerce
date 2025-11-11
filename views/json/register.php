<?php
require_once __DIR__ . '/../../controllers/AuthController.php';

$data = json_decode(file_get_contents('php://input'), true);

$username = $data['username'] ?? '';
$password = $data['password'] ?? '';
$name     = $data['name'] ?? '';
$phone    = $data['phone'] ?? '';
$address  = $data['address_c'] ?? '';
$number   = $data['number_address'] ?? '';
$email    = $data['email'] ?? '';

$auth = new AuthController();
$auth->register($username, $password, [
    'name'    => $name,
    'phone'   => $phone,
    'address_c' => $address,
    'number_address'  => $number,
    'email'   => $email
]);
