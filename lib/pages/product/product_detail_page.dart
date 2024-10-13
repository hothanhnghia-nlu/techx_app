import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  bool isPressed = false;

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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: const Text(
          'Tên sản phẩm',
          style: TextStyle(
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
                  'https://cdn.tgdd.vn/Products/Images/42/305658/iphone-15-pro-max-blue-thumbnew-200x200.jpg',
                  height: 240,
                  fit: BoxFit.fill,
                ),
              ),
          
              const SizedBox(height: 10),

              const Text(
                'Tên sản phẩm',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
          
              const SizedBox(height: 5),

              const Row(
                children: [
                  Row(
                    children: [
                      Text(
                        'Thương hiệu: ',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Brand',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(width: 30),
                  
                  Row(
                    children: [
                      Text(
                        'SKU: ',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        '1',
                        style: TextStyle(
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
                  const Text(
                    '0đ',
                    style: TextStyle(
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
                    child: const Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Text(
                        '-0%',
                        textAlign: TextAlign.center,
                        style: TextStyle(
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
                      const Text(
                        'TSKT Screen',
                        style: TextStyle(
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
                      const Text(
                        'TSKT Camera',
                        style: TextStyle(
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
                      const Text(
                        'TSKT OS',
                        style: TextStyle(
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
                      const Text(
                        'TSKT CPU',
                        style: TextStyle(
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
                      const Text(
                        'TSKT RAM',
                        style: TextStyle(
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
                      const Text(
                        'TSKT Storage',
                        style: TextStyle(
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
                      const Text(
                        'TSKT Battery',
                        style: TextStyle(
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
                      const Text(
                        'TSKT Color',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 24),

              const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Mô tả',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 10),

                  Text(
                    'Mô tả chi tiết sản phẩm',
                    style: TextStyle(
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
                    '(0 đánh giá)',
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
                  const Column(
                    children: [
                      Text(
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
                            '0',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(width: 5),
                          Icon(Icons.star, color: Colors.amber),
                        ],
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showEvaluationDialog(context);
                    },
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
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const ButtonBottomNav(),
    );
  }
  
  // Dialog Đánh giá sản phẩm
  Future<dynamic> showEvaluationDialog(BuildContext context) {
    final contentController = TextEditingController();
    String message = "";
    double rateCount = 0;

    // Nút Gửi đánh giá
    void sendButton() {
      setState(() {
        String content = contentController.text;

        if (rateCount == 0) {
          message = "Vui lòng chọn đánh giá!";
        } else if (content.isEmpty) {
          message = "Vui lòng nhập nội dung đánh giá!";
        } else {
          message = "Đánh giá thành công!";
        }
      });
    }

    return showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,  
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.6,
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

                RatingBar.builder(
                  initialRating: 0,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                  itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber), 
                  onRatingUpdate: (rating) {
                    rateCount = rating;
                  }
                ),
                
                const SizedBox(height: 20),

                TextFormField(
                  controller: contentController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Nhập nội dung đánh giá',
                    hintStyle: TextStyle(
                      color: Color(hexColor('#9DA2A7')),
                      fontSize: 13,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  obscureText: false,
                ),

                const SizedBox(height: 20),

                GestureDetector(
                  onTap: sendButton,
                  child:  Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(50)),
                    child: const Center(
                      child: Text(
                        'Gửi đánh giá',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
      },
    );
  }
}

class ButtonBottomNav extends StatelessWidget {
  const ButtonBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
  
    // Nút Thêm vào Giỏ hàng
    void addToCartButton() {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Đã nhấn nút Thêm vào giỏ hàng'),
          duration: Duration(seconds: 1),
        ),
      );
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
            onTap: addToCartButton,
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