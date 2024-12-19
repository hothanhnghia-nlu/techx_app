import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/order_provider.dart';

class ListOrderPage extends StatefulWidget {
  const ListOrderPage({super.key});

  @override
  State<ListOrderPage> createState() => _ListOrderPageState();
}

class _ListOrderPageState extends State<ListOrderPage> {
  @override
  void initState() {
    Provider.of<OrderProvider>(context, listen: false).refreshOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Management'),
      ),
      body: Consumer<OrderProvider>(
        builder: (context, orderProvider, child) {
          print(orderProvider.orders);
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('ID')),
                DataColumn(label: Text('User')),
                DataColumn(label: Text('Total')),
                DataColumn(label: Text('Payment Method')),
                DataColumn(label: Text('Order Date')),
                DataColumn(label: Text('Status')),
              ],
              rows: orderProvider.orders.map((order) {
                return DataRow(cells: [
                  DataCell(Text(order.id.toString())),
                  DataCell(Text(order.user.fullName)),
                  DataCell(Text(order.total.toString())),
                  DataCell(Text(order.paymentMethod)),
                  DataCell(Text(order.orderDate.toString())),
                  DataCell(
                    DropdownButton<int>(
                      value: order.status,
                      items: const [
                        DropdownMenuItem(
                            value: 0, child: Text('Chờ thanh toán')),
                        DropdownMenuItem(value: 1, child: Text('Đang xử lý')),
                        DropdownMenuItem(
                            value: 2, child: Text('Đang vận chuyển')),
                        DropdownMenuItem(
                            value: 3, child: Text('Giao hàng thành công')),
                        DropdownMenuItem(value: 4, child: Text('Đã hủy')),
                      ],
                      onChanged: (newStatus) {
                        if (newStatus != null) {
                          setState(() {
                            orderProvider.updateOrderStatus(
                                order.id, order.copyWith(status: newStatus));
                          });
                        }
                      },
                    ),
                  ),
                ]);
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
