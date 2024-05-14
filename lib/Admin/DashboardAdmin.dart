// ignore: file_names
// DashboardAdmin.dart
// ignore_for_file: file_names, duplicate_ignore

import 'package:flutter/material.dart';

import 'Content/HalamanContentAdmin.dart';
import 'Nav/WidgetNav.dart';

class DashboardAdmin extends StatefulWidget {
  const DashboardAdmin({super.key});

  @override
  State<DashboardAdmin> createState() => _DashboardAdminState();
}

class _DashboardAdminState extends State<DashboardAdmin> {
  int index = 0;

  List<String> indextext = [
    'Dashboard Admin',
    'TryOut',
    'Admin',
    'Tentor',
    'Siswa'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          indextext[index],
        ),
        elevation: 5,
        centerTitle: true,
      ),
      body: Row(
        children: [
          SizedBox(
            width: 200,
            child: AdminNav(
              onNavItemTap: (selectedIndex) {
                setState(() {
                  index = selectedIndex;
                });
              },
            ),
          ),
          const VerticalDivider(
            width: 1,
            thickness: 2,
          ),
          Expanded(
            child: HalamanContent(index: index),
          )
        ],
      ),
    );
  }
}
