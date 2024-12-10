import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:techx_app/pages/product/product_reviews_widget.dart';
import 'package:techx_app/services/cart_service.dart';
import 'package:techx_app/services/reviews_service.dart';

class ProductDetailPage extends StatefulWidget {
  final dynamic product;

  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  bool isPressed = false;
  final ReviewService reviewService = ReviewService();
  List<Map<String, dynamic>> reviews = [];

  void fetchReviews(int productId) async {
    try {
      final data = await reviewService.getAllReviewsByProduct(productId);
      setState(() {
        reviews = data;
      });
      print('Reviews: $reviews');
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchReviews(7);
  }

  // Tính trung bình sao đánh giá
  double calculateAverageRating(List<Map<String, dynamic>> reviews) {
    if (reviews.isEmpty) {
      return 0.0; // Trả về 0 nếu không có đánh giá
    }

    double totalRating =
    reviews.fold(0, (sum, review) => sum + (review['rating'] ?? 0));
    double average = totalRating / reviews.length;

    return double.parse(average.toStringAsFixed(1));
  }

  // Decode UTF8
  String decodeUtf8(String value) {
    try {
      return utf8.decode(value.runes.toList());
    } catch (e) {
      return value;
    }
  }

  // Format currency
  String formatCurrency(double originalCurrency) {
    var formatter = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');
    return formatter.format(originalCurrency);
  }

  // Calculate discount percentage
  String discountPercentage(double originalPrice, double newPrice) {
    double discount = ((originalPrice - newPrice) / originalPrice) * 100;
    return discount.round().toString();
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
          duration: Duration(seconds: 1),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Đã nhấn nút Xóa khỏi yêu thích'),
          duration: Duration(seconds: 1),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Text(
          product['name'] ?? '',
          style: const TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),

      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Image.network(
                  (product['images'] != null && product['images'].isNotEmpty)
                      ? product['images'][0]['url']
                      : 'https://via.placeholder.com/240', // URL placeholder nếu không có ảnh
                  height: 240,
                  fit: BoxFit.fill,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.broken_image, size: 240); // Hiển thị icon nếu URL không hợp lệ
                  },
                ),
              ),


              const SizedBox(height: 10),

              Text(
                product['name'],
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 5),

              Row(
                children: [
                  Row(
                    children: [
                      const Text(
                        'Thương hiệu: ',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        product['provider']?['name'],
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(width: 30),

                  Row(
                    children: [
                      const Text(
                        'SKU: ',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        product['id'].toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 8),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    formatCurrency(product['newPrice']),
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(width: 10),

                  Container(
                    decoration: BoxDecoration(
                      color: Color(hexColor('#F1F1F1')),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text(
                        '${discountPercentage(product['originalPrice'].toDouble(), product['newPrice'].toDouble())}%',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  IconButton(
                    onPressed: _addToFavoriteButton,
                    icon: Icon(
                      isPressed ? Icons.favorite : Icons.favorite_border,
                      color: isPressed ? Colors.red : Colors.black,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Thông số kỹ thuật',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Màn hình',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(hexColor('#727880')),
                        ),
                      ),
                      Text(
                        decodeUtf8(product['screen']),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),
                  const Divider(color: Color(0xffF6F6F6)),
                  const SizedBox(height: 12),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Camera',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(hexColor('#727880')),
                        ),
                      ),
                      Text(
                        decodeUtf8(product['camera']),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),
                  const Divider(color: Color(0xffF6F6F6)),
                  const SizedBox(height: 12),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Hệ điều hành',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(hexColor('#727880')),
                        ),
                      ),
                      Text(
                        decodeUtf8(product['operatingSystem']),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),
                  const Divider(color: Color(0xffF6F6F6)),
                  const SizedBox(height: 12),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'CPU',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(hexColor('#727880')),
                        ),
                      ),
                      Text(
                        decodeUtf8(product['cpu']),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),
                  const Divider(color: Color(0xffF6F6F6)),
                  const SizedBox(height: 12),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'RAM',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(hexColor('#727880')),
                        ),
                      ),
                      Text(
                        decodeUtf8(product['ram']),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),
                  const Divider(color: Color(0xffF6F6F6)),
                  const SizedBox(height: 12),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Dung lượng lưu trữ',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(hexColor('#727880')),
                        ),
                      ),
                      Text(
                        decodeUtf8(product['storage']),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),
                  const Divider(color: Color(0xffF6F6F6)),
                  const SizedBox(height: 12),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Pin',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(hexColor('#727880')),
                        ),
                      ),
                      Text(
                        decodeUtf8(product['battery']),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),
                  const Divider(color: Color(0xffF6F6F6)),
                  const SizedBox(height: 12),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Màu sản phẩm',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(hexColor('#727880')),
                        ),
                      ),
                      Text(
                        decodeUtf8(product['color']),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),
                  const Divider(color: Color(0xffF6F6F6)),
                  const SizedBox(height: 12),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Năm sản xuất',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(hexColor('#727880')),
                        ),
                      ),
                      Text(
                        product['producedYear'].toString(),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 24),

              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Mô tả',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    decodeUtf8(product['description'] ?? 'Chưa có mô tả cho sản phẩm này'),
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Đánh giá sản phẩm',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    '(${reviews.length} đánh giá)',
                    style: TextStyle(
                      color: Color(hexColor('#727880')),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const  Text(
                        'Trung bình',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            '${calculateAverageRating(reviews)}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(width: 5),
                          const Icon(Icons.star, color: Colors.amber),
                        ],
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showEvaluationDialog(context,7);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                    ),
                    child: const Text(
                      'Viết đánh giá',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              reviews.isNotEmpty
                  ? ProductReviewWidget(reviews: reviews)
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: ButtonBottomNav(product: product),
    );
  }

  void showEvaluationDialog(BuildContext context, int productId) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      builder: (context) {
        return EvaluationDialog(productId: productId);
      },
    );
  }
}

// Dialog Đánh giá sản phẩm
class EvaluationDialog extends StatefulWidget {
  final int productId;
  const EvaluationDialog({super.key, required this.productId});

  @override
  State<EvaluationDialog> createState() => _EvaluationDialogState();
}

class _EvaluationDialogState extends State<EvaluationDialog> {
  final contentController = TextEditingController();
  final ReviewService reviewService = ReviewService();
  String message = "";
  double rateCount = 0;

  void createReview(int productId, double rating, String comment) async {
    final reviewData = {
      'rating': rating,
      'comment': comment,
    };

    try {
      final newReview = await reviewService.createReview(productId, reviewData);
      print('Created Review: $newReview');
    } catch (e) {
      print('Error: $e');
      setState(() {
        message = "Đã xảy ra lỗi khi tạo đánh giá!";
      });
    }
  }

  void sendButton() {
    setState(() {
      String content = contentController.text;

      if (rateCount == 0) {
        message = "Vui lòng chọn đánh giá!";
      } else if (content.isEmpty) {
        message = "Vui lòng nhập nội dung đánh giá!";
      } else {
        createReview(widget.productId, rateCount, content);
        Navigator.pop(context);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Cảm ơn bạn đã đánh giá sản phẩm!'),
            duration: Duration(seconds: 1),
          ),
        );
      }
    });
  }

  // Hàm chuyển đổi rating thành text
  String getRatingText(double rating) {
    switch (rating) {
      case 1:
        return "Rất tệ";
      case 2:
        return "Tệ";
      case 3:
        return "Tạm ổn";
      case 4:
        return "Tốt";
      case 5:
        return "Rất tốt";
      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.65,
      widthFactor: 1,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.close, size: 18),
                ),
              ],
            ),

            const Text(
              'Đánh giá sản phẩm',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Hãy cho chúng tôi biết đánh giá của bạn về sản phẩm này!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                ),
              ),
            ),

            const SizedBox(height: 20),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RatingBar.builder(
                    initialRating: 0,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                    itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
                    onRatingUpdate: (rating) {
                      setState(() {
                        rateCount = rating;
                      });
                    }
                ),
                const SizedBox(height: 10),
                Text(
                  getRatingText(rateCount),
                  style: const TextStyle(fontSize: 15, color: Colors.black),
                ),
              ],
            ),

            const SizedBox(height: 20),

            TextFormField(
              controller: contentController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: 'Nhập nội dung đánh giá',
                hintStyle: const TextStyle(
                  color: Color(0xFF9DA2A7),
                  fontSize: 13,
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              obscureText: false,
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: sendButton,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
              ),
              child: const Text(
                'Gửi đánh giá',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 10),

            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Nút AddToCart và BuyNow
class ButtonBottomNav extends StatelessWidget {
  final Map<String, dynamic> product; // Accept product as a parameter

  const ButtonBottomNav({super.key, required this.product}); // Pass product to the constructor

  @override
  Widget build(BuildContext context) {
    CartService cartService = CartService();

    // Nút Thêm vào Giỏ hàng
    void addToCartButton(int productId) async {
      try {
        await cartService.addProductCart(productId);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Sản phẩm đã được thêm vào giỏ hàng!'),
            duration: Duration(seconds: 2),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Không thể thêm sản phẩm vào giỏ hàng. Lỗi: $e'),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }

    // Nút Mua ngay
    void buyNowButton() {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Đã nhấn nút Mua ngay'),
          duration: Duration(seconds: 1),
        ),
      );
    }

    return BottomAppBar(
      color: Colors.white,
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => addToCartButton(product['id']), // Use product['id'] here
            child: Container(
              height: 50,
              width: 150,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(6)),
              child: const Center(
                child: Text(
                  'Thêm vào giỏ',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: buyNowButton,
            child: Container(
              height: 50,
              width: 130,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(6)),
              child: const Center(
                child: Text(
                  'Mua ngay',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
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