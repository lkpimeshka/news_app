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
          'https://newsapi.org/v2/everything?q=tesla&from=2023-12-26&sortBy=publishedAt&apiKey=cdfcaf6c8f2547dca324a80585d4d12e'));
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