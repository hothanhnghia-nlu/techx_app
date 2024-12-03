import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:techx_app/pages/product/product_detail_page.dart';
import 'cart_product_model.dart';
import 'package:techx_app/services/cart_service.dart';
import 'package:techx_app/utils/currency.dart';

class CartItemsWidget extends StatefulWidget {
  final List<ProductCart> products;
  final VoidCallback onTotalChanged; // Callback để cập nhật tổng tiền

  const CartItemsWidget({
    Key? key,
    required this.products,
    required this.onTotalChanged,}) : super(key: key);

@override
  _CartItemsWidgetState createState() => _CartItemsWidgetState();
}

class _CartItemsWidgetState extends State<CartItemsWidget> {
  final CartService cartService = CartService();

  void _removeProduct(var carProduct) async {
     await cartService.removeProduct(carProduct.id);
    setState(() {
      widget.products.remove(carProduct); // Xóa sản phẩm trong danh sách
      widget.onTotalChanged();
       // Gọi callback để cập nhật số lượng sản phẩm còn lại
    // widget.onProductCountChanged(widget.products.length);
    });
   
  }

  @override
  Widget build(BuildContext context) {
    
    // Tăng số lượng
    void increasingButton(var cartProduct) async {
      try {

        final newQuantity = cartProduct.quantity+1;
           setState(() {
          cartProduct.quantity = newQuantity;
          widget.onTotalChanged();
        });

        await cartService.updateCart(cartProduct);
       
            print('increas Product: ${cartProduct.quantity}');

       } catch (e) {
      // Xử lý lỗi nếu có
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Lỗi: $e'),
          duration: Duration(seconds: 2),
        ),
      );
    }
    }

    // Giảm số lượng
    void decreasingButton(var cartProduct) async {
      if(cartProduct.quantity <= 1) return;
      try {
         final newQuantity = cartProduct.quantity-1;
        
      setState(() {
        cartProduct.quantity = newQuantity;
        widget.onTotalChanged();
      });
      await cartService.updateCart(cartProduct);
    print('decreas Product: ${cartProduct.quantity}');
       } catch (e) {
      // Xử lý lỗi nếu có
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Lỗi: $e'),
          duration: Duration(seconds: 2),
        ),
      );
    }
    }
 
    // Nút Xóa Giỏ hàng
    void clearCartItemButton(var carProduct) {
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
            'Bạn có chắc muốn xóa giỏ hàng này?',
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
               
              _removeProduct(carProduct);
                
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Đã xóa sản phẩm khỏi giỏ hàng'),
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


    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
    
      child: widget.products.isEmpty
          ? Center(
              child: Text('Giỏ hàng trống',
                  style: TextStyle(
                      color: Color(hexColor('#9DA2A7')), fontSize: 18)))
          : ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: widget.products.length,
              itemBuilder: (context, index) {
                final cartProduct = widget.products[index];
                return Padding(
                  padding: const EdgeInsets.only(top: 1, left: 5, right: 5),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const ProductDetailPage()));
                    },
                    child: Card(
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Padding(
                          //   padding: const EdgeInsets.only(top: 12.0, left: 12.0, bottom: 12.0),
                          //   child:
                          //   Image.network(
                          //     'https://cdn.tgdd.vn/Products/Images/42/305658/iphone-15-pro-max-blue-thumbnew-20 0x200.jpg',
                          //     height: 75,
                          //     width: 75,
                          //     fit: BoxFit.cover,
                          //   ),
                          // ),
                          const SizedBox(width: 12),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  cartProduct.name,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '${0}Thông số kỹ thuật',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Color(0xff727880),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text( 
                                  formatCurrency(cartProduct.price),
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    // Nút Tăng giảm
                                    Row(
                                      children: [
                                        // Tăng số lượng
                                        InkWell(
                                          onTap: () => increasingButton(cartProduct),
                                          child: Container(
                                            padding: const EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    spreadRadius: 1,
                                                    blurRadius: 10,
                                                  ),
                                                ]),
                                            child: const Icon(
                                                CupertinoIcons.plus,
                                                size: 18),
                                          ),
                                        ),
                                        // Số lượng
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Text(
                                            '${cartProduct.quantity}',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Color(hexColor('#4C53A5')),
                                            ),
                                          ),
                                        ),
                                        // Giảm số lượng
                                        InkWell(
                                          onTap: () => decreasingButton(cartProduct),
                                          child: Container(
                                            padding: const EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    spreadRadius: 1,
                                                    blurRadius: 10,
                                                  ),
                                                ]),
                                            child: const Icon(
                                                CupertinoIcons.minus,
                                                size: 18),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 100),
                                    // Nút xóa item
                                    InkWell(
                                      onTap: () => clearCartItemButton(cartProduct),
                                      child: const Icon(Icons.delete,
                                          color: Colors.red),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
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
