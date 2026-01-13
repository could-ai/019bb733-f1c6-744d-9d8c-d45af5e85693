import 'package:flutter/material.dart';
import '../models/properti_teater.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  // Local State: List untuk menyimpan data di memori
  final List<PropertiTeater> _inventoryList = [];

  // Controllers untuk Form
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _jumlahController = TextEditingController();
  final TextEditingController _jenisController = TextEditingController();
  final TextEditingController _kondisiController = TextEditingController();

  // Helper untuk membersihkan form
  void _clearForm() {
    _namaController.clear();
    _jumlahController.clear();
    _jenisController.clear();
    _kondisiController.clear();
  }

  // CREATE: Menambah data baru
  void _addItem() {
    if (_namaController.text.isEmpty || _jumlahController.text.isEmpty) return;

    setState(() {
      _inventoryList.add(PropertiTeater(
        DateTime.now().millisecondsSinceEpoch.toString(), // Generate ID unik sederhana
        _namaController.text,
        int.tryParse(_jumlahController.text) ?? 0,
        _jenisController.text,
        _kondisiController.text,
      ));
    });
    _clearForm();
    Navigator.of(context).pop(); // Tutup dialog
  }

  // UPDATE: Mengedit data yang ada
  void _editItem(PropertiTeater item, int index) {
    // Update data melalui setter (Encapsulation)
    setState(() {
      item.nama = _namaController.text;
      item.jumlah = int.tryParse(_jumlahController.text) ?? 0;
      item.jenis = _jenisController.text;
      item.kondisi = _kondisiController.text;
      
      // Karena object reference, list otomatis terupdate, tapi setState memicu rebuild UI
    });
    _clearForm();
    Navigator.of(context).pop();
  }

  // DELETE: Menghapus data
  void _deleteItem(int index) {
    setState(() {
      _inventoryList.removeAt(index);
    });
  }

  // Menampilkan Dialog Form (bisa untuk Tambah atau Edit)
  void _showFormDialog({PropertiTeater? item, int? index}) {
    bool isEdit = item != null;
    
    // Jika Edit, isi form dengan data lama
    if (isEdit) {
      _namaController.text = item.nama;
      _jumlahController.text = item.jumlah.toString();
      _jenisController.text = item.jenis;
      _kondisiController.text = item.kondisi;
    } else {
      _clearForm();
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(isEdit ? 'Edit Properti' : 'Tambah Properti'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _namaController,
                  decoration: const InputDecoration(labelText: 'Nama Properti'),
                ),
                TextField(
                  controller: _jumlahController,
                  decoration: const InputDecoration(labelText: 'Jumlah'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: _jenisController,
                  decoration: const InputDecoration(labelText: 'Jenis (ex: Kostum, Lighting)'),
                ),
                TextField(
                  controller: _kondisiController,
                  decoration: const InputDecoration(labelText: 'Kondisi (ex: Baik, Rusak)'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                _clearForm();
                Navigator.of(context).pop();
              },
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                if (isEdit) {
                  _editItem(item, index!);
                } else {
                  _addItem();
                }
              },
              child: Text(isEdit ? 'Simpan' : 'Tambah'),
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
        title: const Text('Manajemen Inventaris Teater'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      // READ: Menampilkan List Data
      body: _inventoryList.isEmpty
          ? const Center(child: Text('Belum ada data inventaris'))
          : ListView.builder(
              itemCount: _inventoryList.length,
              itemBuilder: (context, index) {
                final item = _inventoryList[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(item.nama[0].toUpperCase()),
                    ),
                    title: Text(item.nama),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Jumlah: ${item.jumlah} | Jenis: ${item.jenis}'),
                        Text('Kondisi: ${item.kondisi}', 
                             style: TextStyle(
                               color: item.kondisi.toLowerCase().contains('rusak') 
                                      ? Colors.red 
                                      : Colors.green
                             )),
                      ],
                    ),
                    isThreeLine: true,
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Tombol Edit
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => _showFormDialog(item: item, index: index),
                        ),
                        // Tombol Hapus
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteItem(index),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showFormDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
