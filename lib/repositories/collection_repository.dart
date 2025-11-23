import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:union_shop/models/collection.dart';

class CollectionRepository {
  static final CollectionRepository instance = CollectionRepository();
  factory CollectionRepository() => instance;
  CollectionRepository._internal();

  late final Map<String, Collection> _collections;

  Collection? getCollection(String key) {
    return _collections[key];
  }

  void loadCollections() async {
    String jsonString = await rootBundle.loadString("assets/store/collections.json");
    List<Map<String, dynamic>> jsonData = json.decode(jsonString);

    _collections = {};



  }

}