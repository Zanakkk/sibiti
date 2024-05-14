// ignore_for_file: file_names

import 'package:flutter/material.dart';

import 'NavBar/NavBarButton.dart';

class NavBarSibiti extends StatefulWidget {
  final void Function(int) onNavItemTap;

  const NavBarSibiti({
    required this.onNavItemTap,
    super.key,
  });

  @override
  State<NavBarSibiti> createState() => _NavBarSibitiState();
}


class _NavBarSibitiState extends State<NavBarSibiti> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Card(
        color: Theme.of(context).colorScheme.inversePrimary,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'SIBITI',
                style: TextStyle(fontSize: 24),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  NavBarButton(
                    text: 'Home',
                    selected: _selectedIndex == 0,
                    onTap: () {
                      widget.onNavItemTap(0);
                      setState(() {
                        _selectedIndex = 0;
                      });
                    },
                  ),
                  NavBarButton(
                    text: 'Ujian',
                    selected: _selectedIndex == 1,
                    onTap: () {
                      widget.onNavItemTap(1);
                      setState(() {
                        _selectedIndex = 1;
                      });
                    },
                  ),
                  NavBarButton(
                    text: 'Info',
                    selected: _selectedIndex == 2,
                    onTap: () {
                      widget.onNavItemTap(2);
                      setState(() {
                        _selectedIndex = 2;
                      });
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
