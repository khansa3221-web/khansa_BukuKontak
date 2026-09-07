// Model data satu kontak: nama, email, no HP, kategori (opsional)
class Kontak {
  final String nama;
  final String email;
  final String noHp;
  final String? kategori; // Nullable: tidak semua kontak wajib punya kategori

  Kontak({
    required this.nama,
    required this.email,
    required this.noHp,
    this.kategori, // Opsional, tidak wajib diisi saat membuat objek Kontak
  });
}