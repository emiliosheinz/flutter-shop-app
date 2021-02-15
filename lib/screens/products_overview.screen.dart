import 'package:flutter/material.dart';
import 'package:shop_app/components/products_grid.component.dart';

class ProductsOverviewScreen extends StatelessWidget {
  static const String routeName = '/products-overview';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
      ),
      body: ProductsGrid(),
    );
  }
}
