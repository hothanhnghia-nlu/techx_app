import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:techx_app/pages/product/product_detail_page.dart';

import '../../models/cart_product_model.dart';

class CheckoutItemsWidget extends StatelessWidget {
  final List<ProductCart> products;

  const CheckoutItemsWidget({
    Key? key,
    required this.products,
  }) : super(key: key);

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
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return Padding(
              padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
              child: GestureDetector(
                onTap: () {
                  // Điều hướng tới trang chi tiết sản phẩm nếu cần
                  // Navigator.of(context).push(MaterialPageRoute(
                  //   builder: (_) => ProductDetailPage(product: product),
                  // ));
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
                    // Hiển thị thông tin sản phẩm
                    children: [
                      // Hình ảnh sản phẩm
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Image.network(
                          product.imageUrl,
                          height: 75,
                          width: 75,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Thông tin sản phẩm
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.name,
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${product.ram}/ ${product.storage}/ ${decodeUtf8(product.color)}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xff727880),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                formatCurrency(product.price),
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Số lượng: ${product.quantity}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
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

// Decode UTF8
String decodeUtf8(String value) {
  try {
    return utf8.decode(value.runes.toList());
  } catch (e) {
    return value;
  }
}
