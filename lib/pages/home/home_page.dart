import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:techx_app/pages/auth/login_page.dart';
import 'package:techx_app/pages/cart/cart_page.dart';
import 'package:techx_app/pages/product/promotion_products_widget.dart';
import 'package:techx_app/pages/search/search_page.dart';
import 'package:techx_app/pages/home/banners_widget.dart';
import 'package:techx_app/pages/product/new_products_widget.dart';
import 'package:techx_app/services/cart_service.dart';

import '../product/all_products_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CartService cartService = CartService();
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
    cartService.getQuantityProduct().then((quantity) {
      cartService.cartItemSize.value = quantity;
    });
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken');
    setState(() {
      isLoggedIn = token != null; 
    });
  }

  // Nút giỏ hàng
  void _cartButton() {
    if (isLoggedIn) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const ShoppingCartPage()),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        title: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const SearchPage()),
            );
          },
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(color: Color(hexColor('#D7CCC8'))),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Row(
                  children: [
                    Icon(Icons.search, color: Color(hexColor('#CACACA'))),
                    const SizedBox(width: 5),
                    Text(
                      'Bạn muốn mua gì hôm nay?',
                      style: TextStyle(
                        color: Color(hexColor('#CACACA')),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: ValueListenableBuilder<int>(
              valueListenable: cartService.cartItemSize, // Lắng nghe thay đổi
              builder: (context, value, child) {
                return badges.Badge(
                  badgeContent: Text(
                    '$value', // Hiển thị số lượng sản phẩm
                    style: const TextStyle(color: Colors.white),
                  ),
                  child: GestureDetector(
                    onTap: _cartButton,
                    child: Icon(
                      Icons.shopping_cart_outlined,
                      color: Color(hexColor('#5D4037')),
                      size: 30,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BannerWidget(),

            const SizedBox(height: 20),
        
            // Sản phẩm mới
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Sản phẩm mới',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => AllProductsPage(
                                productKey: 'new-product', // Key cho sản phẩm mới
                                title: 'Sản phẩm mới',
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          'Xem tất cả',
                          style: TextStyle(
                            color: Color(0xff386692),
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
        
                  const NewProductsWidget(),
                ],
              ),
            ),

            // Sản phẩm bán chạy
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Sản phẩm bán chạy',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => AllProductsPage(
                                productKey: 'new-product', // Key cho sản phẩm mới
                                title: 'Sản phẩm mới',
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          'Xem tất cả',
                          style: TextStyle(
                            color: Color(0xff386692),
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
        
                  const NewProductsWidget(),
                ],
              ),
            ),
            
            // Sản phẩm khuyến mãi
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Sản phẩm khuyến mãi',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => AllProductsPage(
                                productKey: 'promotion-product', // Key cho sản phẩm khuyến mãi
                                title: 'Sản phẩm khuyến mãi',
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          'Xem tất cả',
                          style: TextStyle(
                            color: Color(0xff386692),
                            fontSize: 13,
                          ),
                        ),
                      ),

                    ],
                  ),
        
                  const PromotionProductsWidget(),
                ],
              ),
            ),
          ],
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