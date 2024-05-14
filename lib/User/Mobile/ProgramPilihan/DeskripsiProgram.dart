// ignore_for_file: file_names

import 'package:flutter/material.dart';

import 'ProgramPilihan.dart';

class DeskripsiProgram extends StatelessWidget {
  final ProgramUser programUser;

  const DeskripsiProgram({super.key, required this.programUser});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(programUser.namaProgram),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 4,
              margin: const EdgeInsets.symmetric(
                  vertical: 12, horizontal: 12),
              child: Image.asset(
                programUser.gambarProgram,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width * 0.5,
                fit: BoxFit.cover,
              ),

            ),
            const SizedBox(height: 16),
            const Text(
              'Deskripsi:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 8),
            Text(
              programUser.deskripsiProgram,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
