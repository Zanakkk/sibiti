// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_onboard/flutter_onboard.dart';

import '../../main.dart';

class OnBoardNew extends StatelessWidget {
  final PageController _pageController = PageController();

  OnBoardNew({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnBoard(
        pageController: _pageController,
        // Either Provide onSkip Callback or skipButton Widget to handle skip state
        onSkip: () {
          // print('skipped');
        },
        // Either Provide onDone Callback or nextButton Widget to handle done state
        onDone: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const MyHomePage()));
        },
        onBoardData: onBoardData,
        titleStyles: TextStyle(
          color: Theme.of(context).colorScheme.inversePrimary,
          fontSize: 18,
          fontWeight: FontWeight.w900,
          letterSpacing: 0.15,
        ),
        descriptionStyles: TextStyle(
          fontSize: 16,
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
        pageIndicatorStyle: PageIndicatorStyle(
          width: 100,
          inactiveColor: Theme.of(context).colorScheme.inversePrimary,
          activeColor: Theme.of(context).colorScheme.primary,
          inactiveSize: const Size(8, 8),
          activeSize: const Size(12, 12),
        ),
        // Either Provide onSkip Callback or skipButton Widget to handle skip state
        skipButton: TextButton(
          onPressed: () {
            // print('skipButton pressed');
          },
          child: const Text(
            "",
            style: TextStyle(color: Colors.deepOrangeAccent),
          ),
        ),
        // Either Provide onDone Callback or nextButton Widget to handle done state
        nextButton: OnBoardConsumer(
          builder: (context, ref, child) {
            final state = ref.watch(onBoardStateProvider);
            return InkWell(
              onTap: () => _onNextTap(state, context),
              child: Container(
                width: 230,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.inversePrimary,
                    ],
                  ),
                ),
                child: Text(
                  state.isLastPage ? "Done" : "Next",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _onNextTap(OnBoardState onBoardState, context) {
    if (!onBoardState.isLastPage) {
      _pageController.animateToPage(
        onBoardState.page + 1,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOutSine,
      );
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const MyHomePage()));
    }
  }
}

final List<OnBoardModel> onBoardData = [
  const OnBoardModel(
    title: "Administrasi",
    description: "Bingung Mau Bertanya Ke Siapa masalah HIV ???",
    imgUrl: 'assets/onboard/Halaman1.jpg',
  ),
  const OnBoardModel(
    title: "Rekam Medis",
    description: "Kesulitan dalam mengatur rekam medis pasien ?"
        "Pernah kehilangan rekam medis ?",
    imgUrl: 'assets/onboard/Halaman2.jpg',
  ),
  const OnBoardModel(
    title: "Memperkenalkan PRAKARSA",
    description:
        "PRAKARSA membantumu dalam mengatur administrasi dan rekam medis pasien",
    imgUrl: 'assets/onboard/Halaman3.png',
  ),
];
