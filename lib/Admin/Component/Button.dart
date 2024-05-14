// AdminButton.dart
// ignore_for_file: file_names

import 'package:flutter/material.dart';

class AdminButton extends StatelessWidget {
  const AdminButton({
    super.key,
    required this.text,
    required this.onTap, // Tambah properti onTap
  });

  final String text;
  final VoidCallback onTap; // Ubah tipe data properti menjadi VoidCallback

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        color: Theme.of(context).colorScheme.primary,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 0,
        child: InkWell(
          onTap: onTap, // Gunakan properti onTap
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
