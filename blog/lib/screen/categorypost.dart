import 'package:flutter/material.dart';
import 'package:moviesapi/screen/postdetail.dart';

import 'package:moviesapi/services/post.dart';

class CategoryPage extends StatefulWidget {
  CategoryPage({Key? key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  // ignore: non_constant_identifier_names
  Post CategoryService = Post();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: FutureBuilder<List>(
          future: CategoryService.getCategory(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data?.length == 0) {
                return Center(
                  child: Text("No post "),
                );
              }
              return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, i) {
                    return Card(
                      child: ListTile(
                        title: Card(
                          child: ListTile(
                            title: Row(
                              children: [
                                Expanded(
                                  child: Hero(
                                    tag: snapshot.data![i]["id"],
                                    child: Image.network(snapshot.data![i]
                                            ["_embedded"]["wp:featuredmedia"][0]
                                        ["source_url"]),
                                  ),
                                ),
                                Padding(padding: EdgeInsets.all(7)),
                                Expanded(
                                    child: Text(
                                  snapshot.data![i]['title']['rendered'],
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ))
                              ],
                            ),
                            subtitle: Text(
                              snapshot.data![i]["content"]["rendered"]
                                  .toString()
                                  .replaceAll("<p>", "")
                                  .replaceAll("</p>", ""),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 17.0),
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
      ),
    );
  }
}
