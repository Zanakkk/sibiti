// ignore_for_file: file_names, library_private_types_in_public_api

import 'dart:convert';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UniversityDropdown extends StatefulWidget {
  const UniversityDropdown({super.key});

  @override
  _UniversityDropdownState createState() => _UniversityDropdownState();
}

class _UniversityDropdownState extends State<UniversityDropdown> {
  List<dynamic> universities = [];
  String selectedUniversityId = '';
  String selectedUniversityName = '';
  List<String> activePrograms = [];
  String selectedProgram = '';
  TextEditingController textEditingController = TextEditingController();
  bool isDataLoaded = false; // Flag to indicate if data is loaded

  Future<void> fetchUniversities() async {
    final response = await http
        .get(Uri.parse('https://api-frontend.kemdikbud.go.id/loadpt'));
    if (response.statusCode == 200) {
      List<dynamic> unsortedData = json.decode(response.body);

      // Sort universities alphabetically by their names
      unsortedData.sort(
          (a, b) => (a['nama_pt'] as String).compareTo(b['nama_pt'] as String));

      setState(() {
        universities = unsortedData;
        isDataLoaded = true; // Set flag to true when data is loaded
      });
    } else {
      throw Exception('Failed to load universities');
    }
  }

  Future<void> masterfetchUniversities() async {
    final response = await http
        .get(Uri.parse('https://api-frontend.kemdikbud.go.id/loadpt'));
    if (response.statusCode == 200) {
      List<dynamic> unsortedData = json.decode(response.body);

      // Sort universities alphabetically by their names
      unsortedData.sort(
          (a, b) => (a['nama_pt'] as String).compareTo(b['nama_pt'] as String));

      // List to store universities without active programs
      List<dynamic> updatedData = [];

      // Iterate through each university data
      for (var data in unsortedData) {
        final response2 = await http.get(Uri.parse(
            'https://api-frontend.kemdikbud.go.id/v2/detail_pt_prodi/${data['id_sp']}'));
        if (response2.statusCode == 200) {
          List<dynamic> responseData = json.decode(response2.body);
          bool hasActiveProgram =
              responseData.any((dataa) => dataa['stat_prodi'] == "Aktif");
          if (!hasActiveProgram) {
            updatedData.add(data);
          }
        } else {
          if (kDebugMode) {
            print('Failed to fetch data. Error: ${response2.statusCode}');
          }
        }
      }

      setState(() {
        universities = updatedData;
        isDataLoaded = true; // Set flag to true when data is loaded
      });
    } else {
      throw Exception('Failed to load universities');
    }
  }

  Future<void> fetchUniversityData(String encodedUniversityID) async {
    final response = await http.get(Uri.parse(
        'https://api-frontend.kemdikbud.go.id/v2/detail_pt_prodi/$encodedUniversityID'));

    if (response.statusCode == 200) {
      List<dynamic> responseData = json.decode(response.body);
      List<String> filteredData = [];

      for (var data in responseData) {
        if (data['stat_prodi'] == "Aktif") {
          filteredData.add(data['nm_lemb']);
        }
      }

      setState(() {
        activePrograms = filteredData;
      });
    } else {
      if (kDebugMode) {
        print('Failed to fetch data. Error: ${response.statusCode}');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUniversities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('University Dropdown'),
      ),
      body: Center(
        child: isDataLoaded
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      hint: Text(
                        'Select University',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      items: universities
                          .map((uni) => DropdownMenuItem(
                                value: uni['nama_pt'] as String,
                                child: Text(
                                  uni['nama_pt'] as String,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ))
                          .toList(),
                      value: selectedUniversityName.isNotEmpty
                          ? selectedUniversityName
                          : null,
                      onChanged: (newValue) {
                        setState(() {
                          selectedUniversityName = newValue!;
                          selectedUniversityId = universities.firstWhere(
                                  (uni) => uni['nama_pt'] == newValue)['id_sp']
                              as String;
                          fetchUniversityData(
                              base64Encode(utf8.encode(selectedUniversityId)));
                          selectedProgram =
                              ''; // Reset selected program when university changes
                        });
                      },
                      buttonStyleData: const ButtonStyleData(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        height: 40,
                        width: 200,
                      ),
                      dropdownStyleData: const DropdownStyleData(
                        maxHeight: 200,
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        height: 40,
                      ),
                      dropdownSearchData: DropdownSearchData(
                        searchController: textEditingController,
                        searchInnerWidgetHeight: 50,
                        searchInnerWidget: Container(
                          height: 50,
                          padding: const EdgeInsets.only(
                            top: 8,
                            bottom: 4,
                            right: 8,
                            left: 8,
                          ),
                          child: TextFormField(
                            expands: true,
                            maxLines: null,
                            controller: textEditingController,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 8,
                              ),
                              hintText: 'Search for a university...',
                              hintStyle: const TextStyle(fontSize: 12),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        searchMatchFn: (item, searchValue) {
                          return item.value.toString().contains(searchValue);
                        },
                      ),
                      // This to clear the search value when you close the menu
                      onMenuStateChange: (isOpen) {
                        if (!isOpen) {
                          textEditingController.clear();
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      hint: Text(
                        'Pilih Program Studi',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      items: activePrograms
                          .map((program) => DropdownMenuItem(
                                value: program,
                                child: Text(
                                  program,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ))
                          .toList(),
                      value:
                          selectedProgram.isNotEmpty ? selectedProgram : null,
                      onChanged: (newValue) {
                        setState(() {
                          selectedProgram = newValue!;
                        });
                      },
                      buttonStyleData: const ButtonStyleData(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        height: 40,
                        width: 200,
                      ),
                      dropdownStyleData: const DropdownStyleData(
                        maxHeight: 200,
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        height: 40,
                      ),
                    ),
                  ),
                ],
              )
            : const CircularProgressIndicator(), // Show loading indicator while data is being fetched
      ),
    );
  }
}
