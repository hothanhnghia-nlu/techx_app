import 'package:flutter/material.dart';
import 'package:techx_app/pages/auth/reset_password_page.dart';

class VerifyOTPPage extends StatefulWidget {
  const VerifyOTPPage({super.key});

  @override
  State<VerifyOTPPage> createState() => _VerifyOTPPageState();
}

class _VerifyOTPPageState extends State<VerifyOTPPage> {
  
  void _confirmButton() async {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const ResetPasswordPage()),
      (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            Image.asset(
              'assets/otp_verify_img.jpg',
              height: 300,
              width: 300,
            ),
        
            const Text(
              'Vui lòng nhập mã đã được gửi đến email',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xff9DA2A7),
              ),
            ),

            const SizedBox(height: 5),
        
            const Text(
              'email@example.com',
              style: TextStyle(
                fontSize: 17,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 30),


            const SizedBox(height: 30),
        
            GestureDetector(
              onTap: _confirmButton,
              child: Container(
                height: 40,
                width: 184,
                decoration: BoxDecoration(
                    color: Colors.black, borderRadius: BorderRadius.circular(14)),
                child: const Center(
                  child: Text(
                    'Xác nhận',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Chưa nhận được OTP?',
                  style: TextStyle(
                    color: Color(hexColor('#78829D')),
                    fontSize: 15,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    
                  },
                  child: const Text(
                    'Gửi lại mã',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}