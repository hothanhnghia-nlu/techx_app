import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:techx_app/models/product_model.dart';
import 'package:techx_app/pages/product/product_detail_page.dart';
import 'package:techx_app/utils/constant.dart';

class MySearchBar extends StatefulWidget {
  const MySearchBar({super.key});

  @override
  State<MySearchBar> createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  final baseUrl = Constant.api;
  List<dynamic> _products = [];
  List<dynamic> displayList = [];

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  // Fetch data from API
  Future<void> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/products"));
      if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
        setState(() {
          _products = jsonData.map((item) => Product.fromJson(item)).toList();
          displayList = List.from(_products);
        });
      } else {
        throw Exception("Failed to load products");
      }
    } catch (e) {
      print('Error fetching products: $e');
    }
  }

  void updateList(String value) {
    setState(() {
      displayList = _products
          .where((product) =>
              product.name!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  // Định dạng đơn vị tiền tệ
  String formatCurrency(double orginalCurrency) {
    var formatter = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');
    return formatter.format(orginalCurrency);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        leadingWidth: 30,
        title: TextField(
          onChanged: (value) => updateList(value),
          style: const TextStyle(
            color: Colors.black,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: Color(hexColor('#F0F1F0')),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide.none,
            ),
            hintText: "Tìm kiếm tại đây...",
            hintStyle: TextStyle(
              color: Color(hexColor('#9aa0a6')),
              fontWeight: FontWeight.w300,
            ),
            prefixIcon: const Icon(Icons.search),
            prefixIconColor: Color(hexColor('#9aa0a6')),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: displayList.isEmpty
            ? Center(
                child: Text('Không tìm thấy kết quả',
                    style: TextStyle(
                        color: Color(hexColor('#9DA2A7')), fontSize: 18)))
            :
        ListView.builder(
          itemCount: displayList.length,
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              // Navigator.of(context).push(MaterialPageRoute(
              //   builder: (_) => ProductDetailPage(product: displayList[index])));
            },
            child: ListTile(
              title: Text(
                displayList[index].name!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${displayList[index].ram!}/ ${displayList[index].storage!}/ ${displayList[index].color!}',
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xff727880),
                    ),
                  ),
                  Text(
                    formatCurrency(displayList[index].newPrice!),
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
              leading: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Color(hexColor('#ecedef')),
                    width: 2,
                  )
                ),
                child: Image.network(
                  displayList[index].imageUrl!,
                  height: 80,
                  width: 60,
                )
              ),
            ),
          ),
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