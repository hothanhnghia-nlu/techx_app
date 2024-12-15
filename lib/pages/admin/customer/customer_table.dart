import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:techx_app/pages/admin/customer/customer_detail_screen.dart';
import 'package:techx_app/utils/constant.dart';

class CustomerTable extends StatefulWidget {
  const CustomerTable({super.key});

  @override
  State<CustomerTable> createState() => _CustomerTableState();
}

class _CustomerTableState extends State<CustomerTable> {
  List<dynamic> _users = [];
  final baseUrl = Constant.api;

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  // Get list users
  Future<void> fetchUsers() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/users/by-role'));
      if (response.statusCode == 200) {
        final decodedBody = utf8.decode(response.bodyBytes);
        setState(() {
          _users = json.decode(decodedBody);
        });
      } else {
        throw Exception("Failed to load users");
      }
    } catch (e) {
      print(e);
    }
  }

  // Delete user
  Future<void> deleteUserById(int id) async {
    final url = Uri.parse('$baseUrl/users/$id');
    final response = await http.delete(url);

    if (response.statusCode != 200) {
      throw Exception('Failed to delete user: ${response.body}');
    }
  }

  // Convert status data from numeric to plain text
  Widget convertStatusData(int status) {
    switch (status) {
      case 2:
        return const Text(
          'Ngừng hoạt động',
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        );
      default:
        return const Text(
          'Đang hoạt động',
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
        );
    }
  }

  // Delete item Button
  void deleteButton(int userId) {
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
            child: const Text('Hủy'),
          ),

          // Button Confirm
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              try {
                await deleteUserById(userId);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Xóa thành công!'),
                    duration: Duration(seconds: 1),
                  ),
                );
                setState(() {
                  _users.removeWhere((user) => user['id'] == userId);
                });
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Xóa thất bại: $e'),
                    duration: const Duration(seconds: 2),
                  ),
                );
              }
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
          'Quản lý khách hàng',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: _users.isEmpty
            ? Padding(
                padding: const EdgeInsets.only(top: 300),
                child: Center(
                  child: Text(
                    'Không có dữ liệu nào',
                    style: TextStyle(
                      color: Color(hexColor('#9DA2A7')),
                      fontSize: 18,
                    ),
                  ),
                ),
              )
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('ID')),
                    DataColumn(label: Text('Tên khách hàng')),
                    DataColumn(label: Text('Số điện thoại')),
                    DataColumn(label: Text('Email')),
                    DataColumn(label: Text('Trạng thái')),
                    DataColumn(label: Text('Chức năng')),
                  ],
                  rows: _users.map((user) {
                    return DataRow(cells: [
                      DataCell(SizedBox(
                          width: 40,
                          child: Text('${user['id']}',
                              overflow: TextOverflow.ellipsis))),
                      DataCell(SizedBox(
                        width: 150,
                        child: Text('${user['fullName']}',
                            overflow: TextOverflow.ellipsis),
                      )),
                      DataCell(SizedBox(
                        width: 120,
                        child: Text('${user['phoneNumber']}',
                            overflow: TextOverflow.ellipsis),
                      )),
                      DataCell(SizedBox(
                        width: 150,
                        child: Text('${user['email']}',
                            overflow: TextOverflow.ellipsis),
                      )),
                      DataCell(convertStatusData(user['status'])),
                      
                      DataCell(Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (_) =>
                                        CustomerDetailScreen(user: user)),
                              );
                            },
                            icon: const Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () => deleteButton(user['id']),
                            icon: const Icon(Icons.delete),
                          ),
                        ],
                      )),
                    ]);
                  }).toList(),
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
