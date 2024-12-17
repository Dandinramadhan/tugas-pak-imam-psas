<?php
header('Content-Type: application/json');
include "../config/conn.php";


$judul = $_POST['judul'];
$pengarang = $_POST['pengarang'];
$penerbit = $_POST['penerbit'];
$kategori = $_POST['kategori'];
$sinopsis = $_POST['sinopsis'];
$tahun_terbit = $_POST['tahun_terbit'];

try {
    $stmt = $conn->prepare("INSERT INTO books (judul, pengarang, penerbit, kategori, sinopsis, tahun_terbit) 
                            VALUES (?, ?, ?, ?, ?, ?)");
    
    $result = $stmt->execute([$judul, $pengarang, $penerbit, $kategori, $sinopsis, $tahun_terbit]);

    echo json_encode([
        'success' => $result,
        'message' => $result ? 'Data berhasil disimpan.' : 'Gagal menyimpan data.'
    ]);
} catch (Exception $e) {
    echo json_encode([
        'success' => false,
        'message' => 'Terjadi kesalahan: ' . $e->getMessage()
    ]);
}
?>