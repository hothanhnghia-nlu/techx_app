import 'package:flutter/material.dart';

class ProductReviewWidget extends StatelessWidget {
  const ProductReviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    int size = 5;

    return SizedBox(
      height: 300,
      child: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: [
          for (int i = 1; i <= size; i++)
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'DD/MM/YYYY',
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(hexColor('#727880')),
                  ),
                )
              ),
              const SizedBox(width: 17),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Họ tên khách hàng',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          '5',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(width: 5),
                        Icon(Icons.star, color: Colors.amber),
                      ],
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Nội dung đánh giá',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
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