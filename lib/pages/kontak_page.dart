
import 'dart:async';
import 'package:flutter/material.dart';
import '../models/kontak.dart';

class KontakPage extends StatefulWidget {
  final List<Kontak> daftarKontak;

  const KontakPage({super.key, required this.daftarKontak});

  @override
  State<KontakPage> createState() => _KontakPageState();
}

class _KontakPageState extends State<KontakPage> {
  final StreamController<String> _searchController = StreamController<String>();
  final TextEditingController _searchTextController = TextEditingController();

  @override
  void dispose() {
    _searchController.close();
    _searchTextController.dispose();
    super.dispose();
  }

  List<Kontak> _filterKontak(String keyword) {
    if (keyword.isEmpty) return widget.daftarKontak;
    final lowerKeyword = keyword.toLowerCase();
    return widget.daftarKontak.where((kontak) {
      final namaMatch = kontak.nama.toLowerCase().contains(lowerKeyword);
      final kategoriMatch =
          (kontak.kategori ?? '').toLowerCase().contains(lowerKeyword);
      return namaMatch || kategoriMatch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: TextField(
            controller: _searchTextController,
            decoration: const InputDecoration(
              labelText: 'Cari nama atau kategori...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            onChanged: (teks) {
              _searchController.add(teks);
            },
          ),
        ),
        Expanded(
          child: StreamBuilder<String>(
            stream: _searchController.stream,
            initialData: '',
            builder: (context, snapshot) {
              final keyword = snapshot.data ?? '';
              final hasilPencarian = _filterKontak(keyword);

              if (widget.daftarKontak.isEmpty) {
                return const Center(
                  child: Text(
                    'Belum ada kontak tersimpan.\nTekan tombol + untuk menambah kontak.',
                    textAlign: TextAlign.center,
                  ),
                );
              }

              if (hasilPencarian.isEmpty) {
                return const Center(
                  child: Text('Kontak tidak ditemukan.'),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: hasilPencarian.length,
                itemBuilder: (context, index) {
                  final kontak = hasilPencarian[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(
                          kontak.nama.isNotEmpty
                              ? kontak.nama[0].toUpperCase()
                              : '?',
                        ),
                      ),
                      title: Text(
                        kontak.nama,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        '${kontak.email}\n${kontak.noHp}\nKategori: ${kontak.kategori ?? 'Tanpa kategori'}',
                      ),
                      isThreeLine: true,
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
