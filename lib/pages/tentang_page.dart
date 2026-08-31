import 'package:flutter/material.dart';

class TentangPage extends StatelessWidget {
  const TentangPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tentang'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/images/foto_profil.jpeg'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Khansa Qurratu’ain', // TODO: ganti dengan nama kamu
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              'XII RPL B', // TODO: ganti dengan kelas kamu
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 10),
            const _InfoRow(icon: Icons.school, label: 'Sekolah', value: 'SMK NEGERI 5 SURAKARTA'),
            const _InfoRow(icon: Icons.email, label: 'Email', value: 'khansa3221@gmail.com'),
            const _InfoRow(icon: Icons.phone, label: 'No. HP', value: '085159009088'),
            const _InfoRow(icon: Icons.location_on, label: 'Alamat', value: 'soditan gumpang kartosuro'),
            const SizedBox(height: 20),
            const Text(
              'Aplikasi Buku Kontak ini dibuat sebagai tugas mata pelajaran '
              'Pemrograman Perangkat Bergerak dengan menerapkan Material '
              'Design, Navigasi, dan Routing menggunakan Flutter.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.blueGrey),
          const SizedBox(width: 10),
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.w600)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
