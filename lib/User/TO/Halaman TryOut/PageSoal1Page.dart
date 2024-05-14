// ignore_for_file: file_names

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PageSoal1Subtes extends StatefulWidget {
  const PageSoal1Subtes({super.key});

  @override
  State<PageSoal1Subtes> createState() => _PageSoal1SubtesState();
}

class _PageSoal1SubtesState extends State<PageSoal1Subtes> {
  int currentIndex = 0;
  bool submit = false;

  // List untuk menyimpan soal
  List<String> soalList = List.generate(
    15,
    (index) => 'Ini adalah contoh soal nomor ${index + 1}.',
  );

  // List untuk menyimpan jawaban
  List<List<String>> jawabanList = List.generate(
    15,
    (index) {
      int offset = index * 5;
      return [
        'A. Jawaban A adalah ${1 + offset}',
        'B. Jawaban B adalah ${2 + offset}',
        'C. Jawaban C adalah ${3 + offset}',
        'D. Jawaban D adalah ${4 + offset}',
        'E. Jawaban E adalah ${5 + offset}',
      ];
    },
  );

  // List untuk menyimpan jawaban yang dipilih oleh pengguna
  List<String> pilihJawabanList = List.filled(15, '');

  List<bool> raguRaguList = List.filled(15, false);

  late Timer _timer;
  int _remainingTime = 15 * 60; // Waktu awal dalam detik (15 menit)

  @override
  void initState() {
    super.initState();
    fetchData();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
        } else {
          _timer.cancel();
          // Implementasi aksi yang dijalankan ketika waktu habis
        }
      });
    });
  }

  Future<void> fetchData() async {
    const String apiUrl = 'https://sibiti-backend.vercel.app/soal/10/1';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<dynamic> data = responseData['data'];

        for (int i = 0; i < data.length; i++) {
          final Map<String, dynamic> item = data[i];
          setState(() {
            soalList[i] = item['soal'];
            jawabanList[i] = [
              'A. ${item['a']}',
              'B. ${item['b']}',
              'C. ${item['c']}',
              'D. ${item['d']}',
              'E. ${item['e']}',
            ];
          });
        }
      } else {
        if (kDebugMode) {
          print('Request failed with status: ${response.statusCode}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    }
  }

  showAlertDialogRaguRagu(BuildContext context) {
    // Menampilkan AlertDialog dengan pesan yang sesuai
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Peringatan'),
          content: Text(
              'Kamu masih ragu-ragu di nomor ${raguRaguList.indexOf(true) + 1}'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  showAlertDialogBelumMengisi(BuildContext context) {
    // Menampilkan AlertDialog dengan pesan yang sesuai
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Peringatan'),
          content: Text(
              'Kamu masih belum mengisi di nomor ${pilihJawabanList.indexOf('') + 1}'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    int minutes = _remainingTime ~/ 60;
    int seconds = _remainingTime % 60;

    return Scaffold(
      appBar: AppBar(
        title: const Text('SOAL TRYOUT'),
        elevation: 5,
        centerTitle: true,
      ),
      body: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              soalList[currentIndex],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: jawabanList[currentIndex].map((answer) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      pilihJawabanList[currentIndex] = answer;
                                    });
                                  },
                                  child: Text(
                                    answer,
                                    style: TextStyle(
                                      color: pilihJawabanList[currentIndex] ==
                                              answer
                                          ? Colors.blue
                                          : Colors.black,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                      activeColor: Colors.yellow,
                      value: raguRaguList[currentIndex],
                      onChanged: (value) {
                        setState(() {
                          raguRaguList[currentIndex] = value!;
                        });
                      },
                    ),
                    const Text('Ragu - Ragu'),
                  ],
                ),
                SizedBox(
                  height: 80,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        for (int i = 0; i < 5; i++)
                          Expanded(
                            child: Card(
                              color: pilihJawabanList[currentIndex] ==
                                      String.fromCharCode(65 + i)
                                  ? const Color(0xFF000080) // Biru Tua
                                  : Colors.white, // Putih
                              clipBehavior: Clip.antiAlias,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    pilihJawabanList[currentIndex] =
                                        String.fromCharCode(65 + i);
                                  });
                                },
                                borderRadius: BorderRadius.circular(25),
                                // Mengatur border radius menjadi bulat
                                child: Center(
                                  child: Text(
                                    String.fromCharCode(65 + i),
                                    // Mengubah angka menjadi karakter A, B, C, dst
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: pilihJawabanList[currentIndex] ==
                                              String.fromCharCode(65 + i)
                                          ? Colors.white
                                          : const Color(0xFF000080), // Biru Tua
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Column(
                children: List.generate(
                  (soalList.length / 5).ceil(),
                  (colIndex) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      5,
                      (rowIndex) {
                        int index = colIndex * 5 + rowIndex;
                        if (index < soalList.length) {
                          return InkWell(
                            child: Card(
                              color: (currentIndex == index)
                                  ? const Color(0xFF000080)
                                  : raguRaguList[index]
                                      ? Colors.yellow
                                      : (pilihJawabanList[index] != '')
                                          ? Colors.green.shade500
                                          : Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: SizedBox(
                                  height: 36,
                                  width: 36,
                                  child: Center(
                                    child: Text(
                                      (index + 1).toString(),
                                      // Ubah menjadi (index + 1)
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: (currentIndex == index)
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                currentIndex = index;
                              });
                            },
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
                    ),
                  ),
                ),
              ),
              Card(
                color: submit
                    ? const Color(0xFF000080)
                    : Colors.grey, // Biru Tua jika tidak ada ragu-ragu
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: TextButton(
                  style: TextButton.styleFrom(minimumSize: const Size(160, 48)),
                  child: submit
                      ? Text(
                          'Submit',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: submit
                                ? Colors.white
                                : Colors
                                    .black, // Putih jika tidak ada ragu-ragu
                          ),
                        )
                      : Text(
                          'Cek',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: submit
                                ? Colors.white
                                : Colors
                                    .black, // Putih jika tidak ada ragu-ragu
                          ),
                        ),
                  onPressed: () {
                    setState(() {
                      if (raguRaguList.contains(false) &&
                          pilihJawabanList
                              .every((jawaban) => jawaban.isNotEmpty)) {
                        submit =
                            true; // Mengubah status submit menjadi true jika tidak ada ragu-ragu dan semua jawaban telah diisi
                      }
                    });
                    if (pilihJawabanList[currentIndex].isEmpty) {
                      // Jika ada jawaban yang belum diisi, tampilkan AlertDialog
                      showAlertDialogBelumMengisi(context);
                    } else if (raguRaguList.contains(true)) {
                      // Jika masih ada ragu-ragu, tampilkan AlertDialog
                      showAlertDialogRaguRagu(context);
                    } else {
                      // Jika tidak ada ragu-ragu dan semua jawaban telah diisi, tampilkan AlertDialog selamat
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Selamat'),
                            content: const Text(
                                'Anda telah menyelesaikan semua soal.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Waktu Tersisa: ${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: _remainingTime <= 60 ? Colors.red : Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
