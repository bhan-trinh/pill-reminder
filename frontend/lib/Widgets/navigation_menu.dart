import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Pages/home.dart';
import '../Pages/prescript.dart';
import '../Themes/AppColors.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    return Scaffold(
      bottomNavigationBar: Obx (
        () => NavigationBar(
        backgroundColor: AppColors.secondaryBackground,
        indicatorColor: AppColors.accent1,
        selectedIndex: controller.selectedIndex.value,
        onDestinationSelected: (index) {
          controller.selectedIndex.value = index;
          },
        destinations: [
          NavigationDestination(icon: const Icon(Icons.home, color: Colors.black), label: "Home"),
          NavigationDestination(icon: const Icon(Icons.book, color: Colors.black), label: "Prescriptions"),
          NavigationDestination(icon: const Icon(Icons.settings, color: Colors.black), label: "Settings"),
        ],
        )
        ),
        body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController{
  final Rx<int> selectedIndex = 0.obs;
  final screens = [
    const HomePage(),
    const PrescriptPage(),
    Container(),
    ];
}