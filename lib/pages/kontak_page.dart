import 'package:flutter/material.dart';
import '../models/kontak.dart';

class KontakPage extends StatelessWidget {
  final List<Kontak> daftarKontak;

  const KontakPage({super.key, required this.daftarKontak});

  @override
  Widget build(BuildContext context) {
    if (daftarKontak.isEmpty) {
      return const Center(
        child: Text(
          'Belum ada kontak tersimpan.\nTekan tombol + untuk menambah kontak.',
          textAlign: TextAlign.center,
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: daftarKontak.length,
      itemBuilder: (context, index) {
        final kontak = daftarKontak[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: CircleAvatar(
              child: Text(
                kontak.nama.isNotEmpty ? kontak.nama[0].toUpperCase() : '?',
              ),
            ),
            title: Text(
              kontak.nama,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('${kontak.email}\n${kontak.noHp}'),
            isThreeLine: true,
          ),
        );
      },
    );
  }
}
