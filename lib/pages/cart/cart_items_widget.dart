import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:techx_app/pages/product/product_detail_page.dart';

class CartItemsWidget extends StatelessWidget {
  final int size;

  const CartItemsWidget({
    super.key,
    required this.size
  });

 @override
  Widget build(BuildContext context) {

    // Tăng số lượng
    void increasingButton() {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tăng số lượng'),
          duration: Duration(seconds: 1),
        ),
      );
    }

  // Định dạng đơn vị tiền tệ
  String formatCurrency(double orginalCurrency) {
    var formatter = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');
    return formatter.format(orginalCurrency);
  }

    // Giảm số lượng
    void decreasingButton() {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Giảm số lượng'),
          duration: Duration(seconds: 1),
        ),
      );
    }

    // Nút Xóa Giỏ hàng
    void clearCartItemButton() {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          backgroundColor: Colors.white,
          title: const Text(
            'Thông báo',
            style: TextStyle(
              color: Colors.red,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            'Bạn có chắc muốn xóa giỏ hàng này?',
            style: TextStyle(
              fontSize: 15,
              color: Colors.black,
            ),
          ),
          actions: [
            // Button Cancel
            TextButton(
              onPressed: () => Navigator.pop(context, 'Hủy'),
              style: ButtonStyle(
                backgroundColor:
                    WidgetStateProperty.all(Color(hexColor('#9DA2A7'))),
                foregroundColor: WidgetStateProperty.all(Colors.white),
                padding: WidgetStateProperty.all(
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20)),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              child: const Text('Hủy'),
            ),

            // Button Confirm
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Đã nhấn nút xóa'),
                    duration: Duration(seconds: 1),
                  ),
                );
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.red),
                foregroundColor: WidgetStateProperty.all(Colors.white),
                padding: WidgetStateProperty.all(
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20)),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              child: const Text('Đồng ý',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
            ),
          ],
        ),
      );
    }

    return SizedBox(
      height: 380,
      child: size == 0
        ? Center(child: Text('Giỏ hàng trống', style: TextStyle(color: Color(hexColor('#9DA2A7')), fontSize: 18)))
        : ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: [
          for (int i = 1; i <= size; i++)
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => const ProductDetailPage()));
              },
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
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0, left: 12.0, bottom: 12.0),
                      child: Image.network(
                        'https://cdn.tgdd.vn/Products/Images/42/305658/iphone-15-pro-max-blue-thumbnew-200x200.jpg',
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
                          const Text(
                            'Tên sản phẩm',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Thông số kỹ thuật',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xff727880),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            '0đ',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 12),
                    
                          Row(
                            children: [
                              // Nút Tăng giảm
                              Row(
                                children: [
                                  // Tăng số lượng
                                  InkWell(
                                    onTap: increasingButton,
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 10,
                                          ),
                                        ]),
                                      child: const Icon(CupertinoIcons.plus, size: 18),
                                    ),
                                  ),
                                  // Số lượng
                                  Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(
                                      '01',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color(hexColor('#4C53A5')),
                                      ),
                                    ),
                                  ),
                                  // Giảm số lượng
                                  InkWell(
                                    onTap: decreasingButton,
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 10,
                                          ),
                                        ]),
                                      child: const Icon(CupertinoIcons.minus, size: 18),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 100),
                              // Nút xóa item
                              InkWell(
                                onTap: clearCartItemButton,
                                child: const Icon(
                                  Icons.delete, color: Colors.red),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
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