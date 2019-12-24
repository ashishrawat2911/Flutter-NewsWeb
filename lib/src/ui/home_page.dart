import 'package:flutter/material.dart';

import '../model/categories_model.dart';
import 'news_list.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CategoriesModel> categoriesList;

  @override
  void initState() {
    categoriesList = new List<CategoriesModel>();
    categoriesList = loadCategories();
    super.initState();
  }

  List<CategoriesModel> loadCategories() {
    var categories = <CategoriesModel>[
      //adding all the categories of news in the list
      new CategoriesModel('images/top_news.png', "Top Headlines", "top_news"),
      new CategoriesModel('images/health_news.png', "Health", "health"),
      new CategoriesModel(
          'images/entertainment_news.png', "Entertainment", "entertainment"),
      new CategoriesModel('images/sports_news.png', "Sports", "sports"),
      new CategoriesModel('images/business_news.png', "Business", "business"),
      new CategoriesModel('images/tech_news.png', "Technology", "technology"),
      new CategoriesModel('images/science_news.png', "Science", "science"),
      new CategoriesModel('images/politics_news.png', "Politics", "politics")
    ];
    return categories;
  }

  @override
  Widget build(BuildContext context) {
    final title = 'News Web';
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: GridView.count(
        // Create a grid with 2 columns. If you change the scrollDirection to
        // horizontal, this would produce 2 rows.
        crossAxisCount: 2,
        // Generate 100 Widgets that display their index in the List
        children: List.generate(8, (index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              color: Colors.white,elevation: 1.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0)),
              child: Column(
                children: <Widget>[
                  Image(
                    image: AssetImage(categoriesList[index].image),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      categoriesList[index].title,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => NewsListPage(
                        categoriesList[index].title,
                        categoriesList[index].newsType)));
              },
            ),
          );
        }),
      ),
    );
  }
}
