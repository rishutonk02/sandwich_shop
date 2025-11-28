import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:sandwich_shop/models/sandwich.dart';

class SandwichRepository {
  Future<List<Sandwich>?> loadAll() async {
    final jsonString = await rootBundle.loadString('assets/sandwiches.json');
    final Map<String, dynamic> data =
        json.decode(jsonString) as Map<String, dynamic>;
    final List<dynamic> arr = data['sandwiches'] as List<dynamic>;
    return arr
        .map((e) => Sandwich.fromJson(e as Map<String, dynamic>))
        .toList()
        .cast<Sandwich>();
  }
}
