import 'package:flutter/material.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: 0,
        onDestinationSelected: (index) => {

        },
        destinations: [
          NavigationDestination(icon: const Icon(Icons.home), label: "Home"),
          NavigationDestination(icon: const Icon(Icons.book), label: "Prescriptions"),
          NavigationDestination(icon: const Icon(Icons.settings), label: "Settings"),
          Container(),
        ],
        ),
        body: Container(),
    );
  }
}
