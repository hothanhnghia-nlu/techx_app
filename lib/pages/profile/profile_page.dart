import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techx_app/pages/auth/change_password_page.dart';
import 'package:techx_app/pages/auth/login_page.dart';
import 'package:techx_app/pages/profile/edit_profile_page.dart';
import 'package:techx_app/pages/profile/list_address_page.dart';
import 'package:techx_app/providers/auth_provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  void _deleteAccountButton() {
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
          'Bạn có chắc muốn xóa tài khoản?',
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

          // Button Confirm
          TextButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                  (route) => false);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Tài khoản đã được xóa thành công!'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Colors.red),
              foregroundColor: WidgetStateProperty.all(Colors.white),
              padding: WidgetStateProperty.all(
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 20)),
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            child: const Text('Đồng ý',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                )),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.user;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          automaticallyImplyLeading: true,
          surfaceTintColor: Colors.white,
          elevation: 5,
          shadowColor: Color(hexColor('#F0F1F0')),
          title: const Text(
            'Thông tin cá nhân',
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
            child: Column(
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
                         user?.fullName ?? "Trống",
                          style: TextStyle(
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
                          user?.email ?? "Trống",
                          style: TextStyle(
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
                          user?.phoneNumber.toString() ?? "Trống",
                          style: TextStyle(
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
                const SizedBox(height: 10),
                Divider(color: Color(hexColor('#F0F1F0'))),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      CupertinoPageRoute(
                          builder: (_) => const ListAddressPage()),
                    );
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.location_on_outlined),
                          SizedBox(width: 20),
                          Text(
                            'Địa chỉ giao hàng',
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
                  onTap: _deleteAccountButton,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.delete_outlined),
                          SizedBox(width: 20),
                          Text(
                            'Xóa tài khoản',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios,
                          size: 20, color: Colors.black54),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ));
  }
}

int hexColor(String color) {
  String newColor = "0xff$color";
  newColor = newColor.replaceAll('#', '');
  int finalColor = int.parse(newColor);
  return finalColor;
}
