import 'package:flutter/material.dart';
import '../models/kontak.dart';

class TambahKontakPage extends StatefulWidget {
  // Jika kontakLama diisi, halaman ini berfungsi sebagai form EDIT
  // (form akan terisi otomatis dengan data lama). Jika null, berarti mode TAMBAH.
  final Kontak? kontakLama;

  const TambahKontakPage({super.key, this.kontakLama});

  bool get isEdit => kontakLama != null;

  @override
  State<TambahKontakPage> createState() => _TambahKontakPageState();
}

class _TambahKontakPageState extends State<TambahKontakPage> {
  // Key untuk mengakses & memvalidasi state Form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Controller untuk masing-masing form input
  late final TextEditingController namaController;
  late final TextEditingController emailController;
  late final TextEditingController noHpController;
  late final TextEditingController kategoriController;

  @override
  void initState() {
    super.initState();
    // Jika mode edit, isi controller dengan data kontak yang sudah ada.
    // Jika mode tambah, controller dimulai kosong.
    final kontakLama = widget.kontakLama;
    namaController = TextEditingController(text: kontakLama?.nama ?? '');
    emailController = TextEditingController(text: kontakLama?.email ?? '');
    noHpController = TextEditingController(text: kontakLama?.noHp ?? '');
    kategoriController = TextEditingController(text: kontakLama?.kategori ?? '');
  }

  @override
  void dispose() {
    namaController.dispose();
    emailController.dispose();
    noHpController.dispose();
    kategoriController.dispose();
    super.dispose();
  }

  void _simpanKontak() {
    // Validasi form terlebih dahulu, kontak hanya disimpan jika valid
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final kategoriText = kategoriController.text.trim();

    final kontakBaru = Kontak(
      nama: namaController.text,
      email: emailController.text,
      noHp: noHpController.text,
      // Kategori bersifat opsional: jika kosong, simpan sebagai null
      kategori: kategoriText.isEmpty ? null : kategoriText,
    );

    // Kembali ke halaman sebelumnya sambil mengirim data kontak
    // (baru jika mode tambah, atau hasil perubahan jika mode edit)
    Navigator.pop(context, kontakBaru);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEdit ? 'Edit Kontak' : 'Tambah Kontak'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              // ---------- FORM INPUT dengan Validasi ----------
              TextFormField(
                controller: namaController,
                decoration: const InputDecoration(
                  labelText: 'Nama Lengkap',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nama lengkap wajib diisi';
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
                    return 'Email harus mengandung karakter @';
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
                  final hanyaAngka = RegExp(r'^[0-9]+$');
                  if (!hanyaAngka.hasMatch(value.trim())) {
                    return 'Nomor handphone hanya boleh berisi angka';
                  }
                  if (value.trim().length < 10) {
                    return 'Nomor handphone minimal 10 digit';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              // Input kategori (opsional, boleh dikosongkan, tanpa validator)
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
                  label: Text(widget.isEdit ? 'Simpan Perubahan' : 'Simpan'),
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
