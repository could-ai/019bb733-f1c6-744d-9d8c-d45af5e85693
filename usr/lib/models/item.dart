class Item {
  // Encapsulation: Private variables (dimulai dengan underscore)
  String _id;
  String _nama;
  int _jumlah;

  // Constructor
  Item(this._id, this._nama, this._jumlah);

  // Getters (untuk mengakses private variables)
  String get id => _id;
  String get nama => _nama;
  int get jumlah => _jumlah;

  // Setters (untuk mengubah private variables)
  set nama(String value) {
    _nama = value;
  }

  set jumlah(int value) {
    _jumlah = value;
  }
}
