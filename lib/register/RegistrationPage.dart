// ignore_for_file: file_names, use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hive/hive.dart';
import 'package:sibiti/API/Auth.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sibiti/data.dart';

import 'InputProfile.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  Future<void> signUp() async {
    try {
      final response = await http.post(
        Uri.parse(SignUp),
        body: jsonEncode({
          'email': _usernameController.text,
          'password': _passwordController.text,
          // Tambahkan data tambahan yang diperlukan
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (kDebugMode) {
        if (kDebugMode) {
          print(response.body);
        }
      }

      if (response.statusCode == 201) {
        // Sign up berhasil, pindah ke halaman selanjutnya
        final Map<String, dynamic> responseData = json.decode(response.body);
        responseData['userId'].toString();
        final box = await Hive.openBox<Data>('DataBox');
        await box.put(
            'userData',
            Data(
                userId: responseData['userId'].toString(),
                email: _usernameController.text));
        print('user id : ${responseData['userId']}');
        print('email : ${_usernameController.text}');

        // Navigasi ke RegistrationFormPage dengan menyertakan userId sebagai parameter

        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RegistrationFormPage(userId: responseData['userId'].toString()),
            ));

      } else if (response.statusCode == 400) {
        // Email sudah terdaftar
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('E-mail sudah terdaftar'),
            content: const Text('Coba gunakan e-mail lainnya.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else {
        // Handle error lainnya
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
        title: const Text('REGISTRASI',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              Opacity(
                opacity: 0.7,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/register/gurun.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Card(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                margin: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: (constraints.maxWidth > 720) ? 1 : 1,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: FormBuilder(
                          key: _formKey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: SingleChildScrollView(
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: MediaQuery.of(context).size.width,
                                maxHeight:
                                    MediaQuery.of(context).size.height - 150,
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(height: 24),
                                      Text(
                                        'Selamat Datang di ReCheck',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        'Ayo Buat Akunmu',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12),
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 12),
                                        FormBuilderTextField(
                                          name: 'email',
                                          decoration: const InputDecoration(
                                            labelText: 'Email',
                                          ),
                                          validator:
                                              FormBuilderValidators.compose([
                                            FormBuilderValidators.required(),
                                            FormBuilderValidators.email(),
                                          ]),
                                          controller: _usernameController,
                                        ),
                                        const SizedBox(height: 12),
                                        FormBuilderTextField(
                                          name: 'password',
                                          decoration: const InputDecoration(
                                            labelText: 'Password',
                                          ),
                                          obscureText: true,
                                          validator:
                                              FormBuilderValidators.compose([
                                            FormBuilderValidators.required(),
                                            FormBuilderValidators.minLength(8),
                                          ]),
                                          controller: _passwordController,
                                        ),
                                        const SizedBox(height: 12),
                                        const SizedBox(height: 20),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        child: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              100,
                                          child: Card(
                                            clipBehavior: Clip.antiAlias,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                            elevation: 4,
                                            margin: const EdgeInsets.all(8),
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            child: const Padding(
                                              padding: EdgeInsets.all(24),
                                              child: Text(
                                                'Daftar',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        onTap: () {
                                          signUp();
                                        },
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text('Sudah Punya Akun ? '),
                                          TextButton(
                                            onPressed: () {},
                                            child: const Text('Masuk'),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Expanded(
                                    child: HiveDataWidget(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    (constraints.maxWidth > 400)
                        ? Expanded(
                            flex: constraints.maxWidth > 400 ? 2 : 0,
                            child: Card(
                              clipBehavior: Clip.antiAlias,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              elevation: 4,
                              margin: const EdgeInsets.all(8),
                              child: Container(
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image:
                                        AssetImage('assets/register/gurun.jpg'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class HiveDataWidget extends StatelessWidget {
  const HiveDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Box<Data>>(
      future: Hive.openBox<Data>(
          'DataBox'), // Menggunakan fungsi untuk membuka kotak data
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData) {
          final boxData = snapshot.data!;
          final dataList = boxData.values.toList();
          return ListView.builder(
            itemCount: dataList.length,
            itemBuilder: (context, index) {
              final data = dataList[index];
              return ListTile(
                title: Text(data.userId),
                subtitle: Text(data.email),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return const Center(
              child:
                  Text('Tidak ada data yang tersimpan dalam local storage.'));
        }
      },
    );
  }
}
