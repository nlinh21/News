import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newapp/models/article_model.dart';
import 'package:newapp/models/slider_model.dart';
import 'package:newapp/pages/article_view.dart';
import 'package:newapp/services/news.dart';
import 'package:newapp/services/slider_data.dart';

class AllNews extends StatefulWidget {
  String news;

  AllNews({required this.news});

  @override
  State<AllNews> createState() => _AllNewsState();
}

class _AllNewsState extends State<AllNews> {
  List<SliderModel> slider = [];
  List<ArticleModel> articles = [];

  void initState() {
    getSliders();
    getNews();
    super.initState();
  }


  getNews() async {
    News newsclass = News();
    await newsclass.getNews();
    articles = newsclass.news;
    setState(() {
    });
  }

  getSliders() async {
    Sliders slidert = Sliders();
    await slidert.getSlider();
    slider = slidert.sliders;
    setState(() {

    });
  }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title:
          Text(
            widget.news + ' News',
            style:
            TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: widget.news == 'Breaking'? slider.length: articles.length,
              itemBuilder: (context, index) {
                return AllNewsSection(
                  Image: widget.news == 'Breaking'? slider[index].urlToImage!: articles[index].urlToImage!,
                  desc: widget.news == 'Breaking'? slider[index].description!: articles[index].description!,
                  title:widget.news == 'Breaking'? slider[index].title!: articles[index].title!,
                  url:widget.news == 'Breaking'? slider[index].url!: articles[index].url!,
                );
              },
            )
        ),
      );
  }
}
  class AllNewsSection extends StatelessWidget {
    String Image, desc, title, url;
    AllNewsSection({required this.Image, required this.desc, required this.title, required this.url});

    @override
    Widget build(BuildContext context) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
            builder: (context) => ArticleView(blogUrl:url)));
            },
        child: Container(
          child: Column(
            children: [
              ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
              imageUrl:Image,
              width: MediaQuery.of(context).size.width,
              height: 200,
              fit: BoxFit.cover,
              ),
              ),
              SizedBox(height: 5,),
              Text(title,
              maxLines: 2,
              style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold)
              ),
              Text(desc,
              maxLines: 3,
              ),
              SizedBox(height: 20,)
              ],
              ),
              ),
    );
    }
    }

