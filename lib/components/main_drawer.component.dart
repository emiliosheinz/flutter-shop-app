import 'package:flutter/material.dart';
import 'package:shop_app/screens/orders.screen.dart';
import 'package:shop_app/screens/products_overview.screen.dart';
import 'package:shop_app/screens/user_products.scree.dart';

class MainDrawer extends StatelessWidget {
  Widget buildListTile({String title, IconData icon, Function onTap}) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 130,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).primaryColor,
            child: Text(
              'MyShop!',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 30,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 20),
          buildListTile(
            title: 'Products',
            icon: Icons.shopping_cart,
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(ProductsOverviewScreen.routeName);
            },
          ),
          buildListTile(
            title: 'Orders',
            icon: Icons.shopping_bag,
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(OrdersScreen.routeName);
            },
          ),
          buildListTile(
            title: 'Manage Products',
            icon: Icons.edit,
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(UserProductsScreen.routeName);
            },
          )
        ],
      ),
    );
  }
}
