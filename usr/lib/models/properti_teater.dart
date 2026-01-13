import 'item.dart';

// Inheritance: PropertiTeater mewarisi sifat dari class Item
class PropertiTeater extends Item {
  // Encapsulation: Private variable khusus untuk child class
  String _jenis; // Contoh: Kostum, Lighting, Sound, Dekorasi
  String _kondisi; // Contoh: Baik, Rusak, Perlu Perbaikan

  // Constructor menggunakan super untuk memanggil constructor parent
  PropertiTeater(
    String id, 
    String nama, 
    int jumlah, 
    this._jenis, 
    this._kondisi
  ) : super(id, nama, jumlah);

  // Getters
  String get jenis => _jenis;
  String get kondisi => _kondisi;

  // Setters
  set jenis(String value) {
    _jenis = value;
  }

  set kondisi(String value) {
    _kondisi = value;
  }
}
