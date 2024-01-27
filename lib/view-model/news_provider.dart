import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:news/model/news_model.dart';

class NewsProvider with ChangeNotifier {
  NewsModel? _news;
  NewsModel? get news => _news;
  // Future<void> fetchNewsData() async {
  //   try {
  //     final response = await http.get(Uri.parse(
  //         'https://newsapi.org/v2/everything?q=tesla&from=2023-12-27&sortBy=publishedAt&apiKey=cdfcaf6c8f2547dca324a80585d4d12e'));
  //     if (response.statusCode == 200) {
  //       final Map<String, dynamic> data = json.decode(response.body);
  //       _news = NewsModel.fromJson(data);
  //       notifyListeners();
  //     } else {
  //       throw Exception('Failed to load news data');
  //     }
  //   } catch (error) {
  //     throw Exception('Error: $error');
  //   }
  // }

  Future<void> fetchNewsData(String? searchKeyword) async {
    try {

      final response = await http.get(Uri.parse(
             'https://newsapi.org/v2/everything?q=$searchKeyword&from=2023-12-27&sortBy=publishedAt&apiKey=cdfcaf6c8f2547dca324a80585d4d12e'));
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

  Future<void> fetchNewByCategory(String? category) async {
    try {
      final response = await http.get(Uri.parse(
          'https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=cdfcaf6c8f2547dca324a80585d4d12e'));

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

  Future<void> fetchSortNewsBy(String? sortBy) async {
    try {
      final response = await http.get(Uri.parse(
          'https://newsapi.org/v2/everything?q=tesla&from=2023-12-27&sortBy=$sortBy&apiKey=cdfcaf6c8f2547dca324a80585d4d12e'));

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

  Future<void> fetchWallStreetJournalNews() async {
    try {
      final response = await http.get(Uri.parse(
          'https://newsapi.org/v2/everything?domains=wsj.com&apiKey=cdfcaf6c8f2547dca324a80585d4d12e'));

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