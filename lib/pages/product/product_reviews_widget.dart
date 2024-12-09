import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:techx_app/utils/date_format .dart';

class ProductReviewWidget extends StatelessWidget {
  final List<Map<String, dynamic>> reviews;

  const ProductReviewWidget({Key? key, required this.reviews}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // Decode UTF8
    String decodeUtf8(String value) {
      try {
        return utf8.decode(value.runes.toList());
      } catch (e) {
        return value;
      }
    }

    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: reviews.length,
        itemBuilder: (context, index) {
          final review = reviews[index];
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  formatDateTime(review['createdAt']) ??
                      'Unknown Date', // Ngày đánh giá
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(hexColor('#727880')),
                  ),
                ),
              ),
              const SizedBox(width: 17),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      decodeUtf8(review['user']['fullName']) ??
                          'Anonymous', // Họ tên khách hàng
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          review['rating'].toString(), // Số sao đánh giá
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(width: 5),
                        const Icon(Icons.star, color: Colors.amber),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      decodeUtf8(review['comment']) ?? 'No comment', // Nội dung đánh giá
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
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
