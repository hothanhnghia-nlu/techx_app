import 'package:flutter/material.dart';

class CustomerDetailScreen extends StatefulWidget {
  final dynamic user;

  const CustomerDetailScreen({super.key, required this.user});

  @override
  State<CustomerDetailScreen> createState() => _CustomerDetailScreenState();
}

class _CustomerDetailScreenState extends State<CustomerDetailScreen> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();

  void _saveButton() {
    String name = nameController.text;
    String phone = phoneController.text;
    String email = emailController.text;

    // if (name.isNotEmpty && phone.isNotEmpty && email.isNotEmpty) {
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
        content: Text('Cập nhật dữ liệu thành công'),
      ),
    );
    Navigator.pop(context);
  }
  
  @override
  Widget build(BuildContext context) {
    final dynamic user = widget.user;
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 5,
        shadowColor: Color(hexColor('#F0F1F0')),
        centerTitle: true,
        title: const Text(
          'Chỉnh sửa hồ sơ',
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Form(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextFormField(
                  controller: nameController..text = user['fullName'],
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                  labelText: 'Họ và tên',
                  ),
                  obscureText: false,
                ),
              
                const SizedBox(height: 20),
              
                TextFormField(
                  controller: emailController..text = user['email'],
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                  labelText: 'Email',
                  ),
                  obscureText: false,
                ),
                    
                const SizedBox(height: 20),
                    
                TextFormField(
                  controller: phoneController..text = user['phoneNumber'],
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                            color: Color(hexColor('#3F4F4F')))),
                  labelText: 'Số điện thoại',
                  ),
                  obscureText: false,
                ),
              
                const SizedBox(height: 25),
                    
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  child: GestureDetector(
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
                ),
              ],
            ),
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