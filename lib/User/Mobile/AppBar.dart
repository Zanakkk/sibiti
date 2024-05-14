// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sibiti/User/Mobile/Setting/Setting.dart';

class SibitiAppBar extends StatefulWidget {
  const SibitiAppBar({
    required this.show,
    required this.materiatauTO,
    required this.setting,
    super.key,
  });

  final bool show;
  final bool materiatauTO;
  final bool setting;

  @override
  State<SibitiAppBar> createState() => _SibitiAppBarState();
}

class _SibitiAppBarState extends State<SibitiAppBar> {
  TextEditingController konten = TextEditingController();
  String nama = 'Daffa';

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: widget.setting
            ? buildWithSettings(context)
            : buildWithoutSettings(context),
      ),
    );
  }

  Widget buildWithSettings(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Halo $nama',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w400,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        Center(
          child: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsPage(),
                ),
              );
            },
            icon: const Icon(Icons.settings),
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget buildWithoutSettings(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Text(
          'Halo $nama',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w400,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        if (widget.show) const SizedBox(height: 24),
        if (widget.show)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                flex: 6,
                child: TextFormField(
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    focusColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    hintText: widget.materiatauTO
                        ? 'Temukan materi yang kamu suka'
                        : 'Temukan TO yang kamu suka',
                    fillColor: Colors.white,
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    hintStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: "verdana_regular",
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  controller: konten,
                  onTapOutside: (value) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
              ),
              Flexible(
                flex: 1,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    LineIcons.bell,
                    size: 24,
                    color: Colors.white,
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.bookmark,
                    size: 24,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
