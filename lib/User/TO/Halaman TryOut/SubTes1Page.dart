// ignore_for_file: file_names, non_constant_identifier_names, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../Utils/test.dart';
import 'PageSoal1Page.dart';
import 'PageSoalMobile.dart';

class SubTes1 extends StatefulWidget {
  const SubTes1({
    super.key,
    required this.IDTO,
    required this.IDSubTes,
    required this.JudulSubtes,
    required this.JumlahSoal,
    required this.Waktu,
    required this.token,
  });

  final String IDTO;
  final String JudulSubtes;
  final int JumlahSoal, Waktu;
  final String IDSubTes;
  final String token;

  @override
  _SubTes1State createState() => _SubTes1State();
}

class _SubTes1State extends State<SubTes1> {
  late TextEditingController tokenController;

  @override
  void initState() {
    super.initState();
    tokenController = TextEditingController();
  }

  @override
  void dispose() {
    tokenController.dispose();
    super.dispose();
  }

  bool token = false;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Text(
                          widget.JudulSubtes,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        LittleCard(
                          '${widget.JumlahSoal} Soal',
                          Colors.yellow.shade50,
                          Colors.yellow.shade900,
                        ),
                        LittleCard(
                          '${widget.Waktu} Menit',
                          Colors.blue.shade900,
                          Colors.blue.shade200,
                        ),
                      ],
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      alignment: Alignment.center,
                      minimumSize: const Size(48, 36),
                      elevation: 20,
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      if (screenWidth < 400) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PageSoalMobile()));
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PageSoal1Subtes()));
                      }

                      if (widget.token == tokenController.text) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PageSoal1Subtes(),
                          ),
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Token Salah'),
                            content:
                                const Text('Token yang Anda masukkan salah.'),
                            actions: <Widget>[
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                    child: const Text('Kerjakan'),
                  ),
                )
              ],
            ),
            token
                ? Column(
                    children: [
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: tokenController,
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.black),
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                focusColor: Colors.black,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      const BorderSide(color: Colors.black),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      const BorderSide(color: Colors.black),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      const BorderSide(color: Colors.black),
                                ),
                                hintText: 'Token',
                                fillColor: Colors.black,
                                prefixIcon: const Icon(
                                  Icons.qr_code,
                                  color: Colors.black,
                                ),
                                hintStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontFamily: "verdana_regular",
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              onTapOutside: (_) {
                                FocusManager.instance.primaryFocus?.unfocus();
                              },
                              onChanged: (_) {
                                setState(() {});
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              alignment: Alignment.center,
                              minimumSize: const Size(48, 36),
                              elevation: 20,
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () {
                              if (widget.token == tokenController.text) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const PageSoal1Subtes(),
                                  ),
                                );
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Token Salah'),
                                    content: const Text(
                                        'Token yang Anda masukkan salah.'),
                                    actions: <Widget>[
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                            child: const Text('Kerjakan'),
                          ),
                        ],
                      ),
                    ],
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
