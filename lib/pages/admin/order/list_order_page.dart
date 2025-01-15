import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:techx_app/utils/date_format.dart';

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

  // Định dạng đơn vị tiền tệ
  String formatCurrency(double orginalCurrency) {
    var formatter = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');
    return formatter.format(orginalCurrency);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 5,
        shadowColor: Color(hexColor('#F0F1F0')),
        title: const Text(
          'Quản lý đơn hàng',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
          ),
        ),
      ),
      body: Consumer<OrderProvider>(
        builder: (context, orderProvider, child) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('STT')),
                DataColumn(label: Text('Tên khách hàng')),
                DataColumn(label: Text('Thành tiền')),
                DataColumn(label: Text('Phương thức thanh toán')),
                DataColumn(label: Text('Ngày đặt hàng')),
                DataColumn(label: Text('Trạng thái')),
              ],
              rows: orderProvider.orders.map((order) {
                return DataRow(cells: [
                  DataCell(Text(order.id.toString())),
                  DataCell(Text(order.user.fullName)),
                  DataCell(Text(formatCurrency(order.total))),
                  DataCell(Text(order.paymentMethod)),
                  DataCell(Text(formatDateTime(order.orderDate.toString()))),
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

int hexColor(String color) {
  String newColor = "0xff$color";
  newColor = newColor.replaceAll('#', '');
  return int.parse(newColor);
}
