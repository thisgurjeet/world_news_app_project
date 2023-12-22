import 'dart:convert';

import 'package:world_news_app_project/model/category_news_model.dart';
import 'package:world_news_app_project/model/news_channel_headlines_model.dart';
import 'package:http/http.dart' as http;

class NewsRepository {
  Future<NewsChannelHeadlinesModel> fetchNewsChannelApiHeadlines(
      String channelName) async {
    String url =
        "https://newsapi.org/v2/top-headlines?sources=$channelName&apiKey=2d471b65da0440fba363c335ada17c6a";

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return NewsChannelHeadlinesModel.fromJson(body);
    } else {
      throw Exception('Error');
    }
  }

  Future<CategoriesNewsModel> fetchCategoriesNewsApi(
      String categoryName) async {
    String url =
        "https://newsapi.org/v2/everything?q=$categoryName&apiKey=2d471b65da0440fba363c335ada17c6a";

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return CategoriesNewsModel.fromJson(body);
    } else {
      throw Exception('Error');
    }
  }
}
