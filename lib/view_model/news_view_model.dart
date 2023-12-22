import 'package:world_news_app_project/model/category_news_model.dart';
import 'package:world_news_app_project/model/news_channel_headlines_model.dart';
import 'package:world_news_app_project/repository/news_repository.dart';

class NewsViewModel {
  // importing the news repository class which contains two APIs
  final _rep = NewsRepository();

  Future<NewsChannelHeadlinesModel> fetchNewsChannelHeadlinesApi(
      String channel) async {
    final response = await _rep.fetchNewsChannelApiHeadlines(channel);
    return response;
  }

  Future<CategoriesNewsModel> fetchCategoriesNewsApi(String category) async {
    final response = await _rep.fetchCategoriesNewsApi(category);
    return response;
  }
}
