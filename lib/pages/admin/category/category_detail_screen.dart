import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class CategoryDetailScreen extends StatefulWidget {
  final Map<String, dynamic>? category;

  const CategoryDetailScreen({super.key, this.category});

  @override
  State<CategoryDetailScreen> createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen> {
  final TextEditingController nameController = TextEditingController();
  File? imageFile;

  @override
  void initState() {
    super.initState();
    if (widget.category != null) {
      nameController.text = widget.category!['name'];
    }
  }

  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> saveCategory(BuildContext context) async {
    final String apiUrl = widget.category == null
        ? "http://10.0.2.2:8080/api/v1/providers"
        : "http://10.0.2.2:8080/api/v1/providers/${widget.category!['id']}";

    try {
      var request = http.MultipartRequest(
        widget.category == null ? 'POST' : 'PUT',
        Uri.parse(apiUrl),
      );

      // Thêm tên danh mục
      request.fields['name'] = nameController.text;

      // Thêm file ảnh nếu có
      if (imageFile != null) {
        request.files.add(await http.MultipartFile.fromPath('imageFile', imageFile!.path)); // Đổi từ 'image' thành 'imageFile'
      }

      final response = await request.send();

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cập nhật danh mục thành công')),
        );
        Navigator.pop(context);
      } else {
        final responseBody = await response.stream.bytesToString();
        print("Lỗi: ${response.statusCode}, $responseBody");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cập nhật danh mục thất bại')),
        );
      }
    } catch (e) {
      print("Lỗi kết nối: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lỗi kết nối')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category == null ? 'Tạo danh mục' : 'Chỉnh sửa danh mục'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Tên danh mục',
              ),
            ),
            const SizedBox(height: 20),
            imageFile != null
                ? Image.file(imageFile!, height: 150, width: 150, fit: BoxFit.cover)
                : TextButton.icon(
              onPressed: pickImage,
              icon: const Icon(Icons.image),
              label: const Text('Chọn ảnh'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => saveCategory(context),
              child: Text(widget.category == null ? 'Tạo mới' : 'Cập nhật'),
            ),
          ],
        ),
      ),
    );
  }
}
