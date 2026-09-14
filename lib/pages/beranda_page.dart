import 'dart:async';
import 'package:flutter/material.dart';
import '../models/kontak.dart';
import 'kontak_page.dart';
import 'favorit_page.dart';
import 'tambah_kontak_page.dart';
import 'tentang_page.dart';

class BerandaPage extends StatefulWidget {
  const BerandaPage({super.key});

  @override
  State<BerandaPage> createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  // List untuk menyimpan semua kontak yang sudah ditambahkan
  final List<Kontak> daftarKontak = [];

  // StreamController untuk pencarian kontak secara real-time
  final StreamController<String> _searchController = StreamController<String>.broadcast();
  final TextEditingController _searchTextController = TextEditingController();

  void _onSearchChanged(String teks) {
    _searchController.add(teks);
  }

  @override
  void dispose() {
    _searchController.close(); // supaya tidak terjadi memory leak
    _searchTextController.dispose();
    super.dispose();
  }

  Future<void> _bukaTambahKontak() async {
    final hasil = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const TambahKontakPage()),
    );

    if (hasil != null && hasil is Kontak) {
      setState(() {
        daftarKontak.add(hasil);
      });
    }
  }

  Future<void> _bukaEditKontak(Kontak kontakLama) async {
    final hasil = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TambahKontakPage(kontakLama: kontakLama),
      ),
    );

    if (hasil != null && hasil is Kontak) {
      setState(() {
        // Cari kontak lama berdasarkan referensi objeknya (bukan index list
        // hasil filter pencarian), supaya kontak yang benar yang diperbarui
        // walaupun sedang dalam kondisi terfilter oleh pencarian.
        final index = daftarKontak.indexOf(kontakLama);
        if (index != -1) {
          daftarKontak[index] = hasil;
        }
      });
    }
  }

  void _hapusKontak(Kontak kontak) {
    setState(() {
      // Hapus berdasarkan referensi objek yang sama persis dengan yang
      // dipilih user, baik dari daftar penuh maupun dari hasil pencarian.
      daftarKontak.remove(kontak);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Buku Kontak'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.contacts), text: 'Kontak'),
              Tab(icon: Icon(Icons.star), text: 'Favorit'),
            ],
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(color: Colors.blue),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    CircleAvatar(
                      radius: 28,
                      child: Icon(Icons.person, size: 32),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Buku Kontak',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.contacts),
                title: const Text('Kontak'),
                onTap: () {
                  Navigator.pop(context);
                  DefaultTabController.of(context).animateTo(0);
                },
              ),
              ListTile(
                leading: const Icon(Icons.person_add),
                title: const Text('Tambah Kontak'),
                onTap: () {
                  Navigator.pop(context);
                  _bukaTambahKontak();
                },
              ),
              ListTile(
                leading: const Icon(Icons.star),
                title: const Text('Favorit'),
                onTap: () {
                  Navigator.pop(context);
                  DefaultTabController.of(context).animateTo(1);
                },
              ),
              ListTile(
                leading: const Icon(Icons.info),
                title: const Text('Tentang'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const TentangPage()),
                  );
                },
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            KontakPage(
              daftarKontak: daftarKontak,
              searchController: _searchTextController,
              onSearchChanged: _onSearchChanged,
              searchStream: _searchController.stream,
              onEdit: _bukaEditKontak,
              onDelete: _hapusKontak,
            ),
            const FavoritPage(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _bukaTambahKontak,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
