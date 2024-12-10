import 'package:flutter/material.dart';
import 'package:techx_app/services/user_service.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confPasswordController = TextEditingController();
  final UserService _userService = UserService();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  // Hàm kiểm tra dữ liệu hợp lệ
  bool _validateInput() {
    if (nameController.text.isEmpty) {
      _showError('Họ và tên không được để trống');
      return false;
    }
    if (emailController.text.isEmpty ||
        !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(emailController.text)) {
      _showError('Email không hợp lệ');
      return false;
    }
    if (phoneController.text.isEmpty ||
        !RegExp(r'^\d{10,11}$').hasMatch(phoneController.text)) {
      _showError('Số điện thoại không hợp lệ');
      return false;
    }
    if (passwordController.text.isEmpty) {
      _showError('Mật khẩu không được để trống');
      return false;
    }
    if (confPasswordController.text.isEmpty) {
      _showError('Vui lòng nhập lại mật khẩu');
      return false;
    }
    if (passwordController.text != confPasswordController.text) {
      _showError('Mật khẩu và mật khẩu nhập lại không khớp');
      return false;
    }
    return true;
  }

  // Hàm hiển thị thông báo lỗi
  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _showMess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }

  // Hàm gọi API đăng ký
  void _signUpButton() async {
    if (_validateInput()) {
      String? error = await _userService.registerUser(
        fullName: nameController.text,
        email: emailController.text,
        phoneNumber: phoneController.text,
        password: passwordController.text,
      );
      if (error == 'Đăng ký thành công') {
        // Đăng ký thành công
        _showMess('Đăng ký thành công, vui lòng đăng nhập');
        // Chờ 1 giây trước khi quay về màn hình đăng nhập
        await Future.delayed(const Duration(seconds: 1));
        Navigator.pop(context);
      } else {
        // Đăng ký thất bại, hiển thị thông báo lỗi
        _showError('$error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        automaticallyImplyLeading: false,
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
                        'Tham gia cùng TechX',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '6.000.000+ sản phẩm sẵn sàng để mua bán',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: 'Họ và tên',
                    ),
                    obscureText: false,
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
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: 'Số điện thoại',
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
                          _obscurePassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Color(hexColor('#9DA2A7')),
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                    obscureText: _obscurePassword,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: confPasswordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'Nhập lại mật khẩu',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureConfirmPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Color(hexColor('#9DA2A7')),
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureConfirmPassword =
                            !_obscureConfirmPassword;
                          });
                        },
                      ),
                    ),
                    obscureText: _obscureConfirmPassword,
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: _signUpButton,
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(50)),
                      child: const Center(
                        child: Text(
                          'Đăng ký',
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
