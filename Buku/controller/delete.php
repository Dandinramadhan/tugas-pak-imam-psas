<?php
header('Content-Type: application/json');
include "../config/conn.php";

$id = (int) $_POST['id'];
$stmt = $conn->prepare("DELETE FROM books WHERE id = ?");
$result = $stmt->execute([$id]);

echo json_encode([
    'id' => $id,
    'success' => $result
]);
?>