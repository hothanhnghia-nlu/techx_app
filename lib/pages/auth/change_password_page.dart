import 'package:flutter/material.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void _saveButton() {
    String currentPassword = currentPasswordController.text;
    String newPassword = newPasswordController.text;
    String rePassword = confirmPasswordController.text;

    // if (currentPassword.isNotEmpty && newPassword.isNotEmpty && rePassword.isNotEmpty) {
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

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Thay đổi mật khẩu'),
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
        centerTitle: true,
        title: Text(
          'Thay đổi mật khẩu',
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
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: currentPasswordController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                      labelText: 'Mật khẩu hiện tại',
                    ),
                    obscureText: true,
                  ),

                  const SizedBox(height: 5),

                  Text(
                    'Mật khẩu hiện tại đã liên kết với tài khoản của bạn',
                    style: TextStyle(
                      color: Color(hexColor('#3F4F4F')),
                      fontSize: 13,
                    ),
                  ),

                  const SizedBox(height: 15),

                  TextFormField(
                    controller: newPasswordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                      labelText: 'Mật khẩu mới',
                    ),
                    obscureText: true,
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
                          borderRadius: BorderRadius.circular(8)),
                      labelText: 'Nhập lại mật khẩu mới',
                    ),
                    obscureText: true,
                  ),

                  const SizedBox(height: 25),
                  
                  GestureDetector(
                    onTap: _saveButton,
                    child: Container(
                      padding: const EdgeInsets.all(15.0),
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
