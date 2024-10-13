import 'package:flutter/material.dart';
import 'package:techx_app/pages/order/order_items_widget.dart';

class MyOrdersPage extends StatefulWidget {
  const MyOrdersPage({super.key});

  @override
  State<MyOrdersPage> createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 5,
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          elevation: 5,
          shadowColor: Color(hexColor('#F0F1F0')),
          automaticallyImplyLeading: true,
          title: const Text(
            'Đơn hàng của tôi',
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.white,
              height: 45,
              alignment: Alignment.centerLeft,
              child: TabBar(
                isScrollable:true,
                indicatorColor: Colors.red[700],
                labelColor: Colors.red[700],
                unselectedLabelColor: Color(hexColor('#868686')),
                labelStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
                tabs: const [
                  Tab(text: 'Tất cả đơn'),
                  Tab(text: 'Đang xử lý'),
                  Tab(text: 'Đang vận chuyển'),
                  Tab(text: 'Đã giao'),
                  Tab(text: 'Đã hủy'),
                ],
              ),
            ),
            
            const Expanded(
              child: TabBarView(
                children: [
                  OrderItemsWidget(),
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