// ignore_for_file: file_names

import 'package:flutter/material.dart';

class ListFeature extends StatelessWidget {
  const ListFeature({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            InfoCard(
              title: 'Rangkuman Ciamik',
              description:
                  'Dapatkan rangkuman materi yang lengkap dengan desain yang menarik! Cocok banget untuk kamu review materi.',
              buttonText: 'Lihat Caranya',
              onPressed: () {
                // Implement your action here
              },
            ),
            InfoCard(
              title: 'Quiz',
              description:
                  'Uji pemahaman Rangkuman yang sudah kamu baca secara cepat dengan mengerjakan Quiz!',
              buttonText: 'Lihat Caranya',
              onPressed: () {
                // Implement your action here
              },
            ),
            InfoCard(
              title: 'Tryout UTBK dengan soal yang berkualitas',
              description:
                  'Soal tryout UTBK dibuat oleh alumni PTN terbaik dengan sistem penilaian IRT agar kamu masuk PTN impian!',
              buttonText: 'Lihat Caranya',
              onPressed: () {
                // Implement your action here
              },
            ),
          ],
        ),
        Row(
          children: [
            InfoCard(
              title: 'Live Class',
              description:
                  'Kamu bisa belajar langsung bersama Tutor dan teman-teman yang lain, supaya kamu lebih memahami materi!',
              buttonText: 'Lihat Caranya',
              onPressed: () {
                // Implement your action here
              },
            ),
            InfoCard(
              title: 'Rekomendasi Belajar',
              description:
                  'Evaluasi tryout makin mudah dengan Rekomendasi Belajar! Buwhan akan kasih tahu materi yang perlu kamu pelajari lebih lanjut!',
              buttonText: 'Lihat Caranya',
              onPressed: () {
                // Implement your action here
              },
            ),
            InfoCard(
              title: 'Rekomendasi Jurusan & Kampus',
              description:
                  'Kamu bisa mendapatkan rekomendasi jurusan dan kampus berdasarkan tes kepribadian dan juga hasil TO kamu.',
              buttonText: 'Lihat Caranya',
              onPressed: () {
                // Implement your action here
              },
            ),
          ],
        ),
      ],
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final String description;
  final String buttonText;
  final VoidCallback onPressed;

  const InfoCard({
    super.key,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(8.0), // Menyesuaikan padding
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minHeight: 250, // Set nilai minimal tinggi
            ),
            child: Container(
              // Menggunakan Container sebagai wadah untuk mengatur bentuk
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(8), // Mengatur sudut menjadi bulat
                color:
                    Colors.white, // Memberi warna putih sebagai latar belakang
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5), // Memberi bayangan
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // Posisi bayangan
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(
                    16.0), // Menyesuaikan padding di dalam wadah
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      style: const TextStyle(fontSize: 16),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 16),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: onPressed,
                        child: Text(buttonText),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
