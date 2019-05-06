import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_news_web/model/news.dart';
import 'package:flutter_news_web/news_details.dart';
import 'package:http/http.dart' as http;

class NewsListPage extends StatefulWidget {
  final String title;
  final String newsType;

  NewsListPage(this.title, this.newsType);

  @override
  _NewsListPageState createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  @override
  void initState() {
    super.initState();
  }

  Future<List<Article>> getData(String newsType) async {
    List<Article> list;
    String link;
    if (newsType == "top_news") {
      link =
          "https://newsapi.org/v2/top-headlines?country=in&apiKey=ae6c3c0f9d8e485a98fd70edcff81134";
    } else {
      link =
          "https://newsapi.org/v2/top-headlines?country=in&category=$newsType&apiKey=ae6c3c0f9d8e485a98fd70edcff81134";
    }
    var res = await http
        .get(Uri.encodeFull(link), headers: {"Accept": "application/json"});
    // print(res.body);
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      var rest = data["articles"] as List;
      print(rest);
      list = rest.map<Article>((json) => Article.fromJson(json)).toList();
    }
    print("List Size: ${list.length}");
    return list;
  }

  Widget listViewWidget(List<Article> article) {
    return Container(
      child: ListView.builder(
          itemCount: 20,
          padding: const EdgeInsets.all(2.0),
          itemBuilder: (context, position) {
            return Card(
              child: Container(
                height: 120.0,
                width: 120.0,
                child: Center(
                  child: ListTile(
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        '${article[position].author}',
                      ),
                    ),
                    title: Text(
                      '${article[position].title}',
                      style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    leading: Container(
                      height: 100.0,
                      width: 100.0,
                      child: article[position].urlToImage == null
                          ? Image(
                              image:
                                  AssetImage('images/no_image_available.png'),
                            )
                          : Image.network('${article[position].urlToImage}'),
                    ),
                    onTap: () => _onTapItem(context, article[position]),
                  ),
                ),
              ),
            );
          }),
    );
  }

  void _onTapItem(BuildContext context, Article article) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => NewsDetails(article, widget.title)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
          future: getData(widget.newsType),
          builder: (context, snapshot) {
            return snapshot.data != null
                ? listViewWidget(snapshot.data)
                : Center(child: CircularProgressIndicator());
          }),
    );
  }
}
