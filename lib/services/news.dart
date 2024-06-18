import 'dart:convert';

import 'package:newapp/models/article_model.dart';
import 'package:http/http.dart' as http;

class News {
  List<ArticleModel> news=[];

  Future<void> getNews() async {
    String url = 'https://newsapi.org/v2/everything?q=tesla&from=2024-04-10&sortBy=publishedAt&apiKey=5b38cdddeb6e409490d2dc0c057cbfb7';
    var response = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {
        if(element['urlToImage']!=null && element['description']!=null) {
          ArticleModel articleModel = ArticleModel(
            title: element['title'],
            description: element ['description'],
            url: element['url'],
            urlToImage: element['urlToImage'],
            content: element['content'],
            author: element['author'],
          );
          news.add(articleModel);
        }
      });
    }
  }
}