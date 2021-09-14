import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class PageDetail extends StatelessWidget {
  final data;
  const PageDetail({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Latest",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(8),
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.only(bottom: 10.0, top: 10.0),
              child: Text(data["title"]["rendered"]),
            ),
          ),
          Hero(
            tag: data["id"],
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Html(data: data["content"]["rendered"]),
            ),
          )
        ],
      ),
    );
  }
}
