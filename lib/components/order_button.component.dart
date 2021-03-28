import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.provider.dart';
import 'package:shop_app/providers/orders.provider.dart';

class OrderButton extends StatefulWidget {
  final Cart cart;

  OrderButton(this.cart);

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isPlacingOrder = false;

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);

    return FlatButton(
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Text('ORDER NOW'),
          _isPlacingOrder
              ? SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(),
                )
              : Container(),
        ],
      ),
      onPressed: widget.cart.itemCount > 0
          ? () async {
              try {
                setState(() {
                  _isPlacingOrder = true;
                });

                await Provider.of<Orders>(context, listen: false).addOrder(
                  widget.cart.items.values.toList(),
                  widget.cart.totalAmount,
                );
                widget.cart.clear();
              } catch (error) {
                scaffold.showSnackBar(
                  SnackBar(
                    content: Text(
                      'There was an error placing that order, try again!',
                    ),
                  ),
                );
              } finally {
                setState(() {
                  _isPlacingOrder = false;
                });
              }
            }
          : null,
      textColor: Theme.of(context).primaryColor,
    );
  }
}
