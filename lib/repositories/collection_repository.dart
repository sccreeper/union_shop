import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:union_shop/models/collection.dart';

class CollectionRepository {
  static final CollectionRepository instance = CollectionRepository();
  factory CollectionRepository() => instance;
  // ignore: unused_element
  CollectionRepository._internal();

  late final Map<String, Collection> _collections;

  Collection? getCollection(String key) {
    return _collections[key];
  }

  void loadCollections() async {
    String jsonString = await rootBundle.loadString("assets/store/collections.json");
    List<Map<String, dynamic>> jsonData = json.decode(jsonString);

    _collections = {};

    for (Map<String, dynamic> element in jsonData) {
      _collections[element["id"]] = Collection.fromJson(element);
    }

  }

}