import 'package:flutter/material.dart';
import 'package:techx_app/pages/cart/checkout_page.dart';
import 'package:techx_app/pages/cart/cart_items_widget.dart';

class ShoppingCartPage extends StatefulWidget {
  const ShoppingCartPage({super.key});

  @override
  State<ShoppingCartPage> createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {

  // Nút Xóa Giỏ hàng
  void _deleteCartButton() {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: Colors.white, 
        title: const Text(
          'Thông báo',
          style: TextStyle(
            color: Colors.red,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Text(
          'Bạn có chắc muốn xóa toàn bộ giỏ hàng?',
          style: TextStyle(
            fontSize: 15,
            color: Colors.black,
          ),
        ),
        actions: [
          // Button Cancel
          TextButton(
            onPressed: () => Navigator.pop(context, 'Hủy'),
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Color(hexColor('#9DA2A7'))),
              foregroundColor: WidgetStateProperty.all(Colors.white),
              padding: WidgetStateProperty.all(const EdgeInsets.symmetric(vertical: 10, horizontal: 20)),
              shape: WidgetStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            child: const Text('Hủy'),
          ),

          // Button Confirm
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Đã nhấn nút xóa'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Colors.red),
              foregroundColor: WidgetStateProperty.all(Colors.white),
              padding: WidgetStateProperty.all(const EdgeInsets.symmetric(vertical: 10, horizontal: 20)),
              shape: WidgetStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            child: const Text(
              'Đồng ý',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              )
            ),
          ),
        ],
      ),
    );
  }

  // Nút Thanh toán
  void paymentButton(int size) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => CheckoutPage(size: size)),
    );
  }

  @override
  Widget build(BuildContext context) {
    int cartItemSize = 2;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: const Text(
          'Giỏ hàng',
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              color: Colors.white,
              onPressed: _deleteCartButton,
              icon: Icon(
                Icons.delete_outlined,
                color: Color(hexColor('#5D4037')),
                size: 24,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 5),
              child: cartItemSize == 0 ? null : Row(
                children: [
                  const Text(
                    'Tất cả ',
                  ),
                   Text(
                    '$cartItemSize',
                  ),
                   const Text(
                    ' sản phẩm',
                  ),
                ],
              ),
            ),
        
            const SizedBox(height: 4),
        
            CartItemsWidget(size: cartItemSize),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tổng cộng:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        '0đ',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                            
                  const SizedBox(height: 20),
                        
                  GestureDetector(
                    onTap: cartItemSize == 0 ? null : () => paymentButton(cartItemSize),
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          color: cartItemSize == 0 ? Colors.grey : Colors.black,
                          borderRadius: BorderRadius.circular(50)),
                      child: const Center(
                        child: Text(
                          'Thanh toán',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
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