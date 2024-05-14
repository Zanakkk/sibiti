// ignore_for_file: file_names

import 'package:flutter/material.dart';

class IntroductionPage extends StatefulWidget {
  const IntroductionPage({super.key});

  @override
  State<IntroductionPage> createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage>
    with SingleTickerProviderStateMixin {
  final List<String> words = [
    "",
    "C",
    "CP",
    "CPN",
    "CPNS",
    "CPN",
    "CP",
    "C",
    "",
    "S",
    "SN",
    "SNB",
    "SNBT",
    "SNB",
    "SN",
    "S",
    "",
    "C",
    "CA",
    "CAT",
    "CA",
    "C",
    "",
    "T",
    "TO",
    "TOE",
    "TOEF",
    "TOEFL",
    "TOEF",
    "TOE",
    "TO",
    "T",
    "",
    "K",
    "KS",
    "KSN",
    "KS",
    "K",
    "",
  ];
  late AnimationController _controller;
  late Animation<double> _animation;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });
    _startTypingAnimation();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startTypingAnimation() async {
    while (true) {
      for (int i = 0; i < words.length; i++) {
        setState(() {
          _index = i;
          _controller.reset(); // Mengatur ulang animasi untuk memulai dari awal
          _controller.forward(); // Memulai animasi
        });
        await Future.delayed(const Duration(milliseconds: 500));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.7,
      child: Center(
        child: Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 24,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Mimpi emang kunci, ',
                      style: TextStyle(fontSize: 72 * screenWidth / 1536),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Tapi bukan kunci lulus ',
                          style: TextStyle(fontSize: 72 * screenWidth / 1536),
                        ),
                        SizedBox(
                          // Sesuaikan lebar sesuai kebutuhan
                          width: 250 * screenWidth / 1536,
                          child: AnimatedBuilder(
                            animation: _animation,
                            builder: (context, child) {
                              final currentText = words[_index];
                              return Row(
                                children: [
                                  Text(
                                    currentText,
                                    style: TextStyle(
                                      fontSize: 72 * screenWidth / 1536,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                  Visibility(
                                    visible: _animation.value < 0.5,
                                    child: Text(
                                      "_",
                                      style: TextStyle(
                                        fontSize: 72 * screenWidth / 1536,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                const Text(
                  'Ga ada proses yang instan, bahkan platform ini pun lahir dengan kerja keras',
                  style: TextStyle(fontSize: 20),
                ),
                const Text(
                  'Roma Tidak Dibangun Dalam Semalam',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 24,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
