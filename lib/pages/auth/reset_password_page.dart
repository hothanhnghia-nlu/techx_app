import 'package:flutter/material.dart';
import 'package:techx_app/pages/auth/login_page.dart';
import 'package:techx_app/services/user_service.dart';

import '../../utils/dialog_utils.dart';

class ResetPasswordPage extends StatefulWidget {
  final String email;

  const ResetPasswordPage({Key? key, required this.email}) : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  UserService userService = new UserService();
  bool _obscureText = true;

  void _resetPassword() async {
    final newPassword =
        newPasswordController.text; // Lấy mật khẩu mới từ TextField
    final confirmPassword = confirmPasswordController.text;
    if(!checkPassword(newPassword, confirmPassword)){
      DialogUtils.showErrorDialog(context: context, message: "Mật khẩu và mật khẩu nhập lại phải trùng khớp");
      return;
    }
    final result = await userService.resetPassword(widget.email, newPassword);
    if (result == 'Mật khẩu đã được cập nhật thành công!') {
      // Quay lại màn hình đăng nhập
      DialogUtils.showSuccessDialog(context: context, message: "Đặt lại mật khẩu thành công, quay lại trang đăng nhập");
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
              (route) => false,
        );
      });
    } else {
      // Hiển thị lỗi
      DialogUtils.showErrorDialog(context: context, message: "Không thể thay đổi mật khẩu, vui lòng thử lại sau");
    }
  }

  bool checkPassword(String? newPass, String? comfirmPass) {
    if (newPass == comfirmPass) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text(
          'Đặt lại mật khẩu',
          style: TextStyle(
            fontSize: 18,
            color: Color(hexColor('#3C3C3C')),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: newPasswordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'Mật khẩu mới',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Color(hexColor('#9DA2A7')),
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                    ),
                    obscureText: _obscureText,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Mật khẩu phải bao gồm:\n'
                    '  * 8-20 ký tự\n'
                    '  * Ít nhất một chữ số\n'
                    '  * Ít nhất một chữ viết hoa\n'
                    '  * Ít nhất một ký tự đặc biệt (e.g. !@#&%)\n'
                    '  * Không khoảng trắng',
                    style: TextStyle(
                      color: Color(hexColor('#3F4F4F')),
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: confirmPasswordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'Nhập lại mật khẩu mới',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Color(hexColor('#9DA2A7')),
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                    ),
                    obscureText: _obscureText,
                  ),
                  const SizedBox(height: 25),
                  GestureDetector(
                    onTap: _resetPassword,
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(50)),
                      child: const Center(
                        child: Text(
                          'Lưu thay đổi',
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
