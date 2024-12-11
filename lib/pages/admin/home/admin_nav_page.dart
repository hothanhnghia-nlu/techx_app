import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:techx_app/pages/admin/home/admin_home_page.dart';
import 'package:techx_app/pages/admin/home/dashboard_page.dart';
import 'package:techx_app/pages/admin/profile/admin_profile_page.dart';

class AdminNavigationPage extends StatefulWidget {
  const AdminNavigationPage({super.key});

  @override
  State<AdminNavigationPage> createState() => _AdminNavigationPageState();
}

class _AdminNavigationPageState extends State<AdminNavigationPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    final _items = [
      SalomonBottomBarItem(
        icon: _selectedIndex == 0 ? const Icon(Icons.home) : const Icon(Icons.home_outlined), 
        title: const Text('Trang chủ'),
      ),
      SalomonBottomBarItem(
        icon: _selectedIndex == 1 ? const Icon(Icons.dashboard) : const Icon(Icons.dashboard_outlined), 
        title: const Text('Bảng điều khiển'),
      ),
      SalomonBottomBarItem(
        icon: _selectedIndex == 2 ? const Icon(Icons.person) : const Icon(Icons.person_outline), 
        title: const Text('Cá nhân'),
      ),
    ];

    // ignore: no_leading_underscores_for_local_identifiers
    final List _pages = [
      const AdminHomePage(),
      const DashboardPage(),
      const AdminProfilePage(),
    ];

    return Scaffold(
      backgroundColor: Color(hexColor('#f4f6f9')),
      body: _pages[_selectedIndex],
      bottomNavigationBar: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 6,
        color: Colors.white,
        margin: const EdgeInsets.all(16.0),
        child: SalomonBottomBar(
          duration: const Duration(seconds: 1),
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          items: _items,
          currentIndex: _selectedIndex,
          onTap: (index) => setState(() {
            _selectedIndex = index;
          }),
          itemPadding: const EdgeInsets.all(8),
        ),
      ),
    );
  }
}

int hexColor(String color) {
  String newColor = "0xff$color";
  newColor = newColor.replaceAll('#', '');
  int finalColor = int.parse(newColor);
  return finalColor;
}