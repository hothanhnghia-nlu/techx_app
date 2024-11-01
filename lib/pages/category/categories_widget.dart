import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:techx_app/pages/product/product_cat_page.dart';

class CategoriesWidget extends StatefulWidget {
  const CategoriesWidget({super.key});

  @override
  State<CategoriesWidget> createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    int size = 5;
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          for (int i = 1; i <= size; i++)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => const ProductCatPage()));
                },
                child: _isLoading
                    ? buildShimmerPlaceholder()
                    : buildProductContainer(),
              ),
            ),
        ],
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
              color: Colors.grey[300], // or Colors.white for a blank shimmer
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
    );
  }


  // Container Sau khi dữ liệu đã được tải
  Widget buildProductContainer() {
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
          child: Image.network(
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTV58grb2DWbTqDMRCtPxJ_dT_PkPSA0rJFIQ&s',
            fit: BoxFit.fill,
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
