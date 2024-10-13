import 'package:flutter/material.dart';
import 'package:techx_app/pages/cart/checkout_items_widget.dart';
import 'package:techx_app/pages/home/navigation_page.dart';
import 'package:techx_app/pages/order/orders_page.dart';
import 'package:techx_app/pages/profile/my_addresses_page.dart';

final noteController = TextEditingController();

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: const Text(
          'Xác nhận đơn hàng',
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Text(
                        'Họ tên người nhận',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),   
               
                      SizedBox(width: 10),

                      Text(
                        '|',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xff9DA2A7),
                        ),
                      ),

                      SizedBox(width: 10),

                      Text(
                        'Số điện thoại',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.location_on_outlined, color: Color(0xff9DA2A7)),
                          SizedBox(width: 8),
                          Text(
                            'Địa chỉ chi tiết',
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xff9DA2A7),
                            ),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => const MyAddressesPage()));
                        },
                        child: const Icon(Icons.arrow_forward_ios, color: Colors.black54, size: 18),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),
        
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: const CheckoutItemsWidget()
            ),

            const SizedBox(height: 8),

            Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.payment, color: Colors.red),
                      SizedBox(width: 8),
                      Text(
                        'Phương thức thanh toán',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                                
                  const SizedBox(height: 8),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Hình thức thanh toán',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xff9DA2A7),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          showPaymentMethodDialog(context);
                        },
                        child: const Icon(Icons.arrow_forward_ios, color: Colors.black54, size: 18),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 8),

            Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Ghi chú',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                                
                  const SizedBox(height: 8),
                  
                  TextFormField(
                    controller: noteController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: 'Nhập ghi chú (không bắt buộc)',
                      hintStyle: TextStyle(
                        color: Color(hexColor('#9DA2A7')),
                        fontSize: 13,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    obscureText: false,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: const Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Tạm tính',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xff9DA2A7),
                            ),
                          ),
                          Text(
                            '0đ',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Giảm giá',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xff9DA2A7),
                            ),
                          ),
                          Text(
                            '0đ',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Phí vận chuyển',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xff9DA2A7),
                            ),
                          ),
                          Text(
                            'Miễn phí',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Divider(color: Color(0xff727880)),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Thành tiền',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
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
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // Nút Đặt hàng
      bottomNavigationBar: const OrderConfirmBtnNavBar(),
    );
  }

  // Dialog Chọn Phương thức thanh toán
  Future<dynamic> showPaymentMethodDialog(BuildContext context) {
    return showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,  
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.75,
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
                  'Chọn Phương thức thanh toán',
                  style: TextStyle(
                    fontSize: 17,
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

class OrderConfirmBtnNavBar extends StatelessWidget {
  const OrderConfirmBtnNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    
    // Nút Đặt hàng
    void orderConfirmButton() {
      String note = noteController.text;
      
      showCompletedDialog(context);
    }

    return BottomAppBar(
      color: Colors.grey[200],
      padding: const EdgeInsets.all(20),
      child: GestureDetector(
        onTap: orderConfirmButton,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black, 
            borderRadius: BorderRadius.circular(50)
          ),
          child: const Center(
            child: Text(
              'Đặt hàng',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Dialog Đặt hàng thành công
  Future<dynamic> showCompletedDialog(BuildContext context) {
    return showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      builder: (context) {
        // ignore: deprecated_member_use
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: FractionallySizedBox(
            heightFactor: 0.75,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/img_completed.png',
                    height: 200,
                    width: 200,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Đặt hàng thành công!',
                    style: TextStyle(
                      fontSize: 26,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Cảm ơn bạn đã mua hàng của chúng tôi! Hãy theo dõi đơn hàng thường xuyên nhé!',
                      style: TextStyle(fontSize: 17),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => const MyOrdersPage()),
                          (route) => false);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                    ),
                    child: const Text(
                      'Đơn hàng của tôi',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => const NavigationPage()),
                          (route) => false);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(hexColor('#F0F1F0')),
                    ),
                    child: const Text(
                      'Về trang chủ',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}



int hexColor(String color) {
  String newColor = "0xff$color";
  newColor = newColor.replaceAll('#', '');
  int finalColor = int.parse(newColor);
  return finalColor;
}