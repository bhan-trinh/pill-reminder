import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    return Scaffold(
      bottomNavigationBar: Obx (
        () => NavigationBar(
        selectedIndex: controller.selectedIndex.value,
        onDestinationSelected: (index) => controller.selectedIndex.value = index,
        destinations: [
          NavigationDestination(icon: const Icon(Icons.home), label: "Home"),
          NavigationDestination(icon: const Icon(Icons.book), label: "Prescriptions"),
          NavigationDestination(icon: const Icon(Icons.settings), label: "Settings"),
        ],
        )
        ),
        body: controller.screens[controller.selectedIndex.value],
    );
  }
}

class NavigationController extends GetxController{
  final Rx<int> selectedIndex = 0.obs;
  final screens = [
    const HomePage(),
    Container(),
    Container(),
    ];
}