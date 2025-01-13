import 'package:flutter/material.dart';
import 'package:techx_app/pages/auth/verify_otp_page.dart';
import 'package:techx_app/services/user_service.dart';

import '../../utils/dialog_utils.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final emailController = TextEditingController();
  UserService userService = new UserService();
  bool isLoading = false; // Trạng thái loading

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  void _sendOtp() async {
    String email = emailController.text.trim();
    if (email.isEmpty) {
      DialogUtils.showErrorDialog(
          context: context, message: 'Vui lòng nhập email');
      return;
    }

    if (!isValidEmail(email)) {
      DialogUtils.showErrorDialog(
          context: context, message: 'Email không hợp lệ');
      return;
    }
    setState(() {
      isLoading = true; // Hiển thị trạng thái loading
    });
    try {
      DialogUtils.showLoadingDialog(context);
      final result = await userService.sendOtpToEmail(email);
      Navigator.pop(context); // Đóng dialog loading
      setState(() {
        isLoading = false; // Tắt trạng thái loading
      });

      if (result == 'OTP đã được gửi thành công!') {
        // Chuyển sang màn hình xác thực OTP
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => VerifyOTPPage(email: email)),
        );
      } else {
        // Hiển thị lỗi
        DialogUtils.showErrorDialog(
            context: context, message: 'Không thể gửi OTP. Vui lòng thử lại.');
      }
    } catch (e) {
      Navigator.pop(context); // Đóng dialog loading
      setState(() {
        isLoading = false; // Tắt trạng thái loading
      });
      DialogUtils.showErrorDialog(
          context: context, message: 'Đã xảy ra lỗi. Vui lòng thử lại.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        automaticallyImplyLeading: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              children: [
                const Text(
                  'Quên mật khẩu',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 10),
                  height: 288,
                  width: 311,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: SingleChildScrollView(
                    child: Form(
                      child: Column(
                        children: [
                          Text(
                            'Vui lòng nhập email đã đăng ký để xác thực',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(hexColor('#78829D')),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: Color(hexColor('#F9F9FB')),
                                ),
                              ),
                              labelText: 'Email',
                            ),
                            obscureText: false,
                          ),
                          const SizedBox(height: 25),
                          GestureDetector(
                            onTap: isLoading
                                ? null
                                : _sendOtp, // Vô hiệu hóa khi đang loading
                            child: Container(
                              height: 40,
                              width: 184,
                              decoration: BoxDecoration(
                                color: isLoading
                                    ? Colors.grey // Màu xám khi loading
                                    : Colors.black, // Màu đen khi sẵn sàng
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Center(
                                child: isLoading
                                    ? const Text(
                                  'Đang gửi yêu cầu...',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                                    : const Text(
                                  'Gửi OTP',
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
                  ),
                ),
              ],
            ),
          ),
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
