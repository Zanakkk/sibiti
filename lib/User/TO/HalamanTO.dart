// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sibiti/User/TO/DeskripsiTO.dart';

import 'BeliTO/BeliTO.dart';
import 'Halaman TryOut/PageSoal1Page.dart';

List listlive = [];
List listtutor = [];
List listmateri = [];
List listTO = [];

class TOData {
  final int idTO;
  final String judul;
  final String tanggal;
  final String waktu;
  final String deskripsi;

  TOData({
    required this.idTO,
    required this.judul,
    required this.tanggal,
    required this.waktu,
    required this.deskripsi,
  });
}

class HalamanTO extends StatefulWidget {
  const HalamanTO({super.key});

  @override
  State<HalamanTO> createState() => _HalamanTOState();
}

class _HalamanTOState extends State<HalamanTO> {
  int _selectedIndex = 0;

  final List<TOData> toList = [
    TOData(
      idTO: 1,
      judul: 'Try Out 1',
      tanggal: '31 Maret 2024',
      waktu: '08:00 - 10:00',
      deskripsi: 'Deskripsi Try Out 1',
    ),
    TOData(
      idTO: 2,
      judul: 'Try Out 2',
      tanggal: '1 April 2024',
      waktu: '09:00 - 11:00',
      deskripsi: 'Deskripsi Try Out 2',
    ),
    TOData(
      idTO: 3,
      judul: 'Try Out 3',
      tanggal: '1 April 2024',
      waktu: '09:00 - 11:00',
      deskripsi: 'Deskripsi Try Out 3',
    ),
    TOData(
      idTO: 4,
      judul: 'Try Out 4',
      tanggal: '1 April 2024',
      waktu: '09:00 - 11:00',
      deskripsi: 'Deskripsi Try Out 2',
    ),
    TOData(
      idTO: 5,
      judul: 'Try Out 5',
      tanggal: '1 April 2024',
      waktu: '09:00 - 11:00',
      deskripsi: 'Deskripsi Try Out 3',
    ),
    // Tambahkan data TO lainnya sesuai kebutuhan
  ];
  List<TOData> toAktif = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
              child: GNav(
                rippleColor: Colors.grey[300]!,
                hoverColor: Colors.grey[100]!,
                gap: 8,
                activeColor: Colors.black,
                iconSize: 24,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: const Duration(milliseconds: 400),
                tabBackgroundColor: Colors.grey[100]!,
                color: Colors.black,
                tabs: const [
                  GButton(
                    icon: LineIcons.home,
                    text: 'Try Out Aktif',
                  ),
                  GButton(
                    icon: LineIcons.book,
                    text: 'Beli Try Out',
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
        Expanded(
          child: _getSelectedWidget(_selectedIndex, toList, toAktif),
        ),
      ],
    );
  }

  Widget _getSelectedWidget(
      int index, List<TOData> toList, List<TOData> toAktif) {
    switch (index) {
      case 0:
        return TOAktifWidget(toList: toAktif);
      case 1:
        return BeliTOWidget(
          toList: toList,
          onBeliPressed: (TOData beliTO) {
            setState(() {
              toAktif.add(beliTO);
            });
          },
        );
      default:
        return Container();
    }
  }
}

class TOAktifWidget extends StatelessWidget {
  final List<TOData> toList;

  const TOAktifWidget({required this.toList, super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return ListView.builder(
      itemCount: toList.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 4,
          margin: const EdgeInsets.all(8),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      toList[index].judul,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text('Tanggal: ${toList[index].tanggal}'),
                    Text('Waktu: ${toList[index].waktu}'),
                    Text('Deskripsi: ${toList[index].deskripsi}'),
                  ],
                ),
                InkWell(
                  child: SizedBox(
                    width: 120,
                    height: 48,
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 4,
                      child: const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          child: Center(
                            child: Text(
                              'Kerjakan',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          )),
                    ),
                  ),
                  onTap: () {
                    if (screenWidth < 400) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const DeskripsiTO(nomorTO: '1',)));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PageSoal1Subtes()));
                    }
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class BeliTOWidget extends StatelessWidget {
  const BeliTOWidget({
    required this.toList,
    required this.onBeliPressed,
    super.key,
  });

  final List<TOData> toList;
  final Function(TOData) onBeliPressed;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: toList.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 4,
          margin: const EdgeInsets.all(8),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      toList[index].judul,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text('Tanggal: ${toList[index].tanggal}'),
                    Text('Waktu: ${toList[index].waktu}'),
                    Text('Deskripsi: ${toList[index].deskripsi}'),
                  ],
                ),
                InkWell(
                  child: SizedBox(
                    width: 120,
                    height: 48,
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 4,
                      child: const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          child: Center(
                            child: Text(
                              'Beli',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          )),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                HalamanBeliTO(toList[index])));
                    onBeliPressed(toList[index]);
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
