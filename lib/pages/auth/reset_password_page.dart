import 'package:flutter/material.dart';
import 'package:techx_app/pages/auth/login_page.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool _obscureText = true;

  void _saveButton() {
    String newPassword = newPasswordController.text;
    String rePassword = confirmPasswordController.text;

    // if (newPassword.isNotEmpty && rePassword.isNotEmpty) {
    //   Navigator.of(context).pushReplacement(
    //     MaterialPageRoute(builder: (_) => const ChangePasswordCompleted()),
    //   );
    // } else {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(
    //       content: Text('Vui lòng điền đầy đủ thông tin'),
    //     ),
    //   );
    // }
    
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginPage()),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        automaticallyImplyLeading: false,
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
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
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
                    onTap: _saveButton,
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
