import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'api.dart';
import 'package:http/http.dart' as http;
import 'mitems.dart';
import 'form.dart';

class EditBuku extends StatefulWidget {
  final ItemModel sw;

  const EditBuku({required this.sw, Key? key}) : super(key: key);

  @override
  State<EditBuku> createState() => _EditBukuState();
}

class _EditBukuState extends State<EditBuku> {
  final formKey = GlobalKey<FormState>();

  late TextEditingController judulController;
  late TextEditingController pengarangController;
  late TextEditingController penerbitController;
  late TextEditingController sinopsisController;
  late TextEditingController tahunTerbitController;
  late Category selectedCategory;

  @override
  void initState() {
    super.initState();

    judulController = TextEditingController(text: widget.sw.judul);
    pengarangController = TextEditingController(text: widget.sw.pengarang);
    penerbitController = TextEditingController(text: widget.sw.penerbit);
    sinopsisController = TextEditingController(text: widget.sw.sinopsis);
    tahunTerbitController = TextEditingController(text: widget.sw.tahun_terbit.toString());

    selectedCategory = Category.values.firstWhere(
          (e) => e.name == widget.sw.kategori,
      orElse: () => Category.History,
    );
  }

  Future<void> editSw() async {
    try {
      final response = await http.post(
        Uri.parse(BaseUrl.Edit),
        body: {
          "id": widget.sw.id.toString(),
          "judul": judulController.text,
          "pengarang": pengarangController.text,
          "penerbit": penerbitController.text,
          "kategori": selectedCategory.name,
          "sinopsis": sinopsisController.text,
          "tahun_terbit": tahunTerbitController.text,
        },
      );

      final data = json.decode(response.body);

      if (data['success']) {
        _showSuccessToast();
        Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
      } else {
        _showErrorToast("Gagal memperbarui data.");
      }
    } catch (e) {
      _showErrorToast("Terjadi kesalahan: $e");
    }
  }

  void _showSuccessToast() {
    Fluttertoast.showToast(
      msg: "Perubahan data berhasil",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  void _showErrorToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  void _onConfirm(BuildContext context) async {
    if (formKey.currentState?.validate() ?? false) {
      await editSw();
    } else {
      _showErrorToast("Harap lengkapi semua data.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      bottomNavigationBar: _buildBottomNavigationBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
        "Edit Buku",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ),
      ),
      centerTitle: true,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepOrange, Colors.orangeAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
      elevation: 5.0,
    );
  }

  Padding _buildBottomNavigationBar() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ElevatedButton(
        onPressed: () => _onConfirm(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepOrange,
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        child: const Text("Simpan Perubahan", style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Colors.orange.shade50],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFormCard(),
            const SizedBox(height: 20),
            _buildInstructionText(),
          ],
        ),
      ),
    );
  }



  Card _buildFormCard() {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      shadowColor: Colors.deepOrange,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: AppForm(
          formkey: formKey,
          judulController: judulController,
          pengarangController: pengarangController,
          penerbitController: penerbitController,
          sinopsisController: sinopsisController,
          tahun_terbitController: tahunTerbitController,
          selectedCategory: selectedCategory,
          onCategoryChanged: (Category newCategory) {
            setState(() {
              selectedCategory = newCategory;
            });
          },
        ),
      ),
    );
  }



  Center _buildInstructionText() {
    return Center(
      child: Text(
        "Pastikan semua data benar sebelum menyimpan.",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16,
          color: Colors.grey[800],
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}