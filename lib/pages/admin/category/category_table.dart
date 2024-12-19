import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'category_detail_screen.dart';

class CategoryTable extends StatefulWidget {
  const CategoryTable({super.key});

  @override
  State<CategoryTable> createState() => _CategoryTableState();
}

class _CategoryTableState extends State<CategoryTable> {
  List<Map<String, dynamic>> categories = [];

  // Lấy danh mục từ API
  Future<void> fetchCategories() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8080/api/v1/providers'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        categories = List<Map<String, dynamic>>.from(data);
      });
    } else {
      print("Lỗi khi tải danh mục: ${response.statusCode}");
    }
  }

  // Xóa danh mục
  Future<void> deleteCategory(BuildContext context, int categoryId) async {
    final String apiUrl = "http://10.0.2.2:8080/api/v1/providers/$categoryId";

    try {
      final response = await http.delete(Uri.parse(apiUrl));

      if (response.statusCode == 200 || response.statusCode == 204) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Xóa danh mục thành công')),
        );
        fetchCategories(); // Cập nhật lại danh sách danh mục
      } else {
        print("Lỗi xóa danh mục: ${response.statusCode}, ${response.body}");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Xóa danh mục thất bại')),
        );
      }
    } catch (e) {
      print("Lỗi kết nối: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lỗi kết nối')),
      );
    }
  }

  // Hiển thị hộp thoại xác nhận xóa
  void deleteButton(int categoryId) {
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
          'Bạn có chắc muốn xóa mục này?',
          style: TextStyle(
            fontSize: 15,
            color: Colors.black,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, 'Hủy'),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Color(hexColor('#9DA2A7'))),
              foregroundColor: MaterialStateProperty.all(Colors.white),
            ),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              deleteCategory(context, categoryId);
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.red),
              foregroundColor: MaterialStateProperty.all(Colors.white),
            ),
            child: const Text(
              'Đồng ý',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    fetchCategories(); // Gọi API khi trang được tải
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
          'Danh mục',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
          ),
        ),
      ),
      body: categories.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: const [
              DataColumn(label: Text('ID')),
              DataColumn(label: Text('Tên danh mục')),
              DataColumn(label: Text('Chức năng')),
            ],
            rows: categories.map((category) {
              return DataRow(cells: [
                DataCell(Text(category['id'].toString())),
                DataCell(Text(category['name'])),
                DataCell(Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) =>
                                CategoryDetailScreen(category: category),
                          ),
                        );
                      },
                      icon: const Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () => deleteButton(category['id']),
                      icon: const Icon(Icons.delete),
                    ),
                  ],
                )),
              ]);
            }).toList(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => CategoryDetailScreen()),
          );
        },
        backgroundColor: Colors.blue[50],
        child: const Icon(Icons.add),
      ),
    );
  }
}

int hexColor(String color) {
  String newColor = "0xff$color";
  newColor = newColor.replaceAll('#', '');
  return int.parse(newColor);
}
