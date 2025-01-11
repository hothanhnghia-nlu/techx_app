import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:techx_app/models/order_model.dart';
import 'package:techx_app/utils/date_format%20.dart';

class OrderDetailPage extends StatelessWidget {
  final Order order;
  const OrderDetailPage({super.key, required this.order});

  // Định dạng đơn vị tiền tệ
  String formatCurrency(double orginalCurrency) {
    var formatter = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');
    return formatter.format(orginalCurrency);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 5,
        shadowColor: Color(hexColor('#F0F1F0')),
        title: const Text(
          'Thông tin đơn hàng',
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.fire_truck_outlined),
                      SizedBox(width: 8),
                      Text(
                        'Thông tin đơn hàng',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Mã đơn hàng',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xff9DA2A7),
                        ),
                      ),
                      Text(
                        order.id.toString(),
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Thời gian đặt hàng',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xff9DA2A7),
                        ),
                      ),
                      Text(
                        formatDateTime(order.orderDate.toString()),
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xff9DA2A7),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Thời gian thanh toán',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xff9DA2A7),
                        ),
                      ),
                      Text(
                        formatDateTime(
                          order.paymentDate == null
                              ? DateTime.now().toString()
                              : order.paymentDate.toString(),
                        ),
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xff9DA2A7),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Trạng thái đơn hàng',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xff9DA2A7),
                        ),
                      ),
                      Text(
                        // Các trạng thái đơn hàng: 0 - Chờ thanh toán ; 1 - Đang xử lý ; 2 - Đang vận chuyển ; 3 - Giao hàng thành công ; 4 - Đã hủy
                        order.status.toString() == "0"
                            ? 'Chờ thanh toán'
                            : order.status.toString() == "1"
                                ? 'Đang xử lý'
                                : order.status.toString() == "2"
                                    ? 'Đang vận chuyển'
                                    : order.status.toString() == "3"
                                        ? 'Giao hàng thành công'
                                        : 'Đã hủy',
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xff9DA2A7),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.location_on_outlined),
                      SizedBox(width: 8),
                      Text(
                        'Địa chỉ nhận hàng',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Text(
                        'Họ tên người nhận',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xff9DA2A7),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        order.user.fullName,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Text(
                        'Số điện thoại',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xff9DA2A7),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        order.user.phoneNumber,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Text(
                        'Địa chỉ chi tiết',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xff9DA2A7),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          "${order.address.detail}, ${order.address.ward}, ${order.address.city}, ${order.address.province}",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            // Display product list
            for (var detail in order.orderDetails)
              Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                      child: Image.network(
                        detail.product.images[0].url,
                        height: 75,
                        width: 75,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            detail.product.name,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${detail.product.color}, ${detail.product.ram}, ${detail.product.storage}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xff727880),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Text(
                                'x${detail.quantity}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(width: 20),
                              Text(
                                formatCurrency(detail.price),
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.payment, color: Colors.red),
                      SizedBox(width: 8),
                      Text(
                        'Phương thức thanh toán',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    order.paymentMethod,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xff9DA2A7),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Tạm tính',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xff9DA2A7),
                        ),
                      ),
                      Text(
                        formatCurrency(order.total),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Phí vận chuyển',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xff9DA2A7),
                        ),
                      ),
                      Text(
                        'Miễn phí',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Thành tiền',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        formatCurrency(order.total),
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
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
