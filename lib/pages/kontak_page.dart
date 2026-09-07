import 'package:flutter/material.dart';
import '../models/kontak.dart';

class TambahKontakPage extends StatefulWidget {
  const TambahKontakPage({super.key});

  @override
  State<TambahKontakPage> createState() => _TambahKontakPageState();
}

class _TambahKontakPageState extends State<TambahKontakPage> {
  // TUGAS 5: Form key untuk mengontrol validasi seluruh form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Controller untuk masing-masing form input
  final TextEditingController namaController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController noHpController = TextEditingController();
  final TextEditingController kategoriController = TextEditingController();

  @override
  void dispose() {
    namaController.dispose();
    emailController.dispose();
    noHpController.dispose();
    kategoriController.dispose();
    super.dispose();
  }

  void _simpanKontak() {
    // TUGAS 5: validasi form terlebih dahulu sebelum menyimpan
    if (_formKey.currentState!.validate()) {
      // TUGAS 4: kategori bersifat opsional, kirim null jika kosong
      final kategoriText = kategoriController.text.trim();

      final kontakBaru = Kontak(
        nama: namaController.text,
        email: emailController.text,
        noHp: noHpController.text,
        kategori: kategoriText.isEmpty ? null : kategoriText,
      );

      // Kembali ke halaman Kontak sambil mengirim data kontak yang baru dibuat
      Navigator.pop(context, kontakBaru);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Kontak'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        // TUGAS 5: bungkus seluruh isi halaman dengan widget Form
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              // ---------- FORM INPUT ----------
              TextFormField(
                controller: namaController,
                decoration: const InputDecoration(
                  labelText: 'Nama Lengkap',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nama wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Email wajib diisi';
                  }
                  if (!value.contains('@')) {
                    return 'Format email tidak valid (harus mengandung @)';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: noHpController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Nomor Handphone',
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nomor handphone wajib diisi';
                  }
                  if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                    return 'Nomor handphone hanya boleh berisi angka';
                  }
                  if (value.length < 10) {
                    return 'Nomor handphone minimal 10 digit';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              // TUGAS 4: input kategori, opsional (boleh dikosongkan) - tanpa validator
              TextFormField(
                controller: kategoriController,
                decoration: const InputDecoration(
                  labelText: 'Kategori (Keluarga/Teman/Kerja) - opsional',
                  prefixIcon: Icon(Icons.category),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _simpanKontak,
                  icon: const Icon(Icons.save),
                  label: const Text('Simpan'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}