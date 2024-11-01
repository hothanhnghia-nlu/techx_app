import 'package:flutter/material.dart';

class CategoryDetailScreen extends StatelessWidget {
  CategoryDetailScreen({super.key});

  final TextEditingController nameController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    
  void saveButton() {
  // Category newCategory = Category(
      //   id: category?.id,
      //   name: _nameController.text,
      // );

      // if (category == null) {
      //   provider.createCategory(newCategory);
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     const SnackBar(
      //       content: Text('Tạo danh mục thành công'),
      //     ),
      //   );
      // } else {
      //   provider.updateCategory(newCategory);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Cập nhật danh mục thành công'),
          ),
        );
      // }
      Navigator.pop(context);
  }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 5,
        shadowColor: Color(hexColor('#F0F1F0')),
        surfaceTintColor: Colors.white,
        title: const Text(
          'Tạo danh mục',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  labelText: 'Tên danh mục',
                ),
                obscureText: false,
              ),

              const SizedBox(height: 16),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: GestureDetector(
                  onTap: saveButton,
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
    );
  }
}

int hexColor(String color) {
  String newColor = "0xff$color";
  newColor = newColor.replaceAll('#', '');
  int finalColor = int.parse(newColor);
  return finalColor;
}