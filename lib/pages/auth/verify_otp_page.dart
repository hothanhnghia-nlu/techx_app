import 'dart:async';

import 'package:flutter/material.dart';
import 'package:techx_app/pages/auth/reset_password_page.dart';
import 'package:techx_app/services/user_service.dart';

import '../../utils/dialog_utils.dart';

class VerifyOTPPage extends StatefulWidget {
  final String email;

  const VerifyOTPPage({Key? key, required this.email}) : super(key: key);

  @override
  State<VerifyOTPPage> createState() => _VerifyOTPPageState();
}

class _VerifyOTPPageState extends State<VerifyOTPPage> {
  final otpController = TextEditingController();
  late Timer _timer;
  int _remainingSeconds = 120; // 2 phút = 120 giây
  bool _canResendOTP = false; // Không cho phép gửi lại mã OTP ngay từ đầu
  UserService userService = new UserService();

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  @override
  void dispose() {
    _timer.cancel(); // Hủy timer khi thoát khỏi trang
    otpController.dispose();
    super.dispose();
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        setState(() {
          _canResendOTP = true; // Cho phép gửi lại mã OTP
        });
        _timer.cancel(); // Dừng bộ đếm
      }
    });
  }

  void _verifyOtp() async {
    final otp = otpController.text; // Lấy OTP từ TextField
    final result = await userService.verifyOtp(widget.email, otp);
    if (result == 'Mã OTP hợp lệ!') {
      // Chuyển sang trang đổi mật khẩu
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>ResetPasswordPage(email: widget.email),
        ),
      );
    } else {
      // Hiển thị lỗi
      DialogUtils.showErrorDialog(
          context: context, message: 'Không thể xác thực otp ');
    }
  }

  void _resendOTP() {
    // Logic gửi lại mã OTP
    setState(() {
      _remainingSeconds = 120; // Đặt lại thời gian đếm ngược
      _canResendOTP = false; // Không cho phép gửi lại mã ngay lập tức
    });
    _startCountdown(); // Bắt đầu đếm ngược lại
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0, // Loại bỏ bóng của AppBar
        iconTheme: const IconThemeData(
            color: Colors.black), // Đặt màu của nút quay lại
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          // Căn lề hai bên
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              // Khoảng cách từ trên xuống
              Image.asset(
                'assets/otp_verify_img.jpg',
                height: 250, // Giảm chiều cao ảnh
                width: 250, // Giảm chiều rộng ảnh
              ),
              const SizedBox(height: 30),
              // Khoảng cách giữa ảnh và text
              const Text(
                'Vui lòng nhập mã đã được gửi đến email',
                textAlign: TextAlign.center, // Căn giữa văn bản
                style: TextStyle(
                  fontSize: 18, // Tăng kích thước chữ
                  color: Color(0xff9DA2A7),
                ),
              ),
              const SizedBox(height: 10),
              // Khoảng cách giữa các đoạn text
              Text(
                widget.email,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              // Khoảng cách giữa email và ô nhập OTP
              TextFormField(
                controller: otpController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  labelText: 'Nhập mã OTP',
                  labelStyle: const TextStyle(fontSize: 16),
                  // Kích thước chữ trong label
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 15, horizontal: 10), // Padding trong ô nhập
                ),
              ),
              const SizedBox(height: 20),
              // Khoảng cách giữa ô nhập OTP và nút xác nhận
              GestureDetector(
                onTap: _verifyOtp,
                child: Container(
                  height: 50, // Tăng chiều cao nút
                  width: double.infinity, // Nút chiếm toàn bộ chiều ngang
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Center(
                    child: Text(
                      'Xác nhận',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18, // Tăng kích thước chữ
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Khoảng cách giữa nút xác nhận và dòng text cuối
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _canResendOTP
                        ? 'Bạn có thể gửi lại mã OTP.'
                        : 'Chờ ${_formatTime(_remainingSeconds)} để gửi lại mã OTP.',
                    style: TextStyle(
                      color: _canResendOTP
                          ? Colors.green
                          : const Color(0xff78829D),
                      // Màu xanh khi có thể gửi lại mã
                      fontSize: 16, // Kích thước chữ
                    ),
                  ),
                  TextButton(
                    onPressed: _canResendOTP ? _resendOTP : null,
                    // Chỉ cho phép nhấn khi hết thời gian
                    child: Text(
                      'Gửi lại mã',
                      style: TextStyle(
                        color: _canResendOTP
                            ? Colors.red
                            : Colors.grey, // Màu xám khi không thể nhấn
                        fontWeight: FontWeight.bold,
                        fontSize: 16, // Kích thước chữ
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
