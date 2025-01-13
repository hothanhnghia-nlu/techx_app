import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/order_model.dart';
import '../../utils/currency.dart';

class OrderItemsWidget extends StatelessWidget {
  final List<Order> orders;

  const OrderItemsWidget({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    return orders.isEmpty
        ? const Center(
            child: Text('Không có đơn hàng nào'),
          )
        : ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
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
                            'Trạng thái đơn hàng',
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
