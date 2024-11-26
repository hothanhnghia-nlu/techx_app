import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import 'package:techx_app/pages/product/product_cat_page.dart';
import 'package:logger/logger.dart';
import 'package:techx_app/utils/constant.dart'; // Import constant.dart

class CategoriesWidget extends StatefulWidget {
  const CategoriesWidget({super.key});

  @override
  State<CategoriesWidget> createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  final Logger logger = Logger(); // Thêm Logger
  bool _isLoading = true;
  List<dynamic> _providers = [];

  @override
  void initState() {
    super.initState();
    fetchProviders();
  }

  Future<void> fetchProviders() async {
    const String apiUrl = "${Constant.api}/providers"; // Sử dụng từ Constant
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        setState(() {
          _providers = json.decode(response.body);
          _isLoading = false;
        });
      } else {
        throw Exception("Failed to load providers");
      }
    } catch (e) {
      logger.e("Error fetching providers", e); // Sử dụng Logger để log lỗi
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
      child: _isLoading
          ? ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
          child: buildShimmerPlaceholder(),
        ),
      )
          : ListView.builder(
        itemCount: _providers.length,
        itemBuilder: (context, index) {
          final provider = _providers[index];
          return Padding(
            padding:
            const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ProductCatPage(
                      providerId: provider['id'], // Truyền id của hãng
                      providerName: provider['name'], // Truyền tên của hãng
                    ),
                  ),
                );
              },
              child: buildProductContainer(provider),
            ),
          );
        },
      ),
    );
  }

  Widget buildShimmerPlaceholder() {
    return Card(
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
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            height: 100,
            width: 150,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildProductContainer(dynamic provider) {
    return Card(
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
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: SizedBox(
          height: 100,
          width: 150,
          child: Column(
            children: [
              Expanded(
                child: Image.network(
                  provider['image']['url'],
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                provider['name'],
                style: const TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ],
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
