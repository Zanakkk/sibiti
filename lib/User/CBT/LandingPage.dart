// ignore_for_file: file_names, deprecated_member_use, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:sibiti/User/CBT/Home/IntroductionPage.dart';
import 'package:sibiti/User/CBT/Home/ListFeature.dart';
import '../Mobile/ProgramPilihan/ProgramPilihan.dart';
import 'Home/Download.dart';
import 'Home/Footer.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({required this.onNavItemTap, super.key});

  final void Function(int) onNavItemTap;
  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: (screenWidth < 400)
          ? const Column(
              children: [
                ProgramPilihan(),
              ],
            )
          : const Column(
              children: [
                IntroductionPage(),
                ListFeature(),
                Download(),
                Footer(),
              ],
            ),
    );
  }
}

class ExamListPage extends StatelessWidget {
  const ExamListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Ujian'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Kembali ke landing page
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Ujian Matematika'),
            onTap: () {
              // Navigasi ke halaman detail ujian
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const ExamDetailPage(examName: 'Ujian Matematika')),
              );
            },
          ),
          ListTile(
            title: const Text('Ujian Bahasa Inggris'),
            onTap: () {
              // Navigasi ke halaman detail ujian
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const ExamDetailPage(examName: 'Ujian Bahasa Inggris')),
              );
            },
          ),
          // Tambahkan daftar ujian lainnya di sini
        ],
      ),
    );
  }
}

class ExamDetailPage extends StatelessWidget {
  final String examName;

  const ExamDetailPage({super.key, required this.examName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Ujian'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Kembali ke halaman daftar ujian
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Detail Ujian: $examName',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // Tambahkan konten detail ujian di sini
          ],
        ),
      ),
    );
  }
}
