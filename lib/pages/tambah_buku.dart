import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'api.dart';
import 'package:http/http.dart' as http;

// Enum for Category
enum Category { Fiction, Science, History, Fantasy, Horor }

extension CategoryExtension on Category {
  String get name {
    switch (this) {
      case Category.Fiction:
        return 'Fiction';
      case Category.Science:
        return 'Science';
      case Category.History:
        return 'History';
      case Category.Fantasy:
        return 'Fantasy';
      case Category.Horor:
        return 'Horor';
      default:
        return '';
    }
  }
}

class ProdukTambah extends StatefulWidget {
  const ProdukTambah({super.key});

  @override
  State<StatefulWidget> createState() => ProdukTambahState();
}

class ProdukTambahState extends State<ProdukTambah> {
  final formkey = GlobalKey<FormState>();
  TextEditingController judulController = TextEditingController();
  TextEditingController pengarangController = TextEditingController();
  TextEditingController penerbitController = TextEditingController();
  TextEditingController sinopsisController = TextEditingController();
  TextEditingController tahun_terbitController = TextEditingController();

  Category? selectedCategory = Category.History; // Default category selection

  // Create a function to send data to the API
  Future createSw() async {
    return await http.post(
      Uri.parse(BaseUrl.Insert),
      body: {
        'judul': judulController.text,
        'pengarang': pengarangController.text,
        'penerbit': penerbitController.text,
        'kategori': selectedCategory!.name,  // Send the category name
        'sinopsis': sinopsisController.text,
        'tahun_terbit': tahun_terbitController.text,
      },
    );
  }

  void _onConfirm(context) async {
    if (formkey.currentState!.validate()) {
      http.Response response = await createSw();
      final data = json.decode(response.body);
      if (data['success']) {
        Fluttertoast.showToast(
          msg: "Data berhasil ditambahkan",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
      } else {
        Fluttertoast.showToast(
          msg: "Terjadi kesalahan, coba lagi.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Tambah Data Barang",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.orange, Colors.deepOrange],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 8.0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orange[50]!, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(  // Wrap inputs in a Form widget
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInputField("Judul", Icons.title, judulController),
                _buildInputField("Pengarang", Icons.person, pengarangController),
                _buildInputField("Penerbit", Icons.business, penerbitController),
                _buildCategoryDropdown(), // Category dropdown here
                _buildInputField("Sinopsis", Icons.description, sinopsisController, maxLines: 3),
                _buildInputField("Tahun Terbit", Icons.calendar_today, tahun_terbitController, keyboardType: TextInputType.number),
                const SizedBox(height: 20.0),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      _onConfirm(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
                      textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text("Tambah", style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // New method to build the category dropdown
  Widget _buildCategoryDropdown() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: DropdownButtonFormField<Category>(
        value: selectedCategory,
        onChanged: (Category? newCategory) {
          setState(() {
            selectedCategory = newCategory; // Update the selected category
          });
        },
        items: Category.values
            .map((Category category) => DropdownMenuItem<Category>(
          value: category,
          child: Text(category.name),
        ))
            .toList(),
        decoration: InputDecoration(
          labelText: "Kategori",
          prefixIcon: Icon(Icons.category),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        ),
        validator: (value) {
          if (value == null) {
            return 'Pilih Kategori!';
          }
          return null;
        },
      ),
    );
  }

  // Reused input field method
  Widget _buildInputField(String label, IconData icon, TextEditingController controller, {int maxLines = 1, TextInputType keyboardType = TextInputType.text}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        ),
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '$label tidak boleh kosong';
          }
          return null;
        },
      ),
    );
  }
}
