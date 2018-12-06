import 'package:flutter/material.dart';
import 'package:flutter_news_web/categories.dart';
import 'package:flutter_news_web/news_list.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Categories> categoriesList;

  @override
  void initState() {
    categoriesList = new List<Categories>();
    categoriesList = loadCategories();
    super.initState();
  }

  List<Categories> loadCategories() {
    var categories = <Categories>[
      //adding all the categories of news in the list
      new Categories('images/top_news.png', "Top Headlines", "top_news"),
      new Categories('images/health_news.png', "Health", "health"),
      new Categories(
          'images/entertainment_news.png', "Entertainment", "entertainment"),
      new Categories('images/sports_news.png', "Sports", "sports"),
      new Categories('images/business_news.png', "Business", "business"),
      new Categories('images/tech_news.png', "Technology", "technology"),
      new Categories('images/science_news.png', "Science", "science"),
      new Categories('images/politics_news.png', "Politics", "politics")
    ];
    return categories;
  }

  @override
  Widget build(BuildContext context) {
    final title = 'News Web';
    return MaterialApp(
      title: title,
      home: Scaffold(
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
      ),
    );
  }
}
