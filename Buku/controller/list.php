<?php
header('Content-Type: application/json');
include "../config/conn.php";

$stmt = $conn->prepare("SELECT * FROM books");
$stmt->execute();
$result = $stmt->fetchAll(PDO::FETCH_ASSOC);

echo json_encode($result);
?>