// ignore_for_file: file_names

import 'package:flutter/material.dart';

class SliverAppBarPage extends StatelessWidget {
  const SliverAppBarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Sliver App Bar Example'),
              background: Image.asset(
                'assets/register/gurun.jpg', // Menggunakan AssetImage untuk gambar
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return ListTile(
                  title: Text('Item $index'),
                );
              },
              childCount: 50, // Sesuaikan dengan jumlah item yang diperlukan
            ),
          ),
        ],
      ),
    );
  }
}
