import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:techx_app/pages/auth/change_password_page.dart';
import 'package:techx_app/pages/auth/login_page.dart';
import 'package:techx_app/pages/profile/edit_profile_page.dart';
import 'package:techx_app/services/user_service.dart';

class AdminProfilePage extends StatefulWidget {
  const AdminProfilePage({super.key});

  @override
  State<AdminProfilePage> createState() => _AdminProfilePageState();
}

class _AdminProfilePageState extends State<AdminProfilePage> {
  UserService userService = UserService();

  void _logoutButton() {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: Colors.white, 
        title: const Text(
          'Thông báo',
          style: TextStyle(
            color: Colors.red,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Text(
          'Bạn có chắc muốn đăng xuất?',
          style: TextStyle(
            fontSize: 15,
            color: Colors.black,
          ),
        ),
        actions: [
          // Button Cancel
          TextButton(
            onPressed: () => Navigator.pop(context, 'Đóng'),
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Color(hexColor('#9DA2A7'))),
              foregroundColor: WidgetStateProperty.all(Colors.white),
              padding: WidgetStateProperty.all(const EdgeInsets.symmetric(vertical: 10, horizontal: 20)),
              shape: WidgetStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            child: const Text('Đóng'),
          ),

          // Button Confirm
          TextButton(
            onPressed: () async {
              // Xoá token trước khi điều hướng
              final prefs = await SharedPreferences.getInstance();
              await prefs.remove('accessToken'); // Xoá token lưu trữ

              // Điều hướng về LoginPage và xoá lịch sử trang
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const LoginPage()), (route) => false);
            },
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Colors.red),
              foregroundColor: WidgetStateProperty.all(Colors.white),
              padding: WidgetStateProperty.all(const EdgeInsets.symmetric(vertical: 10, horizontal: 20)),
              shape: WidgetStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            child: const Text(
              'Đồng ý',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              )
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(hexColor('#f4f6f9')),
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Hồ sơ cá nhân',
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: FutureBuilder(
              future: userService.getUserInfo(),
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data == null) {
                  return const Text(
                    'Không có dữ liệu',
                    style: TextStyle(color: Colors.grey),
                  );
                }
                
              final user = snapshot.data!;
              return Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(Icons.person_outline, color: Colors.black45),
                      const SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Họ và tên',
                            style: TextStyle(
                              color: Color(hexColor('#9DA2A7')),
                              fontSize: 15,
                            ),
                          ),
                      
                          const SizedBox(height: 10),
                      
                          Text(
                            user.fullName,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
              
                  const SizedBox(height: 10),
                  Divider(color: Color(hexColor('#F0F1F0'))),
                  const SizedBox(height: 10),
              
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(Icons.mail_outline, color: Colors.black45),
                      const SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Email',
                            style: TextStyle(
                              color: Color(hexColor('#9DA2A7')),
                              fontSize: 15,
                            ),
                          ),
                      
                          const SizedBox(height: 10),
                      
                          Text(
                            user.email,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
              
                  const SizedBox(height: 10),
                  Divider(color: Color(hexColor('#F0F1F0'))),
                  const SizedBox(height: 10),
              
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(Icons.phone_outlined, color: Colors.black45),
                      const SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Số điện thoại',
                            style: TextStyle(
                              color: Color(hexColor('#9DA2A7')),
                              fontSize: 15,
                            ),
                          ),
                      
                          const SizedBox(height: 10),
                      
                          Text(
                            user.phoneNumber,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
              
                  const SizedBox(height: 10),
                  Divider(color: Color(hexColor('#F0F1F0'))),
                  const SizedBox(height: 30),
              
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (_) => const EditProfilePage()),
                      );
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.person_outline),
                            SizedBox(width: 20),
                            Text(
                              'Chỉnh sửa hồ sơ',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Icon(Icons.arrow_forward_ios,
                              size: 20, color: Colors.black54),
                      ],
                    ),
                  ),
              
                  const SizedBox(height: 10),
                  Divider(color: Color(hexColor('#F0F1F0'))),
                  const SizedBox(height: 10),
              
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (_) => const ChangePasswordPage()),
                      );
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.password),
                            SizedBox(width: 20),
                            Text(
                              'Thay đổi mật khẩu',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Icon(Icons.arrow_forward_ios,
                              size: 20, color: Colors.black54),
                      ],
                    ),
                  ),
              
                  const SizedBox(height: 12),
                  Divider(color: Color(hexColor('#F0F1F0'))),
                  const SizedBox(height: 5),
                      
                  Center(
                    child: TextButton(
                      onPressed: _logoutButton,
                      child: const Text(
                        'Đăng xuất',
                        style: TextStyle(
                          color: Color(0xffDD5D65)
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              );
            }
          ),
        ),
      )
    );
  }
}

int hexColor(String color) {
  String newColor = "0xff$color";
  newColor = newColor.replaceAll('#', '');
  int finalColor = int.parse(newColor);
  return finalColor;
}