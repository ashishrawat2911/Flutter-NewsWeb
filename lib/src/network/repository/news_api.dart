import 'package:flutter_news_web/src/network/repository/I_news_api.dart';
import 'package:flutter_news_web/src/network/api_base_helper.dart';

import 'package:flutter_news_web/src/model/news_model.dart';

class NewsRepository extends INewsAPi {
  ApiBaseHelper apiBaseHelper = ApiBaseHelper();

  @override
  Future<List<Article>> getCategoryNews(String newsType) async {
    final response = await apiBaseHelper.get(newsType);
    return News.fromJson(response).articles;
  }

  @override
  Future<List<Article>> getTopHeadlines() async {
    final response = await apiBaseHelper.get("top-headlines");
    return News.fromJson(response).articles;
  }
}
