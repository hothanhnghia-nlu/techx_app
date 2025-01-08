import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:techx_app/pages/product/product_detail_page.dart';

class ProductFavoriteWidget extends StatefulWidget {
  final List<Map<String, dynamic>> favoriteProducts;

  const ProductFavoriteWidget({super.key, required this.favoriteProducts});

  @override
  State<ProductFavoriteWidget> createState() => _ProductFavoriteWidgetState();
}

class _ProductFavoriteWidgetState extends State<ProductFavoriteWidget> {
  bool isPressed = true;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Giả lập delay dữ liệu tải
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  // Định dạng đơn vị tiền tệ
  String formatCurrency(double originalCurrency) {
    var formatter = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');
    return formatter.format(originalCurrency);
  }

  // Nút Xóa khỏi Yêu thích
  void _removeFavoriteButton(int productId) {
    setState(() {
      widget.favoriteProducts.removeWhere((product) =>
      product['product']['id'] == productId); // Xóa sản phẩm yêu thích
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Đã nhấn nút Xóa khỏi yêu thích'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: widget.favoriteProducts.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.54,
      ),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final product = widget.favoriteProducts[index];
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => ProductDetailPage(product: product['product']),
              ),
            );
          },
          child: _isLoading
              ? buildShimmerPlaceholder()
              : buildProductContainer(product),
        );
      },
    );
  }

  // Shimmer Placeholder khi đang tải dữ liệu
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

  // Xây dựng shimmer cho title
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

  // Xây dựng shimmer cho hình ảnh
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

  // Xây dựng shimmer cho dòng text
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

  // Container sau khi dữ liệu đã được tải
  // Container sau khi dữ liệu đã được tải
  Widget buildProductContainer(Map<String, dynamic> product) {
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
                onTap: () {
                  _removeFavoriteButton(product['product']['id']);
                },
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
              product['product']['images'] != null && product['product']['images'].isNotEmpty
                  ? product['product']['images'][0]['url'] ?? ''
                  : '', // Kiểm tra null cho hình ảnh
              height: 150, // Đặt chiều cao lớn hơn để hình ảnh to hơn
              width: double.infinity, // Đặt chiều rộng bằng với chiều rộng của container
              fit: BoxFit.cover, // Đảm bảo hình ảnh phủ kín container mà không bị méo
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.error, size: 150); // Hiển thị lỗi nếu không tải được hình
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 8),
            alignment: Alignment.centerLeft,
            child: Text(
              product['product']['name'] ?? 'Tên sản phẩm chưa có', // Kiểm tra null cho tên sản phẩm
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 8),
            alignment: Alignment.centerLeft,
            child: Text(
              product['product']['ram'] ?? 'Thông số kỹ thuật chưa có', // Kiểm tra null cho ram
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xff727880),
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              formatCurrency(product['product']['newPrice'] ?? 0.0), // Kiểm tra null cho giá
              style: const TextStyle(
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

// Hàm chuyển đổi màu hex
int hexColor(String color) {
  String newColor = "0xff$color";
  newColor = newColor.replaceAll('#', '');
  int finalColor = int.parse(newColor);
  return finalColor;
}
