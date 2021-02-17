import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/components/order_item.component.dart';
import 'package:shop_app/providers/orders.provider.dart' show Orders;

class OrdersScreen extends StatelessWidget {
  static const String routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    final ordersProvider = Provider.of<Orders>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      body: ListView.builder(
        itemCount: ordersProvider.orders.length,
        itemBuilder: (context, i) => OrderItem(
          ordersProvider.orders[i],
        ),
      ),
    );
  }
}
