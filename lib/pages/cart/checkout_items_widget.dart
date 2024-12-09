import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:techx_app/pages/product/product_detail_page.dart';

class CheckoutItemsWidget extends StatelessWidget {
  final int size;

  const CheckoutItemsWidget({
    super.key,
    required this.size
  });

  // Định dạng đơn vị tiền tệ
  String formatCurrency(double orginalCurrency) {
    var formatter = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');
    return formatter.format(orginalCurrency);
  }
  
 @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: [
            for (int i = 1; i <= size; i++)
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => const ProductDetailPage(product: null,)));
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
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Tên sản phẩm',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
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
                            Text(
                              '0đ',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
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