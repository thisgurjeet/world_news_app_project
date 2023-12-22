import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:world_news_app_project/view/news_webview.dart';

class NewsDetailScreen extends StatefulWidget {
  final String newsImage,
      newsTitle,
      newsDate,
      author,
      description,
      content,
      source,
      url;
  const NewsDetailScreen(
      {Key? key,
      required this.source,
      required this.newsImage,
      required this.newsTitle,
      required this.newsDate,
      required this.author,
      required this.description,
      required this.content,
      required this.url})
      : super(key: key);

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  final format = DateFormat('MMMM dd, yyyy');
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    DateTime dateTime = DateTime.parse(widget.newsDate);
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'News',
            style:
                GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold),
          )),
      body: SingleChildScrollView(
        child: Container(
          height: height,
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              Container(
                height: height * 0.35,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(40)),
                  child: CachedNetworkImage(
                    imageUrl: widget.newsImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.025,
              ),
              Container(
                child: Text(
                  widget.newsTitle,
                  style: GoogleFonts.poppins(
                      fontSize: 20,
                      color: Colors.black87,
                      fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(
                height: height * 0.045,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.source,
                    style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    format.format(dateTime),
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Text(
                widget.description,
                style: GoogleFonts.poppins(
                  fontSize: 17,
                  color: Colors.black54,
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Container(
                  child: Text(
                widget.content,
                style: GoogleFonts.poppins(
                  fontSize: 17,
                  color: Colors.black54,
                  fontWeight: FontWeight.w300,
                ),
              )),
              SizedBox(
                height: height * 0.032,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => NewsWebView(url: widget.url)));
                },
                child: Container(
                  height: height * 0.065,
                  width: 200,
                  decoration: const BoxDecoration(color: Colors.black87),
                  child: Center(
                    child: Text(
                      'Read Full News',
                      style: GoogleFonts.poppins(
                        fontSize: 17,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
