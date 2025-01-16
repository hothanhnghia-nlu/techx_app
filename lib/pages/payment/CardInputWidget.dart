import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:techx_app/utils/dialog_utils.dart';
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
      DialogUtils.showErrorDialog(
          context: context, message: "Vui lòng điền đầy đủ thông tin thẻ");
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
      DialogUtils.showErrorPaymentDialog(
          context: context,
          message:
              "Thanh toán không thành công vui lòng thử lại hoặc sử dụng phương thức thanh toán khác.");
    } finally {
      setState(() => _isProcessing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(40), // Bo tròn góc trên trái
        topRight: Radius.circular(40), // Bo tròn góc trên phải
      ),
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              // Bọc toàn bộ nội dung trong SingleChildScrollView
              child: Container(
                height: screenHeight * 0.9,
                // Giới hạn chiều cao container
                width: screenWidth * 1,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40), // Bo tròn góc trên trái
                    topRight: Radius.circular(40), // Bo tròn góc trên phải
                  ),
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
                    Center(
                      child: Text(
                        'Thông tin thanh toán',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
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
                                child: CircularProgressIndicator(
                                    color: Colors.white),
                              )
                            : const Text(
                                'Xác nhận thanh toán',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
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
      ),
    );
  }
}
