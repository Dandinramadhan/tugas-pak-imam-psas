class ItemModel {
  final int id;
  final String judul;
  final String pengarang;
  final String penerbit;
  final String kategori;
  final String sinopsis;
  final String tahun_terbit;

  ItemModel({
    required this.id,
    required this.judul,
    required this.pengarang,
    required this.penerbit,
    required this.kategori,
    required this.sinopsis,
    required this.tahun_terbit,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      id: json['id'] ?? 0,
      judul: json['judul'] ?? '',
      pengarang: json['pengarang'] ?? '',
      penerbit: json['penerbit'] ?? '',
      kategori: json['kategori'] ?? '',
      sinopsis: json['sinopsis'] ?? '',
      tahun_terbit: json['tahun_terbit'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'judul': judul,
    'pengarang': pengarang,
    'penerbit': penerbit,
    'kategori': kategori,
    'sinopsis': sinopsis,
    'tahun_terbit': tahun_terbit,

  };
}
