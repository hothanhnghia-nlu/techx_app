import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'products_detail_screen.dart';

class ProductsTable extends StatefulWidget {
  const ProductsTable({Key? key}) : super(key: key);

  @override
  State<ProductsTable> createState() => _ProductsTableState();
}

class _ProductsTableState extends State<ProductsTable> {
  List<dynamic> _products = [];

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    const String apiUrl = "http://10.0.2.2:8080/api/v1/products";
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        setState(() {
          _products = json.decode(response.body);
        });
      } else {
        print("Failed to load products: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching products: $e");
    }
  }

  void deleteProduct(int id) {
    // Hiển thị hộp thoại xác nhận trước khi xóa sản phẩm
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Thông báo'),
        content: const Text('Bạn có chắc muốn xóa sản phẩm này?'),
        actions: [
          // Nút hủy
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          // Nút xóa
          TextButton(
            onPressed: () async {
              Navigator.pop(context); // Đóng hộp thoại sau khi xác nhận
              try {
                // Gửi yêu cầu xóa sản phẩm từ API
                final response = await http.delete(Uri.parse('http://10.0.2.2:8080/api/v1/products/$id'));

                if (response.statusCode == 200) {
                  // Nếu xóa thành công, cập nhật danh sách sản phẩm
                  setState(() {
                    _products.removeWhere((product) => product['id'] == id);
                  });
                  // Hiển thị thông báo thành công
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Xóa sản phẩm thành công!')),
                  );
                } else {
                  // Nếu xóa thất bại, hiển thị thông báo lỗi
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Xóa thất bại: ${response.statusCode}')),
                  );
                  print("Xóa thất bại: ${response.statusCode}");
                }
              } catch (e) {
                // Nếu có lỗi trong quá trình kết nối
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Lỗi khi xóa sản phẩm: $e')),
                );
                print("Lỗi khi xóa sản phẩm: $e");
              }
            },
            child: const Text('Xóa'),
          ),
        ],
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sản phẩm')),
      body: ListView.builder(
        itemCount: _products.length,
        itemBuilder: (context, index) {
          final product = _products[index];
          return Card(
            child: ListTile(
              title: Text(product['name']),
              subtitle: Text('ID: ${product['id']}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductsDetailScreen(
                            productData: product,
                          ),
                        ),
                      ).then((_) => fetchProducts());
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => deleteProduct(product['id']),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ProductsDetailScreen(),
            ),
          ).then((_) => fetchProducts());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
