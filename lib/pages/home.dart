import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:newapp/models/article_model.dart';
import 'package:newapp/models/category_models.dart';
import 'package:newapp/models/slider_model.dart';
import 'package:newapp/pages/all_news.dart';
import 'package:newapp/pages/article_view.dart';
import 'package:newapp/pages/category_news.dart';
import 'package:newapp/services/data.dart';
import 'package:newapp/services/news.dart';
import 'package:newapp/services/slider_data.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories=[];
  List<SliderModel> slider=[];
  List<ArticleModel> articles=[];
  bool _loading= true;

  int activeIndex = 0;
  @override
  void initState() {
    categories = getCategories();
    getSliders();
    getNews();
    super.initState();
  }
  getNews() async {
    News newsclass = News();
    await newsclass.getNews();
    articles = newsclass.news;
    setState(() {
      _loading = false;
    });
  }
  getSliders() async {
    Sliders slidert = Sliders();
    await slidert.getSlider();
    slider = slidert.sliders;
    // setState(() {
    //   _loading = false;
    // });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('NEWS',
              style:
              TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),),

          ],
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: _loading?
      Center(child: CircularProgressIndicator()): SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 10.0),
                height: 70,
                child: ListView.builder(
                  shrinkWrap: true,
                    scrollDirection: Axis.horizontal ,
                    itemCount: categories.length,
                    itemBuilder: (context, index){
                      return CategoryTitle(
                        image: categories[index].image,
                        categoryName: categories[index].categoryName ,);
                    }
                ),
              ),
              SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'BREAKING NEWS!',
                      style: TextStyle(color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      fontFamily: 'Merriweather'),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> AllNews(news: 'Breaking')));
                      },
                      child: Text(
                        'View All',
                        style: TextStyle(color: Colors.blue,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              CarouselSlider.builder(
                  itemCount: 5,
                  itemBuilder: (context, index,realIndex){
                    String? res= slider[index].urlToImage;
                    String? res1= slider[index].title;
                    return buildImage(res!, index, res1!);
                  },
                  options: CarouselOptions(
                      height: 250,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      enlargeStrategy:  CenterPageEnlargeStrategy.height,
                      onPageChanged:(index, reason) {
                        setState(() {
                          activeIndex = index;
                        });
                      }
                  )),
                  SizedBox(height: 15,),
                  Center(child: buildIndicator()),
              SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'TRENDING NEWS!',
                      style: TextStyle(color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> AllNews(news: 'Trending')));
                      },
                      child: Text(
                        'View All',
                        style: TextStyle(color: Colors.blue,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Container(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                  return BlogTitle(
                      url: articles[index].url!,
                      desc: articles[index].description!,
                      imageUrl: articles[index].urlToImage!,
                      title: articles[index].title!);
              },
              )
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 10),
              //   child: Material(
              //     elevation: 3,
              //     borderRadius: BorderRadius.circular(10),
              //     child:
              //     Padding(
              //       padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              //       child: Row(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Container(
              //             child: ClipRRect(
              //               borderRadius: BorderRadius.circular(20),
              //               child: Image.asset(
              //                 'assets/images/sport.png',
              //                 height: 144,
              //                 width: 144,
              //                 fit: BoxFit.cover,),
              //             ),
              //           ),
              //           SizedBox(width: 8,),
              //           Column(
              //             children: [
              //               Container(
              //                 width: MediaQuery.of(context).size.width/1.8,
              //                 child: Text(
              //                   'Rui Costa outsprints breakaway to win stage 15',
              //                   style: TextStyle(color: Colors.black,
              //                       fontWeight: FontWeight.bold,
              //                       fontSize: 18),
              //                 ),
              //               ),
              //               SizedBox( height: 5,),
              //               Container(
              //                 width: MediaQuery.of(context).size.width/1.8,
              //                 child: Text(
              //                   'Then a final kick to beat lennard kama',
              //                   style: TextStyle(color: Colors.black38,
              //                       fontWeight: FontWeight.bold,
              //                       fontSize: 16),
              //                 ),
              //               ),
              //             ],
              //           ),
              //
              //         ],
              //       ),
              //     ),
              //
              //   ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget buildImage(String image, int index, String name) => Container(
    margin: EdgeInsets.symmetric(horizontal: 5),
    child: Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: CachedNetworkImage(

            height: 250,
            fit:  BoxFit.cover,
            width: MediaQuery.of(context).size.width, imageUrl: image,
          ),
      ),
        Container(
          height: 250,
          padding: EdgeInsets.only(left: 10),
          margin: EdgeInsets.only(
              top: 170
          ),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Colors.black26,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20)
          ),
          ),
          child: Text(
            name,
            maxLines: 2,
            style: TextStyle(
                color:Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold
            ),
          ),
        ),

      ],
    ),
  );
  Widget buildIndicator() => AnimatedSmoothIndicator(
      activeIndex: activeIndex,
      count: 5,
      effect: SlideEffect(
        dotWidth: 10,
        dotHeight: 10,
        activeDotColor: Colors.blue
    ),
  );
}
class CategoryTitle extends StatelessWidget {
  final image, categoryName;
  CategoryTitle({
    this.categoryName,
    this.image,
});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryNews(
                    name: categoryName
                )
            )
        );
      },
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                image,
                width: 120,
                height: 70,
              fit: BoxFit.cover,
              ),
            ),
            Container(
              height: 70,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.black26.withOpacity(.3),
      
              ),
              child: Center(
                  child: Text(
                    categoryName,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                    ),)),
            )
          ],
        ),
      ),
    );
  }
}
class BlogTitle extends StatelessWidget {
  String imageUrl, title, desc, url;
  BlogTitle({ required this.desc, required this.imageUrl, required this.title, required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ArticleView(blogUrl: url)));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10) ,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Material(
            elevation: 3,
            borderRadius: BorderRadius.circular(10),
            child:
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CachedNetworkImage(
                        imageUrl: imageUrl,
                        height: 144,
                        width: 144,
                        fit: BoxFit.cover,),
                    ),
                  ),
                  SizedBox(width: 8,),
                  Column(
                    children: [
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width / 1.8,
                        child: Text(
                          title,
                          maxLines: 2,
                          style: TextStyle(color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                      SizedBox(height: 5,),
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width / 1.8,
                        child: Text(
                          desc,
                          maxLines: 3,
                          style: TextStyle(color: Colors.black38,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


