import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:news/model/news_model.dart';

class NewsProvider with ChangeNotifier {
  NewsModel? _news;
  NewsModel? get news => _news;
  Future<void> fetchNewsData() async {
    try {
      final response = await http.get(Uri.parse(
          'https://run.mocky.io/v3/4ff191af-358d-427c-bc71-5e6031817dec'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        _news = NewsModel.fromJson(data);
        notifyListeners();
      } else {
        throw Exception('Failed to load news data');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }
}