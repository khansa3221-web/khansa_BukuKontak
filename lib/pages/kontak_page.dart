import 'package:flutter/material.dart';
import '../models/kontak.dart';

class KontakPage extends StatelessWidget {
  final List<Kontak> daftarKontak;
  final TextEditingController searchController;
  final ValueChanged<String> onSearchChanged;
  final Stream<String> searchStream;
  final ValueChanged<Kontak> onEdit;
  final ValueChanged<Kontak> onDelete;

  const KontakPage({
    super.key,
    required this.daftarKontak,
    required this.searchController,
    required this.onSearchChanged,
    required this.searchStream,
    required this.onEdit,
    required this.onDelete,
  });

  // Dialog konfirmasi sebelum menghapus kontak.
  // Menerima objek `kontak` yang SAMA (referensi) dengan yang ditampilkan di
  // daftar hasil pencarian, sehingga kontak yang dihapus selalu tepat sasaran
  // walau daftar sedang dalam kondisi terfilter.
  Future<void> _konfirmasiHapus(BuildContext context, Kontak kontak) async {
    final konfirmasi = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Hapus Kontak'),
          content: Text('Apakah kamu yakin ingin menghapus "${kontak.nama}" dari daftar kontak?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );

    if (konfirmasi == true) {
      onDelete(kontak);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ---------- Pencarian Kontak Real-time ----------
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: TextField(
            controller: searchController,
            onChanged: onSearchChanged,
            decoration: const InputDecoration(
              labelText: 'Cari kontak (nama/kategori)',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Expanded(
          child: StreamBuilder<String>(
            stream: searchStream,
            initialData: '',
            builder: (context, snapshot) {
              final kataKunci = (snapshot.data ?? '').toLowerCase();

              final hasilFilter = kataKunci.isEmpty
                  ? daftarKontak
                  : daftarKontak.where((k) {
                      final nama = k.nama.toLowerCase();
                      final kategori = (k.kategori ?? '').toLowerCase();
                      return nama.contains(kataKunci) ||
                          kategori.contains(kataKunci);
                    }).toList();

              if (hasilFilter.isEmpty) {
                return Center(
                  child: Text(
                    daftarKontak.isEmpty
                        ? 'Belum ada kontak tersimpan.\nTekan tombol + untuk menambah kontak.'
                        : 'Kontak tidak ditemukan.',
                    textAlign: TextAlign.center,
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: hasilFilter.length,
                itemBuilder: (context, index) {
                  // `kontak` adalah objek yang sama persis (reference) dengan
                  // yang ada di daftarKontak utama, baik saat difilter maupun tidak.
                  // Ini memastikan Edit/Delete selalu mengenai kontak yang benar.
                  final kontak = hasilFilter[index];
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
                        '${kontak.email}\n${kontak.noHp}\n${kontak.kategori ?? 'Tanpa kategori'}',
                      ),
                      isThreeLine: true,
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            tooltip: 'Edit',
                            onPressed: () => onEdit(kontak),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            tooltip: 'Hapus',
                            onPressed: () => _konfirmasiHapus(context, kontak),
                          ),
                        ],
                      ),
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
