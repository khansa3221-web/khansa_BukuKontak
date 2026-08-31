import 'package:flutter/material.dart';

class FavoritPage extends StatelessWidget {
  const FavoritPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Ganti dengan data diri kamu sendiri
    const nama = 'Ardelia Anggun Saputri';
    const email = 'ardeliaanggun4@email.com';
    const noHp = '089523222026q';

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Card(
          child: ListTile(
            leading: const CircleAvatar(
              child: Icon(Icons.favorite),
            ),
            title: const Text(nama),
            subtitle: Text('$email\n$noHp'),
            isThreeLine: true,
          ),
        ),
      ),
    );
  }
}