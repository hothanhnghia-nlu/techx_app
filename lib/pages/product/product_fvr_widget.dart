import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:techx_app/pages/product/product_detail_page.dart';

class ProductFavoriteWidget extends StatefulWidget {
  const ProductFavoriteWidget({super.key});

  @override
  State<ProductFavoriteWidget> createState() => _ProductFavoriteWidgetState();
}

class _ProductFavoriteWidgetState extends State<ProductFavoriteWidget> {
  bool isPressed = true;
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

  // Nút Xóa khỏi Yêu thích
  void _removeFavoriteButton() {
    setState(() {
      isPressed = !isPressed;
    });

    if (!isPressed) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Đã nhấn nút Xóa khỏi yêu thích'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    int size = 3;
    return GridView.count(
      childAspectRatio: 0.54,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      shrinkWrap: true,
      children: [
        for (int i = 1; i <= size; i++)
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const ProductDetailPage()));
          },
          child: _isLoading
              ? buildShimmerPlaceholder()
              : buildProductContainer(),
        )
      ],
    );
  }

  Widget buildShimmerPlaceholder() {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
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
      padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
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
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Color(hexColor('#4C53A5')),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  '-0%',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              GestureDetector(
                onTap: _removeFavoriteButton,
                child: Icon(
                  isPressed ? Icons.favorite : Icons.favorite_border,
                  color: isPressed ? Colors.red : Colors.black,
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: Image.network(
              'https://cdn.tgdd.vn/Products/Images/42/305658/iphone-15-pro-max-blue-thumbnew-200x200.jpg',
              height: 120,
              width: 120,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 8),
            alignment: Alignment.centerLeft,
            child: const Text(
              'Tên sản phẩm',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 8),
            alignment: Alignment.centerLeft,
            child: const Text(
              'Thông số kỹ thuật',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xff727880),
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              '0đ',
              style: TextStyle(
                fontSize: 18,
                color: Colors.red,
                fontWeight: FontWeight.bold,
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
