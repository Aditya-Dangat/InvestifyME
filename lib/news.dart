import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'news_card.dart';

class newsPage extends StatefulWidget {
  @override
  _newsPageState createState() => _newsPageState();
}

class _newsPageState extends State<newsPage> {
  List<Article> articles = [];
  int myIndex=0;
  int buttonSelected = 1;
  static const String routeName = '/news';
  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  Future<void> fetchNews() async {
    final response = await http.get(
        Uri.parse('https://newsapi.org/v2/top-headlines?country=in&category=business&apiKey=d301e8bc90df4cefbe6527e8cefc8daa'));
        
    if (response.statusCode == 200) {
      setState(() {
        articles = (json.decode(response.body)['articles'] as List)
            .map((article) => Article.fromJson(article))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffeffeff),
      appBar: AppBar(
        title: Text('News',style: TextStyle(color: const Color(0xff202232), fontSize: 20.0, fontWeight: FontWeight.bold)),
    
        backgroundColor: Color(0xffeffeff),
      ),
      body: ListView.builder(
      itemCount: articles.length,
      itemBuilder: (context, index) {
        final article = articles[index];
        return GestureDetector(
          onTap: () async {
            if (await canLaunchUrl(Uri.parse(article.url))) {
              await launchUrl(Uri.parse(article.url));
            } else {
              throw 'Could not launch ${article.url}';
            }
          },
          child: NewsCard(article: article),
        );
      },
    ),
    );
    
  }
}

class Article {
  final String author;
  final String title;
  final String description;
  final String url;

  Article({
    required this.author,
    required this.title,
    required this.description,
    required this.url
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      author: json['author'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
    );
  }
}