import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class PostDetail extends StatelessWidget {
  final data;
  const PostDetail({Key? key, required this.data, dataPost}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Latest"),
      ),
      body: ListView(
        padding: EdgeInsets.all(8),
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.only(bottom: 10.0, top: 10.0),
              child: Center(
                child: Text(
                  data["title"]["rendered"],
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Hero(
            tag: data["id"],
            child: Image.network(
                data["_embedded"]["wp:featuredmedia"][0]["source_url"]),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(7.0)),
              color: Colors.white12,
            ),
            child: Html(
              data: data["content"]["rendered"],

              // data["content"]["rendered"].toString(),
              // // .replaceAll("<p>", " ")
              // // .replaceAll("<h3>", "")
              // // .replaceAll("</p>", "")
              // // .replaceAll("</h3>", ""),
              // style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }
}
