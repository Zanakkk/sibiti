// ignore_for_file: file_names

import 'package:flutter/material.dart';

class FreePaymentForm extends StatefulWidget {
  const FreePaymentForm({super.key});

  @override
  State<FreePaymentForm> createState() => _FreePaymentFormState();
}

class _FreePaymentFormState extends State<FreePaymentForm> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Pembayaran Gratis:',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10.0),
        Text('Anda bisa mendapatkan akses gratis.'),
      ],
    );
  }
}
