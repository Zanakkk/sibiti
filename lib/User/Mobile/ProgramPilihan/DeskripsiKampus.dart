// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sibiti/User/Mobile/ProgramPilihan/ProgramPilihan.dart';

class DeskripsiKampus extends StatelessWidget {
  final Ujian ujian;

  const DeskripsiKampus({super.key, required this.ujian});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ujian.namaUjian),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              ujian.gambarKampus,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width * 0.5,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            const Text(
              'Deskripsi:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              ujian.deskripsiUjian,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
