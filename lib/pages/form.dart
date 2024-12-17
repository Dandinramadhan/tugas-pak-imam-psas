import 'package:flutter/material.dart';

// Enum for Category
enum Category { Fiction, Science, History, Fantasy, Horor  }

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

class AppForm extends StatelessWidget {
  final GlobalKey<FormState> formkey;
  final TextEditingController judulController;
  final TextEditingController pengarangController;
  final TextEditingController penerbitController;
  final TextEditingController sinopsisController;
  final TextEditingController tahun_terbitController;
  final Category selectedCategory;
  final ValueChanged<Category> onCategoryChanged;

  AppForm({
    required this.formkey,
    required this.judulController,
    required this.pengarangController,
    required this.penerbitController,
    required this.sinopsisController,
    required this.tahun_terbitController,
    required this.selectedCategory,
    required this.onCategoryChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      autovalidateMode: AutovalidateMode.always,
      child: SingleChildScrollView(
        child: Column(
          children: [
            judul(),
            pengarang(),
            penerbit(),
            kategori(),
            sinopsis(),
            tahun_terbit(),
          ],
        ),
      ),
    );
  }

  Widget judul() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: TextFormField(
        controller: judulController,
        decoration: InputDecoration(
          labelText: "Judul",
          labelStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
          prefixIcon: Icon(Icons.book, color: Colors.blue),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Masukan Judul';
          }
          return null;
        },
      ),
    );
  }

  Widget pengarang() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: TextFormField(
        controller: pengarangController,
        decoration: InputDecoration(
          labelText: "Pengarang",
          labelStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
          prefixIcon: Icon(Icons.person, color: Colors.blue),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Masukkan Pengarang';
          }
          return null;
        },
      ),
    );
  }

  Widget penerbit() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: TextFormField(
        controller: penerbitController,
        decoration: InputDecoration(
          labelText: "Penerbit",
          labelStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
          prefixIcon: Icon(Icons.business, color: Colors.blue),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Masukkan Penerbit';
          }
          return null;
        },
      ),
    );
  }

  Widget kategori() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: DropdownButtonFormField<Category>(
        value: selectedCategory,
        onChanged: (Category? newCategory) {
          if (newCategory != null) {
            onCategoryChanged(newCategory);
          }
        },
        items: Category.values
            .map((Category category) => DropdownMenuItem<Category>(
                  value: category,
                  child: Text(
                    category.name,
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                ))
            .toList(),
        decoration: InputDecoration(
          labelText: "Kategori",
          labelStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
          prefixIcon: Icon(Icons.category, color: Colors.blue),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
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

  Widget sinopsis() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: TextFormField(
        controller: sinopsisController,
        decoration: InputDecoration(
          labelText: "Sinopsis",
          labelStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
          prefixIcon: Icon(Icons.description, color: Colors.blue),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Masukkan Sinopsis!';
          }
          return null;
        },
      ),
    );
  }

  Widget tahun_terbit() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: TextFormField(
        controller: tahun_terbitController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: "Tahun Terbit",
          labelStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
          prefixIcon: Icon(Icons.calendar_today, color: Colors.blue),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Masukkan Tahun Terbit!';
          }
          return null;
        },
      ),
    );
  }
}
