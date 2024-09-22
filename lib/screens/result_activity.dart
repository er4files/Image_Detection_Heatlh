import 'package:flutter/material.dart';
import 'dart:io';

class ResultActivity extends StatelessWidget {
  final File image;
  final String result;

  ResultActivity({required this.image, required this.result});

  @override
  Widget build(BuildContext context) {
    String motivationMessage;

    if (result.toLowerCase().contains('laki-laki')) {
      motivationMessage = 'Kamu adalah laki-laki, kamu harus punya tanggung jawab yang besar!';
    } else if (result.toLowerCase().contains('perempuan')) {
      motivationMessage = 'Kamu adalah perempuan, tetaplah kuat dan bersemangat menghadapi segala tantangan!';
    } else {
      motivationMessage = 'Hasil tidak dikenali, tetap semangat dan teruslah berkembang!';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Hasil Analisis', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.lightBlueAccent,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40),
            Text(
              'Hello Guys!',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
            ),
            Text(
              'Have a nice day.',
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 18,
              ),
            ),
            SizedBox(height: 40),
            Container(
              height: 400,
              decoration: BoxDecoration(
                color: Colors.pink[100],
                borderRadius: BorderRadius.circular(15),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.file(image, fit: BoxFit.cover),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                result, // This now includes the percentage
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Text(
                motivationMessage,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
