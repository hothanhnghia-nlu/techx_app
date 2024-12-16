import 'package:flutter/material.dart';
import 'package:techx_app/pages/admin/category/category_table.dart';
import 'package:techx_app/pages/admin/customer/customer_table.dart';
import 'package:techx_app/pages/admin/order/list_order_page.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> titles = [
      'Khách hàng',
      'Đơn hàng',
      'Danh mục',
      'Sản phẩm',
      'Đánh giá',
    ];

    final List<String> icons = [
      'assets/customers_icon.png',
      'assets/orders_icon.png',
      'assets/categories_icon.png',
      'assets/products_icon.png',
      'assets/reviews_icon.png',
    ];

    final List<Widget> pages = [
      const CustomerTable(), // replace by CustomerTable
      const ListOrderPage(), // replace by OrderTable
      const CategoryTable(),
      const CategoryTable(), // replace by ProductTable
      const CategoryTable(), // replace by ReviewTable
    ];

    return Scaffold(
      backgroundColor: Color(hexColor('#f4f6f9')),
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Bảng điều khiển',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              childAspectRatio: 0.8,
          ),
          itemCount: titles.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => pages[index],
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      icons[index],
                      height: 90,
                      width: 90,
                    ),
                    Text(
                      titles[index],
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
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