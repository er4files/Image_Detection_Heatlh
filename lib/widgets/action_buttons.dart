import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch, // Membuat tombol memenuhi lebar layar
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.redAccent,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16), // Tambahkan padding lebih besar
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          onPressed: () {
            // Aksi untuk tombol "Konsultasi"
          },
          child: Text(
            'Konsultasi Ke Dokter',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
        SizedBox(height: 16), // Jarak antara tombol
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
              side: BorderSide(color: Colors.redAccent),
            ),
          ),
          onPressed: () {
            // Aksi untuk tombol "Kembali"
            Navigator.pop(context);
          },
          child: Text(
            'Kembali ke Beranda',
            style: TextStyle(color: Colors.redAccent, fontSize: 16),
          ),
        ),
      ],
    );
  }
}
