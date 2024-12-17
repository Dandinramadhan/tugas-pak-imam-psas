import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'api.dart';
import 'edit_buku.dart';
import 'mitems.dart';

class DetailBuku extends StatefulWidget {
  final ItemModel sw;

  DetailBuku({required this.sw});

  @override
  State<StatefulWidget> createState() => DetailBukuState();
}

class DetailBukuState extends State<DetailBuku> {
  void deleteProduk(context) async {
    http.Response response = await http.post(
        Uri.parse(BaseUrl.Delete),
        body: {
          'id': widget.sw.id.toString(),
        });
    final data = json.decode(response.body);
    if (data['success']) {
      _showToast("Data berhasil dihapus");
      Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
    }
  }

  void _showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,

        fontSize: 16.0);
  }

  void confirmDelete(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: Text(
            "Konfirmasi",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.orange),
          ),
          content: Text('Apakah Anda yakin ingin menghapus data ini?',
              style: TextStyle(fontSize: 16, color: Colors.black54)),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Batal"),
              style: TextButton.styleFrom(foregroundColor: Colors.black54),
            ),
            ElevatedButton(
              onPressed: () => deleteProduk(context),
              child: Text("Hapus"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Detail Produk",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.orangeAccent,
        elevation: 5,
        actions: [
          IconButton(
            onPressed: () => confirmDelete(context),
            icon: Icon(Icons.delete),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailRow(Icons.code, 'ID:', widget.sw.id.toString()),
                _buildDetailRow(Icons.title, 'Judul:', widget.sw.judul),
                _buildDetailRow(Icons.person, 'Pengarang:', widget.sw.pengarang),
                _buildDetailRow(Icons.book, 'Penerbit:', widget.sw.penerbit),
                _buildDetailRow(Icons.category, 'Kategori:', widget.sw.kategori),
                _buildDetailRow(Icons.description, 'Sinopsis:', widget.sw.sinopsis),
                _buildDetailRow(Icons.calendar_today, 'Tahun:', "${widget.sw.tahun_terbit}"),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) => EditBuku(sw: widget.sw)),
        ),
        child: Icon(Icons.edit, color: Colors.white),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.orange.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 24, color: Colors.orange),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              '$label $value',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
