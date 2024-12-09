import 'package:flutter/material.dart';
import 'package:techx_app/pages/auth/forgot_password_page.dart';
import 'package:techx_app/pages/home/navigation_page.dart';
import 'package:techx_app/pages/auth/signup_page.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:techx_app/utils/constant.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final baseUrl = Constant.authLogin;
  bool _obscureText = true;

  // Nút Đăng nhập
  void _loginButton() async {
    String email = emailController.text;
    String password = passwordController.text;

    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        Dio dio = Dio();
        // Gọi api đăng nhập
        final reponse = await dio.post(
          "$baseUrl",
          data: {'email': email, 'password': password},
        );
        if (reponse.statusCode == 200) {
          final token = reponse.data['accessToken'];
          print('$token');
          await saveToken(token); // Lưu token vào SharedPreferences
          // Điều hướng tới trang chính
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const NavigationPage()),
            (route) => false,
          );
        } else {
          _showSnackbar('Đăng nhập thất bại. Vui lòng thử lại.');
        }
      } catch (e) {
        _showSnackbar('Lỗi khi gọi API: $e');
        print('Lỗi khi gọi API: $e');
      }
    } else {
      _showSnackbar('Vui lòng điền đầy đủ thông tin');
    }
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("accessToken", token);
    print('Token saved: $token');
  }

  // Nút Đăng nhập Google
  void _googleLoginButton() async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Đây là đăng nhập Google'),
      ),
    );
  }

  // Nút Đăng nhập Facebook
  void _facebookLoginButton() {
    showAlertDialog();
  }

  // Nút Đăng nhập Apple
  void _appleLoginButton() {
    showAlertDialog();
  }

  // Hiển thị Dialog
  Future<dynamic> showAlertDialog() {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
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
        content: const Text(
          'Chức năng đang phát triển, vui lòng quay lại sau',
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Form(
              child: Column(
                children: [
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Chào mừng trở lại !',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Quản lý giá thầu, bán hàng và hơn thế nữa',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: 'Email',
                    ),
                    obscureText: false,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'Mật khẩu',
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
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const ForgotPasswordPage()),
                          );
                        },
                        child: const Text(
                          'Quên mật khẩu?',
                          style: TextStyle(
                            color: Color(0xff386692),
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: _loginButton,
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(50)),
                      child: const Center(
                        child: Text(
                          'Đăng nhập',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '--- Hoặc tiếp tục với---',
                    style: TextStyle(
                      color: Color(hexColor('#78829D')),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: _facebookLoginButton,
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          height: 40,
                          width: 50,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border:
                                  Border.all(color: Color(hexColor('#1877F2'))),
                              borderRadius: BorderRadius.circular(14)),
                          child: const Image(
                            image: AssetImage('assets/logo_facebook.png'),
                            height: 24,
                            width: 24,
                          ),
                        ),
                      ),
                      const SizedBox(width: 50),
                      GestureDetector(
                        onTap: _googleLoginButton,
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          height: 40,
                          width: 50,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border:
                                  Border.all(color: Color(hexColor('#EA4335'))),
                              borderRadius: BorderRadius.circular(14)),
                          child: const Image(
                            image: AssetImage('assets/logo_google.png'),
                            height: 24,
                            width: 24,
                          ),
                        ),
                      ),
                      const SizedBox(width: 50),
                      GestureDetector(
                        onTap: _appleLoginButton,
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          height: 40,
                          width: 50,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border:
                                  Border.all(color: Color(hexColor('#000000'))),
                              borderRadius: BorderRadius.circular(14)),
                          child: const Image(
                            image: AssetImage('assets/logo_apple.png'),
                            height: 24,
                            width: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Bạn chưa có tài khoản?',
                          style: TextStyle(
                            color: Color(hexColor('#78829D')),
                            fontSize: 15,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const SignupPage()),
                            );
                          },
                          child: const Text(
                            'Đăng ký ngay',
                            style: TextStyle(
                              color: Color(0xff386692),
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
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
