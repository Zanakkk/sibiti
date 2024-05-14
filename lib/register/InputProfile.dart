// ignore_for_file: file_names, library_private_types_in_public_api, prefer_const_constructors, unused_element, use_build_context_synchronously, non_constant_identifier_names

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:http/http.dart' as http;

import 'package:sibiti/API/Auth.dart';
import 'Component.dart';
import 'OTP.dart';
import 'package:intl/intl.dart';

class RegistrationFormPage extends StatefulWidget {
  const RegistrationFormPage({
    required this.userId,
    super.key,
  });
  final String userId;
  @override
  State<RegistrationFormPage> createState() => _RegistrationFormPageState();
}

class _RegistrationFormPageState extends State<RegistrationFormPage> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  List<Province> _provinceList = [];
  List<Regency> _regencyList = [];

  List<Map<String, dynamic>> _universityList = [];
  List<Map<String, dynamic>> _departmentList = [];

  List<School> _SchoolList = [];

  String _selectedProvinceCode = '';
  String _selectedRegency = '';

  String _selectedUniversity = '';
  String _selectedDepartment = '';
  String _selectedSchool = '';
  String _selectedDate = '';

  String _selectedProvinceCodename = '';
  String _selectedRegencyname = '';
  String _selectedUniversityname = '';
  String _selectedDepartmentname = '';

  @override
  void initState() {
    super.initState();
    fetchProvinceData();
    fetchUniversityData();
  }

  Future<void> fetchProvinceData() async {
    final response = await http.get(Uri.parse(
        'https://api.allorigins.win/raw?url=https://wilayah.id/api/provinces.json'));
    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];
      setState(() {
        _provinceList = responseData
            .map((province) => Province.fromJson(province))
            .toList();
      });
    } else {
      throw Exception('Failed to load provinces');
    }
  }

  Future<void> fetchRegencyData(String provinceCode) async {
    final response = await http.get(Uri.parse(
        'https://api.allorigins.win/raw?url=https://wilayah.id/api/regencies/$provinceCode.json'));
    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];
      setState(() {
        _regencyList =
            responseData.map((regency) => Regency.fromJson(regency)).toList();
      });
    } else {
      throw Exception('Failed to load regencies');
    }
  }

  Future<void> fetchUniversityData() async {
    final response = await http
        .get(Uri.parse('https://sibiti-backend.vercel.app/universitas'));
    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];
      // Mengambil data id, kode, dan nama saja
      List<Map<String, dynamic>> universities = responseData.map((university) {
        return {
          'id': university['id'],
          'kode': university['kode'],
          'nama': university['nama'],
        };
      }).toList();

      // Menyimpan data universitas ke dalam _universityList
      setState(() {
        _universityList = universities;
      });
    } else {
      throw Exception('Failed to load universities');
    }
  }

  Future<void> fetchDepartmentData(String universityCode) async {
    final response = await http.get(
        Uri.parse('https://sibiti-backend.vercel.app/jurusan/$universityCode'));
    print('mulai');
    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];
      // Mengambil data id, kode, dan nama jurusan saja
      List<Map<String, dynamic>> departments = responseData.map((department) {
        return {
          'id': department['id'],
          'kode': department['kode'],
          'nama': department['nama'],
        };
      }).toList();

      // Menyimpan data jurusan ke dalam _departmentList
      setState(() {
        _departmentList = departments;
      });
    } else {
      throw Exception('Failed to load departments');
    }
  }

  Future<void> inputProfile() async {
    try {
      final response = await http.patch(
        Uri.parse('$InputProfile/${widget.userId}'),
        body: jsonEncode({
          'userId': widget.userId,
          'fullName': _formKey.currentState!.fields['fullName']!.value,
          'username': _formKey.currentState!.fields['username']!.value,
          'born': _selectedDate,
          'province':  _selectedProvinceCodename ,
          'city': _selectedRegencyname,
          'school': _selectedSchool,
          'phoneNumber': _formKey.currentState!.fields['phone']!.value,
          'universitas': _selectedUniversityname,
          'jurusan': _selectedDepartmentname,
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (kDebugMode) {
        print(response.body);
      }

      if (response.statusCode == 200 || response.statusCode == 204) {
        // Data berhasil diinput, pindah ke halaman selanjutnya
        if (kDebugMode) {
          print('sukses');
        }
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OTPForm(),
            ));
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
        title:
            const Text('LOGIN', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              Opacity(
                opacity: 0.3,
                child: Container(
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
                  children: [
                    Expanded(
                      child: ConstrainedBox(
                        constraints: MediaQuery.of(context).size.width < 400
                            ? BoxConstraints(
                                maxWidth: MediaQuery.of(context).size.width,
                                maxHeight:
                                    MediaQuery.of(context).size.height - 120)
                            : BoxConstraints(minWidth: 400),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: FormBuilder(
                            key: _formKey,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
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
                                    Expanded(
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            FormBuilderTextField(
                                              name: 'fullName',
                                              decoration: InputDecoration(
                                                  labelText: 'Name'),
                                              validator: FormBuilderValidators
                                                  .required(),
                                            ),
                                            const SizedBox(height: 8),
                                            FormBuilderTextField(
                                              name: 'username',
                                              decoration: InputDecoration(
                                                  labelText: 'Username'),
                                              validator: FormBuilderValidators
                                                  .required(),
                                            ),
                                            const SizedBox(height: 8),
                                            FormBuilderDateTimePicker(
                                              format: DateFormat(
                                                  "EEEE, d MMMM, yyyy"),
                                              inputType: InputType.date,
                                              inputFormatters: [],
                                              name: 'born',
                                              decoration: InputDecoration(
                                                  labelText: 'Tanggal Lahir'),
                                              validator: FormBuilderValidators
                                                  .required(),
                                              initialDate: DateTime.now(),
                                              onChanged: (value) {
                                                String init =
                                                    '${value?.day} / ${value?.month} / ${value?.year}';
                                                _selectedDate =
                                                    value.toString();
                                                if (kDebugMode) {
                                                  print(_selectedDate);
                                                  print(init);
                                                }
                                              },
                                            ),
                                            const SizedBox(height: 8),
                                            FormBuilderTextField(
                                              name: 'phone',
                                              decoration: InputDecoration(
                                                  labelText: 'Phone Number'),
                                              keyboardType: TextInputType.phone,
                                              validator: FormBuilderValidators
                                                  .compose([
                                                FormBuilderValidators
                                                    .required(),
                                                FormBuilderValidators.minLength(
                                                    10),
                                              ]),
                                            ),
                                            const SizedBox(height: 12),
                                            DropdownButtonFormField(
                                              value: _selectedProvinceCode
                                                      .isNotEmpty
                                                  ? _selectedProvinceCode
                                                  : null,
                                              items: _provinceList
                                                  .map((Province province) {
                                                return DropdownMenuItem<String>(
                                                  value: province.provinceCode,
                                                  child: Text(province.name),
                                                );
                                              }).toList(),
                                              onChanged:
                                                  (selectedProvinceCode) {
                                                setState(() {
                                                  _selectedProvinceCode =
                                                      selectedProvinceCode!;
                                                  _selectedProvinceCodename =
                                                      _provinceList
                                                          .firstWhere((province) =>
                                                              province
                                                                  .provinceCode ==
                                                              selectedProvinceCode)
                                                          .name;
                                                  _selectedRegency = '';
                                                  _regencyList = [];
                                                });
                                              },
                                              decoration: InputDecoration(
                                                labelText: 'Pilih Provinsi',
                                                border: OutlineInputBorder(),
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            DropdownButtonFormField(
                                              value: _selectedRegency.isNotEmpty
                                                  ? _selectedRegency
                                                  : null,
                                              items: _regencyList
                                                  .map((Regency regency) {
                                                return DropdownMenuItem<String>(
                                                  value: regency.regencyCode,
                                                  child: Text(regency.name),
                                                );
                                              }).toList(),
                                              onChanged: (selectedRegency) {
                                                setState(() {
                                                  _selectedRegencyname =
                                                      _regencyList
                                                          .firstWhere((province) =>
                                                              province
                                                                  .regencyCode ==
                                                              selectedRegency)
                                                          .name;
                                                  _selectedRegency =
                                                      selectedRegency!;
                                                });
                                              },
                                              decoration: InputDecoration(
                                                labelText: 'Pilih Kota',
                                                border: OutlineInputBorder(),
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            DropdownButtonFormField(
                                              value: _selectedSchool.isNotEmpty
                                                  ? _selectedSchool
                                                  : null,
                                              items: _SchoolList.map(
                                                  (School school) {
                                                return DropdownMenuItem<String>(
                                                  value: school.schoolCode,
                                                  child: Text(school.name),
                                                );
                                              }).toList(),
                                              onChanged: (selectedSchool) {
                                                setState(() {
                                                  _selectedSchool =
                                                      selectedSchool!;
                                                });
                                              },
                                              decoration: InputDecoration(
                                                labelText: 'Pilih Sekolah',
                                                border: OutlineInputBorder(),
                                              ),
                                            ),
                                            Divider(
                                              color: Colors.black,
                                            ),
                                            const SizedBox(height: 8),
                                            DropdownButtonFormField<String>(
                                              isExpanded: true,
                                              value: _selectedUniversity.isNotEmpty ? _selectedUniversity : null,
                                              items: _universityList.map<DropdownMenuItem<String>>(
                                                    (Map<String, dynamic> university) {
                                                  return DropdownMenuItem<String>(
                                                    value: university['kode'].toString(),
                                                    child: SizedBox(
                                                      width: MediaQuery.of(context).size.width - 96,
                                                      child: Text(
                                                        university['nama'].toString(),
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ).toList(),
                                              onChanged: (selectedUniversity) async {
                                                _departmentList = [];
                                                setState(() {
                                                  _selectedUniversityname = _universityList
                                                      .firstWhere((university) => university['kode'].toString() == selectedUniversity)
                                                  ['nama']
                                                      .toString();
                                                  _selectedUniversity = selectedUniversity!;
                                                  fetchDepartmentData(_selectedUniversity);
                                                });
                                              },
                                              decoration: InputDecoration(
                                                labelText: 'Pilih Universitas',
                                                border: OutlineInputBorder(),
                                              ),
                                            ),

                                            const SizedBox(height: 8),
                                            DropdownButtonFormField<String>(
                                              isExpanded: true,
                                              value: _selectedDepartment.isNotEmpty ? _selectedDepartment : null,
                                              items: _departmentList.map<DropdownMenuItem<String>>(
                                                    (Map<String, dynamic> department) {
                                                  return DropdownMenuItem<String>(
                                                    value: department['id'].toString(),
                                                    child: SizedBox(
                                                      // Menggunakan Expanded untuk memanfaatkan ruang yang tersedia secara maksimal
                                                      child: Text(
                                                        department['nama'].toString(),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ).toList(),
                                              onChanged: (selectedDepartment) {
                                                setState(() {
                                                  _selectedDepartmentname = _departmentList
                                                      .firstWhere((department) => department['id'].toString() == selectedDepartment)
                                                  ['nama']
                                                      .toString();
                                                  _selectedDepartment = selectedDepartment!;
                                                });
                                              },
                                              decoration: InputDecoration(
                                                labelText: 'Pilih Jurusan',
                                                border: OutlineInputBorder(),
                                              ),
                                            ),
                                            const SizedBox(height: 12),
                                          ],
                                        ),
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
                                            inputProfile();
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    (constraints.maxWidth > 400)
                        ? Expanded(
                            child: Card(
                              clipBehavior: Clip.antiAlias,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              elevation: 4,
                              margin: const EdgeInsets.all(8),
                              child: Center(
                                child: Container(
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/register/gurun.jpg'),
                                      fit: BoxFit.cover,
                                    ),
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
