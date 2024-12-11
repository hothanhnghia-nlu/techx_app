import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:techx_app/utils/constant.dart';

class StatisticalService {
  final baseUrl = Constant.api;

  // Get total customers
  Future<int> getTotalCustomers() async {
    final url = Uri.parse('$baseUrl/statistical/total-customers');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load total customers: ${response.body}');
    }
  }

  // Get total orders
  Future<int> getTotalOrders() async {
    final url = Uri.parse('$baseUrl/statistical/total-orders');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load total orders: ${response.body}');
    }
  }

  // Get total revenue
  Future<double> getTotalRevenue() async {
    final url = Uri.parse('$baseUrl/statistical/total-revenue');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load total revenue: ${response.body}');
    }
  }

}