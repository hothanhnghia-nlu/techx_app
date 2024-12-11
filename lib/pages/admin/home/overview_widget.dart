import 'package:flutter/material.dart';
import 'package:techx_app/services/statistical_service.dart';
import 'package:techx_app/utils/currency.dart';

// ignore: must_be_immutable
class OverviewWidget extends StatelessWidget {
  OverviewWidget({super.key});

  StatisticalService statisticalService = StatisticalService();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Total customers
        FutureBuilder(
          future: statisticalService.getTotalCustomers(),
          builder: (context, snapshot) {
            final customer = snapshot.data;
            return Container(
              padding: const EdgeInsets.all(10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Image.asset(
                    'assets/customers_icon.png',
                    height: 90,
                    width: 90,
                  ),
            
                  const SizedBox(width: 15),
            
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Tổng số khách hàng',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        (customer ?? 0).toString(),
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        ),

        const SizedBox(height: 10),

        // Total orders
        FutureBuilder(
          future: statisticalService.getTotalOrders(),
          builder: (context, snapshot) {
            final order = snapshot.data;
            return Container(
              padding: const EdgeInsets.all(10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Image.asset(
                    'assets/orders_icon.png',
                    height: 90,
                    width: 90,
                  ),
            
                  const SizedBox(width: 15),
            
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Tổng số đơn đặt hàng',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        (order ?? 0).toString(),
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        ),

        const SizedBox(height: 10),

        // Total revenue
        FutureBuilder(
          future: statisticalService.getTotalRevenue(),
          builder: (context, snapshot) {
            final revenue = snapshot.data;
            return Container(
              padding: const EdgeInsets.all(10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Image.asset(
                    'assets/revenue_icon.png',
                    height: 90,
                    width: 90,
                  ),
            
                  const SizedBox(width: 15),
            
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Tổng doanh thu',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        formatCurrency(revenue ?? 0),
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        ),
      ],
    );
  }
}
