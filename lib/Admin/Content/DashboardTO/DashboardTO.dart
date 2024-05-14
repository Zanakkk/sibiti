// ignore_for_file: file_names

import 'package:flutter/material.dart';

class DashboardTO extends StatefulWidget {
  const DashboardTO({super.key});

  @override
  State<DashboardTO> createState() => _DashboardTOState();
}

class _DashboardTOState extends State<DashboardTO> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text('Ini dashboard TO'),
      ],
    );
  }
}
