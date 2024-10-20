import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderDetailPage extends StatefulWidget {
  const OrderDetailPage({super.key});

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  
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
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
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

                  SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Mã đơn hàng',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xff9DA2A7),
                        ),
                      ),
                      Text(
                        '123456789',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                                
                  SizedBox(height: 8),
                                
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Thời gian đặt hàng',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xff9DA2A7),
                        ),
                      ),
                      Text(
                        'DD-MM-YYYY hh:mm',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xff9DA2A7),
                        ),
                      ),
                    ],
                  ),
                                
                  SizedBox(height: 8),
                                
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Thời gian thanh toán',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xff9DA2A7),
                        ),
                      ),
                      Text(
                        'DD-MM-YYYY hh:mm',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xff9DA2A7),
                        ),
                      ),
                    ],
                  ),
                                
                  SizedBox(height: 8),
                                
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Trạng thái đơn hàng',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xff9DA2A7),
                        ),
                      ),
                      Text(
                        'Giao hàng thành công',
                        style: TextStyle(
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
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
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
                                
                  SizedBox(height: 8),
                  
                  Text(
                    'Họ tên người nhận',
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xff9DA2A7),
                    ),
                  ),
                                
                  SizedBox(height: 8),
                                
                  Text(
                    'Số điện thoại',
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xff9DA2A7),
                    ),
                  ),
                                
                  SizedBox(height: 8),
                  
                  Text(
                    'Địa chỉ chi tiết',
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xff9DA2A7),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                    child: Image.network(
                      'https://cdn.tgdd.vn/Products/Images/42/305658/iphone-15-pro-max-blue-thumbnew-200x200.jpg',
                      height: 75,
                      width: 75,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tên sản phẩm',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Thông số kỹ thuật',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xff727880),
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              'x1',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(width: 20),
                            Text(
                              '0đ',
                              style: TextStyle(
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
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
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
                                
                  SizedBox(height: 8),
                  
                  Text(
                    'Hình thức thanh toán',
                    style: TextStyle(
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
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tạm tính',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xff9DA2A7),
                        ),
                      ),
                      Text(
                        '0đ',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                                
                  SizedBox(height: 8),

                  Row(
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

                  SizedBox(height: 8),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Thành tiền',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        '0đ',
                        style: TextStyle(
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