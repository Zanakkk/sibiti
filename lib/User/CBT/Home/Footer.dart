// ignore_for_file: file_names

import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200], // Warna latar belakang footer
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildColumn(
            context,
            children: [
              _buildSocialIcon('assets/logo/Instagram.png'),
              const SizedBox(width: 10),
              const Text(
                'Media belajar berbasis teknologi yang fokus untuk meningkatkan keterampilan siswa Indonesia dalam memecahkan masalah yang kompleks.',
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.justify,
              ),
            ],
            title: 'SIBITI',
          ),
          _buildColumn(
            context,
            title: 'Fitur',
            children: const [
              Text('Rangkuman'),
              Text('Quiz'),
              Text('Tryout'),
              Text('Live Class'),
              Text('Rekomendasi Belajar'),
              Text('Rekomendasi Jurusan & Kampus'),
            ],
          ),
          _buildRow(
            context,
            title: 'Ikuti Kami',
            children: [
              _buildSocialIcon('assets/logo/Instagram.png'),
              _buildSocialIcon('assets/logo/Tiktok.png'),
              _buildSocialIcon('assets/logo/X.png'),
            ],
          ),
          _buildColumn(
            context,
            title: 'Hubungi Kami',
            children: const [
              Text('Partnership'),
              Text('FAQ'),
              SizedBox(height: 24),
              Text('(+62) 812 5610 5080'),
              Text('hai@analitica.id'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildColumn(BuildContext context,
      {required String title, required List<Widget> children}) {
    return SizedBox(
        width: MediaQuery.of(context).size.width / 4,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: children,
              ),
            ],
          ),
        ));
  }

  Widget _buildRow(BuildContext context,
      {required String title, required List<Widget> children}) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        ],
      ),
    );
  }

  Widget _buildSocialIcon(String imagePath) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Image.asset(
        imagePath,
        width: 30,
        height: 30,
        fit: BoxFit.cover,
      ),
    );
  }
}
