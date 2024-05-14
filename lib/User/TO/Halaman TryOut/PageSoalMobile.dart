// ignore_for_file: file_names

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PageSoalMobile extends StatefulWidget {
  const PageSoalMobile({super.key});

  @override
  State<PageSoalMobile> createState() => _PageSoalMobileState();
}

class _PageSoalMobileState extends State<PageSoalMobile> {
  int currentIndex = 0;
  bool submit = false;
  bool show = false;
  bool loaddata = false;

  // List untuk menyimpan soal
  List<String> soalList = [];

  // List untuk menyimpan jawaban
  List<List<String>> jawabanList = [];

  // List untuk menyimpan jawaban yang dipilih oleh pengguna
  List<String> pilihJawabanList = [];

  List<bool> raguRaguList = [];

  Future<void> fetchData() async {
    final url = Uri.parse('https://sibiti-backend.vercel.app/soal/10/1');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final data = jsonResponse['data'];

        List<String> newSoalList = [];
        List<List<String>> newJawabanList = [];

        for (var item in data) {
          String soal = item['soal'];
          String a = 'A. ${item['a']}';
          String b = 'B. ${item['b']}';
          String c = 'C. ${item['c']}';
          String d = 'D. ${item['d']}';
          String e = 'E. ${item['e']}';

          newSoalList.add(soal);
          newJawabanList.add([a, b, c, d, e]);
        }

        setState(() {
          soalList = newSoalList;
          jawabanList = newJawabanList;
          pilihJawabanList = List.filled(data.length, '');
          raguRaguList = List.filled(data.length, false);
          loaddata = true;
        });

        if (kDebugMode) {
          print('Soal List: $soalList');
        }
        if (kDebugMode) {
          print('Jawaban List: $jawabanList');
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

    _scrollController.animateTo(
      currentIndex * 36.0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
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

  // Buat sebuah ScrollController
  final ScrollController _scrollController = ScrollController();

// Di dalam build method atau di initState, setel posisi scroll agar nomor yang Anda tekan berada di tengah

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
      body: loaddata
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  controller:
                      _scrollController, // Gunakan controller yang telah Anda buat
                  child: Row(
                    children: List.generate(
                      soalList.length,
                      (index) {
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
                      },
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          const Text(
                            'Waktu Tersisa: ',
                          ),
                          Text(
                            '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: _remainingTime <= 60
                                  ? Colors.red
                                  : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Card(
                          child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: InkWell(
                          child: const Icon(
                            Icons.grid_on,
                            size: 28,
                          ),
                          onTap: () {
                            show = !show;
                            setState(() {});
                          },
                        ),
                      )),
                    ),
                    Expanded(
                      flex: 3,
                      child: Card(
                        color: submit
                            ? const Color(0xFF000080)
                            : Colors.grey, // Biru Tua jika tidak ada ragu-ragu
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: TextButton(
                          style: TextButton.styleFrom(
                              minimumSize: const Size(120, 48)),
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
                              submit = !pilihJawabanList
                                      .any((jawaban) => jawaban.isEmpty) &&
                                  !raguRaguList.contains(true);
                            });
                            if (pilihJawabanList[currentIndex] == '') {
                              // Jika ada jawaban yang belum diisi, tampilkan AlertDialog
                              showAlertDialogBelumMengisi(context);
                            } else if (raguRaguList.contains(true)) {
                              // Jika masih ada ragu-ragu, tampilkan AlertDialog
                              showAlertDialogRaguRagu(context);
                            } else if (submit) {
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
                            } else {
                              // Jika ada jawaban yang belum diisi
                              showAlertDialogBelumMengisi(context);
                            }
                          },
                        ),
                      ),
                    )
                  ],
                ),
                show
                    ? Expanded(
                        child: Card(
                          color: Colors.black12,
                          child: GridView.count(
                            crossAxisCount: 5,
                            children: List.generate(
                              soalList.length,
                              (index) {
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
                                      currentIndex =
                                          index; // Perbarui nilai currentIndex
                                      _scrollController.animateTo(
                                        (currentIndex * 58.0),
                                        duration:
                                            const Duration(milliseconds: 500),
                                        curve: Curves.easeInOut,
                                      );
                                    });
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      )
                    : Expanded(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    soalList[currentIndex],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children:
                                        jawabanList[currentIndex].map((answer) {
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            pilihJawabanList[currentIndex] =
                                                answer;
                                          });
                                        },
                                        child: Text(
                                          answer,
                                          style: TextStyle(
                                            color: pilihJawabanList[
                                                        currentIndex] ==
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
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
