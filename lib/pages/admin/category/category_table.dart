import 'package:flutter/material.dart';
import 'package:techx_app/pages/admin/category/category_detail_screen.dart';

class CategoryTable extends StatefulWidget {
  const CategoryTable({super.key});

  @override
  State<CategoryTable> createState() => _CategoryTableState();
}

class _CategoryTableState extends State<CategoryTable> {

  void deleteButton() {
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
          // Button Cancel
          TextButton(
            onPressed: () => Navigator.pop(context, 'Hủy'),
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Color(hexColor('#9DA2A7'))),
              foregroundColor: WidgetStateProperty.all(Colors.white),
              padding: WidgetStateProperty.all(const EdgeInsets.symmetric(vertical: 10, horizontal: 20)),
              shape: WidgetStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            child: const Text('Hủy'),
          ),

          // Button Confirm
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Đã nhấn nút xóa'),
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: const [
              DataColumn(label: Text('ID')),
              DataColumn(label: Text('Tên danh mục')),
              DataColumn(label: Text('Chức năng')),
            ],
            rows: [
              DataRow(cells: [
                const DataCell(SizedBox(
                    width: 40,
                    child: Text('1', overflow: TextOverflow.ellipsis))),
                const DataCell(SizedBox(
                  width: 120,
                  child: Text('Vivo', overflow: TextOverflow.ellipsis),
                )),
                DataCell(Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (_) => CategoryDetailScreen()),
                        );
                      },
                      icon: const Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: deleteButton,
                      icon: const Icon(Icons.delete),
                    ),
                  ],
                )),
              ]),
            ],
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
  int finalColor = int.parse(newColor);
  return finalColor;
}