import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/auth.provider.dart';
import 'package:shop_app/providers/cart.provider.dart';
import 'package:shop_app/providers/product.provider.dart';
import 'package:shop_app/screens/product_detail.screen.dart';

class ProductItem extends StatelessWidget {
  Future<void> _handleFavoritePress(
    Product product,
    ScaffoldState scaffold,
    String authToken,
    String userId,
  ) async {
    try {
      await product.toggleIsFavorite(authToken, userId);
    } catch (_) {
      scaffold.hideCurrentSnackBar();
      scaffold.showSnackBar(
        SnackBar(content: Text('Updating favorite state failed!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    final cart = Provider.of<Cart>(context, listen: false);
    final scaffold = Scaffold.of(context);
    final authData = Provider.of<Auth>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: {
                'id': product.id,
              },
            );
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          leading: IconButton(
            icon: Icon(
              product.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: product.isFavorite ? Colors.red : Colors.white,
            ),
            onPressed: () => _handleFavoritePress(
              product,
              scaffold,
              authData.token,
              authData.userId,
            ),
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              cart.addItem(
                productId: product.id,
                price: product.price,
                title: product.title,
              );
              Scaffold.of(context).hideCurrentSnackBar();
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('Item added to cart!'),
                  action: SnackBarAction(
                    label: 'UNDO',
                    onPressed: () {
                      cart.removeSingleItem(product.id);
                    },
                  ),
                ),
              );
            },
          ),
          backgroundColor: Colors.black54,
        ),
      ),
    );
  }
}
