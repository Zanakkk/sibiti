// ignore_for_file: file_names

import 'package:flutter/material.dart';

class NavBarButton extends StatefulWidget {
  const NavBarButton({
    required this.text,
    required this.selected,
    required this.onTap,
    super.key,
  });

  final String text;
  final Function() onTap;
  final bool selected;
  @override
  State<NavBarButton> createState() => _NavBarButtonState();
}

class _NavBarButtonState extends State<NavBarButton> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: widget.selected ? Colors.white : Colors.red,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 4,
      margin: const EdgeInsets.all(8),
      child: InkWell(
        onTap: widget.onTap,
        child: SizedBox(
          width: 120,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Text(
              widget.text,
              style:
                  TextStyle(color: widget.selected ? Colors.red : Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
