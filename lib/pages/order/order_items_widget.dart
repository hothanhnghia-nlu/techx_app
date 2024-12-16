import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:techx_app/models/order_model.dart';
import 'package:techx_app/pages/order/orders_detail_page.dart';

class OrderItemsWidget extends StatefulWidget {
  final List<Order> orders;

  const OrderItemsWidget({super.key, required this.orders});

  @override
  State<OrderItemsWidget> createState() => _OrderItemsWidgetState();
}

class _OrderItemsWidgetState extends State<OrderItemsWidget> {
  // Định dạng đơn vị tiền tệ
  String formatCurrency(double orginalCurrency) {
    var formatter = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');
    return formatter.format(orginalCurrency);
  }

  // Nút Trang Chi tiết đơn hàng
  void _viewDetailButton(Order order) {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (_) => OrderDetailPage(
                order: order,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.orders.isEmpty) {
      return Center(
        child: Text(
          'Không có đơn hàng nào',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      );
    }
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: widget.orders.length,
      itemBuilder: (context, index) {
        final order = widget.orders[index];
        return GestureDetector(
          onTap: () => _viewDetailButton(order),
          child: Card(
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
              padding: const EdgeInsets.all(10),
              child: Column(
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
                        order.orderDetails[index].product.images[0].url,
                        height: 90,
                        width: 90,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            order.orderDetails[index].product.name,
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 8),

                          // ignore: sized_box_for_whitespace
                          Container(
                            width: 230,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      '${order.total}',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF9DA2A7),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  formatCurrency(order.total),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF9DA2A7),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 8),

                          // ignore: sized_box_for_whitespace
                          Container(
                            width: 230,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Ngày đặt hàng',
                                  style: TextStyle(
                                      fontSize: 14, color: Color(0xFF9DA2A7)),
                                ),
                                Text(
                                  DateFormat('dd-MM-yyyy hh:mm')
                                      .format(order.orderDate),
                                  style: const TextStyle(
                                      fontSize: 14, color: Color(0xFF9DA2A7)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
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
