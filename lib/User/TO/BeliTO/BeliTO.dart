// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sibiti/User/TO/HalamanTO.dart';

import 'HalamanPembayaran.dart';

class HalamanBeliTO extends StatefulWidget {
  final TOData data;
  const HalamanBeliTO(this.data, {super.key});

  @override
  State<HalamanBeliTO> createState() => _HalamanBeliTOState();
}

class _HalamanBeliTOState extends State<HalamanBeliTO> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Beli Try Out'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Card(
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 4,
                      child: Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.data.judul,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            Text('Tanggal: ${widget.data.tanggal}'),
                            Text('Waktu: ${widget.data.waktu}'),
                            Text('Deskripsi: ${widget.data.deskripsi}'),
                          ],
                        ),
                      )),
                ),
                const Divider(),
                const SizedBox(height: 12),
                const Center(
                  child: Text(
                    'SUBTES UJIAN INI',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: ListView.builder(
                    itemCount: 6,
                    itemBuilder: (BuildContext context, int index) {
                      // Menentukan judul dan deskripsi untuk setiap subtes
                      String judul = 'Subtes ${index + 1}';
                      String deskripsi = 'Deskripsi Subtes ${index + 1}';

                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        child: ListTile(
                          title: Text(
                            judul,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(deskripsi),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                        const PaymentPage()));

              },
              child: const Text('BELI'),
            ),
          ),
        ],
      ),
    );
  }
}
