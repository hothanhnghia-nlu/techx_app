import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techx_app/pages/order/order_items_widget.dart';
import 'package:techx_app/providers/order_provider.dart';

import '../../models/order_model.dart';
import '../home/navigation_page.dart';

class MyOrdersPage extends StatefulWidget {
  final String previousPage; // Tham số để xác định nguồn điều hướng

  const MyOrdersPage({Key? key, required this.previousPage}) : super(key: key);

  @override
  State<MyOrdersPage> createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
  List<Order> orders = [];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<OrderProvider>(context, listen: false).refreshOrdersByUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
    orders = orderProvider.orders;

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
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              if (widget.previousPage == 'CheckoutPage') {
                // Nếu đến từ CheckoutPage, quay lại Trang chủ
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (_) => const NavigationPage(initialTabIndex: 1)),
                  (route) => false,
                );
              } else if (widget.previousPage == 'AccountPage') {
                // Nếu đến từ AccountPage, quay lại AccountPage
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (_) => const NavigationPage(initialTabIndex: 2)),
                  (route) => false,
                );
              }
            },
          ),
        ),
        body: orders.isEmpty
            ? Center(child: CircularProgressIndicator())
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.white,
                    height: 45,
                    alignment: Alignment.centerLeft,
                    child: TabBar(
                      isScrollable: true,
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
                  Expanded(
                    child: TabBarView(
                      children: [
                        OrderItemsWidget(
                          orders: orders,
                        ),
                        OrderItemsWidget(
                            orders: orders
                                .where((order) => order.status.toString() == '1')
                                .toList()),
                        OrderItemsWidget(
                            orders: orders
                                .where((order) => order.status.toString() == '2')
                                .toList()),
                        OrderItemsWidget(
                            orders: orders
                                .where((order) => order.status.toString() == '3')
                                .toList()),
                        OrderItemsWidget(
                            orders: orders
                                .where((order) => order.status.toString() == '4')
                                .toList()),
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