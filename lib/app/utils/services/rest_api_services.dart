library rest_api_service;

import 'package:flutter/material.dart';
import 'package:marketplace/app/constans/app_constants.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

// model
part 'model/product.dart';
part 'model/user.dart';
part 'model/etalase.dart';

// src
part 'src/product_service.dart';
part 'src/user_service.dart';
part 'src/etalase_service.dart';

/// custom setup for request api
class RestApiServices {
  // to get data from server, you can use Http for simple feature
  // or Dio for more complex feature

  Future fetchData({required String baseUrl}) async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      // print("api response: $jsonResponse");
      return jsonResponse;
    } else {
      throw Exception('Failed to load products');
    }
  }
}
