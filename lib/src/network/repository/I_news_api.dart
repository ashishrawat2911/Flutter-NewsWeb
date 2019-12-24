import 'package:flutter_news_web/src/model/news_model.dart';

abstract class INewsAPi {
  Future<List<Article>> getCategoryNews(String newsType);

  Future<List<Article>> getTopHeadlines();
}
