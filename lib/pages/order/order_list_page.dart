import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderListPage extends StatefulWidget {
  final List<Map<String, dynamic>> orders;

  const OrderListPage({super.key, required this.orders});

  @override
  State<OrderListPage> createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  
  String formatCurrency(double amount) {
    return NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(amount);
  }

  String formatDate(String date) {
    final parsedDate = DateTime.parse(date);
    return DateFormat('dd-MM-yyyy HH:mm').format(parsedDate);
  }

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách đơn hàng'),
      ),
      body: ListView.builder(
        itemCount: widget.orders.length,
        itemBuilder: (context, index) {
          final order = widget.orders[index];
          final user = order['user'];
          final address = order['address'];
          final orderDetails = order['orderDetails'] as List<dynamic>;

          return Card(
            margin: const EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header: User Info
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        user['fullName'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'SĐT: ${user['phoneNumber']}',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Email: ${user['email']}',
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 10),

                  // Address
                  Text(
                    'Địa chỉ: ${address['detail']}, ${address['ward']}, ${address['city']}, ${address['province']}',
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 10),

                  // Order Info
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tổng tiền: ${formatCurrency(order['total'])}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Trạng thái: ${order['status'] == 1 ? 'Đã thanh toán' : 'Chưa thanh toán'}',
                        style: const TextStyle(fontSize: 14, color: Colors.green),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Ngày đặt hàng: ${formatDate(order['orderDate'])}',
                    style: const TextStyle(fontSize: 14),
                  ),
                  if (order['paymentDate'] != null)
                    Text(
                      'Ngày thanh toán: ${formatDate(order['paymentDate'])}',
                      style: const TextStyle(fontSize: 14),
                    ),
                  const SizedBox(height: 10),

                  // Order Details
                  const Text(
                    'Chi tiết sản phẩm:',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  ...orderDetails.map((detail) {
                    final product = detail['product'];
                    return ListTile(
                      leading: Image.network(
                        product['images'][0]['url'],
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          height: 50,
                          width: 50,
                          color: Colors.grey.shade300,
                          child: const Icon(Icons.broken_image, color: Colors.grey),
                        ),
                      ),
                      title: Text(
                        product['name'],
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Giá: ${formatCurrency(detail['price'])}'),
                          Text('Số lượng: ${detail['quantity']}'),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
