import 'package:techx_app/pages/category/category_page.dart';
import 'package:techx_app/pages/profile/account_page.dart';
import 'package:techx_app/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class NavigationPage extends StatefulWidget {
  final int initialTabIndex; // Tham số để chọn tab ban đầu
  const NavigationPage({super.key, this.initialTabIndex = 1}); // Giá trị mặc định là tab "Trang chủ"

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialTabIndex; // Gán tab ban đầu từ tham số
  }

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    final _items = [
      SalomonBottomBarItem(
        icon: _selectedIndex == 0 ? const Icon(Icons.category) : const Icon(Icons.category_outlined), 
        title: const Text('Danh mục'),
      ),
      SalomonBottomBarItem(
        icon: _selectedIndex == 1 ? const Icon(Icons.home) : const Icon(Icons.home_outlined), 
        title: const Text('Trang chủ'),
      ),
      SalomonBottomBarItem(
        icon: _selectedIndex == 2 ? const Icon(Icons.person) : const Icon(Icons.person_outline), 
        title: const Text('Tài khoản'),
      ),
    ];

    // ignore: no_leading_underscores_for_local_identifiers
    final List _pages = [
      const CategoryPage(),
      const HomePage(),
      const AccountPage(),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: _pages[_selectedIndex],
      bottomNavigationBar: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 6,
        color: Colors.black,
        margin: const EdgeInsets.all(16.0),
        child: SalomonBottomBar(
          duration: const Duration(seconds: 1),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
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
