import 'package:flutter/material.dart';
import 'package:techx_app/pages/cart/checkout_page.dart';
import 'package:techx_app/pages/cart/cart_items_widget.dart';
import 'package:techx_app/services/cart_service.dart';
import '../../models/cart_product_model.dart'; 
import 'package:techx_app/utils/currency.dart';

class ShoppingCartPage extends StatefulWidget {
  
  const ShoppingCartPage({super.key})  ;

  @override
  State<ShoppingCartPage> createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
    CartService cartService = CartService();
    double total = 0.0;
  
   late  List<ProductCart> productsCart = [];
  
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
              backgroundColor:
                  WidgetStateProperty.all(Color(hexColor('#9DA2A7'))),
              foregroundColor: WidgetStateProperty.all(Colors.white),
              padding: WidgetStateProperty.all(
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 20)),
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            child: const Text('Hủy'),
          ),

          // Button Confirm
          TextButton(
            onPressed: () {
              clearAllProducts();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Đã xóa các sản phẩm'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Colors.red),
              foregroundColor: WidgetStateProperty.all(Colors.white),
              padding: WidgetStateProperty.all(
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 20)),
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            child: const Text('Đồng ý',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                )),
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
 
 // Hàm tính tổng tiền cần thanh toán
double calculateTotalPrice() {
    double totalAmount = 0.0;
    for (var product in productsCart) {
      totalAmount += product.price * product.quantity;
    }
    print('Size Cart: ${productsCart.length}');
    print('Total Price Cart: $total');
    return totalAmount;
  }

  // Hàm xóa toàn bộ sản phẩm
  void clearAllProducts() async {
    try{
    await cartService.removeProductAll();
    setState(() {
      productsCart.clear();
      total = 0.0;
    });
  } catch(e){
    throw Exception('Failed to remove product'); 
  }

  }

  void loadData() async {
  try {
    final List<dynamic> jsonData = await cartService.getCartsByUser();
    final List<ProductCart> parsedCarts = parseProductsCart(jsonData);

    setState(() {
      productsCart = parsedCarts; // Cập nhật danh sách sản phẩm
      total = calculateTotalPrice();
    });

    print('productsCart: $productsCart');
  } catch (e) {
    print('Error loading data: $e');
  }
}
  
// Hàm cập nhật tổng tiền từ CartItemsWidget
  void updateTotal() {
    setState(() {
      total = calculateTotalPrice(); // Tính lại tổng tiền
    });
  }

  List<ProductCart> parseProductsCart(dynamic jsonData) {
    return jsonData
        .map<ProductCart>((item) => ProductCart.fromJson(item))
        .toList();
  }

  @override
  void initState() {
    super.initState();
    loadData();
    total = calculateTotalPrice();
  }

  @override
  Widget build(BuildContext context) {

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 5),
                    child: ValueListenableBuilder<int>(
                      valueListenable: cartService.cartItemSize,  // Lắng nghe thay đổi giá trị của cartItemSize
                      builder: (context, value, child) {
                        return value == 0
                            ? const SizedBox.shrink() // Nếu không có sản phẩm, không hiển thị gì
                            : Row(
                                children: [
                                  const Text(
                                    'Tất cả ',
                                  ),
                                  Text(
                                    '$value',  // Hiển thị số lượng sản phẩm từ ValueNotifier
                                  ),
                                  const Text(
                                    ' sản phẩm',
                                  ),
                                ],
                              );
                      },
                    ),
                  ),
                  CartItemsWidget(
                    products: productsCart,
                    onTotalChanged: updateTotal,),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                   const Text(
                      'Tổng cộng:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                     Text(     
                      formatCurrency(total),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                  ValueListenableBuilder<int>(
                    valueListenable: cartService.cartItemSize,  // Lắng nghe sự thay đổi của cartItemSize
                    builder: (context, value, child) {
                      return GestureDetector(
                        onTap: value == 0
                            ? null
                            : () => paymentButton(value),  // Truyền giá trị cartItemSize vào paymentButton
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                              color: value == 0 ? Colors.grey : Colors.black,
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
                      );
                    },
                  )
              ],
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
