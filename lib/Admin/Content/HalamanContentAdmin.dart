// ignore_for_file: file_names, prefer_const_constructors

// HalamanContentAdmin.dart
import 'package:flutter/material.dart';
import 'package:sibiti/Admin/Content/DashboardTO/DashboardTO.dart';

class HalamanContent extends StatefulWidget {
  final int index;

  const HalamanContent({required this.index, super.key});

  @override
  State<HalamanContent> createState() => _HalamanContentState();
}

class _HalamanContentState extends State<HalamanContent> {
  List<Widget> indextext = [
    Text('Dashboard Admin'),
    DashboardTO(),
    Text('Admin'),
    Text('Tentor'),
    Text('Siswa')
  ];
  @override
  Widget build(BuildContext context) {
    return Center(
      child: indextext[widget.index],
    );
  }
}
