import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/models/http_exception.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  Future<void> toggleIsFavorite(String authToken) async {
    final oldIsFavoriteValue = isFavorite;
    final newIsFavoriteValue = !isFavorite;

    isFavorite = newIsFavoriteValue;
    notifyListeners();

    final url =
        'https://flutter-shop-app-d6be4-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken';
    final response = await http.patch(
      url,
      body: json.encode({
        'isFavorite': newIsFavoriteValue,
      }),
    );

    if (response.statusCode >= 400) {
      isFavorite = oldIsFavoriteValue;
      notifyListeners();
      throw HttpException("Could not update favorite value.");
    }
  }
}
