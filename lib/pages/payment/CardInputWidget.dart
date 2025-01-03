import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import '../../services/payment_service.dart';
import '../admin/category/category_detail_screen.dart';

class CardInputWidget extends StatefulWidget {
  final String paymentIntentId;
  final String clientSecret; // Thêm tham số này
  final VoidCallback onPaymentSuccess;

  const CardInputWidget({
    Key? key,
    required this.paymentIntentId,
    required this.clientSecret, // Thêm tham số này
    required this.onPaymentSuccess,
  }) : super(key: key);

  @override
  _CardInputWidgetState createState() => _CardInputWidgetState();
}

class _CardInputWidgetState extends State<CardInputWidget> {
  final CardFormEditController _controller = CardFormEditController();
  final PaymentService _paymentService = PaymentService();
  bool _isProcessing = false;

  Future<void> _handlePayment() async {
    if (!_controller.details.complete) {
      print("Vui lòng điền đầy đủ thông tin thẻ");
      showAlertDialog('Vui lòng điền đầy đủ, chính xác thông tin thẻ');
      return;
    }
    try {
      setState(() => _isProcessing = true);

      // Tạo payment method từ thông tin thẻ
      final paymentMethod = await Stripe.instance.createPaymentMethod(
        params: PaymentMethodParams.card(
          paymentMethodData: PaymentMethodData(),
        ),
      );
      print("paymentMethod: ${paymentMethod.id}");
      // Xác nhận thanh toán
      final status = await _paymentService.confirmPayment(
        paymentIntentId: widget.paymentIntentId,
        paymentMethodId: paymentMethod.id,
      );
      print("Payment status: $status");

      if (status == 'succeeded') {
        // Đóng modal
        Navigator.pop(
            context, true); // Trả về true để biết thanh toán thành công
        // Gọi callback onPaymentSuccess
        widget.onPaymentSuccess();
      } else {
        throw Exception('Payment confirmation failed');
      }
    } catch (e) {
      print('Lỗi thanh toán: $e');
      showAlertDialog('Lỗi thanh toán: $e');
    } finally {
      setState(() => _isProcessing = false);
    }
  }
  Future<dynamic> showAlertDialog(String text) {
    return showDialog(
      context: context,
      builder: (BuildContext context) =>
          AlertDialog(
            backgroundColor: Colors.white,
            title: const Text(
              'Thông báo',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.red,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            content:  Text(
             text ,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, 'Đóng'),
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
                child: const Text('Đóng'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView( // Bọc toàn bộ nội dung trong SingleChildScrollView
            child: Container(
              height: screenHeight * 0.9, // Giới hạn chiều cao container
              width: screenWidth * 0.9,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tiêu đề
                  Text(
                    'Thông tin thanh toán',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Form nhập thông tin thẻ (Stripe CardFormField)
                  CardFormField(
                    controller: _controller,
                    style: CardFormStyle(
                      borderColor: Colors.grey.shade400,
                      textColor: Colors.black,
                      fontSize: 14,
                      placeholderColor: Colors.grey.shade500,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Nút xác nhận thanh toán
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: _isProcessing ? null : _handlePayment,
                      child: _isProcessing
                          ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(color: Colors.white),
                      )
                          : const Text(
                        'Xác nhận thanh toán',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Ghi chú bảo mật
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.lock, size: 14, color: Colors.grey),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          'Thông tin thanh toán được mã hóa và bảo mật',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}