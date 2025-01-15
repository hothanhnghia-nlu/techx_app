import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:techx_app/models/order_model.dart';
import 'package:techx_app/utils/constant.dart';

class RecentOrderWidget extends StatefulWidget {
  const RecentOrderWidget({super.key});

  @override
  State<RecentOrderWidget> createState() => _RecentOrderWidgetState();
}

class _RecentOrderWidgetState extends State<RecentOrderWidget> {
  final baseUrl = Constant.api;
  List<dynamic> orders = [];

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  // Fetch data from API
  Future<void> fetchOrders() async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/orders/all-orders"));
      if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
        setState(() {
          orders = jsonData.map((item) => Order.fromJson(item)).toList();
        });
      } else {
        throw Exception("Failed to load orders");
      }
    } catch (e) {
      print('Error fetching orders: $e');
    }
  }

  // Định dạng đơn vị tiền tệ
  String formatCurrency(double orginalCurrency) {
    var formatter = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');
    return formatter.format(orginalCurrency);
  }

  @override
  Widget build(BuildContext context) {
    final recentOrders = orders.length > 5
        ? orders.sublist(orders.length - 5)
        : orders;

    return orders.isEmpty
        ? const Center(
            child: Text('Không có đơn hàng nào'),
          )
        : ListView.builder(
            shrinkWrap: true,
            itemCount: recentOrders.length,
            itemBuilder: (context, index) {
              final order = recentOrders[index];
              return Card(
                surfaceTintColor: Colors.white,
                elevation: 3,
                color: Colors.white,
                shadowColor: Color(hexColor('#303F4F4F')),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Color(hexColor('#F0F1F0')),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.fire_truck_outlined,
                              color: Color(hexColor('#9DA2A7'))),
                          const SizedBox(width: 8),
                          Text(
                            order.status.toString() == "0"
                          ? 'Chờ thanh toán'
                          : order.status.toString() == "1"
                              ? 'Đang xử lý'
                              : order.status.toString() == "2"
                                  ? 'Đang vận chuyển'
                                  : order.status.toString() == "3"
                                      ? 'Giao hàng thành công'
                                      : 'Đã hủy',
                            style: TextStyle(
                              fontSize: 15,
                              color: Color(hexColor('#9DA2A7')),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Divider(color: Color(0xffF6F6F6)),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            order.orderDetails.length > 0
                                ? order.orderDetails[0].product.images[0].url
                                : '',
                            width: 100,
                            height: 100,
                          ),
                          const SizedBox(width: 10),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                order.orderDetails.length > 0
                                    ? order.orderDetails[0].product.name
                                    : '',
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              SizedBox(
                                width: 230,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Text(
                                          'Số lượng:',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Color(0xFF9DA2A7),
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          order.orderDetails.length > 0
                                              ? order.orderDetails[0].quantity
                                                  .toString()
                                              : "",
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Color(0xFF9DA2A7),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      formatCurrency(
                                          order.orderDetails.isNotEmpty
                                              ? order.total
                                              : 0),
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF9DA2A7),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8),
                              SizedBox(
                                width: 230,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Ngày đặt hàng',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF9DA2A7)),
                                    ),
                                    Text(
                                      DateFormat('dd-MM-yyyy hh:mm').format(
                                          order.orderDetails.isNotEmpty
                                              ? order.orderDate
                                              : DateTime.now()),
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF9DA2A7)),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          );
  }
}

int hexColor(String color) {
  String newColor = "0xff$color";
  newColor = newColor.replaceAll('#', '');
  int finalColor = int.parse(newColor);
  return finalColor;
}