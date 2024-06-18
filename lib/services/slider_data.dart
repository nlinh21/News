import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:newapp/models/slider_model.dart';

class Sliders {
  List<SliderModel> sliders=[];

  Future<void> getSlider() async {
    String url = 'https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=5b38cdddeb6e409490d2dc0c057cbfb7';
    var response = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {
        if(element['urlToImage']!=null && element['description']!=null) {
          SliderModel sliderModel =SliderModel(
            title: element['title'],
            description: element ['description'],
            url: element['url'],
            urlToImage: element['urlToImage'],
            content: element['content'],
            author: element['author'],
          );
          sliders.add(sliderModel);
        }
      });
    }
  }
}