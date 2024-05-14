// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Halaman TryOut/SubTes1Page.dart';

class DeskripsiTO extends StatefulWidget {
  final String nomorTO;

  const DeskripsiTO({required this.nomorTO, super.key});

  @override
  State<DeskripsiTO> createState() => _DeskripsiTOState();
}

class _DeskripsiTOState extends State<DeskripsiTO> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HALAMAN TO',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                color: Theme.of(context).colorScheme.primary,
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nama TO',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: constraints.maxWidth > 600 ? 32 : 24,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Penyelenggara',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: constraints.maxWidth > 600 ? 20 : 16,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Tanggal - Bulan - Tahun   Jam:Menit:Detik',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: constraints.maxWidth > 600 ? 20 : 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: ListView.builder(
                    itemCount: 10, // Sesuaikan jumlah item dengan data Anda
                    itemBuilder: (context, index) {
                      return SubTes1(
                        IDTO: index.toString(),
                        IDSubTes: index.toString(),
                        JudulSubtes: 'Penalaran Umum',
                        JumlahSoal: 15,
                        Waktu: 15,
                        token: 'qwerty', // Token, ganti sesuai data Anda
                        key:
                            UniqueKey(), // Tambahkan key unique untuk masing-masing item
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
