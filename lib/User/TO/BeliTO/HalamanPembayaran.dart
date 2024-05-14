// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:flutter/material.dart';

import 'Free/Free.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String _selectedPayment = 'transfer';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Pembayaran'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Pilih Metode Pembayaran:',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10.0),
                RadioListTile(
                  title: const Text('Transfer Bank'),
                  value: 'transfer',
                  groupValue: _selectedPayment,
                  onChanged: (value) {
                    setState(() {
                      _selectedPayment = value.toString();
                    });
                  },
                ),
                RadioListTile(
                  title: const Text(
                    'QRIS',
                  ),
                  value: 'qris',
                  groupValue: _selectedPayment,
                  onChanged: (value) {
                    setState(() {
                      _selectedPayment = value.toString();
                    });
                  },
                ),
                RadioListTile(
                  title: const Text('Gratis'),
                  value: 'free',
                  groupValue: _selectedPayment,
                  onChanged: (value) {
                    setState(() {
                      _selectedPayment = value.toString();
                    });
                  },
                ),
                Card(
                  child: SizedBox(
                    height: 120,
                    child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: (_selectedPayment == 'transfer')
                            ? const BankTransferForm()
                            : (_selectedPayment == 'qris')
                            ? const QrisPaymentForm()
                            : (_selectedPayment == 'free')
                            ? const FreePaymentForm()
                            : Container()),
                  )
                )
              ],
            ),
          ),
        ));
  }
}

class BankTransferForm extends StatelessWidget {
  const BankTransferForm({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Detail Transfer Bank:',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nama Bank:'),
                Text('Nomor Rekening:'),
                Text('Atas Nama:'),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('Bank Mandiri'),
                Text('1110018568150'),
                Text('Muhammad Daffa Safra'),
              ],
            )
          ],
        ),
      ],
    );
  }
}

class QrisPaymentForm extends StatelessWidget {
  const QrisPaymentForm({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'QRIS:',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10.0),
        Text(
          'Gunakan aplikasi pembayaran QRIS untuk membayar (GoPay, ShopeePay, OVO, e-Wallet lainnya, serta Bank yang mendukung fitur QRIS).',
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }
}
