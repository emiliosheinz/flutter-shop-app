import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/components/main_drawer.component.dart';
import 'package:shop_app/components/order_item.component.dart';
import 'package:shop_app/providers/orders.provider.dart' show Orders;

class OrdersScreen extends StatefulWidget {
  static const String routeName = '/orders';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<Orders>(context, listen: false).fetchAndSetOrders().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }

    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final ordersProvider = Provider.of<Orders>(context);

    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () => Provider.of<Orders>(context, listen: false)
                  .fetchAndSetOrders(),
              child: ListView.builder(
                itemCount: ordersProvider.orders.length,
                itemBuilder: (context, i) => OrderItem(
                  ordersProvider.orders[i],
                ),
              ),
            ),
    );
  }
}
