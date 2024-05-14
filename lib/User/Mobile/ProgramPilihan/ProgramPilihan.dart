// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:sibiti/User/Mobile/ProgramPilihan/DeskripsiKampus.dart';

import 'DeskripsiProgram.dart';

class ProgramUser {
  final int idProgram;
  final String namaProgram;
  final String deskripsiProgram;
  final String gambarProgram;

  ProgramUser({
    required this.idProgram,
    required this.namaProgram,
    required this.deskripsiProgram,
    required this.gambarProgram,
  });
}

class Ujian {
  final int idUjian;
  final String namaUjian;
  final String deskripsiUjian;
  final String gambarKampus;

  Ujian({
    required this.idUjian,
    required this.namaUjian,
    required this.deskripsiUjian,
    required this.gambarKampus,
  });
}

class ProgramPilihan extends StatefulWidget {
  const ProgramPilihan({super.key});

  @override
  State<ProgramPilihan> createState() => _ProgramPilihanState();
}

class _ProgramPilihanState extends State<ProgramPilihan> {
  List<ProgramUser> ListProgramUser = [
    ProgramUser(
      idProgram: 1,
      namaProgram: 'SNBT',
      deskripsiProgram:
          'Seleksi Nasional Berbasis Tes (SNBT) 2024 merupakan seleksi masuk perguruan tinggi yang dilakukan berdasarkan hasil Ujian Tulis Berbasis Komputer (UTBK) dan dapat ditambah dengan kriteria lain sesuai dengan ketentuan yang ditetapkan PTN Akademik, PTN Vokasi, atau Perguruan Tinggi Keagamaan Agama Islam Negeri (PTKIN) yang bersangkutan.',
      gambarProgram: 'assets/register/gurun.jpg',
    ),
    ProgramUser(
      idProgram: 2,
      namaProgram: 'SKD CPNS',
      deskripsiProgram:
          'ANBK atau Asesmen Nasional Berbasis Komputer adalah sistem evaluasi yang digunakan untuk mengukur kemampuan peserta seleksi CPNS dalam bidang pengetahuan umum dan pengetahuan khusus. ANBK digunakan sebagai salah satu tahap dalam seleksi CPNS di Indonesia.',
      gambarProgram: 'assets/register/gurun.jpg',
    ),
    ProgramUser(
      idProgram: 3,
      namaProgram: 'ANBK',
      deskripsiProgram:
          'SKD CPNS atau Seleksi Kompetensi Dasar CPNS adalah tes yang mengukur kompetensi dasar calon pegawai negeri sipil (CPNS) dalam bidang pengetahuan dan keterampilan. SKD CPNS terdiri dari tes wawasan kebangsaan, tes intelegensia umum, dan tes karakteristik pribadi.',
      gambarProgram: 'assets/register/gurun.jpg',
    ),
    // Tambahkan program-program lainnya sesuai kebutuhan
  ];
  List<Ujian> listUjianMandiri = [
    Ujian(
      idUjian: 1,
      namaUjian: 'SIMAK UI',
      deskripsiUjian:
          'Simak-UI (Seleksi Masuk UI) adalah ujian seleksi terpadu masuk UI yang diselenggarakan UI bagi calon mahasiswa yang ingin kuliah di UI. Program pendidikan yang dibuka pada SIMAK UI mulai dari Program Vokasi (D3 dan D4), Sarjana, Sarjana Kelas Khusus Internasional (S1 KKI), Sarjana dan Vokasi dengan Rekognisi Pembelajaran Lampau (S1 RPL & Vokasi RPL), Profesi, Spesialis, Magister dan Doktor.',
      gambarKampus: 'assets/Kampus/UI.png',
    ),
    Ujian(
      idUjian: 2,
      namaUjian: 'UTUL UGM',
      deskripsiUjian:
          'UTUL UGM adalah singkatan dari Ujian Tulis Universitas Gadjah Mada. Dalam tes ini, peserta ujian akan mengerjakan berbagai soal yang hasilnya akan diseleksi sebagai syarat masuk UGM.',
      gambarKampus: 'assets/Kampus/UGM.png',
    ),
    Ujian(
      idUjian: 3,
      namaUjian: 'SIMA UNAND',
      deskripsiUjian:
          'SIMA merupakan jalur penerimaan mahasiswa baru jalur seleksi mandiri yang dilaksanakan Unand. Ada enam jalur SIMA, yakni SIMA Akademik, SIMA Prestasi, SIMA Kerja Sama, SIMA Penyandang Disabilitas, SIMA Internasional, dan SIMA Kelas Internasional.',
      gambarKampus: 'assets/Kampus/UNAND.png',
    ),
    // Tambahkan ujian mandiri lainnya sesuai kebutuhan
  ];
  List<Ujian> listUjianKedinasan = [
    Ujian(
      idUjian: 1,
      namaUjian: 'Sekolah Tinggi Ilmu Kepolisian (STIK)',
      deskripsiUjian:
          'Lulusannya akan bekerja sebagai anggota Kepolisian Republik Indonesia.',
      gambarKampus: 'assets/Kampus/UI.png',
    ),
    Ujian(
      idUjian: 2,
      namaUjian: 'Akademi Militer (AKMIL)',
      deskripsiUjian:
          'Lulusannya akan bekerja sebagai perwira militer di TNI Angkatan Darat.',
      gambarKampus: 'assets/Kampus/UGM.png',
    ),
    Ujian(
      idUjian: 3,
      namaUjian: 'Akademi Angkatan Laut (AKABRI AL)',
      deskripsiUjian:
          'Lulusannya akan bekerja sebagai perwira militer di TNI Angkatan Laut.',
      gambarKampus: 'assets/Kampus/UNAND.png',
    ),
    Ujian(
      idUjian: 4,
      namaUjian: 'Akademi Angkatan Udara (AAU)',
      deskripsiUjian:
          'Lulusannya akan bekerja sebagai perwira militer di TNI Angkatan Udara.',
      gambarKampus: 'assets/Kampus/UI.png',
    ),
    Ujian(
      idUjian: 5,
      namaUjian: 'Institut Pemerintahan Dalam Negeri (IPDN)',
      deskripsiUjian:
          'Lulusannya akan bekerja sebagai pegawai negeri sipil (PNS) di pemerintahan daerah.',
      gambarKampus: 'assets/Kampus/UGM.png',
    ),
    Ujian(
      idUjian: 6,
      namaUjian: 'Akademi Kepolisian (AKPOL)',
      deskripsiUjian:
          'Lulusannya akan bekerja sebagai perwira polisi di Kepolisian Republik Indonesia.',
      gambarKampus: 'assets/Kampus/UNAND.png',
    ),
    Ujian(
      idUjian: 7,
      namaUjian: 'Akademi Imigrasi',
      deskripsiUjian:
          'Lulusannya akan bekerja sebagai pegawai di Kementerian Hukum dan HAM, khususnya di bidang imigrasi.',
      gambarKampus: 'assets/Kampus/UI.png',
    ),
    Ujian(
      idUjian: 8,
      namaUjian: 'Sekolah Staf dan Komando TNI Angkatan Darat (SESKOAD)',
      deskripsiUjian:
          'Lulusannya akan langsung bekerja sebagai perwira staf dan komando di TNI Angkatan Darat.',
      gambarKampus: 'assets/Kampus/UGM.png',
    ),
    Ujian(
      idUjian: 9,
      namaUjian: 'Sekolah Pendidikan dan Latihan Kejaksaan (SPLK)',
      deskripsiUjian:
          'Lulusannya akan bekerja sebagai jaksa di Kejaksaan Republik Indonesia.',
      gambarKampus: 'assets/Kampus/UNAND.png',
    ),
    Ujian(
      idUjian: 10,
      namaUjian: 'Sekolah Tinggi Akuntansi Negara (STAN)',
      deskripsiUjian:
          'Lulusannya akan bekerja sebagai pegawai di Direktorat Jenderal Pajak untuk bidang keuangan dan akuntansi.',
      gambarKampus: 'assets/Kampus/UI.png',
    ),
    Ujian(
      idUjian: 11,
      namaUjian: 'Sekolah Staf dan Komando TNI Angkatan Laut (SESKOAL)',
      deskripsiUjian:
          'Lulusannya langsung bekerja sebagai perwira staf dan komando di TNI Angkatan Laut.',
      gambarKampus: 'assets/Kampus/UGM.png',
    ),
    Ujian(
      idUjian: 12,
      namaUjian: 'Sekolah Tinggi Intelijen Negara (STIN)',
      deskripsiUjian:
          'Lulusannya akan langsung bekerja sebagai pegawai di Badan Intelijen Negara (BIN) dalam bidang intelijen dan keamanan nasional.',
      gambarKampus: 'assets/Kampus/UNAND.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Column(
              children: List.generate(
                ListProgramUser.length,
                (index) => Card(
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 4,
                  child: Column(
                    children: [
                      Image.asset(
                        ListProgramUser[index].gambarProgram,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 4),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      ListProgramUser[index].namaProgram,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20,
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          40, // Batasi tinggi maksimal dua baris
                                      child: Text(
                                        ListProgramUser[index].deskripsiProgram,
                                        maxLines:
                                            2, // Batasi maksimal dua baris
                                        overflow: TextOverflow
                                            .ellipsis, // Tambahkan ellipsis jika melebihi dua baris
                                        textAlign: TextAlign.justify,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // Aksi ketika tombol di tekan
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DeskripsiProgram(
                                      programUser: ListProgramUser[index],
                                    ),
                                  ),
                                );
                              },
                              child: const Text('Ikuti'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            const Text(
              'UJIAN MANDIRI',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  listUjianMandiri.length,
                  (index) => SizedBox(
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DeskripsiKampus(
                                ujian: listUjianMandiri[index],
                              ),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.3,
                                height: MediaQuery.of(context).size.width * 0.3,
                                child: Image.asset(
                                  listUjianMandiri[index].gambarKampus,
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    listUjianMandiri[index].namaUjian,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20,
                                    ),
                                  ),
                                  SizedBox(
                                    height:
                                        40, // Batasi tinggi maksimal dua baris
                                    child: Text(
                                      listUjianMandiri[index].deskripsiUjian,
                                      maxLines: 2, // Batasi maksimal dua baris
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.justify,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            const Text(
              'UJIAN KEDINASAN',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  listUjianKedinasan.length,
                  (index) => SizedBox(
                    width: MediaQuery.of(context).size.width * 0.75,
                    height: MediaQuery.of(context).size.width * 0.75,
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DeskripsiKampus(
                                ujian: listUjianKedinasan[index],
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.3,
                                height: MediaQuery.of(context).size.width * 0.3,
                                child: Image.asset(
                                  listUjianKedinasan[index].gambarKampus,
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                              Text(
                                listUjianKedinasan[index].namaUjian,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(
                                height: 40,
                                child: Text(
                                  listUjianKedinasan[index].deskripsiUjian,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
          ],
        ));
  }
}
