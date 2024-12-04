import 'package:flutter/material.dart';
import 'package:techx_app/pages/product/product_cat_widget.dart';

List<String> list = <String>['Giá Cao - Thấp', 'Giá Thấp - Cao'];

class ProductCatPage extends StatefulWidget {
  const ProductCatPage({Key? key, required this.providerId}) : super(key: key);
  final int providerId; // Nhận ID của hãng

  @override
  State<ProductCatPage> createState() => _ProductCatPageState();
}

class _ProductCatPageState extends State<ProductCatPage> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 5,
        shadowColor: Color(hexColor('#F0F1F0')),
        title: const Text(
          'Tên danh mục', // Có thể thay đổi theo tên của provider nếu cần
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.filter_list),
                      const SizedBox(width: 5),
                      DropdownButton<String>(
                        value: dropdownValue,
                        elevation: 16,
                        style: const TextStyle(color: Colors.black),
                        underline: Container(
                          height: 2,
                          color: Colors.black12,
                        ),
                        onChanged: (String? value) {
                          setState(() {
                            dropdownValue = value!;
                          });
                          // Tùy chỉnh thêm nếu cần xử lý filter
                        },
                        items: list.map<DropdownMenuItem<String>>((
                            String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ProductCatWidget(providerId: widget.providerId), // Truyền ID hãng
          ],
        ),
      ),
    );
  }

  int hexColor(String color) {
    String newColor = "0xff$color";
    newColor = newColor.replaceAll('#', '');
    int finalColor = int.parse(newColor);
    return finalColor;
  }
}
