// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

class LihatFoto extends StatelessWidget {
  const LihatFoto({
    super.key,
    required this.foto,
  });
  final String? foto;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.width,
        width: MediaQuery.of(context).size.width,
        child: PinchZoom(
          resetDuration: const Duration(milliseconds: 100),
          maxScale: 2.5,
          onZoomStart: (){},
          onZoomEnd: (){},
          child: Image.network(foto!),
        ),);
  }
}
