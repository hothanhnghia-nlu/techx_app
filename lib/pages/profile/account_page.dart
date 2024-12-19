import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techx_app/pages/product/favorite_product_page.dart';
import 'package:techx_app/pages/auth/login_page.dart';
import 'package:techx_app/pages/order/orders_page.dart';
import 'package:techx_app/pages/profile/profile_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:techx_app/providers/auth_provider.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
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
             Provider.of<AuthProvider>(context, listen: false).logout();

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 5,
        shadowColor: Color(hexColor('#F0F1F0')),
        surfaceTintColor: Colors.white,
        title: const Text(
          'Tài khoản',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const ProfilePage()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Color(hexColor('#F6F6F6')),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(12),
                        child: Icon(
                          Icons.person_outline,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                        
                    const SizedBox(width: 16),
                        
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Thông tin cá nhân',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        
                        SizedBox(height: 4),
                        
                        Text(
                          'Thay đổi Mật khẩu, Cập nhật thông tin',
                          style: TextStyle(
                            color: Color(0xFF9DA2A7),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
        
              const SizedBox(height: 12),
        
              const Divider(color: Color(0xffF6F6F6)),
        
              const SizedBox(height: 12),
        
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const MyOrdersPage()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Color(hexColor('#F6F6F6')),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(12),
                        child: Icon(
                          Icons.shopping_bag_outlined,
                          color: Colors.green,
                        ),
                      ),
                    ),
                        
                    const SizedBox(width: 16),
                        
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Đơn hàng của tôi',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        
                        SizedBox(height: 4),
                        
                        Text(
                          'Đơn mua, chi tiết đơn hàng của tôi',
                          style: TextStyle(
                            color: Color(0xFF9DA2A7),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
        
              const SizedBox(height: 12),
        
              const Divider(color: Color(0xffF6F6F6)),
        
              const SizedBox(height: 12),
        
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const FavoriteProductPage()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Color(hexColor('#F6F6F6')),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(12),
                        child: Icon(
                          Icons.favorite_outline,
                          color: Colors.red,
                        ),
                      ),
                    ),
                        
                    const SizedBox(width: 16),
                        
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Yêu thích',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        
                        SizedBox(height: 4),
                        
                        Text(
                          'Sản phẩm yêu thích của tôi',
                          style: TextStyle(
                            color: Color(0xFF9DA2A7),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
        
              const SizedBox(height: 12),
        
              const Divider(color: Color(0xffF6F6F6)),
        
              const SizedBox(height: 12),
        
              const Padding(
                padding: EdgeInsets.only(top: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tin tức & bài viết',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black45,
                          size: 18,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 12),
        
              const Divider(color: Color(0xffF6F6F6)),
        
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
            ],
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