// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LittleCard extends StatefulWidget {
  const LittleCard(this.text, this.ColorBG, this.ColorText, {super.key});
  final String text;
  final Color ColorBG, ColorText;

  @override
  State<LittleCard> createState() => _LittleCardState();
}

class _LittleCardState extends State<LittleCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
        color: widget.ColorBG,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: Center(
            child: Text(widget.text,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: widget.ColorText,
                )),
          ),
        ));
  }
}
