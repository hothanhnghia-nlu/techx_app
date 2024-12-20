import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RecentOrderWidget extends StatefulWidget {
  const RecentOrderWidget({super.key});

  @override
  State<RecentOrderWidget> createState() => _RecentOrderWidgetState();
}

class _RecentOrderWidgetState extends State<RecentOrderWidget> {
  
  // Định dạng đơn vị tiền tệ
  String formatCurrency(double orginalCurrency) {
    var formatter = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');
    return formatter.format(orginalCurrency);
  }

  @override
  Widget build(BuildContext context) {
    int size = 3;
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: [
        for (int i = 1; i <= size; i++)
        Card(
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
                    Icon(Icons.person_outline,
                        color: Color(hexColor('#9DA2A7'))),
                    const SizedBox(width: 8),
                    Text(
                      'Họ và tên',
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
                      'https://cdn.tgdd.vn/Products/Images/42/305658/iphone-15-pro-max-blue-thumbnew-200x200.jpg',
                      height: 90,
                      width: 90,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(width: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Tên sản phẩm',
                          style: TextStyle(
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
                            mainAxisAlignment:MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Số lượng:',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(hexColor('#9DA2A7')),
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    '1',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(hexColor('#9DA2A7')),
                                    ),
                                  ),
                                ],
                              ),
                              
                              Text(
                                '0đ',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(hexColor('#9DA2A7')),
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
                              Text(
                                'Ngày đặt hàng',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(hexColor('#9DA2A7'))
                                ),
                              ),
                              Text(
                                'DD-MM-YYYY hh:mm',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(hexColor('#9DA2A7'))
                                ),
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
      ],
    );
  }
}

int hexColor(String color) {
  String newColor = "0xff$color";
  newColor = newColor.replaceAll('#', '');
  int finalColor = int.parse(newColor);
  return finalColor;
}