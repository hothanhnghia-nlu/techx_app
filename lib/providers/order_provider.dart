import 'dart:developer';

import 'package:flutter/material.dart';

import '../controllers/order_controller.dart';
import '../models/order_model.dart';

class OrderProvider extends ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get orders => _orders;

  OrderProvider() {
    _fetchOrders();
    _fetchOrdersByUser();
  }

  Future<void> _fetchOrdersByUser() async {
    final orderController = OrderController();
    _orders = await orderController.getOrdersByUser();
    log("orders: $_orders");
    notifyListeners();
  }

  Future<void> _fetchOrders() async {
    final orderController = OrderController();
    _orders = await orderController.getOrders();
    notifyListeners();
  }

  Future<void> refreshOrders() async {
    await _fetchOrders();
  }

  Future<void> refreshOrdersByUser() async {
    await _fetchOrdersByUser();
  }

  Future<void> updateOrderStatus(int orderId, Order order) async {
    log("thay đổi trạng thái");
     final orderController = OrderController();
    await orderController.updateOrderStatus(orderId, order);
    await _fetchOrders();
     notifyListeners();
  }
}
