# Buku Kontak — Tugas 1 (Navigasi & Routing)

Project ini adalah pengembangan dari `kontak_form` (tugas sebelumnya) dengan menambahkan
Material Design, Navigation Drawer, TabBar/TabBarView, FloatingActionButton, dan Navigasi/Routing
antar halaman, sesuai Lembar Kerja Murid.

## Struktur

```
lib/
 ├─ main.dart                  # entry point, MaterialApp
 ├─ models/
 │   └─ kontak.dart             # model data Kontak
 └─ pages/
     ├─ beranda_page.dart       # AppBar + Drawer + TabBar + TabBarView + FAB
     ├─ kontak_page.dart        # daftar kontak (tab 1)
     ├─ favorit_page.dart       # daftar favorit (tab 2) — "Belum ada kontak favorit."
     ├─ tambah_kontak_page.dart # form tambah kontak (reuse dari tugas sebelumnya)
     └─ tentang_page.dart       # profil diri
```

## Cara menjalankan

1. Ekstrak/salin folder ini sebagai project Flutter (pastikan `pubspec.yaml` ada di root).
2. Jalankan:
   ```
   flutter pub get
   flutter run
   ```
3. **Sebelum submit**, edit `lib/pages/tentang_page.dart` — ganti *Nama Lengkap*, *Kelas/Jurusan*,
   *Sekolah*, *Email*, *No. HP*, dan *Alamat* dengan data dirimu sendiri (sesuai tugas Pertemuan 2).

## Fitur yang sudah diimplementasikan (Tugas 1 LKM)

- [x] Halaman Beranda: AppBar, Navigation Drawer, TabBar, TabBarView, FloatingActionButton
- [x] FloatingActionButton di halaman Kontak → membuka Halaman Tambah Kontak
- [x] Navigation Drawer dengan menu: Kontak, Tambah Kontak, Favorit, Tentang
- [x] Halaman Tambah Kontak: form Nama, Email, No. HP + tombol Simpan → kembali ke halaman Kontak
- [x] Halaman Kontak: menampilkan daftar kontak (nama, email, no HP)
- [x] Halaman Favorit: "Belum ada kontak favorit."
- [x] Halaman Tentang: profil diri (isi datamu sendiri)

## Langkah selanjutnya (Tugas 2 & 3 — dikerjakan sendiri)

Tugas 2 (push ke GitHub pribadi) dan Tugas 3 (Fork–Clone–Commit–Push–Pull Request dengan
teman) harus dilakukan lewat akun GitHub-mu sendiri karena melibatkan identitas dan kerja sama
dengan pasangan. Ikuti panduan langkah demi langkah yang sudah diberikan terpisah.
