<?php
header('Content-Type: application/json');
include "../config/conn.php";

$id = $_POST['id'];
$judul = $_POST['judul'];
$pengarang = $_POST['pengarang'];
$penerbit = $_POST['penerbit'];
$kategori = $_POST['kategori'];
$sinopsis = $_POST['sinopsis'];
$tahun_terbit = $_POST['tahun_terbit'];

try {

    $stmt = $conn->prepare("UPDATE books 
                            SET judul = ?, pengarang = ?, penerbit = ?, kategori = ?, sinopsis = ?, tahun_terbit = ? 
                            WHERE id = ?");
    

    $result = $stmt->execute([$judul, $pengarang, $penerbit, $kategori, $sinopsis, $tahun_terbit, $id]);


    echo json_encode([
        'success' => $result,
        'message' => $result ? 'Data berhasil diperbarui.' : 'Gagal memperbarui data.'
    ]);
} catch (Exception $e) {

    echo json_encode([
        'success' => false,
        'message' => 'Terjadi kesalahan: ' . $e->getMessage()
    ]);
}
?>