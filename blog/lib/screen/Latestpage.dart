import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:moviesapi/screen/postdetail.dart';
import 'package:moviesapi/services/post.dart';

class LatestPage extends StatefulWidget {
  LatestPage({Key? key}) : super(key: key);

  @override
  _LatestPageState createState() => _LatestPageState();
}

class _LatestPageState extends State<LatestPage> {
  Post postService = Post();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<List>(
        future: postService.getAllPost(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data?.length == 0) {
              return Text("No post ");
            }
            return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, i) {
                  return Container(
                    padding: EdgeInsets.only(top: 10),
                    child: Card(
                      color: Colors.white,
                      elevation: 1,
                      shadowColor: Colors.black,
                      child: ListTile(
                        title: Card(
                          child: ListTile(
                            title: Row(
                              children: [
                                Expanded(
                                  child: Hero(
                                    tag: snapshot.data![i]["id"],
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(5.0),
                                              topLeft: Radius.circular(5.0))),
                                      child: Image.network(
                                        snapshot.data![i]["_embedded"]
                                                ["wp:featuredmedia"][0]
                                            ["source_url"],
                                        width: 120,
                                        height: 120,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                    child: Html(
                                  data: snapshot.data![i]['title']['rendered'],
                                ))
                              ],
                            ),
                            subtitle: Html(
                              data: snapshot.data![i]["excerpt"]["rendered"],
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  PostDetail(data: snapshot.data?[i]),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                });
          } else if (snapshot.hasError) {
            return Center(
              child: (Text(snapshot.hasError.toString())),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
