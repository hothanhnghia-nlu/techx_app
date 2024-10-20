import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:techx_app/pages/product/product_detail_page.dart';

class ProductsWidget extends StatefulWidget {
  const ProductsWidget({super.key});

  @override
  State<ProductsWidget> createState() => _ProductsWidgetState();
}

class _ProductsWidgetState extends State<ProductsWidget> {
  bool isPressed = false;
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

  // Định dạng đơn vị tiền tệ
  String formatCurrency(double orginalCurrency) {
    var formatter = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');
    return formatter.format(orginalCurrency);
  }

  // Nút Thêm vào Yêu thích
  void _addToFavoriteButton() {
    setState(() {
      isPressed = !isPressed;
    });

    if (isPressed) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Đã nhấn nút Thêm vào yêu thích'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    int size = 5;
    return SizedBox(
      height: 365,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          for (int i = 1; i <= size; i++)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => const ProductDetailPage()));
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
    return Container(
      width: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border.all(
          color: Color(hexColor('#F6F6F6')),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: buildShimmerTitle(),
          ),
          Center(
            child: buildShimmerImage(),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildShimmerTextLine(100, 20),
                  const SizedBox(height: 8),
                  buildShimmerTextLine(150, 15),
                  const SizedBox(height: 8),
                  buildShimmerTextLine(70, 25),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildShimmerTitle() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 20,
        width: 50,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }

  Widget buildShimmerImage() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 150,
          width: 150,
          color: Colors.grey[300],
        ),
      ),
    );
  }

  Widget buildShimmerTextLine(double width, double height) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: height,
        width: width,
        color: Colors.grey[300],
      ),
    );
  }


  // Container Sau khi dữ liệu đã được tải
  Widget buildProductContainer() {
    return Container(
      width: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border.all(
          color: Color(hexColor('#F6F6F6')),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                      '-0%',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: _addToFavoriteButton,
                  child: Icon(
                    isPressed ? Icons.favorite : Icons.favorite_border,
                    color: isPressed ? Colors.red : Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                'https://cdn.tgdd.vn/Products/Images/42/305658/iphone-15-pro-max-blue-thumbnew-200x200.jpg',
                height: 150,
                fit: BoxFit.fill,
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tên sản phẩm',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Thông số kỹ thuật',
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xff727880),
                    ),
                  ),
                  
                  SizedBox(height: 8),

                  Text(
                    '0đ',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
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
