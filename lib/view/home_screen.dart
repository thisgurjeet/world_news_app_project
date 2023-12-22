import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:world_news_app_project/model/category_news_model.dart';
import 'package:world_news_app_project/model/news_channel_headlines_model.dart';
import 'package:world_news_app_project/view/category_screen.dart';
import 'package:world_news_app_project/view/news_detail_screen.dart';
import 'package:world_news_app_project/view_model/news_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

// created enums for filters
enum FilterList { bbcNews, aryNews, independent, reuters, cnn, alJazeera }

class _HomeScreenState extends State<HomeScreen> {
  // importing news model
  NewsViewModel newsviewModel = NewsViewModel();
  final format = DateFormat('MMMM dd, yyyy');
  // default name is bbc-news
  String name = 'bbc-news';
  // to select different filters
  FilterList? selectedMenu;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (comtext) => const CategoryScreen()));
            },
            icon: Image.asset(
              'assets/images/category_icon.png',
              height: 25,
              width: 25,
            )),
        centerTitle: true,
        title: Text(
          'News',
          style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        actions: [
          // a menu to select filters
          PopupMenuButton(
              initialValue: selectedMenu,
              icon: const Icon(Icons.more_vert),
              onSelected: (FilterList item) {
                if (FilterList.bbcNews.name == item.name) {
                  // api names
                  name = 'bbc-news';
                }
                if (FilterList.cnn.name == item.name) {
                  name = 'cnn';
                }
                if (FilterList.alJazeera.name == item.name) {
                  name = 'al-jazeera-english';
                }
                if (FilterList.aryNews.name == item.name) {
                  name = 'ary-news';
                }
                setState(() {
                  selectedMenu = item;
                });
              },
              // design for our filter List
              itemBuilder: (context) => <PopupMenuEntry<FilterList>>[
                    const PopupMenuItem<FilterList>(
                        value: FilterList.bbcNews, child: Text('bbc news')),
                    const PopupMenuItem<FilterList>(
                        value: FilterList.cnn, child: Text('CNN')),
                    const PopupMenuItem<FilterList>(
                        value: FilterList.alJazeera,
                        child: Text('Al-jazeera News')),
                    const PopupMenuItem<FilterList>(
                        value: FilterList.aryNews, child: Text('ary news'))
                  ])
        ],
      ),
      body: SizedBox(
        height: height,
        child: Column(children: [
          SizedBox(
            height: height * 0.015,
          ),
          Container(
            height: height * 0.55,
            width: width,
            child: FutureBuilder<NewsChannelHeadlinesModel>(
              // importing view Model that we created for our Api
              // name is our channelName
              future: newsviewModel.fetchNewsChannelHeadlinesApi(name),
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: SpinKitCircle(
                      size: 50,
                      color: Colors.blue,
                    ),
                  );
                } else {
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.articles!.length,
                      itemBuilder: (context, index) {
                        // parsing date time
                        DateTime dateTime = DateTime.parse(snapshot
                            .data!.articles![index].publishedAt
                            .toString());
                        return Stack(children: [
                          // Image Container
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => NewsDetailScreen(
                                        source: snapshot
                                            .data!.articles![index].source!.name
                                            .toString(),
                                        newsImage: snapshot
                                            .data!.articles![index].urlToImage
                                            .toString(),
                                        newsTitle: snapshot
                                            .data!.articles![index].title
                                            .toString(),
                                        newsDate: snapshot
                                            .data!.articles![index].publishedAt
                                            .toString(),
                                        author: snapshot
                                            .data!.articles![index].author
                                            .toString(),
                                        description: snapshot
                                            .data!.articles![index].description
                                            .toString(),
                                        content: snapshot
                                            .data!.articles![index].content
                                            .toString(),
                                        url: snapshot.data!.articles![index].url
                                            .toString(),
                                      )));
                            },
                            child: Container(
                              height: height * 0.6,
                              width: width * 0.9,
                              padding: EdgeInsets.symmetric(
                                  horizontal: height * 0.02),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(14),
                                child: CachedNetworkImage(
                                  imageUrl: snapshot
                                      .data!.articles![index].urlToImage
                                      .toString(),
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Container(
                                    child: spinKit2,
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(
                                    Icons.error_outline,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // title, source and dateTime
                          Positioned(
                              left: 22.5,
                              bottom: 20,
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                child: Container(
                                  padding: const EdgeInsets.all(15),
                                  height: height * 0.22,
                                  child: Column(
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: width * 0.7,
                                        child: Text(
                                          snapshot.data!.articles![index].title
                                              .toString(),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.poppins(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      SizedBox(
                                        height: height * 0.012,
                                      ),
                                      Container(
                                        width: width * 0.7,
                                        child: Text(
                                          snapshot.data!.articles![index]
                                              .description
                                              .toString(),
                                          style: GoogleFonts.poppins(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w300),
                                          maxLines: 2,
                                        ),
                                      ),
                                      // spacer is alternative for sized box
                                      const Spacer(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            snapshot.data!.articles![index]
                                                .source!.name
                                                .toString(),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.poppins(
                                                fontSize: 13,
                                                color: Colors.blue,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          const SizedBox(width: 95),
                                          Text(
                                            format.format(dateTime),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )),
                        ]);
                      });
                }
              },
            ),
          ),
          SizedBox(
            height: height * 0.012,
          ),
          SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.only(right: 20, top: 10),
                height: height * 0.29,
                child: FutureBuilder<CategoriesNewsModel>(
                    future: newsviewModel.fetchCategoriesNewsApi('general'),
                    builder: (BuildContext context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: SpinKitCircle(
                            size: 50,
                            color: Colors.blue,
                          ),
                        );
                      } else {
                        // Inside the second part of your code
                        return SizedBox(
                          height: height * 0.29,
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data!.articles!.length,
                            itemBuilder: (context, index) {
                              DateTime dateTime = DateTime.parse(
                                snapshot.data!.articles![index].publishedAt
                                    .toString(),
                              );
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => NewsDetailScreen(
                                      source: snapshot
                                          .data!.articles![index].source!.name
                                          .toString(),
                                      newsImage: snapshot
                                          .data!.articles![index].urlToImage
                                          .toString(),
                                      newsTitle: snapshot
                                          .data!.articles![index].title
                                          .toString(),
                                      newsDate: snapshot
                                          .data!.articles![index].publishedAt
                                          .toString(),
                                      author: snapshot
                                          .data!.articles![index].author
                                          .toString(),
                                      description: snapshot
                                          .data!.articles![index].description
                                          .toString(),
                                      content: snapshot
                                          .data!.articles![index].content
                                          .toString(),
                                      url: snapshot.data!.articles![index].url
                                          .toString(),
                                    ),
                                  ));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 6),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(14),
                                        child: CachedNetworkImage(
                                          imageUrl: snapshot
                                              .data!.articles![index].urlToImage
                                              .toString(),
                                          fit: BoxFit.cover,
                                          height: height * 0.17,
                                          width: width * 0.3,
                                          placeholder: (context, url) =>
                                              Container(child: null),
                                          errorWidget: (context, url, error) =>
                                              const Icon(
                                            Icons.error_outline,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 15),
                                      Expanded(
                                        child: Container(
                                          height: height * 0.17,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                snapshot.data!.articles![index]
                                                    .title
                                                    .toString(),
                                                maxLines: 4,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 14,
                                                  color: Colors.black54,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              SizedBox(
                                                height: height * 0.01,
                                              ),
                                              Text(
                                                snapshot.data!.articles![index]
                                                    .source!.name
                                                    .toString(),
                                                style: GoogleFonts.poppins(
                                                  fontSize: 15,
                                                  color: Colors.black54,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              SizedBox(
                                                height: height * 0.01,
                                              ),
                                              Text(
                                                format.format(dateTime),
                                                style: GoogleFonts.poppins(
                                                  fontSize: 14,
                                                  color: Colors.black54,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }
                    })),
          )
        ]),
      ),
    );
  }
}

const spinKit2 = SpinKitFadingCircle(
  color: Colors.amber,
  size: 50,
);
