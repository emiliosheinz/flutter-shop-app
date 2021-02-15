import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  static const String routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final String productId = arguments['id'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Product name'),
      ),
    );
  }
}
