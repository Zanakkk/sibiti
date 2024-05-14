import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sibiti/User/CBT/Home/NavBar.dart';
import 'package:sibiti/User/CBT/LandingPage.dart';
import 'package:sibiti/User/Info/HalamanInfo.dart';
import 'package:sibiti/data.dart';
import 'package:sibiti/register/LoginPage.dart';
import 'package:sibiti/register/OTP.dart';

import 'User/Mobile/AppBar.dart';
import 'User/TO/HalamanTO.dart';
import 'package:platform/platform.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class UserData {
  String userId;
  String email;

  UserData(this.userId, this.email);

  @override
  String toString() => userId; // Just for print()
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(DataAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.indigo),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  late bool verifiedstatus;

  Future<void> fetchVerificationStatus(String userId) async {
    final response = await http.get(Uri.parse(
        'https://sibiti-backend.vercel.app/auth/check-verification/$userId'));

    if (response.statusCode == 200) {
      // Decode JSON response
      final responseData = json.decode(response.body);
      // Return verifiedStatus

      setState(() {
        verifiedstatus = responseData['verifiedStatus'];
      });
    } else {
      // Jika request gagal, lempar exception atau kembalikan nilai default sesuai kebutuhan aplikasi Anda
      throw Exception('Failed to fetch verification status');
    }
  }

  Widget build(BuildContext context) {
    const LocalPlatform platform = LocalPlatform();
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: FutureBuilder<Box<Data>>(
        future: Hive.openBox<Data>(
            'DataBox'), // Menggunakan fungsi untuk membuka kotak data
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            final boxData = snapshot.data!;
            final dataList = boxData.values.toList();
            fetchVerificationStatus(dataList[0].userId);

            if (verifiedstatus) {
              return Stack(
                children: [
                  Column(
                    children: [
                      const SizedBox(
                        height: 32,
                      ),
                      (screenWidth > 400)
                          ? NavBarSibiti(
                              onNavItemTap: (index) {
                                setState(() {
                                  _selectedIndex = index;
                                });
                              },
                            )
                          : (_selectedIndex == 0)
                              ? const SibitiAppBar(
                                  show: true,
                                  materiatauTO: true,
                                  setting: false,
                                )
                              : (_selectedIndex == 1)
                                  ? const SibitiAppBar(
                                      show: true,
                                      materiatauTO: false,
                                      setting: false,
                                    )
                                  : const SibitiAppBar(
                                      show: false,
                                      materiatauTO: false,
                                      setting: true,
                                    ),
                      Expanded(
                        child: Center(
                          child: _selectedIndex == 0
                              ? LandingPage(
                                  onNavItemTap: (index) {
                                    setState(() {
                                      _selectedIndex = index;
                                    });
                                  },
                                )
                              : _selectedIndex == 1
                                  ? const HalamanTO()
                                  : HalamanInfo(
                                      userId: dataList[0].userId,
                                    ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            } else
              return OTPForm();
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return LoginPage();
          }
        },
      ),
      bottomNavigationBar: (platform.isWindows)
          ? Container()
          : screenWidth < 400
              ? Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 8),
                        child: GNav(
                          rippleColor: Colors.grey[300]!,
                          hoverColor: Colors.grey[100]!,
                          gap: 8,
                          activeColor: Colors.black,
                          iconSize: 24,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          duration: const Duration(milliseconds: 400),
                          tabBackgroundColor: Colors.grey[100]!,
                          color: Colors.black,
                          tabs: const [
                            GButton(
                              icon: LineIcons.home,
                              text: 'Home',
                            ),
                            GButton(
                              icon: LineIcons.book,
                              text: 'Ujian',
                            ),
                            GButton(
                              icon: LineIcons.user,
                              text: 'Profil',
                            ),
                          ],
                          selectedIndex: _selectedIndex,
                          onTabChange: (index) {
                            setState(() {
                              _selectedIndex = index;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                )
              : Container(),
    );
  }
}
