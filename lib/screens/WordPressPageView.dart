//Carlos Daniel Taveras Liranzo
//2021-2021
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';


class WordPressPageView extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<WordPressPageView> {
  List<dynamic> newsData = [];

  @override
  void initState() {
    super.initState();
    fetchNewsData();
  }

  Future<void> fetchNewsData() async {
    final response = await http.get(Uri.parse("https://www.nasa.gov/wp-json/wp/v2/posts"));

    if (response.statusCode == 200) {
      setState(() {
        newsData = json.decode(response.body);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NASA News"),
      ),
      body: ListView.builder(
        itemCount: newsData.length,
        itemBuilder: (context, index) {
          return NewsItem(newsData[index]);
        },
      ),
    );
  }
}

class NewsItem extends StatelessWidget {
  final Map<String, dynamic> news;

  NewsItem(this.news);

  @override
  Widget build(BuildContext context) {
    String title = news['title']['rendered'];
    String summary = news['excerpt']['rendered'];
    String link = news['link'];

    return Card(
      child: Column(
        children: [
          Image.network(
            'https://www.nasa.gov/wp-content/themes/nasa/assets/images/nasa-logo.svg', 
            height: 100, 
          ),
          ListTile(
            title: Text(title),
            subtitle: Text(summary),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              launch(link);
            },
          ),
        ],
      ),
    );
  }
}
