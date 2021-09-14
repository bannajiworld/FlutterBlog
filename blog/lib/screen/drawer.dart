import 'package:flutter/material.dart';
import 'package:moviesapi/screen/pagedetail.dart';
import 'package:moviesapi/services/post.dart';

class MyDrawer extends StatefulWidget {
  MyDrawer({Key? key}) : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  Post pageService = Post();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.orangeAccent,
        child: Column(
          children: [
            Expanded(
                child: Container(
              child: FutureBuilder<List>(
                future: pageService.getPage(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data?.length == 0) {
                      return Center(
                        child: Text("No Page"),
                      );
                    }
                    return SafeArea(
                      child: ListView.builder(
                          padding: EdgeInsets.only(top: 1),
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, i) {
                            return ListTile(
                              title: Hero(
                                tag: snapshot.data![i]["id"],
                                child: Text(
                                  snapshot.data?[i]['title']['rendered'],
                                  style: TextStyle(
                                      fontSize: 22, color: Colors.white),
                                ),
                              ),
                              onTap: () => {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        PageDetail(data: snapshot.data?[i]),
                                  ),
                                )
                              },
                            );
                          }),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ))
          ],
        ),
      ),
    );
  }
}
