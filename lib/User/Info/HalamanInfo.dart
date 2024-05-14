// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sibiti/User/OnBoard/OnBoard.dart';
import 'package:sibiti/register/RegistrationPage.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../API/Device Info.dart';
import '../../data.dart';
import '../../register/LoginPage.dart';
import '../../register/SelectUniversity.dart';
import '../Grading/Grading.dart';
import 'package:http/http.dart' as http;

class HalamanInfo extends StatefulWidget {
  const HalamanInfo({required this.userId, super.key});

  final String userId;
  @override
  State<HalamanInfo> createState() => _HalamanInfoState();
}

class _HalamanInfoState extends State<HalamanInfo> {
  Map<String, dynamic> _userdata = {};

  @override
  void initState() {
    super.initState();
    print(widget.userId);
    fetchData(widget.userId);
  }

  Future<void> fetchData(String userId) async {
    final String url = 'https://sibiti-backend.vercel.app/profile/$userId';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        // Parsing JSON response
        Map<String, dynamic> responseData = json.decode(response.body);

        // Mengakses array data
        List<dynamic> userDataList = responseData['data'];
        if (userDataList.isNotEmpty) {
          // Mengambil data pengguna pertama
          Map<String, dynamic> userData = userDataList[0];

          setState(() {
            _userdata = userData;
          });

          // Menampilkan nilai-nilai yang diminta
          print('Username: ${userData['username']}');
          print('Born: ${userData['born']}');
          print('Email: ${userData['email']}');
          print('Full Name: ${userData['fullName']}');
          print('School: ${userData['school']}');
          print('Province: ${userData['province']}');
          print('City: ${userData['city']}');
          print('Phone Number: ${userData['phoneNumber']}');
          print('Universitas: ${userData['universitas']}');
          print('Jurusan: ${userData['jurusan']}');
        } else {
          print('Data pengguna tidak ditemukan.');
        }
      } else {
        // Jika respons tidak berhasil (status code bukan 200)
        print('Gagal mengambil data: ${response.statusCode}');
      }
    } catch (e) {
      // Tangani kesalahan jaringan atau kesalahan lainnya
      print('Terjadi kesalahan: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_userdata['email'] != null) {
      return SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              child: Card(
                elevation: 2,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: InkWell(
                  onTap: () {
                    // Fungsi ketika card ditekan
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.person),
                                const SizedBox(width: 8),
                                Text(
                                  'Akun',
                                  style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // Fungsi ketika tombol 'Edit' ditekan
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black,
                                elevation: 1,
                                minimumSize: const Size(64, 36),
                              ),
                              child: Text(
                                'Edit',
                                style: GoogleFonts.openSans(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 8),
                        buildRowInfo('e-mail:', _userdata['email']),
                        buildRowInfo('Nama :', _userdata['fullName']),
                        buildRowInfo('Nama :', _userdata['username']),
                        buildRowInfo('Nomor HP :', _userdata['phoneNumber']),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              child: Card(
                elevation: 2,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: InkWell(
                  onTap: () {
                    // Fungsi ketika card ditekan
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.school),
                                const SizedBox(width: 8),
                                Text(
                                  'Sekolah',
                                  style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        buildRowInfo('Provinsi :', _userdata['province']),
                        buildRowInfo('Kab/Kota : ', _userdata['city']),
                        buildRowInfo('Sekolah :', _userdata['school']),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              child: Card(
                elevation: 2,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: InkWell(
                  onTap: () {
                    // Fungsi ketika card ditekan
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(LineIcons.university),
                                const SizedBox(width: 8),
                                Text(
                                  'Jurusan',
                                  style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        buildRowInfo('Kampus :', _userdata['universitas']),
                        buildRowInfo('Jurusan : ', _userdata['jurusan']),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            FutureBuilder<Box<Data>>(
              future: Hive.openBox<Data>(
                  'DataBox'), // Menggunakan fungsi untuk membuka kotak data
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasData) {
                  final boxData = snapshot.data!;
                  final dataList = boxData.values.toList();
                  return ElevatedButton(
                      onPressed: () {
                        fetchData(dataList[0].userId);
                      },
                      child: const Text('Fetch Data'));
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  return const Center(
                      child: Text(
                          'Tidak ada data yang tersimpan dalam local storage.'));
                }
              },
            ),
            Column(
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegistrationPage()));
                    },
                    child: const Text('Halaman Register')),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyApp()));
                    },
                    child: const Text('Halaman Device Info')),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()));
                    },
                    child: const Text('Halaman Login')),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const UniversityDropdown()));
                    },
                    child: const Text('University')),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const GradingPage()));
                    },
                    child: const Text('Grading Page')),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OnBoardNew()));
                    },
                    child: const Text('OnBoard')),
                ElevatedButton(
                    onPressed: () {
                      _launchUrl();
                    },
                    child: const Text('bayar')),
              ],
            )
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  final Uri _url =
      Uri.parse('https://app.midtrans.com/payment-links/1712512397359');

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

// Widget untuk membangun baris informasi
  Widget buildRowInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.openSans(
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.openSans(
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
