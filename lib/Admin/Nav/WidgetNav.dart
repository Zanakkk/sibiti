
// ignore_for_file: file_names

// AdminNav.dart
import 'package:flutter/material.dart';

import '../Component/Button.dart'; // Ubah import path sesuai struktur proyek

class AdminNav extends StatefulWidget {
  final ValueChanged<int> onNavItemTap;

  const AdminNav({super.key, required this.onNavItemTap});

  @override
  State<AdminNav> createState() => _AdminNavState();
}

class _AdminNavState extends State<AdminNav> {
  bool showManajemen = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          height: 100,
        ),
        AdminButton(
          text: 'Dashboard Admin',
          onTap: () {
            widget.onNavItemTap(0); // Mengirimkan indeks 0 untuk Dashboard Admin
          },
        ),
        const SizedBox(
          height: 8,
        ),
        AdminButton(
          text: 'TryOut',
          onTap: () {
            widget.onNavItemTap(1); // Mengirimkan indeks 1 untuk TryOut
          },
        ),
        const SizedBox(
          height: 8,
        ),
        Padding(
          padding: const EdgeInsets.all(4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              const Text('Manajemen User'),
              IconButton(
                onPressed: () {
                  setState(() {
                    showManajemen = !showManajemen;
                  });
                },
                icon: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return ScaleTransition(
                      scale: animation,
                      child: child,
                    );
                  },
                  child: showManajemen
                      ? const Icon(
                    Icons.arrow_drop_up_outlined,
                  )
                      : const Icon(
                    Icons.arrow_drop_down_outlined,
                  ),
                ),
              ),
            ],
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          child: showManajemen
              ? Padding(
            padding: const EdgeInsets.only(left: 40),
            child: Column(
              children: [
                AdminButton(
                  text: 'Admin',
                  onTap: () {
                    widget.onNavItemTap(2);
                  }, // Ubah sesuai dengan properti onTap
                ),
                AdminButton(
                  text: 'Tentor',
                  onTap: () {
                    widget.onNavItemTap(3);
                  }, // Ubah sesuai dengan properti onTap
                ),
                AdminButton(
                  text: 'Siswa',
                  onTap: () {
                    widget.onNavItemTap(4);
                  }, // Ubah sesuai dengan properti onTap
                ),
              ],
            ),
          )
              : const SizedBox(),
        ),
      ],
    );
  }
}