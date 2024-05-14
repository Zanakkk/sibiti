// ignore_for_file: file_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

import '../main.dart';
import 'package:sibiti/API/Auth.dart';

import 'package:http/http.dart' as http;

class OTPForm extends StatelessWidget {
  const OTPForm({
    super.key,
  });

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse(VerificationOTP));

      if (response.statusCode == 200) {
        // Data berhasil diambil
        if (kDebugMode) {
          print(response.body);
        }
      } else {
        // Handle kesalahan lainnya
        if (kDebugMode) {
          print('Error: ${response.statusCode}');
        }
      }
    } catch (e) {
      // Handle error
      if (kDebugMode) {
        print('Error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OTP', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: const EdgeInsets.all(8),
            child: Card(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Masukkan Kode OTP',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Kami sudah mengirimkan 6 digit kode OTP, masukkan dibawah ini',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 32),
                    _buildOTPField(context),
                    const SizedBox(height: 32),
                    _buildResendOTPButton(),
                    const Spacer(),
                    _buildVerifyButton(context),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildOTPField(BuildContext context) {
    return OTPTextField(
      length: 6,
      width: MediaQuery.of(context).size.width,
      fieldWidth: 40,
      style: const TextStyle(fontSize: 17),
      textFieldAlignment: MainAxisAlignment.spaceAround,
      fieldStyle: FieldStyle.underline,
      onChanged: (pin) {
        // Handle OTP input
      },
      onCompleted: (pin) {
        // OTP completed
      },
    );
  }

  Widget _buildResendOTPButton() {
    return TextButton(
      onPressed: () {
        // Action to resend OTP
      },
      child: const Text(
        'Kirim Ulang Kode',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
      ),
    );
  }

  Widget _buildVerifyButton(context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Selamat'),
                content: const Text(
                    'Anda Telah Berhasil Registrasi Akun, Silahkan Login Untuk Melanjutkan.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement((MaterialPageRoute(
                          builder: (context) => const MyHomePage())));
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Text(
          'Verifikasi',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
