import 'package:flutter/material.dart';
import 'detail_buku.dart';
import 'tambah_buku.dart';
import 'api.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'mitems.dart';

class PageBuku extends StatefulWidget {
  @override
  PageBuku({Key? key}) : super(key: key);
  State<StatefulWidget> createState() {
    return PageBukuState();
  }
}

class PageBukuState extends State<PageBuku> {
  late Future<List<ItemModel>> itemsFuture;

  @override
  void initState() {
    super.initState();
    itemsFuture = fetchItems();
  }

  // Function to fetch data from API
  Future<List<ItemModel>> fetchItems() async {
    try {
      final response = await http.get(Uri.parse(BaseUrl.List));
      if (response.statusCode == 200) {
        final items = json.decode(response.body).cast<Map<String, dynamic>>();
        return items.map<ItemModel>((json) => ItemModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ruang Buku",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
        centerTitle: true,
        backgroundColor: Colors.orangeAccent,
        elevation: 4,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orange.shade50, Colors.orange.shade200],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: FutureBuilder<List<ItemModel>>(
          future: itemsFuture,
          builder: (BuildContext context, AsyncSnapshot<List<ItemModel>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return _loadingWidget();
            } else if (snapshot.hasError) {
              return _errorWidget(snapshot.error.toString());
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return _emptyWidget();
            } else {
              return _itemsList(snapshot.data!);
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ProdukTambah()));
        },
        backgroundColor: Colors.orangeAccent,
        child: Icon(Icons.add, size: 28, color: Colors.white),
      ),
    );
  }

  // Loading widget
  Widget _loadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: Colors.orangeAccent),
          SizedBox(height: 16),
          Text("Loading items...",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  // Error widget
  Widget _errorWidget(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error, color: Colors.redAccent, size: 60),
          SizedBox(height: 16),
          Text(
            "Error: $error",
            style: TextStyle(fontSize: 18, color: Colors.redAccent),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // Empty widget
  Widget _emptyWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inbox, size: 60, color: Colors.grey),
          SizedBox(height: 16),
          Text("No items found",
              style: TextStyle(fontSize: 18, color: Colors.grey)),
        ],
      ),
    );
  }

  // Items list
  Widget _itemsList(List<ItemModel> items) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Card(
          margin: EdgeInsets.symmetric(vertical: 8),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.orangeAccent,
              child: Icon(Icons.book, color: Colors.white),
            ),
            title: Text(
              item.judul,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              "Tahun: ${item.tahun_terbit} \nPengarang: ${item.pengarang}",
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.orangeAccent),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DetailBuku(sw: item)),
              );
            },
          ),
        );
      },
    );
  }
}
