import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:union_shop/models/collection.dart';

class CollectionRepository {
  static final CollectionRepository instance = CollectionRepository._internal();
  factory CollectionRepository() => instance;
  // ignore: unused_element
  CollectionRepository._internal();

  late final Map<String, Collection> _collections;

  Collection? getCollection(String key) {
    return _collections[key];
  }

  List<Collection> getCollections() {
    return _collections.entries.map((v) => v.value).toList();
  }

  Future<void> loadCollections() async {
    String jsonString = await rootBundle.loadString("assets/store/collections.json");
    List<dynamic> jsonList = json.decode(jsonString);
    List<Map<String, dynamic>> jsonData = jsonList.map((v) => v as Map<String, dynamic>).toList();

    _collections = {};

    for (Map<String, dynamic> element in jsonData) {
      _collections[element["id"]] = Collection.fromJson(element);
    }

  }

}