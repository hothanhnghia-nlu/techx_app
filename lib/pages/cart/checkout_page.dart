import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techx_app/models/paymentMethod.dart';
import 'package:techx_app/pages/cart/checkout_items_widget.dart';
import 'package:techx_app/pages/home/navigation_page.dart';
import 'package:techx_app/pages/order/orders_page.dart';
import 'package:techx_app/pages/profile/my_addresses_page.dart';
import 'package:techx_app/services/order_service.dart';
import 'package:techx_app/utils/currency.dart';
import 'package:techx_app/utils/dialog_utils.dart';

import '../../models/cart_product_model.dart';
import '../../providers/address_provider.dart';
import '../../services/payment_service.dart';
import '../payment/CardInputWidget.dart';

final noteController = TextEditingController();

class CheckoutPage extends StatefulWidget {
  final String from;
  final List<dynamic> products;

  const CheckoutPage({Key? key, required this.products, required this.from})
      : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String _selectedPaymentMethod = paymentMethods[0].name;
  late double totalPrice;
  final PaymentService _paymentService = PaymentService();
  bool isLoading = true; // Trạng thái loading
  Map<String, dynamic>? _paymentIntent; // Thêm biến để lưu payment intent
  String? receiverName;
  String? receiverPhone;
  String? receiverAddress;

  @override
  void initState() {
    super.initState();
    totalPrice = calculateTotalPrice();
    _loadAddress();
  }

  Future<void> _loadAddress() async {
    // Gọi API để lấy addressDefault
    final addressProvider =
    Provider.of<AddressProvider>(context, listen: false);
    await addressProvider.refreshAddressesDefault();
    // Cập nhật dữ liệu và trạng thái
    setState(() {
      receiverName = addressProvider.addressDefault?.fullName;
      receiverPhone = addressProvider.addressDefault?.phoneNumber;
      receiverAddress =
      '${addressProvider.addressDefault?.detail}, ${addressProvider
          .addressDefault?.ward}, ${addressProvider.addressDefault
          ?.city}, ${addressProvider.addressDefault?.province}';
      isLoading = false; // Dữ liệu đã tải xong
    });
  }

  double calculateTotalPrice() {
    double totalAmount = 0.0;
    for (var product in widget.products) {
      totalAmount += product.price * product.quantity;
    }
    return totalAmount;
  }

// Hàm xử lý khi chọn phương thức thanh toán
  Future<void> onPaymentMethodChanged(String method) async {
    setState(() => _selectedPaymentMethod = method);

    if (method == "Thẻ Tín dụng/Ghi nợ") {
      try {
        // Gọi API tạo payment intent
        final result =
        await _paymentService.createPaymentIntent(amount: totalPrice);
        setState(() {
          _paymentIntent = result;
        });
      } catch (e) {
        print('Error creating payment intent: $e');
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Lỗi khi tạo phiên thanh toán: $e')));
      }
    }
  }

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
                  Row(
                    children: [
                      Text(
                        receiverName ?? 'Họ và tên',
                        // Nếu null thì hiển thị giá trị mặc định,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        '|',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xff9DA2A7),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        receiverPhone ?? 'Số điện thoại',
                        // Nếu null thì hiển thị giá trị mặc định,
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
                      Expanded(
                        child: Row(
                          children: [
                            const Icon(Icons.location_on_outlined,
                                color: Color(0xff9DA2A7)),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                receiverAddress ?? 'Chưa có thông tin',
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Color(0xff9DA2A7),
                                ),
                                overflow: TextOverflow.ellipsis,
                                // Cắt bớt nội dung nếu quá dài
                                maxLines: 2, // Giới hạn số dòng hiển thị
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          final addressProvider = Provider.of<AddressProvider>(
                              context,
                              listen: false);
                          await Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) =>
                                  MyAddressesPage(
                                      address: addressProvider
                                          .addressDefault)));
                          // Làm mới địa chỉ sau khi quay lại
                          await addressProvider
                              .refreshAddressesDefault(); // Làm mới dữ liệu trong AddressProvider
                          _loadAddress(); // Cập nhật lại thông tin hiển thị
                        },
                        child: const Icon(Icons.arrow_forward_ios,
                            color: Colors.black54, size: 18),
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
                child: CheckoutItemsWidget(products: widget.products)),
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
                      Text(
                        _selectedPaymentMethod,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xff9DA2A7),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          String? selectedMethod =
                          await showPaymentMethodDialog(
                              context, _selectedPaymentMethod);
                          if (selectedMethod != null) {
                            setState(() {
                              _selectedPaymentMethod = selectedMethod;
                            });
                          }
                        },
                        child: const Icon(Icons.arrow_forward_ios,
                            color: Colors.black54, size: 18),
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
              child: Column(
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
                            formatCurrency(totalPrice),
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
                            formatCurrency(totalPrice),
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
      bottomNavigationBar: OrderConfirmBtnNavBar(
          totalAmount: totalPrice,
          selectedPaymentMethod: _selectedPaymentMethod,
          paymentIntent: _paymentIntent,
          product: widget.products,
          from: widget.from),
    );
  }

  // Dialog Chọn Phương thức thanh toán
  Future<dynamic> showPaymentMethodDialog(BuildContext context,
      String currentPaymentMethod) {
    int selectedMethodIndex = paymentMethods
        .indexWhere((method) => method.name == currentPaymentMethod);

    return showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return FractionallySizedBox(
              heightFactor: 0.8,
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
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: ListView.builder(
                        itemCount: paymentMethods.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedMethodIndex = index;
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 8.0),
                              padding: const EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  color: selectedMethodIndex == index
                                      ? Colors.orange
                                      : Colors.grey.shade300,
                                  width: 2.0,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Image(
                                    image: AssetImage(
                                        paymentMethods[index].iconUrl),
                                    width: 40,
                                    height: 40,
                                  ),
                                  const SizedBox(width: 16),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        paymentMethods[index].name,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        paymentMethods[index].description,
                                        style:
                                        const TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  if (selectedMethodIndex == index)
                                    const Icon(Icons.check_circle,
                                        color: Colors.orange)
                                  else
                                    const Icon(Icons.radio_button_unchecked),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                      onPressed: () async {
                        String selectedPayment =
                            paymentMethods[selectedMethodIndex].name;
                        // Gọi hàm onPaymentMethodChanged khi chọn phương thức
                        await onPaymentMethodChanged(selectedPayment);
                        Navigator.pop(context, selectedPayment);
                      },
                      child: const Text(
                        'Xác nhận',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class OrderConfirmBtnNavBar extends StatelessWidget {
  final double totalAmount;
  final String selectedPaymentMethod;
  final Map<String, dynamic>? paymentIntent;
  final List<dynamic> product;
  final String from;
  OrderService orderService = new OrderService();

  OrderConfirmBtnNavBar({required this.totalAmount,
    required this.selectedPaymentMethod,
    this.paymentIntent,
    required this.product,
    super.key,
    required this.from});

  Future<void> handlePayment(BuildContext context) async {
    if (selectedPaymentMethod == 'Tiền mặt khi nhận hàng') {
      bool result =
      await handleOrder(context, product, from); // Chờ kết quả từ handleOrder()
      if (result == true) {
        print('Dat hang thanh cong');
        showCompletedDialog(context);
      } else {
        print('Đặt hàng không thành công, vui lòng thử lại');
        DialogUtils.showErrorDialog(context: context, message: "Đặt hàng không thành công, vui lòng thử lại");
      }
    } else if (selectedPaymentMethod == 'Thẻ Tín dụng/Ghi nợ') {
      print(
          'Payment Intent in handlePayment: $paymentIntent'); // Thêm log để debug

      if (paymentIntent == null ||
          !paymentIntent!.containsKey('paymentIntentId')) {
        DialogUtils.showErrorDialog(
            context: context,
            message: 'Lỗi: Không thể tạo phiên thanh toán. Vui lòng thử lại.');
        return;
      }
      // Hiển thị form nhập thẻ
      showModalBottomSheet(
        context: context,
        builder: (context) =>
            CardInputWidget(
              paymentIntentId: paymentIntent!['paymentIntentId'],
              clientSecret: paymentIntent!['clientSecret'],
              // Thêm client secret
              onPaymentSuccess: () async {
                // Gọi handleOrder và chờ hoàn thành
                bool result = await handleOrder(context, product, from);

                if (result) {
                  // Nếu đặt hàng thành công, hiển thị dialog
                  await showCompletedDialog(context);
                } else {
                  // Nếu đặt hàng thất bại, hiển thị thông báo lỗi
                  DialogUtils.showErrorDialog(
                    context: context,
                    message:
                    'Đặt hàng thất bại. Khoản tiền tạm giữ sẽ được hoàn lại.',
                  );
                }
              },
            ),
      );
    }
  }

  Future<bool> handleOrder(BuildContext context, List<dynamic> product,
      String from) async {
    int productID = 0;
    if (from == 'productDetail') {
      print('productDetail');
      productID = product[0].id;
    }
// Lấy ID của addressDefault từ AddressProvider
    final int? idAddress = Provider
        .of<AddressProvider>(context, listen: false)
        .addressDefault
        ?.id;
    print(idAddress);
// Nếu idAddress là null, hiển thị thông báo lỗi
    if (idAddress == null) {
      DialogUtils.showErrorDialog(context: context,
          message: "Vui lòng thêm địa chỉ nhân trước khi đặt hàng.");
      return false;
    }


    String? result = await orderService.createOrfer(
        idAddress: idAddress,
        totalAmount: totalAmount,
        paymentMethod: selectedPaymentMethod,
        productID: productID);
    if (result == "Dặt hàng thành công") {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    // Nút Đặt hàng
    void orderConfirmButton() {
      String note = noteController.text;

      handlePayment(context);
    }

    return BottomAppBar(
      color: Colors.grey[200],
      padding: const EdgeInsets.all(20),
      child: GestureDetector(
        onTap: orderConfirmButton,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.black, borderRadius: BorderRadius.circular(50)),
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
                          MaterialPageRoute(
                              builder: (_) =>
                              const MyOrdersPage(
                                  previousPage: 'CheckoutPage')),
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
                          MaterialPageRoute(
                              builder: (_) => const NavigationPage()),
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
