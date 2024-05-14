// ignore_for_file: file_names

import 'package:flutter/material.dart';

class Download extends StatefulWidget {
  const Download({super.key});

  @override
  State<Download> createState() => _DownloadState();
}

class _DownloadState extends State<Download> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
      width: MediaQuery.of(context).size.width / 2,

      child: Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Kamu sudah mencapai sejauh ini, yuk lanjutkan langkah untuk mencapai tujuanmu!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Play Store'),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('App Store'),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Website'),
                    ),
                  ],
                ),
              ],
            ),
          )),
    ));
  }
}
