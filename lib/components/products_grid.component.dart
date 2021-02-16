import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/components/product_item.component.dart';
import 'package:shop_app/providers/products.provider.dart';

class ProductsGrid extends StatelessWidget {
  final bool _showOnlyFavoriteProducts;

  ProductsGrid(this._showOnlyFavoriteProducts);

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<Products>(context);
    var products = _showOnlyFavoriteProducts
        ? productsProvider.favoriteItems
        : productsProvider.items;

    return GridView.builder(
      padding: const EdgeInsets.all(15),
      itemCount: products.length,
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        value: products[index],
        child: ProductItem(),
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 4 / 5,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
      ),
    );
  }
}
